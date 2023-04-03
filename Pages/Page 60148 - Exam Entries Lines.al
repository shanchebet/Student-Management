page 60148 "Exam Entries Lines"
{
    ApplicationArea = All;
    Caption = 'Exam Entries Lines';
    PageType = ListPart;
    SourceTable = "Exam Entries Lines";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Document Number field.';
                }
                field("Unit Code"; Rec."Unit Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Unit Code field.';
                }
                field("Unit Description"; Rec."Unit Description")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Unit Description field.';
                }
                field("Cat Marks"; Rec."Cat Marks")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cat Marks field.';
                }
                field("Exam Marks"; Rec."Exam Marks")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Exam Marks field.';
                }
                field("Final Mark"; Rec."Final Mark")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Final Mark field.';
                }
                field(Grade; Rec.Grade)
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Grade field.';
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Remarks field.';
                }
            }
        }
    }
}
