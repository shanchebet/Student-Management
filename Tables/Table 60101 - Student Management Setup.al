table 60101 "Student Management Setup"
{
    Caption = 'Student Management Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = CustomerContent;
        }
        field(2; "Application Nos"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Application Nos';
            TableRelation = "No. Series";
        }
        field(3; "Maximum Age"; Integer)
        {
            Caption = 'Maximum age for a student to make application';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var

            begin
                if "Maximum Age" < 0 then
                    Error('Age cannot be less than 0');
                if "Maximum Age" < "Minimum Age" then
                    Error('Maximu Age cannot be less than Minimum Age');
            end;
        }

        field(4; "Minimum Age"; Integer)
        {
            Caption = 'The minimum Age for a student to make application';
            DataClassification = CustomerContent;
            trigger OnValidate()
            var

            begin
                if "Minimum Age" < 0 then
                    Error('Age cannot be less than 0');
                if "Minimum Age" > "Maximum Age" then
                    Error(' Minimum Age cannot be greater than maximum');
            end;


        }
        field(5; "No. of Days In A Year"; Integer)
        {
            DataClassification = ToBeClassified;
            minvalue = 1;
        }
        field(6; "Maximum Course Duration"; Integer)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var

            begin
                if Rec."Maximum Course Duration" < Rec."Minimum Course Duration" then begin
                    Error('Maximum Course Duration Cannot be Less than Minimum Course Duration');
                end;

            end;
        }
        field(7; "Minimum Course Duration"; Integer)
        {
            DataClassification = ToBeClassified;
            MinValue = 1;
        }
        field(8; "Unit Nos"; Code[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Unit Numbers';
            TableRelation = "No. Series";
        }
        field(9; "session Nos"; Code[30])
        {
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
            Caption = 'Session Number Series';
        }
        field(10; "Receipt Nos"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(11; "StudIN Nos"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(12; "Fin Nos"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(13; "General Journal Template"; Code[50])
        {
            Caption = 'General Journal Template';
            DataClassification = CustomerContent;
            TableRelation = "Gen. Journal Template";
        }
        field(14; "General Journal Batch"; Code[50])
        {
            Caption = 'General Journal Batch';
            DataClassification = CustomerContent;
            TableRelation = "Gen. Journal Batch" where("Journal Template Name" = field("General Journal Template"));
        }
    }
    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}
