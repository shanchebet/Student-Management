report 60103 "Suggest Receipt Lines"
{
    Caption = 'Suggest Receipting Lines';
    ProcessingOnly = true;
    dataset
    {
        dataitem(ReceiptHeader; "Receipt Header")
        {
            trigger OnAfterGetRecord()
            begin
                TestField("Paying Account No");
                //Clear ReceiptHeader Lines
                StudMgt.ClearReceiptHeaderLines(ReceiptHeader);

                CustLedger.Reset();
                CustLedger.SetRange("Customer No.", "Paying Account No");
                CustLedger.SetRange(Reversed, false);
                CustLedger.SetRange(Open, true);
                IF CustLedger.FindSet() THEN begin
                    REPEAT
                        CustLedger.CALCFIELDS("Remaining Amount");
                        // Insert into Receipt Header lines Table
                        if ReceiptLines."Applies-to Doc. No." <> CustLedger."Document No." then begin
                            LineNo := LineNo + 10000;//Set The Starting Value of Line No and Increment as the Record is generated
                            ReceiptLines.Init();
                            ReceiptLines."Document No" := ReceiptHeader."No.";
                            ReceiptLines."Line No" := LineNo;
                            ReceiptLines."Account Type" := ReceiptLines."Account Type"::Customer;
                            ReceiptLines."Account No" := ReceiptHeader."Paying Account No";
                            ReceiptLines.Validate("Account No");
                            ReceiptLines."Transaction Type" := CustLedger.Description;
                            ReceiptLines."Applies-to Doc. No." := CustLedger."Document No.";
                            ReceiptLines."Invoiced Amount" := Abs(CustLedger."Remaining Amount");
                            if ReceiptLines."Invoiced Amount" > 0 then
                                ReceiptLines.Insert();
                        end else begin
                            ReceiptLines."Invoiced Amount" += Abs(CustLedger."Remaining Amount");
                            ReceiptLines.Modify();
                        end;
                    until CustLedger.Next() = 0;
                end;
            end;
        }
    }
    var
        ReceiptLines: Record "Receipt Header Lines";
        CustLedger: Record "Cust. Ledger Entry";
        LineNo: Integer;
        StudMgt: Codeunit "Student Management";
}