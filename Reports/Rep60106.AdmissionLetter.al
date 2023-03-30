report 60106 "Admission Letter Report"
{
    ApplicationArea = All;
    Caption = 'Admission Letter';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './Reports/Report 60106 - Admission Letter Report.rdl';
    DefaultLayout = RDLC;
    dataset
    {
        dataitem(ApplicantRegistration; "Applicant Registration")
        {
            column(ApplicationNo; "Application No.")
            {
            }
            column(FullName; "Full Name")
            {
            }
            column(LevelOfStudy; "Level Of Study")
            {
            }
            column(CourseDescription; "Course Description")
            {
            }
            column(Address; Address)
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
