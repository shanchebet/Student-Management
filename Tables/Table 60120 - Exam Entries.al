table 60120 "Exam Entries"
{
    Caption = 'Exam Entries';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var

            begin
                if "No." <> "No." then
                    NoSeriesManagement.TestManual(MSMSStudentSetup."Exam Nos");
            end;
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
        field(13; "Unit Reg No."; Code[30])
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                UnitReglines.Reset();
                UnitReglines.SetRange("Document No.", Rec."Unit Reg No.");
                UnitReglines.SetFilter("Unit Status", '=%1', UnitReglines."Unit Status"::Registered);
                if UnitReglines.FindSet() then begin
                    repeat
                        ExEntrieLine.Init();
                        ExEntrieLine."Line No." := UnitReglines."Line No";
                        ExEntrieLine."Document No." := Rec."No.";
                        ExEntrieLine."Unit Code" := UnitReglines."Unit Code";
                        ExEntrieLine.Validate("Unit Code");
                        ExEntrieLine.Insert();
                    until UnitReglines.Next() = 0;
                end;
            end;
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
    var
        MSMSStudentSetup: Record "Student Management Setup";
        NoSeriesManagement: Codeunit NoSeriesManagement;
        UnitReglines: Record "Unit Registration Line";
        ExEntrieLine: Record "Exam Entries Lines";

    trigger OnInsert()
    begin
        if "No." = '' then begin
            MSMSStudentSetup.Get();
            MSMSStudentSetup.TestField("Exam Nos");
            // NoSeriesManagement.InitSeries(MSMSStudentSetup."Exam Nos", xRec.no);
        end;
    end;
}
