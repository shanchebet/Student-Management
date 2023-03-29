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
                }
                field(Grade; Rec.Grade)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Grade field.';
                }
                field("Maximum Points"; Rec."Maximum Points")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Maximum Points field.';
                }
                field("Manimum Points"; Rec."Manimum Points")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Manimum Points field.';
                }
            }
        }
    }
}