table 60118 "Student Invoice Lines"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No."; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "No"; Code[30])
        {
            DataClassification = CustomerContent;
            Caption = 'No';
            TableRelation = "Finance Structure";
            trigger OnValidate()
            var
                Fin: Record "Finance Structure";
            begin

                if Fin.Get("No") then begin
                    "Transaction Type" := Fin."Transaction Type";
                    "Amount" := Fin.Amount;
                end;

            end;
        }
        field(3; "Transaction Type"; Text[100])
        {
            DataClassification = CustomerContent;

        }
        field(4; Amount; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(5; "Line No"; Integer)
        {
        }
        field(6; "Document Type"; Enum "Gen. Journal Document Type")
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(PK; "Document No.", No, "Line No")
        {
            Clustered = true;
        }
    }
}