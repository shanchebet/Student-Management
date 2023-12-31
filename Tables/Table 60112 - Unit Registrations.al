table 60112 "Unit Registration"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[30])
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                MSMSStudentSetup: Record "Student Management Setup";
                NoSeriesManagement: Codeunit NoSeriesManagement;
            begin
                if "No." <> xRec."No." then begin
                    MSMSStudentSetup.Get();
                    MSMSStudentSetup.TestField("Unit Nos");
                    NoSeriesManagement.TestManual(MSMSStudentSetup."Unit Nos");

                end;
            END;


        }
        field(2; "Student No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Student No.';
            TableRelation = "Student Session"."Student No." where(Reported = const(true));

            trigger OnValidate()
            begin
                if StudentRec.Get("Student No.") then begin
                    "Level Of Study" := StudentRec."Level Of Study";
                    "Course Of Study" := StudentRec."Course Of Study";
                    "Course Description" := StudentRec."Course Description";
                    "Department Description" := StudentRec."Department Description";
                    "School Description" := StudentRec."School Description";
                    "Student Name" := StudentRec.Name;
                end;
            end;

        }
        field(3; "Student Name"; Text[100])
        {
            Caption = 'Student Name';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = lookup(customer.Name where("No." = field("Student No.")));

        }
        field(4; "Level Of Study"; Text[100])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(5; "Course Of Study"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Course of Study';
            Editable = false;

        }
        field(6; "Customer Type"; Enum "Customer Type")
        {
            DataClassification = CustomerContent;
            Caption = 'Type of applicant';
        }
        field(7; "Course Description"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Course Description';
            Editable = false;
        }
        field(8; "School Description"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'School Description';
            Editable = false;
        }
        field(9; "Department Description"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Department Description';
            Editable = false;
        }
        field(10; "LOS Description"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'level of study Description';
            Editable = false;

        }
        field(11; "Academic Year Code"; Code[30])
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
        field(12; Semester; Code[30])
        {
            DataClassification = CustomerContent;
            TableRelation = Semester;

        }
        field(13; "Academic Year Description"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Academic Year Description';
            TableRelation = "Academic Year";
        }
        field(14; "No Series"; Code[30])
        {
            DataClassification = CustomerContent;
        }
        field(15; "Session Code"; Code[30])
        {
            Caption = 'Session Code';
            DataClassification = CustomerContent;
            TableRelation = "Student Session"."Session Code" where(Reported = const(true));

            trigger OnValidate()
            begin
                StudentSession.Reset();
                StudentSession.SetRange("Session Code", "Session Code");
                if StudentSession.FindFirst() then begin
                    "Student No." := StudentSession."Student No.";
                    Validate("Student No.");
                    Semester := StudentSession."Semester Code";
                    "Academic Year Code" := StudentSession."Academic Year Code";
                    Validate("Academic Year Code");
                end;
            end;
        }
        field(16; "Register For Exams"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Status"; enum "Approval Status")
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Unit Status"; Enum "Unit Status")
        {
            DataClassification = ToBeClassified;
            Caption = 'Status Of the Units';
        }
        field(19; "Total Unit Selected"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Unit Registration Line" where(Select = const(true), "Document No." = field("No.")));
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }

    }
    fieldgroups
    {
        fieldgroup(DropDown; "No.", "Student No.", "Student Name", "Level Of Study", "Course Of Study") { }
    }

    var

    var
        UnitMat: Record "Unit Matrix";
        UnitRegLines: Record "Unit Registration Line";
        StudentSession: Record "Student Session";
        StudentRec: Record Customer;
        LineNo: Integer;
        StudMgt: Codeunit "Student Management";
        MSMSStudentSetup: Record "Student Management Setup";
        NoSeriesManagement: Codeunit NoSeriesManagement;

    trigger OnInsert()
    begin
        if "No." = '' then begin
            MSMSStudentSetup.Get();
            MSMSStudentSetup.TestField("Unit Nos");
            NoSeriesManagement.InitSeries(MSMSStudentSetup."Unit Nos", MSMSStudentSetup."Unit Nos", WorkDate(), "No.", MSMSStudentSetup."Unit Nos");

        end;
        Status := Status::Open;
    end;

    procedure AssistEdit(Unit: Record "Unit Registration"): Boolean
    var
        UnitReg: Record "Unit Registration";
        MSMSStudentSetup: Record "Student Management Setup";
        NoSeriesManagement: Codeunit NoSeriesManagement;
    begin
        UnitReg := Rec;
        MSMSStudentSetup.Get();
        MSMSStudentSetup.TestField("Unit Nos");
        if NoSeriesManagement.SelectSeries(MSMSStudentSetup."Unit Nos", '', UnitReg."No Series") then begin
            NoSeriesManagement.SetSeries(UnitReg."No.");
            Rec := UnitReg;
            exit(true);
        end;

    end;
}