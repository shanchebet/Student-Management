report 60105 "Fee Statement"
{
    ApplicationArea = All;
    Caption = 'Fee Statement';
    UsageCategory = Administration;
    RDLCLayout = './Reports/Report 60105 - Fee Statement.rdl';
    DefaultLayout = RDLC;
    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.";
            DataItemTableView = sorting("No.") where("Customer Type" = filter(Student));
            column(No_; "No.")
            {

            }
            column(Name; Name)
            {

            }
            column(Course_Of_Study; "Course Of Study")
            {

            }
            column(Course_Description; "Course Description")
            {

            }
            column(School_Description; "School Description")
            {

            }
            column(Gender; Gender)
            {

            }
            column(Age; Age)
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

            dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
            {
                DataItemLink = "Customer No." = field("No.");
                column(DocumentNo_CustLedgerEntry; "Document No.")
                {
                }
                column(PostingDate_CustLedgerEntry; "Posting Date")
                {
                }
                column(Description_CustLedgerEntry; Description)
                {
                }
                column(DebitAmount_CustLedgerEntry; "Debit Amount")
                {
                }
                column(CreditAmount_CustLedgerEntry; "Credit Amount")
                {
                }
                column(RemainingAmount_CustLedgerEntry; "Remaining Amount")
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
        AmountSum: Decimal;

}