page 60124 "Receipt Header"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    PromotedActionCategories = 'New,Process,Report, New Document,Approve,Request Approval';
    SourceTable = "Receipt Header";

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                Editable = IsEditable and IsOpen;
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No field.';
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting Date field.';

                }


                field(Cashier; Rec.Cashier)
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Cashier field.';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Currency Code field.';
                    Visible = false;
                }
                field("Date Posted"; Rec."Date Posted")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Date Posted field.';
                }
                field("Pay Mode"; Rec."Pay Mode")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Pay Mode field.';
                    Visible = false;
                }
                field("Paying Account Type"; Rec."Paying Account Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Paying Account Type field.';
                }
                field("Paying Account No"; Rec."Paying Account No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Paying Account No field.';
                }
                field(" Receipt Amount"; Rec." Receipt Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Receipt Amount field.';
                    Editable = false;
                }

                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the posted field.';
                    Editable = false;
                }
                field("Receiving Bank Account"; Rec."Receiving Bank Account")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Receiving Bank Account field.';
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bank Name field.';
                }
                field("Received From"; Rec."Received From")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Received From field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                    Editable = false;
                }
                field("Time Posted"; Rec."Time Posted")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Time Posted field.';
                }
            }
            part("Receipt Header Lines"; "Receipt Header Lines")
            {
                SubPageLink = "Document No" = FIELD("No.");
                ApplicationArea = all;
                Editable = IsEditable and IsOpen;
                UpdatePropagation = Both;

            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Suggest Receipt Lines")
            {
                Enabled = Rec.Status = Rec.Status::Open;
                Image = Process;
                PromotedCategory = Process;
                Promoted = true;
                PromotedOnly = true;
                ApplicationArea = All;

                trigger OnAction()

                begin
                    ReceiptHeader.Reset();
                    ReceiptHeader.SetRange("No.", Rec."No.");
                    if ReceiptHeader.FindFirst() then
                        Report.Run(Report::"Suggest Receipt Lines", false, false, ReceiptHeader);
                end;
            }
            action("Post Receipt")
            {
                Enabled = (Rec.Status = Rec.Status::Released) and not rec.Posted;
                Image = Post;
                PromotedCategory = Process;
                Promoted = true;
                PromotedOnly = true;
                ApplicationArea = All;


                trigger OnAction()
                begin
                    if Confirm('Do You want to post %1?', true, Rec."No.") then
                        ReceiptMGMT.PostReceipt(Rec);
                end;

            }
            group(approvals)
            {

                action("Send Approval Request")
                {
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedOnly = true;
                    ApplicationArea = All;
                    Enabled = Rec.Status = Rec.Status::open;
                    trigger OnAction()
                    begin
                        IF ApprovalsMgmtCut.CheckReceiptApprovalsWorkflowEnabled(Rec) then
                            ApprovalsMgmtCut.OnSendReceiptForApproval(Rec);
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
                        ApprovalsMgmtCut.OnCancelReceiptApprovalRequest(Rec);
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
        IsOpen := true;
        IsEditable := true;
        if Rec.Posted then
            IsEditable := false;
        if Rec.Status <> Rec.Status::Open then
            IsOpen := false;

    end;

    var

        ReceiptHeader: Record "Receipt Header";
        ReceiptMGMT: Codeunit Payments;
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
        IsOpen: Boolean;
        IsEditable: Boolean;

}