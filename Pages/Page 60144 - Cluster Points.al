page 60144 "Cluster Points"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Cluster Points";

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No field.';
                    Visible = false;
                }

                field(StartDate; Rec.StartDate)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the StartDate field.';
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the End Date field.';
                }


                field("Manimum Points"; Rec."Manimum Points")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Manimum Points field.';
                }
                field("Maximum Points"; Rec."Maximum Points")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Maximum Points field.';
                }
                field(Grade; Rec.Grade)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Grade field.';
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Remarks field.';
                }

            }
        }
    }
}