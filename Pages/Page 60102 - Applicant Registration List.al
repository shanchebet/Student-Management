page 60102 "Applicant Registration List"
{
    ApplicationArea = All;
    Caption = 'Applicant Registration';
    PageType = List;
    SourceTable = "Applicant Registration";
    UsageCategory = Lists;

    CardPageId = "Applicant Registration";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {

                field("Application No."; Rec."Application No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Application No field.';
                }
                field(FirstName; Rec."First Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the  First Name field.';
                    Visible = false;
                }
                field(MiddleName; Rec."Middle Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Middle Name field.';
                    Visible = false;
                }
                field(SurName; Rec.SurName)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the  SurName field.';
                    Visible = false;
                }
                field(FullName; Rec."Full Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the  FullName field.';
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Gender field.';
                }
                field(DOB; Rec.DOB)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date of Birth field.';
                    Visible = false;


                }
                field(Age; Rec.Age)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Age field.';
                }
                field("Phone Number"; Rec."Phone Number")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Phone Number field.';
                }
                field("Marital Status"; Rec."Marital Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Marital Status field.';
                    Visible = false;
                }
                field("Approval Status "; Rec."Approval Status ")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Approval Status field.';
                }
            }
        }

    }



}
