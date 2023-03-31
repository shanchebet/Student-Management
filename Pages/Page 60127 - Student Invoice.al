page 60127 "Student Invoice"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    PromotedActionCategories = 'New,Process,Report, New Document,Approve,Request Approval';
    SourceTable = "Student Invoice";

    layout
    {
        area(Content)
        {

            group(GroupName)
            {
                Editable = Rec.Posted = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Bill-to Student No."; Rec."Bill-to Student No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bill-to Customer No. field.';

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        stud: Record "Student Session";
                    begin
                        if Page.RunModal(Page::"Student Session List ", stud) = Action::LookupOK then
                            Rec."Bill-to Student No." := stud."Student No.";
                        Rec."Student Name" := stud."Student Name";
                        Rec."Course Of Study" := stud."Course Of Study";
                        Rec."Level Of Study" := stud."Level Of Study";
                        Rec."School Description" := stud."School Description";
                        rec."Course Description" := stud."Course Description";
                        Rec."Academic Year Code" := stud."Academic Year Code";
                        Rec.Semester := stud."Semester Code";
                        rec.Semester := stud."Semester Description";
                    end;

                }
                field("Status "; Rec."Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                    Editable = false;
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
                    ToolTip = 'Specifies the value of the Course of Study field.';
                }
                field("Course Description"; Rec."Course Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Course Description field.';
                }
                field("Academic Year Code"; Rec."Academic Year Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Academic Year Code field.';
                }
                field("School Description"; Rec."School Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the School Description field.';
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Semester field.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field("Invoiced Amount"; Rec."Invoiced Amount")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Invoiced Amount field.';
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posted field.';
                    Editable = false;
                }
            }
            part("Student Invoice Lines"; "Student Invoice Lines")
            {
                Editable = Rec.Posted = false;
                SubPageLink = "Document No." = FIELD("No.");
                ApplicationArea = all;
                UpdatePropagation = Both;
            }
        }
    }
    actions
    {
        area(Processing)
        {
            group(Approval)
            {
                action("Send Approval Request")
                {
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedOnly = true;
                    Enabled = not OpenApprovalEntriesExist;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        IF ApprovalsMgmtCut.CheckInvoiceApprovalsWorkflowEnabled(Rec) then
                            ApprovalsMgmtCut.OnSendInvoiceForApproval(Rec);
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
                        ApprovalsMgmtCut.OnCancelInvoiceApprovalRequest(Rec);
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
                action("Invoice Student")
                {
                    Enabled = Rec.Status = Rec.Status::Released;
                    Image = Post;
                    PromotedCategory = Process;
                    Promoted = true;
                    PromotedOnly = true;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        if Confirm('Do You want to post %1?', true, Rec."No.") then
                            InvMgt.PostInvoice(Rec);
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
        InvMgt: Codeunit "Invoice Management";
        IsPostedInvoices: Boolean;


}

