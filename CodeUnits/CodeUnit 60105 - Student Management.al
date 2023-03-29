codeunit 60105 "Student Management"
{
    trigger OnRun()
    begin

    end;

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


}
