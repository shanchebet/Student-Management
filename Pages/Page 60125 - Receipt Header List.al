page 60125 "Receipt Header List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Receipt Header";
    SourceTable = "Receipt Header";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Cashier; Rec.Cashier)
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Cashier field.';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Currency Code field.';
                }
                field("Pay Mode"; Rec."Pay Mode")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Pay Mode field.';
                }
                field("Date Posted"; Rec."Date Posted")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Date Posted field.';
                }
                field("Paying Account Type"; Rec."Paying Account Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Paying Account Type field.';
                }
                field(" Receipt Amount"; Rec." Receipt Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Receipt Amount field.';
                }
                field("Paying Account No"; Rec."Paying Account No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Paying Account No field.';
                }


                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the posted field.';
                    Editable = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field("Received From"; Rec."Received From")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Received From field.';
                }
                field("Semester Code"; Rec."Semester Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Semester Code field.';
                }
                field("Semester Description"; Rec."Semester Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Semester Description field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Time Posted"; Rec."Time Posted")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Time Posted field.';
                }
            }
        }
        area(Factboxes)
        {
        }
    }
    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}