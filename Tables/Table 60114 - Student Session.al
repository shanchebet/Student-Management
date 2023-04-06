table 60114 "Student Session"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Session Code"; Code[30])
        {
            Caption = 'Session Code';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if "Session Code" <> xRec."Session Code" then
                    NoSeriesManagement.TestManual(MSMSStudentSetup."session Nos");
            end;
        }
        field(2; "Session Description"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Session Description';
        }
        field(3; "Student No."; Code[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Student No';
            TableRelation = Customer where("Customer Type" = const(Student));

            trigger OnValidate()
            var
                StudRec: Record Customer;
            begin
                if StudRec.Get("Student No.") then begin
                    "Student Name" := StudRec.Name;
                    "Level Of Study" := StudRec."Level Of Study";
                    "Course Of Study" := StudRec."Course Of Study";
                    "Course Description" := StudRec."Course Description";
                    "School Description" := StudRec."School Description";

                end;
            end;
        }
        field(4; "Student Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Stdent Name';

        }
        field(5; "Semester Code"; Code[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Semester Code';
            TableRelation = Semester;
            trigger OnValidate()
            var
                Sem: Record "Semester";
                studentSession: Record "Student Session";

            begin
                Sem.Reset();
                Sem.SetRange("Semester Code", "Semester Code");
                if sem.FindFirst() then begin
                    "Semester Description" := sem."Semester Description";
                    "Academic Year Code" := Sem." Academic Year Code";
                    Validate("Academic Year Code");
                    studentSession.Reset();
                    studentSession.SetRange("Semester Code", Rec."Semester Code");
                    studentSession.SetRange("Academic Year Code", Rec."Academic Year Code");
                    if not studentSession.FindFirst() then begin
                        Rec."Semester Code" := Sem."Semester Code";
                        Rec."Semester Description" := Sem."Semester Description";
                        Rec."Academic Year Code" := "Academic Year Code";
                        Rec."Academic Year Description" := "Academic Year Description";
                    end else
                        Error('The record already Exists for semseter %1 and Semester %2', studentSession."Semester Description", studentSession."Academic Year Code");
                end;
            end;
        }
        field(6; "Semester Description"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Semester Description';
        }
        field(7; "Academic Year Code"; Code[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Academic Year Code';
            TableRelation = "Academic Year";

            trigger OnValidate()
            var
                AC: Record "Academic Year";

            begin
                if AC.Get("Academic Year Code") then
                    "Academic Year Description" := AC."Academic Year Description";

            end;
        }
        field(8; "Academic Year Description"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Academic Year Description';

        }

        field(9; Reported; boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Reported';
        }
        field(10; "No Series"; Code[30])
        {
            DataClassification = CustomerContent;
        }
        field(11; "Level Of Study"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "School Description"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'School Description';
        }
        field(13; "Course Of Study"; Text[30])
        {

        }
        field(14; "Course Description"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Course Description';
        }

    }

    keys
    {
        key(Key1; "Session Code")
        {
            Clustered = true;
        }
        key(Key2; "Student No.")
        {

        }
        key(Key3; "Student Name")
        {
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Student No.", "Student Name")
        {
        }
        fieldgroup(Brick; "Student No.", "Student Name")
        {
        }
    }

    var
        MSMSStudentSetup: Record "Student Management Setup";
        NoSeriesManagement: Codeunit NoSeriesManagement;

    trigger OnInsert()
    begin
        if "Session Code" = '' then begin
            MSMSStudentSetup.Get();
            MSMSStudentSetup.TestField("session Nos");
            NoSeriesManagement.InitSeries(MSMSStudentSetup."session Nos", xRec."No Series", 0D, "Session Code", "No Series");
        end;
    end;
}