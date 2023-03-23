table 60106 "Level Of Study"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "LOS Code"; Code[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'level of study code';
            NotBlank = true;


        }
        field(2; "LOS Description"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'level of study Description';

        }
        // field(3; "Course Code"; Code[20])
        // {
        //     DataClassification = ToBeClassified;
        //     Caption = 'Course Code';

        //     TableRelation = Courses;

        //     trigger OnValidate()
        //     var
        //         School: Record Courses;
        //     begin
        //         TestField("Description");
        //         if School.Get("Course Code") then
        //             "Course Description" := School."Course Description";
        //     end;

        // }
        // field(4; "Course Description"; Text[100])
        // {

        //     Caption = 'Course Description';
        //     // CalcFormula = Lookup("Level Of Study"."Course Description"s WHERE("Course Code" = FIELD("Course Code")));
        //     // FieldClass = FlowField;
        // }
    }

    keys
    {
        key(PK; "LOS Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "LOS Code", "LOS Description") { }
    }

    var
        myInt: Integer;



}