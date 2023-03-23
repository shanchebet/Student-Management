page 60117 "Student ManagementCues"
{
    Caption = 'Student Management Cues';
    PageType = CardPart;
    SourceTable = "Student Management Cues";

    layout
    {
        area(content)
        {
            cuegroup("Student Mnagement")
            {

                field("Registered Student List"; Rec."Registered Student List")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Registered Student List";
                    Caption = 'Registered Student List';
                    ToolTip = 'Specifies the value of the Registered Sudents field.';
                }
                field("Open Applicant Registartion"; Rec."Open Applicant Registartion")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Open Applicant Registration";
                    ToolTip = 'Specifies the value of the Open Applicant Registartion field.';
                }

                field("Requests to Approve"; Rec."Requests to Approve")
                {
                    ApplicationArea = All;
                    Caption = 'Request to Approve';
                    DrillDownPageID = "Requests to Approve";
                    ToolTip = 'Specifies the value of the Requests to Approve field.';
                }
                field("Requests Sent for Approval"; Rec."Requests Sent for Approval")
                {
                    ApplicationArea = All;
                    Caption = 'Request Sent for Approval';
                    DrillDownPageID = "Approval Request Entries";
                    ToolTip = 'Specifies the value of the Requests Sent for Approval field.';
                }
                field("Pending Applicant Registation "; Rec."Pending Applicant Registration")
                {
                    ApplicationArea = All;
                    Caption = 'Pending Applicant Registration';
                    DrillDownPageId = "Pending Applicant Registration";
                    ToolTip = 'Specifies the value of the Pending Applicant Registation  field.';
                }
                field("Rejected ApplicantRegistration"; Rec."Rejected Applicant Reg.")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Rejected ApplicantRegistration";
                    Caption = 'Rejected Applicant Registration';
                    ToolTip = 'Specifies the value of the Rejected ApplicantRegistration field.';
                }
                field("Approved Applicant Registration"; Rec."Approved Applicant Reg.")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Approved ApplicantRegistration";
                    Caption = 'Approved Applicant Registration';
                    ToolTip = 'Specifies the value of the Approved ApplicantRegistration field.';
                }
            }
            cuegroup("Finance Management")
            {

                field("Open Invoice List"; Rec."Open Invoice List")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Open Invoice List";
                    Caption = 'Open Invoices';
                    ToolTip = 'Specifies the value of the Open Invoice List field.';
                }
                field("Pending Approval Invoice List"; Rec."Pending Approval Invoice List")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Pending Approval Invoice List";
                    Caption = 'Pending Approval Invoice List';
                    ToolTip = 'Specifies the value of the Pending Approval Invoice List field.';
                }
                field("Reversed Invoice List"; Rec."Reversed Invoice List")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Reversed Invoice List";
                    Caption = 'Reversed Invoice List';
                    ToolTip = 'Specifies the value of the Reversed Invoice List field.';
                }
                field("Rejected Invoice List"; Rec."Rejected Invoice List")
                {
                    ApplicationArea = All;
                    Caption = 'Rejecetd Invoice List';
                    DrillDownPageId = "Rejected Invoice List";
                    ToolTip = 'Specifies the value of the Rejected Invoice List field.';
                }
                field("Approved Invoice List"; Rec."Approved Invoice List")
                {
                    ApplicationArea = All;
                    Caption = 'Approved Invoice List';
                    DrillDownPageId = "Approved Invoice List";
                    ToolTip = 'Specifies the value of the Approved Invoice List field.';
                }
                field("Posted Invoice List"; Rec."Posted Invoice List")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Invoice List';
                    DrillDownPageId = "Posted Invoice List";
                    ToolTip = 'Specifies the value of the Posted Invoice List field.';
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        if not Rec.Get then begin
            Rec.Init();
            Rec.Insert();
        end;

        Rec.SetRange("User ID Filter", UserId);
    end;
}
