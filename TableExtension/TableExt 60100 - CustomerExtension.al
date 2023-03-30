tableextension 60110 CustomerExtension extends Customer
{
    fields
    {
        field(60100; "Gender"; Enum "Gender Type")
        {
            Caption = 'Gender';
            DataClassification = CustomerContent;
        }
        field(60101; "DOB"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Date of Birth';
        }
        field(60102; "Age"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Age';

        }
        field(60103; "Marital Status"; Enum "Marital Status")
        {
            DataClassification = CustomerContent;
            Caption = 'Marital Status';
        }
        field(60104; "Level Of Study"; Text[100])
        {
            DataClassification = CustomerContent;
            TableRelation = "Level Of Study";
            Caption = 'Level of Study';
        }

        field(60105; "Course Of Study"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Course of Study';
            TableRelation = Courses."Course Code";
            trigger OnValidate()
            begin

            end;
        }
        field(60106; "Customer Type"; Enum "Customer Type")
        {
            DataClassification = CustomerContent;
            Caption = 'Customer Type';
        }
        field(60107; "School Description"; Text[100])
        {
            DataClassification = ToBeClassified;

        }
        field(60108; "Department Description"; Text[100])
        {

            Caption = 'Department Description';

        }
        field(60109; "Course Description"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(60120; "First Name"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'First Name';
            trigger OnValidate()
            begin
                Name := "First Name" + ' ' + "Middle Name" + ' ' + SurName;
            end;
        }
        field(60121; "Middle Name"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Middle Name';
            trigger OnValidate()
            begin
                Name := "First Name" + ' ' + "Middle Name" + ' ' + SurName;
            end;

        }
        field(60122; "SurName"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'SurName';
            trigger OnValidate()
            begin
                Name := "First Name" + ' ' + "Middle Name" + ' ' + SurName;
            end;
        }
    }
}
