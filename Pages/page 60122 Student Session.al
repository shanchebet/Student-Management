page 60122 "Student Session"
{
    Caption = 'Caption';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Student Session";


    layout
    {
        area(Content)
        {
            group(General)
            {
                Enabled = Rec.Reported = false;
                field("Session Code"; Rec."Session Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Session Code field.';
                    Editable = false;
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
                    ToolTip = 'Specifies the value of the Student Name field.';
                    Editable = false;
                }
                field("Level Of Study"; Rec."Level Of Study")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Level Of Study field.';
                    Editable = false;
                }
                field("Course Of Study"; Rec."Course Of Study")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Course Of Study field.';
                    Editable = false;
                }
                field("Course Description"; Rec."Course Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Course Description field.';
                    Editable = false;
                }
                field("School Description"; Rec."School Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the School Description field.';
                    Editable = false;
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
                    Editable = false;
                }
                field("Academic Year Code"; Rec."Academic Year Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Academic Year Code field.';
                    Editable = false;
                }
                field("Academic Year Description"; Rec."Academic Year Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Academic Year Description field.';
                    Editable = false;
                }
                field(Reported; Rec.Reported)
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Reported Students field.';
                }

            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Report Session")
            {
                ApplicationArea = All;
                Visible = Rec.Reported = false;
                trigger OnAction()
                begin
                    Rec.TestField("Academic Year Code");
                    Rec.TestField("Semester Code");
                    Rec.TestField("Student No.");
                    Rec.Reported := true;
                    Message('%1,you have successfully Reported For %2', Rec."Student Name", Rec."Academic Year Description");
                    Rec.Modify();
                end;
            }
        }
    }

}