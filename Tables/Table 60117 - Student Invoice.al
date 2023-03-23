table 60117 "Student Invoice"
{
    DataClassification = ToBeClassified;
    LookupPageId = "Student Session List ";

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
                    MSMSStudentSetup.TestField("StudIN Nos");
                    NoSeriesManagement.TestManual(MSMSStudentSetup."StudIN Nos");

                end;
            END;

        }
        field(2; "Bill-to Student No."; Code[20])
        {
            Caption = 'Bill-to Student No.';
            NotBlank = true;
            TableRelation = "Student Session"."Student No.";
            // trigger OnValidate()
            // var
            //     StudRec: Record "Student Session";
            //     CustRec: Record Customer;
            // begin
            //     StudRec.Reset();
            //     StudRec.SetRange("Student No.", "Bill-to Student No.");
            //     if StudRec.FindFirst() then begin
            //         "Student Name" := StudRec."Student Name";
            //         Semester := StudRec."Semester Code";
            //         "Academic Year Code" := StudRec."Academic Year Code";
            //     end;
            //     if CustRec.get("Bill-to Student No.") then begin
            //         "Course Description" := CustRec."Course Description";
            //         "Level Of Study" := CustRec."Level Of Study";
            //         "School Description" := CustRec."School Description";
            //     end;
            // end;


        }
        field(3; "Student Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Stdent Name';
        }
        field(4; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(5; "Level Of Study"; Text[100])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(6; "Course Of Study"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Course of Study';
            Editable = false;

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
        field(11; "Academic Year Code"; Code[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Academic Year Code';
            TableRelation = "Academic Year";
        }
        field(12; Semester; Code[30])
        {
            DataClassification = CustomerContent;
            TableRelation = Semester."Semester Code";
        }
        field(13; "Status"; Enum "Approval Status Type")
        {
            DataClassification = CustomerContent;
            Caption = 'Status';
        }

        field(14; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Invoiced Amount"; Decimal)
        {
            Caption = 'Invoiced Amount';
            FieldClass = FlowField;
            CalcFormula = sum("Student Invoice Lines".Amount where("Document No." = field("No.")));
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
        StudentSession: Record "Student Session";

    trigger OnInsert()
    begin
        if "No." = '' then begin
            MSMSStudentSetup.Get();
            MSMSStudentSetup.TestField("StudIN Nos");
            NoSeriesManagement.InitSeries(MSMSStudentSetup."StudIN Nos", MSMSStudentSetup."StudIN Nos", WorkDate(), "No.", MSMSStudentSetup."StudIN Nos");

        end;
    end;

}