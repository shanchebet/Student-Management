report 60107 "Suggest Invoice Line"
{
    Caption = 'Suggest Invoice Line';
    dataset
    {
        dataitem("Student Invoice"; "Student Invoice")
        {
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                "Student Invoice".TestField("Academic Year Code");
                "Student Invoice".TestField("Course Of Study");
                // clear the student invoice lines if it existed  before
                StudMgt.ClearStudentInvoiceLines("Student Invoice");

                Finance.Reset();
                Finance.SetRange(Course, "Course Of Study");
                Finance.SetRange("Academic Year", "Academic Year Code");
                if Finance.FindSet() then begin
                    repeat
                        lineNo := 10000;
                        StudentInvLines.Init();
                        StudentInvLines."Line No" += lineNo;
                        StudentInvLines."Document No." := "No.";
                        StudentInvLines.No := Finance."Code";
                        StudentInvLines."Transaction Type" := Finance."Transaction Type";
                        StudentInvLines.Amount := Finance.Amount;
                        StudentInvLines.Insert();
                    until Finance.Next() = 0;
                end;

            end;

        }
    }
    var
        Finance: Record "Finance Structure";
        StudentInvLines: Record "Student Invoice Lines";
        lineNo: Integer;
        StudMgt: Codeunit "Student Management";
}
