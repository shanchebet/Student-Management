table 60102 "Type of School"
{
    DataClassification = ToBeClassified;
    Caption = 'Type of School';

    fields
    {
        field(1; "School Code"; Code[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'School Code';
            NotBlank = true;

        }
        field(2; "School Description"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "School Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "School Code", "School Description") { }
    }


}