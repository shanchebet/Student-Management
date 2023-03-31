page 60143 "Posted Receipt"
{
    ApplicationArea = All;
    Caption = 'Posted Receipt';
    PageType = List;
    SourceTable = "Receipt Header";
    UsageCategory = Lists;
    SourceTableView = where("posted" = const(true));
    CardPageId = "Receipt Header";
    DeleteAllowed = false;
    InsertAllowed = false;
    layout
    {
        area(content)
        {
            repeater(General)
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
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Currency Code field.';
                }
                field(Cashier; Rec.Cashier)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cashier field.';
                }
                field("Academic Year Code"; Rec."Academic Year Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Academic Year Code field.';
                }
                field("Academic Year Description"; Rec."Academic Year Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Academic Year Description field.';
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
                field("Paying Account No"; Rec."Paying Account No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Paying Account No field.';
                }
                field("Paying Account Type"; Rec."Paying Account Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Paying Account Type field.';
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
                field("Receiving Bank Account"; Rec."Receiving Bank Account")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Receiving Bank Account field.';
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bank Name field.';
                }
                field(" Receipt Amount"; Rec." Receipt Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Receipt Amount field.';
                }
                field("Date Posted"; Rec."Date Posted")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date Posted field.';
                }
                field("Pay Mode"; Rec."Pay Mode")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Pay Mode field.';
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the posted field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Time Posted"; Rec."Time Posted")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Time Posted field.';
                }
            }
        }
    }
}
