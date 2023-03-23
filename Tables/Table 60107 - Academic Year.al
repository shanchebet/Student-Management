table 60107 "Academic Year"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Academic Year Code"; Code[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Academic Year Code';
            NotBlank = true;
        }
        field(2; "Academic Year Description"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Academic Year Description';
            NotBlank = true;
        }
    }

    keys
    {
        key(PK; "Academic year Code")
        {
            Clustered = true;
        }
    }
    var
        myInt: Integer;


}