page 60101 "Student Management Setup"
{
    Caption = 'Student Management Setup';
    PageType = Card;
    SourceTable = "Student Management Setup";
    UsageCategory = Administration;
    DeleteAllowed = false;
    InsertAllowed = false;
   
    layout
    {
        area(Content)
        {
            group(Numbering)
            {
                field("Application Nos"; Rec."Application Nos")
                {
                    ApplicationArea = All;
                    Caption = 'Numbering For Applicant';
                    ToolTip = 'Specifies the number series for a Applicant';
                }
                field("Exam Nos"; Rec."Exam Nos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Exam Nos field.';
                }
            }
            group("AgeSetup for Applicant")
            {
                field(MaximumAge; Rec."Maximum Age")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Maximum age for an Applicant to make application field.';

                }
                field("Minimum Age"; Rec."Minimum Age")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the The minimum Age for an Applicant to make application field.';
                }
            }
            group("No Of Days In A Year")
            {
                field("No. of Days In A Year"; Rec."No. of Days In A year")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of Days In a Year';
                }
            }
            group("Courses Setup")
            {

                field("Maximum Course Duration"; Rec."Maximum Course Duration")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Maximum Course Duration field.';
                }
                field("Minimum Course Duration"; Rec."Minimum Course Duration")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Minimum Course Duration field.';
                }
                field("Cluster Nos"; Rec."Cluster Nos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cluster Nos field.';
                }
                field("Max Cat Mark"; Rec."Max Cat Mark")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Max Cat Mark field.';
                }
                field("Max Exam Mark"; Rec."Max Exam Mark")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Max Exam Mark field.';
                }
            }
            group("Units & Session Setup")
            {
                field("Unit Nos"; Rec."Unit Nos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit Numbers field.';
                }
                field("session Nos"; Rec."session Nos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Session Number Series field.';
                }
            }
            group("Finance Setup")
            {

                field("Receipt Nos"; Rec."Receipt Nos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Receipt Nos field.';
                }
                field("StudIN Nos"; Rec."StudIN Nos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the StudIN Nos field.';
                }
                field("Fin Nos"; Rec."Fin Nos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Fin Nos field.';
                }
                field("Maximum Fee Balance"; Rec."Maximum Fee Balance")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the maximum Fee Balance field.';
                }

            }
            group(Journals)
            {

                field("General Journal Template"; Rec."General Journal Template")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the General Journal Template field.';
                }
                field("General Journal Batch"; Rec."General Journal Batch")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the General Journal Batch field.';
                }
            }
            group("Posting Group Setup")
            {

                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Gen. Bus. Posting Group field.';
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the VAT Bus. Posting Group field.';
                }
                field("Customer Posting Group"; Rec."Customer Posting Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Default Student Posting Group field.';
                }
            }
        }
    }

    var
        myInt: Integer;

    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert()
        end;
    end;
}
