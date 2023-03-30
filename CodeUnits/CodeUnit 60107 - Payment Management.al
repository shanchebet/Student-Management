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
        StudMgmt: Record "Student Management Setup";
        JnLBatch: Record "Gen. Journal Batch";
        LineNo: Integer;
        GenJnlLine: Record "Gen. Journal Line";
        GLRegister: Record "G/L Register";
        ReceiptLines: Record "Receipt Header Lines";

    begin
        With Receipt do begin
            if Not Confirm(Label2, false, "No.") then
                exit;
            if Posted then
                Error(Label1, "No.");
            StudMgmt.Get();

            StudMgmt.TestField("General Journal Batch");
            StudMgmt.TestField("General Journal Template");
            TestField("Receiving Bank Account");


            JnlBatch.Init;
            JnlBatch."Journal Template Name" := StudMgmt."General Journal Template";
            JnlBatch.Name := "No.";
            if not JnlBatch.Get(StudMgmt."General Journal Template", "No.") then
                JnlBatch.Insert;

            GenJnlLine.Reset;
            GenJnlLine.SetRange(GenJnlLine."Journal Template Name", StudMgmt."General Journal Template");
            GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", "No.");
            GenJnlLine.DeleteAll;
            begin
                //cr Customer/Student.

                ReceiptLines.Reset();
                ReceiptLines.SetRange("Document No", "No.");
                if ReceiptLines.Find('-') then begin
                    repeat
                        LineNo := LineNo + 10000;
                        GenJnlLine.Init;
                        GenJnlLine."Journal Template Name" := JnlBatch."Journal Template Name";
                        GenJnlLine."Journal Batch Name" := JnlBatch.Name;
                        GenJnlLine."Line No." := LineNo;
                        GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
                        GenJnlLine."Account Type" := GenJnlLine."Account Type"::Customer;
                        GenJnlLine."Account No." := ReceiptLines."Account No";
                        GenJnlLine.Validate("Account No.");
                        GenJnlLine."Posting Date" := "Posting Date";
                        GenJnlLine."Document No." := "No.";
                        GenJnlLine."Applies-to Doc. No." := ReceiptLines."Applies-to Doc. No.";
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

            GenJnlLine.Reset;
            GenJnlLine.SetRange("Journal Template Name", StudMgmt."General Journal Template");
            GenJnlLine.SetRange("Journal Batch Name", "No.");
            CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post Batch", GenJnlLine);

            GLRegister.Reset;
            GLRegister.SetRange("Journal Batch Name", "No.");
            if GLRegister.Find('-') then begin
                Posted := true;
                "Time Posted" := Time();
                "Date Posted" := Today();
                Modify();
            end;
        end;
    end;


}
