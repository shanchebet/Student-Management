page 60145 "Cluster Points List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Cluster Points";
    //CardPageId = "Cluster Points";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
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