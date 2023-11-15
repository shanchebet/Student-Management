codeunit 60100 "Workflow Event Handling CUExt"
{
    var
        WorkflowEvent: Codeunit "Workflow Event Handling";
        WorkflowManagement: Codeunit "Workflow Management";
        //global var used for APPlicant Registration.
        ApplicantRegSendForApprovalEventDescTxt: Label 'Approval of Applicant registration is requested';
        ApplicantRegApprovalRequestCancelEventDescTxt: Label 'Approval Request for Applicant Registration has been cancel';
        ApplicantRegReleasedEventDescTxt: Label 'Applicant Registration has been released';
        //variables used for Unit Registration
        UnitRegSendForApprovalEventDescTxt: Label 'Approval of Units registration is requested';
        UnitRegApprovalRequestCancelEventDescTxt: Label 'Approval Request for Units Registration has been cancel';
        UnitRegReleasedEventDescTxt: Label 'Units Registration has been released';

        //Variables used for student Invoices.
        InvoiceSendForApprovalEventDescTxt: Label 'Approval of Invoice is requested';
        InvoiceApprovalRequestCancelEventDescTxt: Label 'Approval Request for Invoices has been cancel';
        InvoiceReleasedEventDescTxt: Label 'Invoices has been released';
        //Variables used for Receipt Payments.
        ReceiptSendForApprovalEventDescTxt: Label 'Approval of Receipt Payment is requested';
        ReceiptApprovalRequestCancelEventDescTxt: Label 'Approval Request for Receipt Payment has been cancel';
        ReceiptReleasedEventDescTxt: Label 'Receipt Payment has been released';

    //functions for Applicant registrations
    procedure RunWorkflowOnSendApplicantRegForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendApplicantRegForApprovalCode'));
    end;

    procedure RunWorkflowOnCancelApplicantRegForApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelApplicantRegForApprovalRequestCode'));
    end;

    procedure RunWorkflowOnAfterReleaseApplicantRegCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnAfterReleaseApplicantRegCode'));
    end;

    procedure RunWorkflowOnRejectedApplicantRegCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnRejectedApplicantRegCode'));
    end;
    //Functions For Unit Registratiion
    procedure RunWorkflowOnSendUnitsForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendUnitsForApprovalCode'))
    end;

    procedure RunWorkflowOnCancelUnitsForApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelUnitsForApprovalRequestCode'));
    end;

    procedure RunWorkflowOnAfterReleaseUnitsCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnAfterReleaseUnitsCode'));
    end;

    procedure RunWorkflowOnRejectedUnitsCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnRejectedInvoiceCode'));
    end;
    //FUNCTIONS FOR student Invoice
    procedure RunWorkflowOnSendInvoiceForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendInvoiceForApprovalCode'))
    end;

    procedure RunWorkflowOnCancelInvoiceForApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelInvoiceForApprovalRequestCode'));
    end;

    procedure RunWorkflowOnAfterReleaseInvoiceCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnAfterReleaseInvoiceCode'));
    end;

    procedure RunWorkflowOnRejectedInvoiceCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnRejectedInvoiceCode'));
    end;


    //FUNCTIONS FOR RECEIPT PAYMENTS
    procedure RunWorkflowOnSendReceiptForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendReceiptForApprovalCode'))
    end;

    procedure RunWorkflowOnCancelReceiptForApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelReceiptForApprovalRequestCode'));
    end;

    procedure RunWorkflowOnAfterReleaseReceiptCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnAfterReleaseReceiptCode'));
    end;

    procedure RunWorkflowOnRejectedReceiptCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnRejectedReceiptCode'));
    end;

    [EventSubscriber(ObjectType::Codeunit, 1520, 'OnAddWorkflowEventsToLibrary', '', false, false)]
    local procedure OnAddWorkflowEventsToLibrary()
    begin
        //Applicant Reg
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnSendApplicantRegForApprovalCode, 60100, ApplicantRegSendForApprovalEventDescTxt, 0, false);
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnCancelApplicantRegForApprovalRequestCode, Database::"Applicant Registration", ApplicantRegApprovalRequestCancelEventDescTxt, 0, false);
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnAfterReleaseApplicantRegCode, Database::"Applicant Registration", ApplicantRegReleasedEventDescTxt, 0, false);
        //invoicing process
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnSendInvoiceForApprovalCode, Database::"Student Invoice", InvoiceSendForApprovalEventDescTxt, 0, false);
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnCancelInvoiceForApprovalRequestCode, Database::"Student Invoice", InvoiceApprovalRequestCancelEventDescTxt, 0, false);
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnAfterReleaseInvoiceCode, Database::"Student Invoice", InvoiceReleasedEventDescTxt, 0, false);
        //RECEIPTING PROCESS
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnSendReceiptForApprovalCode, Database::"Receipt Header", ReceiptSendForApprovalEventDescTxt, 0, false);
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnCancelReceiptForApprovalRequestCode, Database::"Receipt Header", ReceiptApprovalRequestCancelEventDescTxt, 0, false);
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnAfterReleaseReceiptCode, Database::"Receipt Header", ReceiptReleasedEventDescTxt, 0, false);
        //Unit Registration Process
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnSendUnitsForApprovalCode, Database::"Unit Registration", UnitRegSendForApprovalEventDescTxt, 0, false);
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnCancelUnitsForApprovalRequestCode, Database::"Unit Registration", UnitRegApprovalRequestCancelEventDescTxt, 0, false);
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnAfterReleaseUnitsCode, Database::"Unit Registration", UnitRegReleasedEventDescTxt, 0, false);

    end;

    [EventSubscriber(ObjectType::Codeunit, 1520, 'OnAddWorkflowEventPredecessorsToLibrary', '', false, false)]
    local procedure OnAddWorkflowEventPredecessorsToLibrary(EventFunctionName: Code[128])
    var
        WorkflowEvent: Codeunit "Workflow Event Handling";
    begin
        case EventFunctionName of

            //Applicant Registration
            RunWorkflowOnCancelApplicantRegForApprovalRequestCode:
                WorkflowEvent.AddEventPredecessor(RunWorkflowOnCancelApplicantRegForApprovalRequestCode, RunWorkflowOnSendApplicantRegForApprovalCode);


            WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode:
                begin
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendApplicantRegForApprovalCode);
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendInvoiceForApprovalCode);
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendReceiptForApprovalCode);
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendUnitsForApprovalCode);

                end;

            RunWorkflowOnRejectedApplicantRegCode:
                WorkflowEvent.AddEventPredecessor(RunWorkflowOnRejectedApplicantRegCode, RunWorkflowOnSendApplicantRegForApprovalCode);

            WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode:
                begin
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendApplicantRegForApprovalCode);
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendInvoiceForApprovalCode);
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendReceiptForApprovalCode);
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendUnitsForApprovalCode);

                end;
            //Invoincing Process
            RunWorkflowOnCancelInvoiceForApprovalRequestCode:
                WorkflowEvent.AddEventPredecessor(RunWorkflowOnCancelInvoiceForApprovalRequestCode, RunWorkflowOnSendInvoiceForApprovalCode);

            RunWorkflowOnRejectedInvoiceCode:
                WorkflowEvent.AddEventPredecessor(RunWorkflowOnRejectedInvoiceCode, RunWorkflowOnSendInvoiceForApprovalCode);
            //RECEIPTING PROCESS
            RunWorkflowOnCancelReceiptForApprovalRequestCode:
                WorkflowEvent.AddEventPredecessor(RunWorkflowOnCancelReceiptForApprovalRequestCode, RunWorkflowOnSendReceiptForApprovalCode);

            RunWorkflowOnRejectedReceiptCode:
                WorkflowEvent.AddEventPredecessor(RunWorkflowOnRejectedReceiptCode, RunWorkflowOnSendReceiptForApprovalCode);
            //Unit Registration Process
            RunWorkflowOnCancelUnitsForApprovalRequestCode:
                WorkflowEvent.AddEventPredecessor(RunWorkflowOnCancelUnitsForApprovalRequestCode, RunWorkflowOnSendUnitsForApprovalCode);
            RunWorkflowOnRejectedUnitsCode:
                WorkflowEvent.AddEventPredecessor(RunWorkflowOnRejectedUnitsCode, RunWorkflowOnSendUnitsForApprovalCode);


        end;
    end;

    //EventSubscriber For Applicant Registration

    [EventSubscriber(ObjectType::Codeunit::Codeunit, 60101, 'OnSendApplicantRegForApproval', '', false, false)]
    local procedure RunWorkflowOnSendApplicantRegForApproval(var ApplicantReg: Record "Applicant Registration")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendApplicantRegForApprovalCode, ApplicantReg);
    end;

    [EventSubscriber(ObjectType::Codeunit::Codeunit, 60101, 'OnCancelApplicantRegApprovalRequest', '', false, false)]
    local procedure RunWorkflowOnCancelApplicantRegForApproval(var ApplicantReg: Record "Applicant Registration")
    var
        ApplicantRec: Record "Applicant Registration";
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelApplicantRegForApprovalRequestCode, ApplicantReg);
        ApplicantRec.Reset();
        ApplicantRec.SetRange("Application No.", ApplicantReg."Application No.");
        if ApplicantRec.FindFirst then begin
            ApplicantRec."Approval Status" := ApplicantRec."Approval Status"::OPen;
            ApplicantRec.Modify();
        end;
    end;
    //EventSubscriber For Units Registration

    [EventSubscriber(ObjectType::Codeunit::Codeunit, 60101, 'OnSendUnitsRegForApproval', '', false, false)]
    local procedure RunWorkflowOnSendUnitsRegForApproval(var UnitReg: Record "Unit Registration")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendUnitsForApprovalCode, UnitReg);
    end;


    [EventSubscriber(ObjectType::Codeunit::Codeunit, 60101, 'OnCancelUnitRegApprovalRequest', '', false, false)]
    local procedure RunWorkflowOnCancelUnitsRegForApproval(var UnitReg: Record "Unit Registration")
    var
        UnitsRec: Record "Unit Registration";
    // UnitReg: Record "Unit Registration Line";
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelUnitsForApprovalRequestCode, UnitReg);
        UnitsRec.Reset();
        UnitsRec.SetRange("No.", UnitReg."No.");
        if UnitsRec.FindFirst then begin
            UnitsRec.Status := UnitsRec.Status::OPen;
            UnitsRec.Modify();
        end;
    end;
    //Eventsubscriber for Student Invoice
    [EventSubscriber(ObjectType::Codeunit::Codeunit, 60101, 'OnSendInvoiceForApproval', '', false, false)]
    local procedure RunWorkflowOnSendInvoiceForApproval(VAR Inv: Record "Student Invoice")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendInvoiceForApprovalCode, Inv);
    end;

    [EventSubscriber(ObjectType::Codeunit::Codeunit, 60101, 'OnCancelInvoiceApprovalRequest', '', false, false)]

    local procedure RunWorkflowOnCancelInvoiceForApproval(VAR Inv: Record "Student Invoice")
    var
        InvRec: Record "Student Invoice";
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelInvoiceForApprovalRequestCode, Inv);
        InvRec.Reset();
        InvRec.SetRange("No.", Inv."No.");
        if InvRec.FindFirst then begin
            InvRec."Status" := InvRec."Status"::OPen;
            InvRec.Modify();
        end;
    end;

    //EventSubscriber For Receipt Payments.
    [EventSubscriber(ObjectType::Codeunit::Codeunit, 60101, 'OnSendReceiptForApproval', '', false, false)]
    local procedure RunWorkflowOnSendReceiptForApproval(Var Receipt: Record "Receipt Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendReceiptForApprovalCode, Receipt);
    end;

    [EventSubscriber(ObjectType::Codeunit::Codeunit, 60101, 'OnCancelReceiptApprovalRequest', '', false, false)]

    local procedure RunWorkflowOnCancelReceiptForApproval(Var Receipt: Record "Receipt Header")
    var
        ReceiptRec: Record "Receipt Header";
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelReceiptForApprovalRequestCode, Receipt);
        ReceiptRec.Reset();
        ReceiptRec.SetRange("No.", Receipt."No.");
        if ReceiptRec.FindFirst then begin
            ReceiptRec."Status" := ReceiptRec."Status"::OPen;
            ReceiptRec.Modify();
        end;
    end;

    //rejecting Applicant Registration
    [EventSubscriber(ObjectType::Codeunit::Codeunit, 1535, 'OnRejectApprovalRequest', '', false, false)]
    procedure RunWorkflowOnRejectApplicantRegForApproval(VAR ApprovalEntry: Record "Approval Entry")
    var
        ApplicantRec: Record "Applicant Registration";
    begin
        WorkflowManagement.HandleEventOnKnownWorkflowInstance(RunWorkflowOnRejectedApplicantRegCode, ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
        ApplicantRec.RESET();
        ApplicantRec.SetRange("Application No.", ApprovalEntry."Document No.");
        if ApplicantRec.FindFirst then begin
            ApplicantRec."Approval Status" := ApplicantRec."Approval Status"::Rejected;
            ApplicantRec.Modify();

        end;

    end;
    //rejecting Unit Registration
    [EventSubscriber(ObjectType::Codeunit::Codeunit, 1535, 'OnRejectApprovalRequest', '', false, false)]
    procedure RunWorkflowOnRejectUnitRegForApproval(VAR ApprovalEntry: Record "Approval Entry")
    var
        UnitRec: Record "Unit Registration";
    begin
        WorkflowManagement.HandleEventOnKnownWorkflowInstance(RunWorkflowOnRejectedUnitsCode, ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
        UnitRec.RESET();
        UnitRec.SetRange("No.", ApprovalEntry."Document No.");
        if UnitRec.FindFirst then begin
            UnitRec.Status := UnitRec.Status::Rejected;
            UnitRec.Modify();

        end;

    end;
    // rejecting Student Invoice
    [EventSubscriber(ObjectType::Codeunit::Codeunit, 1535, 'OnRejectApprovalRequest', '', false, false)]
    local procedure RunWorkflowOnRejectInvoiceForApproval(VAR ApprovalEntry: Record "Approval Entry")
    var
        InvRec: Record "Student Invoice";
    begin
        WorkflowManagement.HandleEventOnKnownWorkflowInstance(RunWorkflowOnRejectedInvoiceCode, ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
        InvRec.RESET();
        InvRec.SetRange("No.", ApprovalEntry."Document No.");
        if InvRec.FindFirst then begin
            InvRec."Status" := InvRec."Status"::Rejected;
            InvRec.Modify();
        end;

    end;
    //for Rejecting Receipts
    [EventSubscriber(ObjectType::Codeunit::Codeunit, 1535, 'OnRejectApprovalRequest', '', false, false)]
    local procedure RunWorkflowOnRejectReceiptForApproval(VAR ApprovalEntry: Record "Approval Entry")
    var
        ReceiptRec: Record "Receipt Header";

    begin
        WorkflowManagement.HandleEventOnKnownWorkflowInstance(RunWorkflowOnRejectedReceiptCode, ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
        ReceiptRec.RESET();
        ReceiptRec.SetRange("No.", ApprovalEntry."Document No.");
        if ReceiptRec.FindFirst then begin
            ReceiptRec."Status" := ReceiptRec."Status"::Rejected;
            ReceiptRec.Modify();
        end;

    end;

}
