table 60116 "Receipt Header Lines"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No"; Code[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Document No';

        }
        field(2; "No"; Code[30])
        {
            DataClassification = CustomerContent;
            Caption = 'No';
        }
        field(3; "Account Type"; Enum "Gen. Journal Account Type")
        {
        }
        field(4; "Account No"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = IF ("Account Type" = CONST("G/L Account")) "G/L Account"
            ELSE
            IF ("Account Type" = CONST("Fixed Asset")) "Fixed Asset"
            ELSE
            IF ("Account Type" = CONST(Customer)) Customer
            ELSE
            IF ("Account Type" = CONST("Bank Account")) "Bank Account"
            ELSE
            IF ("Account Type" = CONST(Vendor)) Vendor;
        }

        field(5; "Transaction Type"; Text[100])
        {
            DataClassification = CustomerContent;

        }
        field(6; Amount; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(7; "Line No"; Integer)
        {
        }
        field(8; "Applies-to Doc. No."; Code[20])
        {
            Caption = 'Applies-to Doc. No.';
        }

        field(9; "Applies-to Doc. Type"; Enum "Gen. Journal Document Type")
        {
            Caption = 'Applies-to Doc. Type';
        }
        field(10; "Invoiced Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Document No", "Line No")
        {
            Clustered = true;
        }
    }
}