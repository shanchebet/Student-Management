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

    Procedure MyProcedure()
    var
    begin

    end;
}
