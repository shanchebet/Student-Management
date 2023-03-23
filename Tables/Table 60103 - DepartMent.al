table 60103 Department
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Department Code"; Code[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Department Code';
            NotBlank = true;


        }
        field(2; "Department Description"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Department Description';


        }
        field(3; "School Code"; Code[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'School Code';
            TableRelation = "Type of School";
            trigger OnValidate()
            var
                School: Record "Type of School";
            begin
                TestField("Department Description");
                if School.Get("School Code") then
                    "School Description" := School."School Description";
            end;
        }
        field(4; "School Description"; text[100])
        {
            Caption = 'School Description';
            // CalcFormula = Lookup("Type of School".Description WHERE("School Code" = FIELD("School Code")));
            // FieldClass = FlowField;
        }
    }
    keys
    {
        key(PK; "Department Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Department Code", "Department Description", "School Code", "School Description") { }
    }
}