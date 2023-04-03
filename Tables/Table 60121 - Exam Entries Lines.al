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
            //NotBlank = true;
            TableRelation = Units;
            trigger OnValidate()
            var
                UnitRec: Record Units;
            begin
                if UnitRec.Get("Unit Code") then
                    "Unit Description" := UnitRec."Unit Description";
            end;
        }
        field(3; "Unit Description"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Unit Description';

        }
        field(4; "Cat Marks"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                Stdmgt.Get();
                if Rec."Exam Marks" > Stdmgt."Max Cat Mark" then
                    Error('Maximum Cat Marks Should be less or Equal to %1', Stdmgt."Max Cat Mark");
                Validate("Final Mark");
            end;

        }
        field(5; "Exam Marks"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                Stdmgt.Get();
                if Rec."Exam Marks" > Stdmgt."Max Exam Mark" then
                    Error('Maximum Exam Marks Should be less or Equal to %1', Stdmgt."Max Exam Mark");
                Validate("Final Mark");
            end;
        }
        field(6; "Final Mark"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                "Final Mark" := "Cat Marks" + "Exam Marks";
                GradingSystem.Reset();
                GradingSystem.SetFilter("Minimum Points", '<=%1', "Final Mark");
                GradingSystem.SetFilter("Maximum Points", '>=%1', "Final Mark");
                if GradingSystem.FindFirst() then begin
                    Grade := GradingSystem.Grade;
                    Remarks := GradingSystem.Remarks;
                end;
            end;
        }
        field(7; "Grade"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Remarks"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }

    }
    keys
    {
        key(PK; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }

    var
        GradingSystem: Record "Cluster Points";
        Stdmgt: Record "Student Management Setup";

}
