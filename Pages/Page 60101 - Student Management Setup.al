page 60101 "Student Management Setup"
{
    Caption = 'Student Management Setup';
    PageType = Card;
    SourceTable = "Student Management Setup";
    UsageCategory = Administration;
    DeleteAllowed = false;
    InsertAllowed = false;
    ApplicationArea = All;

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
