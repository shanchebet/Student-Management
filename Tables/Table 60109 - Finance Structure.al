table 60109 "Finance Structure"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code"; Code[30])
        {
            DataClassification = CustomerContent;
            NotBlank = true;
            Caption = 'Fee Number';
            trigger OnValidate()
            var
                MSMSStudentSetup: Record "Student Management Setup";
                NoSeriesManagement: Codeunit NoSeriesManagement;
            begin
                if "Code" <> xRec."Code" then begin
                    MSMSStudentSetup.Get();
                    MSMSStudentSetup.TestField("Fin Nos");
                    NoSeriesManagement.TestManual(MSMSStudentSetup."Fin Nos");

                end;
            END;
        }
        field(2; "Date Prepared"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Date';
        }
        field(3; "Academic Year"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Academic Year";
            Caption = 'Academic Year';
        }
        field(4; Semester; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Semester';
            TableRelation = Semester;
        }
        field(5; Course; Text[50])
        {
            DataClassification = CustomerContent;
            TableRelation = Courses;
            Caption = 'Courses';
        }
        field(6; Amount; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount';
        }
        field(7; "Bal. Account Type"; Enum "Gen. Journal Account Type")
        {
            DataClassification = CustomerContent;
            Caption = 'Balancing Account Type';
        }
        field(8; "Balancing Account No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Bal. Account No.';
            TableRelation = IF ("Bal. Account Type" = CONST("G/L Account")) "G/L Account" WHERE("Account Type" = CONST(Posting),
                                                                                               Blocked = CONST(false))
            ELSE
            IF ("Bal. Account Type" = CONST(Customer)) Customer
            ELSE
            IF ("Bal. Account Type" = CONST(Vendor)) Vendor
            ELSE
            IF ("Bal. Account Type" = CONST("Bank Account")) "Bank Account"
            ELSE
            IF ("Bal. Account Type" = CONST("Fixed Asset")) "Fixed Asset"
            ELSE
            IF ("Bal. Account Type" = CONST("IC Partner")) "IC Partner"
            ELSE
            IF ("Bal. Account Type" = CONST(Employee)) Employee;

        }
        field(9; "Student Category"; Option)
        {
            OptionMembers = " ",GSSP,PSSP;

        }
        field(10; "Prepared By"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(11; "Transaction Type"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(12; "Posting Group"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Gen. Business Posting Group";
        }
        field(13; "Frequency"; Enum "Frequency ")
        {
            DataClassification = ToBeClassified;
            Caption = 'frequency';
        }
    }

    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; Code, "Transaction Type", Amount, Frequency)
        {

        }
    }

    var
        MSMSStudentSetup: Record "Student Management Setup";
        NoSeriesManagement: Codeunit NoSeriesManagement;

    trigger OnInsert()
    begin
        "Prepared By" := UserId;

        if "Code" = '' then begin
            MSMSStudentSetup.Get();
            MSMSStudentSetup.TestField("Fin Nos");
            NoSeriesManagement.InitSeries(MSMSStudentSetup."Fin Nos", MSMSStudentSetup."Fin Nos", WorkDate(), "Code", MSMSStudentSetup."Fin Nos");

        end;
    end;

}