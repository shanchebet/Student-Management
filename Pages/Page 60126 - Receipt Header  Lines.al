page 60126 "Receipt Header Lines"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Receipt Header Lines";

    layout
    {
        area(Content)
        {
            repeater(control1)
            {
                field("Document No"; Rec."Document No")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Document No field.';
                }
                field(No; Rec.No)
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the value of the No field.';
                }
                field("Line No"; Rec."Line No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Line No field.';
                    Visible = false;
                }
                field("Applies-to Doc. No."; Rec."Applies-to Doc. No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Applies-to Doc. No. field.';
                }
                field("Applies-to Doc. Type"; Rec."Applies-to Doc. Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Applies-to Doc. Type field.';
                    Visible = false;
                }

                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Account No field.';
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Account Type field.';
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Transaction Type field.';
                }
                field("Invoiced Amount"; Rec."Invoiced Amount")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Invoiced Amount field.';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount field.';
                }
            }
        }

    }
}
