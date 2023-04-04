page 60119 "Unit Registration"
{
    Caption = 'Unit Registration';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    PromotedActionCategories = 'New,Process,Report, New Document,Approve,Request Approval,Release';
    SourceTable = "Unit Registration";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update();
                    end;
                }
                field("Session Code"; Rec."Session Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Session Code field.';
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Student No. field.';
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Customer Name field.';
                }

                field("Level Of Study"; Rec."Level Of Study")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Level Of Study field.';
                }
                field("Course Of Study"; Rec."Course Of Study")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Course Of Study field.';
                }
                field("Department Description"; Rec."Department Description")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Department Description field.';
                }
                field("School Description"; Rec."School Description")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the School Description field.';
                }
                field("Course Description"; Rec."Course Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Course Description field.';
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Semester field.';

                }
                field("Academic Year Code"; Rec."Academic Year Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Academic Year Code field.';
                }
                field("Academic Year Description"; Rec."Academic Year Description")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Academic Year Description field.';
                }
                field("Register For Exams"; Rec."Register For Exams")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Register For Exams field.';
                }
            }
            part(Lines; "Units Registration")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = field("No.");
            }
        }
    }
    actions
    {
        area("Processing")
        {
            action("Suggest Units to Register")
            {
                trigger OnAction()

                begin
                    UnitReg.Reset();
                    UnitReg.SetRange("No.", Rec."No.");

                    if UnitReg.FindFirst() then
                        Report.Run(Report::"Suggest Units Registration", false, false, UnitReg);
                end;
            }
            group(Register)
            {
                action("Register For Units ")
                {
                    Image = Action;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        ReleaseDoc.UnitRegRelease(Rec);
                    end;
                }
                action("Exams Registration")
                {
                    Image = Action;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        ReleaseDoc.UnitRegRelease(Rec);
                    end;
                }

            }
        }
        area(Navigation)
        {
            action(Report)
            {
                ApplicationArea = All;
                Caption = 'Unit Registration Report';
                Image = Entry;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    UnitRegistration.Reset();
                    UnitRegistration.SetRange("No.", Rec."No.");
                    UnitRegistration.SetRange("Student No.", Rec."Student No.");
                    UnitRegistration.SetFilter("Student Name", '%1', Rec."Student Name");
                    UnitRegReport.SetTableView(UnitRegistration);
                    UnitRegReport.Run();
                end;

            }
        }
    }
    var
        UnitReg: Record "Unit Registration";
        UnitRegReport: Report "Unit Registration Report";
        UnitRegistration: Record "Unit Registration";
        ReleaseDoc: Codeunit "Document Release";
}