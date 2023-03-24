page 60120 "Units Registration"
{
    PageType = Listpart;
    SourceTable = "Unit Registration Line";

    layout
    {
        area(Content)
        {
            repeater(Lines)
            {
                field(Select; Rec.Select)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Select field.';
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Document Number field.';
                }
                field("Entry No"; Rec."Entry No")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Units field.';
                }
                field("Line No"; Rec."Line No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Line No field.';
                    Visible = false;

                }

                field("Unit Code"; Rec."Unit Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit Code field.';
                    Editable = false;
                }
                field("Unit Description"; Rec."Unit Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit Description field.';
                    Editable = false;

                }
                field("Course Description"; Rec."Course Description")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Course Description field.';
                }
                field("Semester Code"; Rec."Semester Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Semester Code field.';
                }
                field("Unit Status"; Rec."Unit Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status Of the Units field.';
                    Editable = false;
                }

                field("Unit Core/Elective"; Rec."Unit Core/Elective")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Unit Core/Elective field.';
                }
            }
        }
    }
}