report 60109 "Exam Card"
{
    ApplicationArea = All;
    UsageCategory = Administration;
    RDLCLayout = './Reports/Reportc 60109 - Exam Card.rdl';
    DefaultLayout = RDLC;




    dataset
    {
        dataitem(Customer; Customer)
        {

            RequestFilterFields = "No.";
            column(No_Customer; "No.")
            {
            }
            column(Name_Customer; Name)
            {
            }
            column(LevelOfStudy_Customer; "Level Of Study")
            {
            }
            column(CourseDescription_Customer; "Course Description")
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
            dataitem("Unit Registration"; "Unit Registration")
            {
                DataItemLink = "Student No." = field("No.");
                column(Semester_UnitRegistration; Semester)
                {
                }
                column(AcademicYearCode_UnitRegistration; "Academic Year Code")
                {
                }
                column(AcademicYearDescription_UnitRegistration; "Academic Year Description")
                {
                }
                column(TotalUnitSelected_UnitRegistration; "Total Unit Selected")
                {
                }
                dataitem("Unit Registration Line"; "Unit Registration Line")
                {
                    DataItemLink = "Document No." = field("No.");
                    DataItemTableView = where(Select = const(true));
                    column(Select_UnitRegistrationLine; Select)
                    {
                    }

                    column(UnitCode_UnitRegistrationLine; "Unit Code")
                    {
                    }
                    column(UnitDescription_UnitRegistrationLine; "Unit Description")
                    {
                    }
                    column(UnitStatus_UnitRegistrationLine; "Unit Status")
                    {
                    }
                    column(UnitCoreElective_UnitRegistrationLine; "Unit Core/Elective")
                    {
                    }

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
        AmountSum: Decimal;
}