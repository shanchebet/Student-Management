table 60120 "Exam Entries"
{
    Caption = 'Exam Entries';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Student No."; Code[20])
        {
            Caption = 'Student No';
            DataClassification = ToBeClassified;
            TableRelation = "Unit Registration";
        }
        field(3; "Student Name"; Text[100])
        {
            Caption = 'Student Name';

        }
        field(4; "Level Of Study"; Text[100])
        {
            DataClassification = CustomerContent;

        }

        field(5; "Course Of Study"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Course of Study';

        }
        field(11; "Academic Year Code"; Code[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Academic Year Code';
        }
        field(12; Semester; Code[30])
        {
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
}
