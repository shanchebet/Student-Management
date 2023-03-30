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
                END;
            WorkFlowResponse.CreateApprovalRequestsCode:
                BEGIN

                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnSendApplicantRegForApprovalCode);
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnSendInvoiceForApprovalCode);
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnSendReceiptForApprovalCode);

                END;
            WorkFlowResponse.SendApprovalRequestForApprovalCode:
                BEGIN

                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode, WorkflowEventHandling.RunWorkflowOnSendApplicantRegForApprovalCode);
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode, WorkflowEventHandling.RunWorkflowOnSendInvoiceForApprovalCode);
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode, WorkflowEventHandling.RunWorkflowOnSendReceiptForApprovalCode);

                END;
            WorkFlowResponse.OpenDocumentCode:
                BEGIN

                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode, WorkflowEventHandling.RunWorkflowOnRejectedApplicantRegCode);
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode, WorkflowEventHandling.RunWorkflowOnSendInvoiceForApprovalCode);
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode, WorkflowEventHandling.RunWorkflowOnSendReceiptForApprovalCode);
                END;

            WorkFlowResponse.CancelAllApprovalRequestsCode:
                BEGIN

                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnCancelApplicantRegForApprovalRequestCode);
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnSendInvoiceForApprovalCode);
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnSendReceiptForApprovalCode);
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
    begin
        VarVariant := RecRef;
        CASE RecRef.NUMBER OF
            DATABASE::"Applicant Registration":
                begin
                    ApplicantReg.SetView(RecRef.GetView());
                    Handled := true;
                    ReleaseDoc.ApplicantRegRelease(VarVariant);
                    ReleaseDoc.CreateApplicant(VarVariant);
                    StudMgt.EmailAdmissionLetter(VarVariant)
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
    begin
        VarVariant := RecRef;
        CASE RecRef.NUMBER OF
            DATABASE::"Applicant Registration":
                begin
                    ApplicantReg.SetView(RecRef.GetView());
                    Handled := true;
                    ReleaseDoc.ApplicantRegReopen(VarVariant);

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
