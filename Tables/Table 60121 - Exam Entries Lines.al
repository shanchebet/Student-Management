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
            trigger OnValidate()
            begin
                Validate("Final Mark");
            end;

        }
        field(5; "Exam Marks"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                Validate("Final Mark");
            end;
        }
        field(6; "Final Mark"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
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

}
