report 60104 "Unit Registration Report"
{
    ApplicationArea = All;
    Caption = 'Unit Registration Report';
    UsageCategory = Administration;
    RDLCLayout = './Reports/Report 60104 - Unit Registration Report.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Unit Registration"; "Unit Registration")
        {
            RequestFilterFields = "No.", "Student No.", "Student Name";
            column(No_; "No.")
            {

            }
            column(Student_No_; "Student No.")
            {

            }
            column(Student_Name; "Student Name")
            {

            }
            column(LOS_Description; "LOS Description")
            {

            }
            column(Course_Of_Study; "Course Of Study")
            {

            }
            column(Course_Description; "Course Description")
            {

            }
            column(Semester; Semester)
            {

            }
            column(Academic_Year_Code; "Academic Year Code")
            {

            }
            column(Academic_Year_Description; "Academic Year Description")
            {

            }

            column(CompLogo; CompInfo.Picture)
            {

            }
            column(CompName; CompInfo.Name)
            {

            }
            column(CompAddress; CompInfo.Address)
            {

            }
            column(CompCity; CompInfo.City)
            {

            }
            column(CompEmail; CompInfo."E-Mail")
            {

            }
            column(PreparedBy; UserId)
            {

            }
            column(DatePrepared; Today())
            {

            }
            dataitem("Unit Registration Line"; "Unit Registration Line")
            {

                DataItemLink = "Document No." = field("No.");
                column(Unit_Code; "Unit Code")
                {

                }
                column(Unit_Description; "Unit Description")
                {

                }
                column(Unit_Core_Elective; "Unit Core/Elective")
                {

                }
                column(Unit_Status; "Unit Status")
                {

                }
                column(Select; Select)
                {

                }
            }
        }

    }

    trigger OnPreReport()
    begin
        CompInfo.Get();
        CompInfo.CalcFields(Picture);
    end;

    var
        CompInfo: Record "Company Information";
        UserSetup: Record "User Setup";
}