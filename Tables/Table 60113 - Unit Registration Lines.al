table 60113 "Unit Registration Line"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No."; Code[30])
        {
            Caption = 'Document Number';
            TableRelation = "Unit Registration";
        }

        field(2; "Entry No"; Code[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Entry No';
            // TableRelation = "Unit Matrix" where("Semester Code" = FIELD("Semester Code"));
            // trigger OnValidate()
            // var
            //     UnitMat: Record "Unit Matrix";
            // begin
            //     if UnitMat.Get("Entry No") then begin
            //         "Unit Code" := UnitMat."Unit Code";
            //         "Unit Description" := UnitMat."Unit Description";
            //         "Course Description" := UnitMat."Course Description";
            //         "Semester Code" := UnitMat."Semester Code";
            //         "Unit Core/Elective" := UnitMat."Unit Core/Elective";

            //     end;
            // end;

        }
        field(3; "Unit Code"; Code[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Unit Code';
            NotBlank = true;
            TableRelation = Units;
            trigger OnValidate()
            var
                UnitRec: Record Units;
            begin
                if UnitRec.Get("Unit Code") then
                    "Unit Description" := UnitRec."Unit Description";
            end;
        }
        field(4; "Unit Description"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Unit Description';
            Editable = false;


        }
        field(5; "Course Code"; Code[20])
        {
            DataClassification = CustomerContent;
            NotBlank = true;
            Caption = 'Course Code';

        }

        field(6; "Course Description"; Text[100])
        {
            DataClassification = CustomerContent;

        }
        field(7; "Semester Code"; Code[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Semester Code';
            NotBlank = true;
        }
        field(8; "Academic Year Code"; Code[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Academic Year Code';
            NotBlank = true;
        }
        field(9; "Unit Core/Elective"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(10; Select; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Line No"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Unit Status"; Enum "Unit Status")
        {
            DataClassification = ToBeClassified;
            Caption = 'Status Of the Units';
        }
    }
    keys
    {
        key(PK; "Document No.", "Line No")
        {
            Clustered = true;
        }
    }


}