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
            MinimumPoints := Cluster."Manimum Points";
            if ClusterReg.Points > MaximumPoints then begin
                Error('Points Exceed The Maximum Grade selected.', ClusterReg.Points - MaximumPoints);
            end;
            if ClusterReg.Points < MinimumPoints then begin
                Error('The points are below the Minimum Grade selected', MinimumPoints - ClusterReg.Points);
            end;
        end;
    end;

    procedure EmailAdmissionLetter(ApplicantRec: Record "Applicant Registration")

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

            TempBlob.CreateOutStream(Oustr);
            Report.SaveAs(Report::"Fee Statement", '', ReportFormat::Pdf, Oustr);
            TempBlob.CreateInStream(Instr);

            EmailMessage.Create(Recipient, Subject, BodyTxt, false);
            EmailMessage.AddAttachment('Fee Statement.pdf', 'pdf', Base64Convert.ToBase64(Instr));
            Email.Send(EmailMessage);
        end;
    end;

}
