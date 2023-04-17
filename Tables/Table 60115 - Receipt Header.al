table 60115 "Receipt Header"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; code[30])
        {
            DataClassification = CustomerContent;
            Caption = 'No';
            trigger OnValidate()
            var
                MSMSStudentSetup: Record "Student Management Setup";
                NoSeriesManagement: Codeunit NoSeriesManagement;
            begin
                if "No." <> xRec."No." then begin
                    MSMSStudentSetup.Get();
                    MSMSStudentSetup.TestField("Receipt Nos");
                    NoSeriesManagement.TestManual(MSMSStudentSetup."Receipt Nos");

                end;
            END;

        }
        field(2; "Description"; Text[150])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';

        }
        field(3; "Posting Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Posting Date';

            trigger OnValidate()
            begin
                if "Posting Date" > Today then
                    Error('Posting date cannot be greater than Today');
            end;

        }
        field(4; "Semester Code"; Code[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Semester Code';
            TableRelation = Semester;
            trigger OnValidate()
            var
                Sem: Record "Semester";
            begin
                if Sem.Get("Semester Code") then
                    "Semester Description" := Sem."Semester Description"
            end;
        }
        field(5; "Semester Description"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Semester Description';
        }
        field(6; "Academic Year Code"; Code[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Academic Year Code';
            TableRelation = "Academic Year";

            trigger OnValidate()
            var
                AC: Record "Academic Year";
            begin
                if AC.Get("Academic Year Code") then
                    "Academic Year Description" := AC."Academic Year Description"
            end;
        }
        field(7; "Academic Year Description"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Academic Year Description';

        }
        field(8; "Paying Account Type"; Enum "Gen. Journal Account Type")
        {

        }

        field(9; "Paying Account No"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Paying Account No';
            TableRelation = IF ("Paying Account Type" = CONST("G/L Account")) "G/L Account"
            ELSE
            IF ("Paying Account Type" = CONST("Fixed Asset")) "Fixed Asset"
            ELSE
            IF ("Paying Account Type" = CONST(Customer)) Customer
            ELSE
            IF ("Paying Account Type" = CONST("Bank Account")) "Bank Account"
            ELSE
            IF ("Paying Account Type" = CONST(Vendor)) Vendor;

        }

        field(10; "Cashier"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Cashier';
        }

        field(11; "Posted"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'posted';
        }
        field(12; "Pay Mode"; Code[20])
        {
            TableRelation = "Payment Method";
        }
        field(13; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
        }
        field(14; "Date Posted"; Date)
        {
        }
        field(15; "Time Posted"; Time)
        {
        }
        field(16; "Received From"; Text[100])
        {
        }
        field(17; Status; Enum "Approval Status")
        {
        }
        field(18; " Receipt Amount"; Decimal)
        {
            Caption = 'Receipt Amount';
            FieldClass = FlowField;
            CalcFormula = sum("Receipt Header Lines".Amount where("Document No" = field("No.")));
        }

        field(19; "Receiving Bank Account"; Code[20])
        {
            TableRelation = "Bank Account";

            trigger OnValidate()
            begin
                if Bank.Get("Receiving Bank Account") then begin
                    "Bank Name" := Bank.Name;
                end;
            end;
        }
        field(20; "Bank Name"; Text[100])
        {
            Caption = 'Bank Name';
            Editable = false;
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
        Bank: Record "Bank Account";
        UserSetup: Record "User Setup";

    trigger OnInsert()
    begin
        if "No." = '' then begin
            MSMSStudentSetup.Get();
            MSMSStudentSetup.TestField("Receipt Nos");
            NoSeriesManagement.InitSeries(MSMSStudentSetup."Receipt Nos", MSMSStudentSetup."Receipt Nos", WorkDate(), "No.", MSMSStudentSetup."Receipt Nos");
        end;
        "Cashier" := UserId;
        Status := Status::Open;
    end;

}