table 60110 "Student Management Cues"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Registered Student List"; Integer)
        {
            Caption = 'Registered Sudents';
            FieldClass = FlowField;
            CalcFormula = count("Customer" where("Customer Type" = const(Student)));
        }
        field(3; "User ID Filter"; Code[50])
        {
            Caption = 'User ID Filter';
            FieldClass = FlowFilter;
        }
        field(4; "Requests to Approve"; Integer)
        {
            CalcFormula = Count("Approval Entry" WHERE("Approver ID" = FIELD("User ID Filter"),
                                                        Status = FILTER(Open)));
            Caption = 'Requests to Approve';
            FieldClass = FlowField;
        }
        field(5; "Requests Sent for Approval"; Integer)
        {
            CalcFormula = Count("Approval Entry" WHERE("Sender ID" = FIELD("User ID Filter"),
                                                         Status = FILTER(Open)));
            Caption = 'Requests Sent for Approval';
            FieldClass = FlowField;
        }
        field(10; "Pending Applicant Registration"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Applicant Registration" where("Approval Status " = CONST("Pending")));
        }
        field(11; "Approved Applicant Reg."; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Applicant Registration" where("Approval Status " = CONST(Released)));
        }
        field(12; "Rejected Applicant Reg."; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Applicant Registration" where("Approval Status " = CONST(Rejected)));
        }
        field(13; "Posted Invoice List"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Student Invoice" where(Posted = CONST(True)));
        }
        field(14; "Reversed Invoice List"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Student Invoice" where(Status = CONST(Reversed)));
        }
        field(15; "Open Invoice List"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Student Invoice" where(Status = CONST(Open)));
        }
        field(16; "Pending Approval Invoice List"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Student Invoice" where(Status = CONST("Pending")));
        }
        field(17; "Approved Invoice List"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Student Invoice" where(Status = CONST(Released)));
        }
        field(18; "Rejected Invoice List"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Student Invoice" where("Status" = CONST(Rejected)));
        }
        field(19; "Open Applicant Registartion"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Applicant Registration" where("Approval Status " = CONST(OPen)));
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;



}