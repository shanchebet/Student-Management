codeunit 60106 "Invoice Management"
{
    trigger OnRun()
    begin

    end;

    var
        Label1: Label 'The Invoice %1 has already been posted!';
        Label2: Label 'Are you sure you want to post Invoice No. %1 ?';

    //Post Invoice
    procedure PostInvoice(INVRec: Record "Student Invoice")
    var
        StudMgmt: Record "Student Management Setup";
        JnLBatch: Record "Gen. Journal Batch";
        LineNo: Integer;
        GenJnlLine: Record "Gen. Journal Line";
        GLRegister: Record "G/L Register";
        InvoiceLines: Record "Student Invoice Lines";
        StudentBillSetup: Record "Finance Structure";

    begin
        With INVRec do begin
            //Dialogue box that prompt one for yes or no.
            if Not Confirm(Label2, false, "No.") then
                exit;
            if Posted then
                Error(Label1, "No.");

            StudMgmt.Get();
            // step 1 : Tests fields of all the important fields not to be blank or Zero in Student Management Setup
            StudMgmt.TestField("General Journal Batch");
            StudMgmt.TestField("General Journal Template");

            //Tests fields of all the important fields not to be blank or Zero Invoice Header
            TestField("Posting Date");
            TestField("Bill-to Student No.");

            // Step 2:  Create a Gen Journal batch using the document No and Template Using "General Journal Template" from StudentMgt
            JnlBatch.Init;
            JnlBatch."Journal Template Name" := StudMgmt."General Journal Template";
            JnlBatch.Name := "No.";

            //If the Gen Journal batch does not Exist it Inserts/Creates
            if not JnlBatch.Get(StudMgmt."General Journal Template", "No.") then
                JnlBatch.Insert;

            // Step 3: Delete/Reset the lines with the Same Batch Name and Template Name if Exist in Gen Journal Lines Before inserting
            GenJnlLine.Reset;
            GenJnlLine.SetRange(GenJnlLine."Journal Template Name", StudMgmt."General Journal Template");
            GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", "No.");
            GenJnlLine.DeleteAll;

            begin
                //Setting the range for Invoice Lines with the Invoice Header Record so as to insert into Journal Line all the Record From Invoice Lines
                InvoiceLines.Reset();
                InvoiceLines.SetRange("Document No.", "No.");
                if InvoiceLines.FindSet() then begin
                    repeat
                        StudentBillSetup.get(InvoiceLines."No");

                        LineNo := LineNo + 10000; // Increment LineNo by 10000 so as to avoid Existing Record for Same Record
                        GenJnlLine.Init;
                        GenJnlLine."Journal Template Name" := JnlBatch."Journal Template Name";
                        GenJnlLine."Journal Batch Name" := JnlBatch.Name;
                        GenJnlLine."Line No." := LineNo;

                        //  Cr Fee Structure Accounts
                        GenJnlLine."Account Type" := StudentBillSetup."Bal. Account Type";
                        GenJnlLine."Account No." := StudentBillSetup."Balancing Account No.";
                        GenJnlLine."Posting Date" := "Posting Date";
                        GenJnlLine."Document No." := InvoiceLines."Document No.";
                        GenJnlLine.Description := StrSubstNo('%1 for Invoice Reference No. %2', InvoiceLines."Transaction Type", InvoiceLines.No);

                        //DR Student/Customer Account
                        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::Customer;
                        GenJnlLine."Bal. Account No." := "Bill-to Student No.";
                        GenJnlLine.Amount := -Round(InvoiceLines.Amount);
                        GenJnlLine.Validate(Amount);
                        if GenJnlLine.Amount <> 0 then
                            GenJnlLine.Insert;
                    until InvoiceLines.Next() = 0;
                end;
            end;
            // step 4: This passes the lines for posting 
            GenJnlLine.Reset;
            GenJnlLine.SetRange("Journal Template Name", StudMgmt."General Journal Template");
            GenJnlLine.SetRange("Journal Batch Name", "No.");
            CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post Batch", GenJnlLine);

            // step 5: modify when posted and set the posted boolean to be posted.if the record exist in GL Register
            GLRegister.Reset;
            GLRegister.SetRange("Journal Batch Name", "No.");
            if GLRegister.Find('-') then begin
                Posted := true;
                Modify();
            end;
        end;
    end;



}