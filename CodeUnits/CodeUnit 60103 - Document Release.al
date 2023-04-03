codeunit 60103 "Document Release"
{
    trigger OnRun()
    begin
    end;

    procedure UnitRegRelease(var UnitReg: Record "Unit Registration")
    var
        MExits: Record "Unit Registration Line";
    begin
        with UnitReg do begin
            MExits.SetRange("Document No.", "No.");
            MExits.SetRange(Select, true);
            if MExits.FindSet() then begin
                repeat
                    MExits."Unit Status" := MExits."Unit Status"::Registered;
                    MExits.Modify();
                until MExits.Next() = 0;
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
        MEXists: Record "Student Invoice";
    begin
        InvRec.Status := InvRec.Status::Released;
        InvRec.Modify();
    end;

    procedure InvoiceReopen(var InvRec: Record "Student Invoice")
    begin
        InvRec.Status := InvRec.Status::OPen;
        InvRec.Modify();
    end;
    //procedure Used to Release Receipts
    procedure ReceiptRelease(Var Receipt: Record "Receipt Header")
    var
        MEXists: Record "Receipt Header";
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
        MExits: Record "Applicant Registration";
        StudMgt: Codeunit "Student Management";
    begin
        MExits.Reset();
        MExits.SetRange("Application No.", ApplicantRec."Application No.");
        if MExits.FindFirst() then begin
            ApplicantRec."Approval Status" := ApplicantRec."Approval Status"::Released;
            ApplicantRec.Modify();
            //CreateApplicant(ApplicantRec);
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
    begin
        if ApplicantRec."Approval Status" = ApplicantRec."Approval Status"::Released then begin
            Cust.Init();
            Cust.TransferFields(ApplicantRec);
            Cust.Insert();
        end;
    end;
}
