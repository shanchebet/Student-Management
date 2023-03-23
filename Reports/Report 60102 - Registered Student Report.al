report 60102 "Registered Student Report"
{
    ApplicationArea = All;
    Caption = 'Registered Student Report';
    UsageCategory = Administration;
    RDLCLayout = './Reports/Report 60102 - Registered Student Report.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "Customer Type";

            column(Age; Age)
            {
            }
            column(Address; Address)
            {
            }
            column(Amount; Amount)
            {
            }
            column(Balance; Balance)
            {
            }
            column(CustomerType; "Customer Type")
            {
            }
            column(DOB; DOB)
            {
            }
            column(Name; Name)
            {
            }

            column(MaritalStatus; "Marital Status")
            {
            }
            column(No; "No.")
            {
            }
            column(PhoneNo; "Phone No.")
            {
            }
            column(County; County)
            {
            }
            column(CountryRegionCode; "Country/Region Code")
            {
            }
            column(CourseDescription; "Course Description")
            {
            }
            column(CourseOfStudy; "Course Of Study")
            {
            }
            column(LevelOfStudy; "Level Of Study")
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
