codeunit 60105 "Student Management"
{
    trigger OnRun()
    begin

    end;

    var
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        Recipient: text;
        Instr: InStream;
        Oustr: OutStream;
        TempBlob: Codeunit "Temp Blob";
        TextBuilder: TextBuilder;
        Base64Convert: Codeunit "Base64 Convert";
        RecRef: RecordRef;
        BodyTxt: Text;
        Location: Text;
        FileName: Text;
        Subject: Text;
        File: File;
        CompInfor: Record "Company Information";

    // Clear Unit Registration Line if Exist Before Inserting new values
    procedure ClearUnitRegistrationLines(UnitReg: Record "Unit Registration")
    var
        UnitRegLine: Record "Unit Registration Line";
    begin
        with UnitReg do begin
            UnitRegLine.Reset();
            UnitRegLine.SetRange("Document No.", "No.");
            UnitRegLine.DeleteAll();
        end;
    end;

    //clear Receipt Lines If Exist Before Inserting New Values
    procedure ClearReceiptHeaderLines(RCPT: Record "Receipt Header")
    var
        RCPTREC: Record "Receipt Header Lines";
    begin
        with RCPT do begin
            RCPTREC.Reset();
            RCPTREC.SetRange("Document No", "No.");
            RCPTREC.DeleteAll();

        end;

    end;
    // Clear student Invoice lines
    procedure ClearStudentInvoiceLines(StdInv: Record "Student Invoice")
    var
        StdInvRec: Record "Student Invoice Lines";
    begin
        with StdInv do begin
            StdInvRec.Reset();
            StdInvRec.SetRange("Document No.", "No.");
            StdInvRec.DeleteAll();
        end;

    end;
    //procedure for checking the cluster points in applicant card.
    procedure CheckClusterPointsRange(var ClusterReg: Record "Applicant Registration")
    var
        Cluster: Record "Cluster Points";
        MaximumPoints: Integer;
        MinimumPoints: Integer;
    begin
        MaximumPoints := 0;
        MinimumPoints := 0;
        Cluster.Reset();
        Cluster.SetRange(Grade, ClusterReg."Grade Attain");
        if Cluster.FindFirst() then begin
            MaximumPoints := Cluster."Maximum Points";
            MinimumPoints := Cluster."Minimum Points";
            if ClusterReg.Points > MaximumPoints then begin
                Error('Points Exceed The Maximum Grade selected.', ClusterReg.Points - MaximumPoints);
            end;
            if ClusterReg.Points < MinimumPoints then begin
                Error('The points are below the Minimum Grade selected', MinimumPoints - ClusterReg.Points);
            end;
        end;
    end;

    procedure EmailAdmissionLetter(ApplicantRec: Record "Applicant Registration")
    var
        AdmissionLetter: Report "Admission Letter Report";
        FilePath: Text;
        AppRec: Record "Applicant Registration";
    begin
        if ApplicantRec."Approval Status" = ApplicantRec."Approval Status"::Released then begin

            Clear(EmailMessage);
            Clear(TextBuilder);
            Clear(Email);
            Clear(Recipient);
            Clear(BodyTxt);
            Clear(Subject);
            Clear(RecRef);

            CompInfor.Get();

            if RecRef.Get(ApplicantRec.RecordId) then;
            Recipient := ApplicantRec.Email;
            Subject := 'Admission Letter';

            TextBuilder.AppendLine('Dear ' + ApplicantRec."Full Name");
            TextBuilder.AppendLine();//New Line
            TextBuilder.AppendLine('Find attached Admission Letter');
            TextBuilder.AppendLine();//New Line
            TextBuilder.AppendLine('Kind Regards,');
            TextBuilder.AppendLine();//New Line
            TextBuilder.AppendLine(CompInfor.Name);

            BodyTxt := TextBuilder.ToText();

            Location := TemporaryPath + 'Admission Letter.pdf';

            AppRec.Reset();
            AppRec.SetRange("Application No.", ApplicantRec."Application No.");
            if AppRec.FindFirst() then;

            Clear(AdmissionLetter);
            AdmissionLetter.SetTableView(AppRec);
            AdmissionLetter.SaveAsPdf(Location);

            File.Open(Location);
            File.CreateInStream(Instr);

            EmailMessage.Create(Recipient, Subject, BodyTxt, false);
            EmailMessage.AddAttachment(Location, 'pdf', Instr);
            Email.Send(EmailMessage);
            File.Close();
        end;
    end;
}
