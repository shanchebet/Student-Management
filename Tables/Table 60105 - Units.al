table 60105 Units
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Unit Code"; Code[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Unit Code';
            NotBlank = true;

        }
        field(2; "Unit Description"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Unit Description';
            //Editable = false;

        }
        // field(3; "Course Code"; Code[20])
        // {
        //     DataClassification = ToBeClassified;
        //     Caption = 'Course Code';
        //     TableRelation = Courses;
        //     //   Editable = false;

        //     trigger OnValidate()
        //     var
        //         School: Record Courses;
        //     begin
        //         TestField("Unit Description");
        //         if School.Get("Course Code") then
        //             "Course Description" := School."Course Description";
        //     end;

        // }
        // field(4; "Course Description"; Text[100])
        // {

        //     Caption = 'Course Description';
        //     // CalcFormula = Lookup(Units."Unit Description" WHERE("Course Code" = FIELD("Course Code")));
        //     // FieldClass = FlowField;
        //     Editable = false;
        // }
    }

    keys
    {
        key(PK; "Unit Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Unit Code", "Unit Description") { }
    }
    var
        myInt: Integer;

}