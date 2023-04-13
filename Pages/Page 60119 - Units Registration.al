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
                Editable = IsEditable;
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
                    Editable = false;

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
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                    Editable = false;
                }
                field("Register For Exams"; Rec."Register For Exams")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Register For Exams field.';
                    Visible = false;
                }
                field("Total Unit Selected"; Rec."Total Unit Selected")
                {
                    ApplicationArea = All;
                    Editable = false
                    ;
                    ToolTip = 'Specifies the value of the Total Unit Selected field.';
                }
                field("Unit Status"; Rec."Unit Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status Of the Units field.';
                    visible = false;

                }
            }
            part(Lines; "Units Registration")
            {
                Editable = IsEditable;
                ApplicationArea = All;
                SubPageLink = "Document No." = field("No.");
            }
        }
    }
    actions
    {
        area("Processing")
        {
            group(Approvals)
            {
                action("Send Approval Request")
                {
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category6;
                    Enabled = Rec.Status = Rec.Status::Open;
                    PromotedOnly = true;
                    ApplicationArea = All;
                    trigger OnAction()

                    begin
                        Rec.CalcFields("Total Unit Selected");
                        if Rec."Total Unit Selected" > 0 then begin
                            IF ApprovalsMgmtCut.CheckUnitsRegApprovalsWorkflowEnabled(Rec) then
                                ApprovalsMgmtCut.OnSendUnitsRegForApproval(Rec);
                        end else
                            Error('Please Select Atleast one Unit to Register!!!');
                    end;
                }
                action("Cancel Approval Request")
                {
                    Enabled = CanCancelApprovalForRecord OR CanCancelApprovalForFlow;
                    Image = CancelApprovalRequest;
                    PromotedCategory = Category6;
                    Promoted = true;
                    PromotedOnly = true;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        ApprovalsMgmtCut.OnCancelUnitRegApprovalRequest(Rec);
                    end;
                }
                action(ApprovalEntries)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        ApprovalsMgmt.OpenApprovalEntriesPage(Rec.RecordId);
                    end;
                }
            }
            group(Register)
            {
                action("Suggest Units to Register")
                {
                    Image = Action;
                    Promoted = true;
                    PromotedCategory = process;
                    PromotedOnly = true;
                    ApplicationArea = All;
                    trigger OnAction()

                    begin
                        UnitReg.Reset();
                        UnitReg.SetRange("No.", Rec."No.");

                        if UnitReg.FindFirst() then
                            Report.Run(Report::"Suggest Units Registration", false, false, UnitReg);
                    end;
                }
                action("Register For Units ")
                {
                    Image = Action;
                    Promoted = true;
                    PromotedCategory = process;
                    PromotedOnly = true;
                    ApplicationArea = All;
                    Visible = false;
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
                    Visible = false;
                    trigger OnAction()
                    begin
                        ReleaseDoc.UnitRegRelease(Rec);
                    end;
                }

            }
            group(Reports)
            {

                action(Report)
                {
                    ApplicationArea = All;
                    Caption = 'Unit Registration Report';
                    Image = Entry;
                    Promoted = true;
                    PromotedCategory = Report;
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

    }
    trigger OnAfterGetRecord()

    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(rec.RECORDID);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(rec.RECORDID);
        WorkflowWebhookMgt.GetCanRequestAndCanCancel(rec.RECORDID, CanRequestApprovalForFlow, CanCancelApprovalForFlow);
    end;

    trigger OnOpenPage()
    begin

        SetPageControl();
        CurrPage.Update();
    end;

    procedure SetPageControl()
    begin
        IsEditable := true;
        case Rec.Status of
            Rec.Status::" ",
            Rec.Status::Pending,
            Rec.Status::Rejected,
        Rec.Status::Canceled,
        Rec.Status::Released:
                begin
                    IsEditable := false;
                end;
        end;
    end;

    var
        UnitReg: Record "Unit Registration";
        IsEditable: Boolean;
        UnitRegReport: Report "Unit Registration Report";
        UnitRegistration: Record "Unit Registration";
        ReleaseDoc: Codeunit "Document Release";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        WorkflowWebhookMgt: Codeunit 1543;
        ApprovalsMgmtCut: Codeunit "Approval Management CUEXT";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        CanCancelApprovalForFlow: Boolean;
        CanRequestApprovalForFlow: Boolean;
        EnabledApprovalWorkflowsExist: Boolean;
}