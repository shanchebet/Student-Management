table 60121 "Exam Entries Lines"
{
    Caption = 'Exam Entries Lines';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No."; Code[30])
        {
            Caption = 'Document Number';
            TableRelation = "Exam Entries";
        }
        field(2; "Unit Code"; Code[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Unit Code';
            NotBlank = true;
        }
        field(3; "Unit Description"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Unit Description';

        }
        field(4; "Cat Marks"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Exam Marks"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Final Mark"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Grade"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Remarks"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

    }
    keys
    {
        key(PK; "Document No.")
        {
            Clustered = true;
        }
    }
}
