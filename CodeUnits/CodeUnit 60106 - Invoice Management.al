codeunit 60106 "Invoice Management"
{
    trigger OnRun()
    begin

    end;

    var

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
            if Not Confirm(Label2, false, "No.") then
                exit;
            if Posted then
                Error(Label1, "No.");
            StudMgmt.Get();

            // step 1 : Test field all the important fields
            StudMgmt.TestField("General Journal Batch");
            StudMgmt.TestField("General Journal Template");
            INVRec.Testfield("Invoiced Amount");
            INVRec.TestField("Posting Date");
            INVRec.TestField("Bill-to Student No.");

            // Step 2:  Create a batch using the document 
            JnlBatch.Init;
            JnlBatch."Journal Template Name" := StudMgmt."General Journal Template";
            JnlBatch.Name := "No.";
            if not JnlBatch.Get(StudMgmt."General Journal Template", "No.") then
                JnlBatch.Insert;

            // Step 3: Reset the lines and code that will loop through the lines to insert the journal lines for  invoicing.
            GenJnlLine.Reset;
            GenJnlLine.SetRange(GenJnlLine."Journal Template Name", StudMgmt."General Journal Template");
            GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", "No.");
            GenJnlLine.DeleteAll;

            begin
                InvoiceLines.Reset();
                InvoiceLines.SetRange("Document No.", "No.");
                if InvoiceLines.FindSet() then begin
                    repeat
                        StudentBillSetup.get(InvoiceLines.No);
                        LineNo := LineNo + 10000;
                        GenJnlLine.Init;
                        GenJnlLine."Journal Template Name" := JnlBatch."Journal Template Name";
                        GenJnlLine."Journal Batch Name" := JnlBatch.Name;
                        GenJnlLine."Line No." := LineNo;

                        //  Cr Fee Structure Accounts
                        GenJnlLine."Account Type" := StudentBillSetup."Bal. Account Type";
                        GenJnlLine."Account No." := StudentBillSetup."Balancing Account No.";
                        GenJnlLine."Posting Group" := StudentBillSetup."Posting Group";
                        GenJnlLine."Posting Date" := "Posting Date";
                        GenJnlLine."Document No." := InvoiceLines.No;
                        GenJnlLine.Description := StrSubstNo('%1 for Invoice Reference No. %2', InvoiceLines."Transaction Type", InvoiceLines.No);

                        //DR Student/Customer Account
                        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::Customer;
                        GenJnlLine."Bal. Account No." := "Bill-to Student No.";
                        //GenJnlLine."Document Type" := GenJnlLine."Document Type"::Invoice;
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
            GenJnlLine.SetRange("Journal Batch Name", INVRec."No.");
            CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post Batch", GenJnlLine);
            // step 5: modfies when posted and set the posted boolean to be posted.
            GLRegister.Reset;
            GLRegister.SetRange("Journal Batch Name", INVRec."No.");
            if GLRegister.Find('-') then begin
                INVRec.Posted := true;
                INVRec.Modify();
            end;
        end;
    end;
}