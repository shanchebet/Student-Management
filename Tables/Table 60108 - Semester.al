table 60108 Semester
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Semester Code"; Code[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Semester Code';
            NotBlank = true;
        }
        field(2; "Semester Description"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Semester Description';
        }

        field(3; " Academic Year Code"; Code[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Academic Year Code';
            TableRelation = "Academic Year";

            trigger OnValidate()
            var
                AC: Record "Academic Year";
            begin
                if AC.Get(" Academic Year Code") then
                    "Academic Year Description" := AC."Academic Year Description"
            end;

        }
        field(4; "Academic Year Description"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Academic Year Description';

        }
    }

    keys
    {
        key(PK; "Semester Code", " Academic Year Code")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;
}