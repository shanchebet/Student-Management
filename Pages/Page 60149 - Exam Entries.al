page 60149 "Exam Entries Card"
{
    Caption = 'Exam entries';
    PageType = Card;
    SourceTable = "Exam Entries";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                    //Visible = false;
                }

                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Student No field.';

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        UnitReg: Record "Unit Registration";
                        UnitRegLines: Record "Unit Registration Line";
                    begin
                        if Page.RunModal(Page::"Unit Registration List", UnitReg) = Action::LookupOK then begin
                            Rec."Student No." := UnitReg."Student No.";
                            Rec."Unit Reg No." := UnitReg."No.";
                            Rec.Validate("Unit Reg No.");
                            Rec."Student Name" := UnitReg."Student Name";
                            rec."Level Of Study" := UnitReg."Level Of Study";
                            Rec."Course Of Study" := UnitReg."Course Of Study";
                            Rec."Academic Year Code" := UnitReg."Academic Year Code";
                            Rec.Semester := UnitReg.Semester;
                        end;
                    end;
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
                    ToolTip = 'Specifies the value of the Course of Study field.';
                    Editable = false;
                }
                field("Academic Year Code"; Rec."Academic Year Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Academic Year Code field.';
                    Editable = false;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Semester field.';
                    Editable = false;
                }
            }
            part("Exam Entries Lines"; "Exam Entries LInes")
            {
                SubPageLink = "Document No." = field("No.");
                ApplicationArea = all;
            }
        }
    }
}
