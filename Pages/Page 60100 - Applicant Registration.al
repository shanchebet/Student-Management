page 60100 "Applicant Registration"
{
    Caption = 'Applicant Registration';
    PageType = Card;
    SourceTable = "Applicant Registration";
    PromotedActionCategories = 'New,Process,Report, New Document,Approve,Request Approval';
    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(Content)
        {

            group(General)

            {
                Editable = IsEditable;

                Caption = 'General';

                field("Application No."; Rec."Application No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Application No field.';

                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update();
                    end;
                }
                field(FirstName; Rec."First Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the FirstName field.';
                    ShowMandatory = true;
                }
                field(MiddleName; Rec."Middle Name")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    ToolTip = 'Specifies the value of the MiddleName field.';
                }
                field(SurName; Rec.SurName)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    ToolTip = 'Specifies the value of the SurName field.';
                }
                field(FullName; Rec."Full Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Student FullName field.';
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Gender field.';
                }
                field(DOB; Rec.DOB)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    ToolTip = 'Specifies the value of the Date of Birth field.';
                }
                field(Age; Rec.Age)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Age field.';
                    Editable = false;

                }

                field("Marital Status"; Rec."Marital Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Marital Status field.';
                }
                field("Approval Status"; Rec."Approval Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Approval Status field.';
                    Editable = false;
                }
                field("Customer Type"; Rec."Customer Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Type of applicant field.';
                    Editable = false;

                }
                field("Grade Attain"; Rec."Grade Attain")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Grade Attained field.';
                    Visible = false;
                }
                field(Points; Rec.Points)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Points Attained field.';
                    Visible = false;
                }
            }
            group("Contacts & Address")
            {
                Editable = IsEditable;
                field("Phone Number"; Rec."Phone Number")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Phone Number field.';
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Email Address field.';
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Address field.';
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the city field.';
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Country/Region Code field.';
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Post Code field.';
                }
                field(County; Rec.County)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the County field.';
                }
            }
            group("Applicant Field of Study")
            {
                Editable = IsEditable;
                field("Level Of Study"; Rec."Level Of Study")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Level Of Study field.';
                }
                field("LOS Description"; Rec."LOS Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the level of study Description field.';
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
                    Editable = false;
                }
                field("Department Description"; Rec."Department Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Department Description field.';
                    Editable = false;
                }
                field("School Description"; Rec."School Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the School Description field.';
                    Editable = false;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            group(Approval)

            {
                action(Approve)
                {
                    ApplicationArea = All;
                    Visible = OpenApprovalEntriesExistForCurrUser;
                    Image = Approve;
                    Caption = 'Approve';
                    PromotedCategory = Category5;
                    Promoted = true;
                    PromotedIsBig = true;
                    trigger OnAction()
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
                    end;
                }


                action("Send Approval Request")
                {
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category6;
                    Enabled = Rec."Approval Status" = Rec."Approval Status"::Open;
                    PromotedOnly = true;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        Rec.TestField("Phone Number");
                        Rec.TestField(Email);
                        Rec.TestField("Level Of Study");
                        Rec.TestField("Course Of Study");
                        IF ApprovalsMgmtCut.CheckApplicantRegApprovalsWorkflowEnabled(Rec) then
                            ApprovalsMgmtCut.OnSendApplicantRegForApproval(Rec);

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
                        ApprovalsMgmtCut.OnCancelApplicantRegApprovalRequest(Rec);
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
            action(Email)
            {
                ApplicationArea = all;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Promoted = true;
                Image = SendMail;
                trigger OnAction()
                var
                    myInt: Integer;
                begin
                    stud.EmailAdmissionLetter(Rec);
                end;

            }
        }
    }
    trigger OnAfterGetRecord()

    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(rec.RECORDID);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(rec.RECORDID);
        WorkflowWebhookMgt.GetCanRequestAndCanCancel(rec.RECORDID, CanRequestApprovalForFlow, CanCancelApprovalForFlow);
        Clear(Rec);
    end;

    trigger OnOpenPage()
    begin

        SetPageControl();
        Clear(Rec);
        CurrPage.Update();

        // Rec.RESET;
        // if not Rec.GET then begin
        //     Rec.INIT;
        //     Rec.INSERT;
        // end;

    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        SetPageControl();
        CurrPage.Update();
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        SetPageControl();
        CurrPage.Update();
    end;

    procedure SetPageControl()
    begin
        IsEditable := true;
        case Rec."Approval Status" of
            Rec."Approval Status"::" ",
            Rec."Approval Status"::Pending,
            Rec."Approval Status"::Rejected,
        Rec."Approval Status"::Canceled,
        Rec."Approval Status"::Released:
                begin
                    IsEditable := false;
                end;

        end;
    end;

    var
        myInt: Integer;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        WorkflowWebhookMgt: Codeunit 1543;
        ApprovalsMgmtCut: Codeunit "Approval Management CUEXT";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        CanCancelApprovalForFlow: Boolean;
        CanRequestApprovalForFlow: Boolean;
        ReleaseDoc: Codeunit "Document Release";
        EnabledApprovalWorkflowsExist: Boolean;

        fieldeditable: Boolean;
        stud: Codeunit "Student Management";
        IsEditable: Boolean;
}
