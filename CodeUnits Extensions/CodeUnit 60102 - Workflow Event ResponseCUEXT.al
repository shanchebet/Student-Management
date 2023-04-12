codeunit 60102 "Workflow Event Response CUEXT"
{
    [EventSubscriber(ObjectType::Codeunit, 1521, 'OnAddWorkflowResponsePredecessorsToLibrary', '', false, false)]
    local procedure OnAddWorkflowResponsePredecessorsToLibrary(ResponseFunctionName: Code[128])
    var
        WorkflowEventHandling: Codeunit "Workflow Event Handling CUExt";
        WorkFlowResponse: Codeunit "Workflow Response Handling";
    begin
        CASE ResponseFunctionName OF

            WorkFlowResponse.SetStatusToPendingApprovalCode:
                BEGIN
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode, WorkflowEventHandling.RunWorkflowOnSendApplicantRegForApprovalCode);
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode, WorkflowEventHandling.RunWorkflowOnSendInvoiceForApprovalCode);
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode, WorkflowEventHandling.RunWorkflowOnSendReceiptForApprovalCode);
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode, WorkflowEventHandling.RunWorkflowOnSendUnitsForApprovalCode);

                END;
            WorkFlowResponse.CreateApprovalRequestsCode:
                BEGIN

                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnSendApplicantRegForApprovalCode);
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnSendInvoiceForApprovalCode);
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnSendReceiptForApprovalCode);
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnSendUnitsForApprovalCode);

                END;
            WorkFlowResponse.SendApprovalRequestForApprovalCode:
                BEGIN

                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode, WorkflowEventHandling.RunWorkflowOnSendApplicantRegForApprovalCode);
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode, WorkflowEventHandling.RunWorkflowOnSendInvoiceForApprovalCode);
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode, WorkflowEventHandling.RunWorkflowOnSendReceiptForApprovalCode);
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode, WorkflowEventHandling.RunWorkflowOnSendUnitsForApprovalCode);

                END;
            WorkFlowResponse.OpenDocumentCode:
                BEGIN

                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode, WorkflowEventHandling.RunWorkflowOnRejectedApplicantRegCode);
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode, WorkflowEventHandling.RunWorkflowOnSendInvoiceForApprovalCode);
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode, WorkflowEventHandling.RunWorkflowOnSendReceiptForApprovalCode);
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode, WorkflowEventHandling.RunWorkflowOnSendUnitsForApprovalCode);
                END;

            WorkFlowResponse.CancelAllApprovalRequestsCode:
                BEGIN

                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnCancelApplicantRegForApprovalRequestCode);
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnSendInvoiceForApprovalCode);
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnSendReceiptForApprovalCode);
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnSendUnitsForApprovalCode);
                END;
        end;

    end;

    [EventSubscriber(ObjectType::Codeunit, 1521, 'OnReleaseDocument', '', false, false)]
    local procedure OnReleaseDocument(RecRef: RecordRef; VAR Handled: Boolean)
    var
        ReleaseDoc: Codeunit "Document Release";
        ApplicantReg: Record "Applicant Registration";
        Inv: Record "Student Invoice";
        Receipt: Record "Receipt Header";
        VarVariant: Variant;
        StudMgt: Codeunit "Student Management";
        UnitRec: Record "Unit Registration";
    begin
        VarVariant := RecRef;
        CASE RecRef.NUMBER OF
            DATABASE::"Applicant Registration":
                begin
                    ApplicantReg.SetView(RecRef.GetView());
                    Handled := true;
                    ReleaseDoc.ApplicantRegRelease(VarVariant);
                end;
            Database::"Unit Registration":
                begin
                    UnitRec.SetView(RecRef.GetView());
                    Handled := true;
                    ReleaseDoc.UnitsRelease(VarVariant);
                end;

            Database::"Student Invoice":
                begin
                    Inv.SetView(RecRef.GetView());
                    Handled := true;
                    ReleaseDoc.InvoiceRelease(VarVariant);
                end;

            Database::"Receipt Header":
                begin
                    Receipt.SetView(RecRef.GetView());
                    Handled := true;
                    ReleaseDoc.ReceiptRelease(VarVariant);
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 1521, 'OnOpenDocument', '', false, false)]
    local procedure OnOpenDocument(RecRef: RecordRef; VAR Handled: Boolean)
    var
        ReleaseDoc: Codeunit "Document Release";
        ApplicantReg: Record "Applicant Registration";
        Inv: Record "Student Invoice";
        Receipt: Record "Receipt Header";
        VarVariant: Variant;
        UnitRec: Record "Unit Registration";
    begin
        VarVariant := RecRef;
        CASE RecRef.NUMBER OF
            DATABASE::"Applicant Registration":
                begin
                    ApplicantReg.SetView(RecRef.GetView());
                    Handled := true;
                    ReleaseDoc.ApplicantRegReopen(VarVariant);

                end;
            Database::"Unit Registration":
                begin
                    UnitRec.SetView(RecRef.GetView());
                    Handled := true;
                    ReleaseDoc.UnitsReopen(VarVariant);
                end;

            Database::"Student Invoice":
                begin
                    Inv.SetView(RecRef.GetView());
                    Handled := true;
                    ReleaseDoc.InvoiceReopen(VarVariant);
                end;
            Database::"Receipt Header":
                begin

                    Receipt.SetView(RecRef.GetView());
                    Handled := true;
                    ReleaseDoc.InvoiceReopen(VarVariant);
                end;
        end;
    end;
}
