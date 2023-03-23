table 60111 "Unit Matrix"
{


    fields
    {
        field(1; "Entry No"; Code[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Entry No';
            NotBlank = true;
        }
        field(2; "Unit Code"; Code[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Unit Code';
            NotBlank = true;
            TableRelation = Units;
            trigger OnValidate()
            var
                UnitRec: Record Units;
            begin
                if UnitRec.Get("Unit Code") then begin
                    "Unit Description" := UnitRec."Unit Description";

                end;
            end;


        }
        field(3; "Unit Description"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Unit Description';
            Editable = false;


        }
        field(4; "Course Code"; Code[20])
        {
            DataClassification = CustomerContent;
            NotBlank = true;
            Caption = 'Course Code';
            TableRelation = Courses;

            trigger OnValidate()
            var
                School: Record Courses;
            begin
                TestField("Unit Description");
                if School.Get("Course Code") then
                    "Course Description" := School."Course Description";
            end;

        }

        field(5; "Course Description"; Text[100])
        {
            DataClassification = CustomerContent;

        }
        field(6; "Semester Code"; Code[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Semester Code';
            NotBlank = true;
            TableRelation = Semester;
        }
        field(7; "Academic Year Code"; Code[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Academic Year Code';
            TableRelation = "Academic Year";

        }
        field(8; "Unit Core/Elective"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

    }
    keys
    {
        key(PK; "Unit Code", "Course Code", "Semester Code", "Academic Year Code")
        {
            Clustered = true;
        }
    }



    var
        myInt: Integer;


}