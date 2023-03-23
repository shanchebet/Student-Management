page 60118 "Unit Matrix"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Unit Matrix";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Entry No"; Rec."Entry No")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Entry No field.';
                }
                field("Unit Code"; Rec."Unit Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit Code field.';
                }
                field("Unit Description"; Rec."Unit Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit Description field.';
                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the course Code field.';
                }
                field("Course Description"; Rec."Course Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Course Description field.';
                }
                field("Semester Code"; Rec."Semester Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Semester Code field.';
                }
                field("Academic Year Code"; Rec."Academic Year Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Academic Year Code field.';
                }
                field("Unit Core/Elective"; Rec."Unit Core/Elective")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit Core/Elective field.';
                }
            }
        }

    }
}