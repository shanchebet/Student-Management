report 60100 "Suggest Units Registration"
{
    Caption = 'Suggest Units Registration';
    ProcessingOnly = true;
    dataset
    {
        dataitem("Unit Registration"; "Unit Registration")
        {
            trigger OnAfterGetRecord()
            begin

                // Test if the Semester and and Academic Year Code Has A value 
                "Unit Registration".TestField(Semester);
                "Unit Registration".TestField("Academic Year Code");
                "Unit Registration".TestField("Course Of Study");
                //Clear Unit Registration Lines
                StudMgt.ClearUnitRegistrationLines("Unit Registration");
                //Insert Into the Unit Registration lines from Unit Matrix Table(Record)
                UnitMat.Reset();
                UnitMat.SetRange("Academic Year Code", "Academic Year Code");
                UnitMat.SetRange("Semester Code", Semester);
                UnitMat.SetRange("Course Code", "Course Of Study");
                UnitMat.SetRange("Course Description", "Course Description");

                if UnitMat.Find('-') then begin
                    repeat
                        LineNo := 10000;//Set The Starting Value of Line No and Increment as the Record is generated
                        UnitRegLines.Init();//Initializes the records
                        UnitRegLines."Line No" += LineNo;
                        UnitRegLines."Document No." := "No.";
                        UnitRegLines."Unit Code" := UnitMat."Unit Code";
                        UnitRegLines.Validate("Unit Code");
                        UnitRegLines."Unit Core/Elective" := UnitMat."Unit Core/Elective";
                        UnitRegLines.Insert();
                    until UnitMat.Next() = 0;
                end;
            end;
        }
    }
    var
        UnitMat: Record "Unit Matrix";
        UnitRegLines: Record "Unit Registration Line";
        LineNo: Integer;
        StudMgt: Codeunit "Student Management";
}
