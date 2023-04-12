codeunit 60101 "Approval Management CUEXT"
{
    var
        WorkFlowManagement: Codeunit "Workflow Management";
        NoWorkflowEnabledErr: Label 'No approval workflow for this record type is enabled.';
        WorkflowEventHandling: Codeunit "Workflow Event Handling CUExt";
    //Function for checking if the workflow is enabled for Applicant Reg
    procedure CheckApplicantRegApprovalsWorkflowEnabled(VAR ApplicantReg: Record "Applicant Registration"): Boolean
    begin
        IF NOT IsApplicantRegApprovalsWorkflowEnabled(ApplicantReg) THEN
            ERROR(NoWorkflowEnabledErr);
        EXIT(TRUE);
    end;

    procedure IsApplicantRegApprovalsWorkflowEnabled(VAR ApplicantReg: Record "Applicant Registration"): Boolean
    begin
        EXIT(WorkflowManagement.CanExecuteWorkflow(ApplicantReg, WorkflowEventHandling.RunWorkflowOnSendApplicantRegForApprovalCode));
    end;
    //Function For Checking if the Workflow for Units Registration Is Enabled.
    procedure CheckUnitsRegApprovalsWorkflowEnabled(VAR UnitReg: Record "Unit Registration"): Boolean
    begin
        IF NOT IsUnitsRegApprovalsWorkflowEnabled(UnitReg) THEN
            ERROR(NoWorkflowEnabledErr);
        EXIT(TRUE);
    end;

    procedure IsUnitsRegApprovalsWorkflowEnabled(VAR UnitReg: Record "Unit Registration"): Boolean
    begin
        EXIT(WorkflowManagement.CanExecuteWorkflow(UnitReg, WorkflowEventHandling.RunWorkflowOnSendUnitsForApprovalCode));
    end;


    //Fuction for Checking if the workflow is enabled for Invoicing
    procedure CheckInvoiceApprovalsWorkflowEnabled(VAR Inv: Record "Student Invoice"): Boolean
    begin
        IF NOT IsInvoiceApprovalsWorkflowEnabled(Inv) THEN
            ERROR(NoWorkflowEnabledErr);
        EXIT(TRUE);
    end;

    procedure IsInvoiceApprovalsWorkflowEnabled(VAR Inv: Record "Student Invoice"): Boolean
    begin
        EXIT(WorkflowManagement.CanExecuteWorkflow(Inv, WorkflowEventHandling.RunWorkflowOnSendInvoiceForApprovalCode));
    end;

    //Function for Checking If the workflow is enabled for Receipting.
    procedure CheckReceiptApprovalsWorkflowEnabled(VAR Receipt: Record "Receipt Header"): Boolean
    begin
        IF NOT IsReceiptApprovalsWorkflowEnabled(Receipt) THEN
            ERROR(NoWorkflowEnabledErr);
        EXIT(TRUE);
    end;

    procedure IsReceiptApprovalsWorkflowEnabled(VAR Receipt: Record "Receipt Header"): Boolean
    begin
        EXIT(WorkflowManagement.CanExecuteWorkflow(Receipt, WorkflowEventHandling.RunWorkflowOnSendReceiptForApprovalCode));
    end;

    //integration for Applicant Reg
    [IntegrationEvent(false, false)]
    procedure OnSendApplicantRegForApproval(VAR ApplicantReg: Record "Applicant Registration")
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelApplicantRegApprovalRequest(VAR ApplicantReg: Record "Applicant Registration")
    begin

    end;
    // Integration For Unit Registration
    [IntegrationEvent(false, false)]
    procedure OnSendUnitsRegForApproval(VAR UnitReg: Record "Unit Registration")
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelUnitRegApprovalRequest(VAR UnitReg: Record "Unit Registration")
    begin

    end;
    //Integration for invoicing
    [IntegrationEvent(false, false)]
    procedure OnSendInvoiceForApproval(VAR Inv: Record "Student Invoice")
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelInvoiceApprovalRequest(VAR Inv: Record "Student Invoice")
    begin

    end;
    //Interegration For Receipting
    [IntegrationEvent(false, false)]
    procedure OnSendReceiptForApproval(Var Receipt: Record "Receipt Header")
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelReceiptApprovalRequest(var Receipt: Record "Receipt Header")
    begin

    end;


    [EventSubscriber(ObjectType::Codeunit, 1535, 'OnPopulateApprovalEntryArgument', '', false, false)]
    local procedure OnPopulateApprovalEntryArgument(VAR RecRef: RecordRef; VAR ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
    var

        ApplicantReg: Record "Applicant Registration";
        NumberSeries: Codeunit NoSeriesManagement;
        Inv: Record "Student Invoice";
        Receipt: Record "Receipt Header";
        UnitReg: Record "Unit Registration";
        ApprovalAmnt: Decimal;
    begin
        CASE RecRef.NUMBER OF

            DATABASE::"Applicant Registration":
                BEGIN
                    RecRef.SETTABLE(ApplicantReg);

                    ApprovalEntryArgument."Document No." := ApplicantReg."Application No.";

                END;
            Database::"Unit Registration":
                begin
                    RecRef.SetTable(UnitReg);
                    ApprovalEntryArgument."Document No." := UnitReg."No.";
                end;

            Database::"Student Invoice":
                begin
                    RecRef.SetTable(Inv);
                    Inv.CalcFields("Invoiced Amount");
                    ApprovalAmnt := Inv."Invoiced Amount";
                    ApprovalEntryArgument.Amount := ApprovalAmnt;
                    ApprovalEntryArgument."Amount (LCY)" := ApprovalAmnt;
                    ApprovalEntryArgument."Document No." := Inv."No."
                end;

            Database::"Receipt Header":
                begin
                    RecRef.SetTable(Receipt);
                    Receipt.CalcFields(" Receipt Amount");
                    ApprovalAmnt := Receipt." Receipt Amount";
                    ApprovalEntryArgument.Amount := ApprovalAmnt;
                    ApprovalEntryArgument."Amount (LCY)" := ApprovalAmnt;
                    ApprovalEntryArgument."Document No." := Receipt."No.";
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 1535, 'OnSetStatusToPendingApproval', '', false, false)]
    local procedure OnSetStatusToPendingApproval(RecRef: RecordRef; VAR Variant: Variant; VAR IsHandled: Boolean)
    var
        ApplicantReg: Record "Applicant Registration";
        NumberSeries: Codeunit NoSeriesManagement;
        Inv: Record "Student Invoice";
        Receipt: Record "Receipt Header";
        UnitReg: Record "Unit Registration";
    begin

        CASE RecRef.NUMBER OF

            DATABASE::"Applicant Registration":
                BEGIN
                    RecRef.SETTABLE(ApplicantReg);
                    ApplicantReg.VALIDATE("Approval Status", ApplicantReg."Approval Status"::"Pending");
                    ApplicantReg.MODIFY(TRUE);
                    Variant := ApplicantReg;
                    IsHandled := true;
                END;
            Database::"Unit Registration":
                begin
                    RecRef.SetTable(UnitReg);
                    UnitReg.Validate(Status, UnitReg.Status::Pending);
                    UnitReg.Modify(true);
                    Variant := UnitReg;
                    IsHandled := true;
                end;

            Database::"Student Invoice":
                begin
                    RecRef.SetTable(Inv);
                    Inv.Validate("Status", Inv.Status::"Pending");
                    Inv.Modify(true);
                    Variant := Inv;
                    IsHandled := true;
                end;

            Database::"Receipt Header":
                begin
                    RecRef.SetTable(Receipt);
                    Receipt.Validate(Status, Receipt.Status::Pending);
                    Receipt.Modify(true);
                    Variant := Receipt;
                    IsHandled := true;
                end;
        end;
    end;

}
