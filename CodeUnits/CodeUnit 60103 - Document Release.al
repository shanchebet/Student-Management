codeunit 60103 "Document Release"
{
    trigger OnRun()
    begin
    end;
    //procedure used to release Units registration in the lines .
    procedure UnitRegRelease(var UnitReg: Record "Unit Registration")
    var
        UnitRecLines: Record "Unit Registration Line";
    begin
        with UnitReg do begin
            UnitRecLines.SetRange("Document No.", "No.");
            UnitRecLines.SetRange(Select, true);
            if UnitRecLines.FindSet() then begin
                repeat
                    UnitRecLines."Unit Status" := UnitRecLines."Unit Status"::Registered;
                    UnitRecLines.Modify();
                until UnitRecLines.Next() = 0;
            end;
        end;
    end;

    procedure UnitRegReopen(var UnitReg: Record "Unit Registration Line")
    begin
        with UnitReg do begin

            UnitReg."Unit Status" := UnitReg."Unit Status"::open;
            UnitReg.Modify();
        end;

    end;
    //Procedure used to release an invoice
    procedure InvoiceRelease(var InvRec: Record "Student Invoice")
    var
        StudInvc: Record "Student Invoice";
    begin
        InvRec.Status := InvRec.Status::Released;
        InvRec.Modify();
    end;

    procedure InvoiceReopen(var InvRec: Record "Student Invoice")
    begin
        InvRec.Status := InvRec.Status::OPen;
        InvRec.Modify();
    end;
    //procedure used to Release Units
    procedure UnitsRelease(var UnitsRec: Record "Unit Registration")
    var
        UnitReg: Record "Unit Registration";
    begin
        UnitReg.Reset();
        UnitReg.SetRange("No.", UnitsRec."No.");
        if UnitReg.FindFirst() then begin
            UnitsRec.Status := UnitsRec.Status::Released;
            UnitsRec.Modify();
            UnitRegRelease(UnitsRec);
        end;
    end;

    procedure UnitsReopen(var UnitsRec: Record "Unit Registration")
    begin
        UnitsRec.Status := UnitsRec.Status::OPen;
        UnitsRec.Modify();
    end;

    //procedure Used to Release Receipts
    procedure ReceiptRelease(Var Receipt: Record "Receipt Header")
    var
        RcptHdr: Record "Receipt Header";
    begin
        Receipt.Status := Receipt.Status::Released;
        Receipt.Modify();
    end;

    procedure ReceiptReopen(var Receipt: Record "Receipt Header")
    begin
        Receipt.Status := Receipt.Status::OPen;
        Receipt.Modify();
    end;

    //Procedure for Applicant Registration
    procedure ApplicantRegRelease(var ApplicantRec: Record "Applicant Registration")
    var
        AppReg: Record "Applicant Registration";
        StudMgt: Codeunit "Student Management";
    begin
        AppReg.Reset();
        AppReg.SetRange("Application No.", ApplicantRec."Application No.");
        if AppReg.FindFirst() then begin
            ApplicantRec."Approval Status" := ApplicantRec."Approval Status"::Released;
            ApplicantRec.Modify();
            CreateApplicant(ApplicantRec);
            StudMgt.EmailAdmissionLetter(ApplicantRec);
        end;
    end;

    procedure ApplicantRegReopen(var ApplicantRec: Record "Applicant Registration")
    begin
        ApplicantRec."Approval Status" := ApplicantRec."Approval Status"::Open;
        ApplicantRec.Modify();
    end;

    procedure CreateApplicant(ApplicantRec: Record "Applicant Registration")
    var
        Cust: Record Customer;
        StdMgtSetup: Record "Student Management Setup";
    begin
        StdMgtSetup.Get();
        StdMgtSetup.TestField("Gen. Bus. Posting Group");
        StdMgtSetup.TestField("VAT Bus. Posting Group");
        StdMgtSetup.TestField("Customer Posting Group");
        if ApplicantRec."Approval Status" = ApplicantRec."Approval Status"::Released then begin
            Cust.Init();
            Cust.TransferFields(ApplicantRec);
            Cust."Gen. Bus. Posting Group" := StdMgtSetup."Gen. Bus. Posting Group";
            Cust."VAT Bus. Posting Group" := StdMgtSetup."VAT Bus. Posting Group";
            Cust."Customer Posting Group" := StdMgtSetup."Customer Posting Group";
            Cust.Insert();
        end;
    end;
}
