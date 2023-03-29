table 60119 "Cluster Points"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; No; Code[20])
        {
            trigger OnValidate()
            var
                MSMSStudentSetup: Record "Student Management Setup";
                NoSeriesManagement: Codeunit NoSeriesManagement;
            begin
                if No <> xRec.No then begin

                    MSMSStudentSetup.Get();
                    MSMSStudentSetup.TestField("Cluster Nos");
                    NoSeriesManagement.TestManual(MSMSStudentSetup."Cluster Nos");
                end;
            end;

        }
        field(2; "Grade"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Maximum Points"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Manimum Points"; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; No, Grade)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; Grade)
        {

        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    var
        MSMSStudentSetup: Record "Student Management Setup";
        NoSeriesManagement: Codeunit NoSeriesManagement;
    begin
        if No = '' then begin
            MSMSStudentSetup.Get();
            MSMSStudentSetup.TestField("Cluster Nos");
            NoSeriesManagement.InitSeries(MSMSStudentSetup."Cluster Nos", MSMSStudentSetup."Cluster Nos", WorkDate(), No, MSMSStudentSetup."Cluster Nos");
        end;
    end;

    trigger OnModify()
    begin

    end;
}