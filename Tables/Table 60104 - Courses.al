table 60104 Courses
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Course Code"; Code[20])
        {
            DataClassification = CustomerContent;
            NotBlank = true;
            Caption = 'course Code';

        }

        field(2; "Course Description"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(3; "Department Code"; Code[30])
        {
            DataClassification = CustomerContent;
            TableRelation = Department;

            trigger OnValidate()
            var
                School: Record Department;
            begin
                TestField("Course Description");
                if School.Get("Department Code") then
                    "Department Description" := School."Department Description";
                if School.Get("Department Code") then "School Code" := School."School Code";
                if School.Get("Department Code") then "School Description" := School."School Description";


            end;

        }
        field(4; "Department Description"; Text[100])
        {

            Caption = 'Department Description';
            // CalcFormula = Lookup("Department"."Department Description" WHERE("Department Code" = FIELD("Department Code")));
            // FieldClass = FlowField;
        }


        field(5; "Duration"; Integer)
        {
            DataClassification = CustomerContent;
            MaxValue = 5;
            MinValue = 3;
        }
        field(6; "LOS Code"; Code[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'level of study code';
            TableRelation = "Level Of Study";

            trigger OnValidate()
            var
                School: Record "Level Of Study";
            begin
                TestField("Course Code");
                if School.Get("LOS Code") then
                    "LOS Description" := School."LOS Description";
            end;
        }

        field(7; "LOS Description"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'level of study Description';

        }
        field(8; "School Code"; Code[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'School Code';
            TableRelation = "Type of School";

            trigger OnValidate()
            var
                School: Record "Type of School";
            begin

                if School.Get("School Code") then
                    "School Description" := School."School Description";
            end;


        }
        field(9; "School Description"; Text[100])
        {
            DataClassification = ToBeClassified;

        }
    }

    keys
    {
        key(PK; "Course Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Course Code", "Course Description", "Department Code", "Department Description") { }
    }

    var
        myInt: Integer;

}