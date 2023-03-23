page 60123 "Student Session List "
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = 60122;
    SourceTable = "Student Session";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Session Code"; Rec."Session Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Session Code field.';
                }
                field("Session Description"; Rec."Session Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Session Description field.';
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Student No field.';
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Stdent Name field.';
                }
                field("Level Of Study"; Rec."Level Of Study")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Level Of Study field.';
                }
                field("Course Of Study"; Rec."Course Of Study")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Course Of Study field.';
                }
                field("Course Description"; Rec."Course Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Course Description field.';
                }
                field("School Description"; Rec."School Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the School Description field.';
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
                field(Reported; Rec.Reported)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Reported Students field.';
                }
            }
        }

    }
}