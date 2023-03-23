report 60101 "Applicant Registration Report"
{
    ApplicationArea = All;
    Caption = 'Applicant Registration Report';
    UsageCategory = Administration;
    RDLCLayout = './Reports/Report 60101 - Applicant Registration Report.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(ApplicantRegistration; "Applicant Registration")
        {
            RequestFilterFields = "Approval Status ";
            column(ApplicationNo; "Application No.")
            {
            }
            column(FullName; "Full Name")
            {
            }
            column(Age; Age)
            {
            }
            column(LevelOfStudy; "Level Of Study")
            {
            }
            column(LOSDescription; "LOS Description")
            {
            }
            column(CourseOfStudy; "Course Of Study")
            {
            }
            column(CourseDescription; "Course Description")
            {
            }
            column(Gender; Gender)
            {
            }
            column(PhoneNumber; "Phone Number")
            {
            }
            column(CustomerType; "Customer Type")
            {
            }
            column(ApprovalStatus; "Approval Status ")
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
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
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
