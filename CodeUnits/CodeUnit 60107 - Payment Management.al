codeunit 60107 Payments
{
    trigger OnRun()
    begin

    end;

    var
        Label1: Label 'The Receipt Payment %1 has already been posted!';
        Label2: Label 'Are you sure you want to post Receipt Payment No. %1 ?';

    procedure PostReceipt(Receipt: Record "Receipt Header")
    var
        // fetches the record from a certain table variables
        StudMgmt: Record "Student Management Setup";
        JnLBatch: Record "Gen. Journal Batch";
        LineNo: Integer;
        GenJnlLine: Record "Gen. Journal Line";
        GLRegister: Record "G/L Register";
        ReceiptLines: Record "Receipt Header Lines";

    begin
        With Receipt do begin
            //Dialogue box that prompt one for yes or no.
            if Not Confirm(Label2, false, "No.") then
                exit;
            if Posted then
                Error(Label1, "No.");
            StudMgmt.Get();
            // step 1 : Tests fields of all the important fields not to be blank or Zero in Student Management Setup
            StudMgmt.TestField("General Journal Batch");
            StudMgmt.TestField("General Journal Template");

            TestField("Receiving Bank Account");

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
                //cr Customer/Student.
                //Setting the range for Receipt Lines with the Receipt Header Record so as to insert into Journal Line all the Record From Receipt Lines
                ReceiptLines.Reset();
                ReceiptLines.SetRange("Document No", "No.");
                if ReceiptLines.Find('-') then begin
                    repeat
                        LineNo := LineNo + 10000;// Increment LineNo by 10000 so as to avoid Existing Record for Same Record
                        GenJnlLine.Init;
                        GenJnlLine."Journal Template Name" := JnlBatch."Journal Template Name";
                        GenJnlLine."Journal Batch Name" := JnlBatch.Name;
                        GenJnlLine."Line No." := LineNo;
                        GenJnlLine."Account Type" := ReceiptLines."Account Type"::Customer;
                        GenJnlLine."Account No." := ReceiptLines."Account No";
                        GenJnlLine.Validate("Account No.");
                        GenJnlLine."Posting Date" := "Posting Date";
                        GenJnlLine."Document No." := "No.";
                        GenJnlLine."Applies-to Doc. No." := ReceiptLines."Applies-to Doc. No.";
                        GenJnlLine.Validate("Applies-to Doc. No.");
                        GenJnlLine.Description := StrSubstNo('%1 for Payment Reference No. %2', ReceiptLines."Transaction Type", "No.");
                        //DR BANK
                        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"Bank Account";
                        GenJnlLine."Bal. Account No." := "Receiving Bank Account";
                        GenJnlLine.Validate("Bal. Account No.");

                        GenJnlLine.Amount := -Round(ReceiptLines.Amount);

                        GenJnlLine.Validate(Amount);
                        if GenJnlLine.Amount <> 0 then
                            GenJnlLine.Insert;
                    until ReceiptLines.Next() = 0

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
                Receipt.Posted := true;
                Receipt."Time Posted" := Time();
                Receipt."Date Posted" := Today();
                Receipt.Modify();
            end;
        end;
    end;


}
