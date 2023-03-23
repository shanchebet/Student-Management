page 60112 "level OF Study List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Level Of Study";

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {

                field("LOS Code"; Rec."LOS Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the level of study code field.';
                    NotBlank = true;
                }
                field(Description; Rec."LOS Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the level of study Description field.';
                    NotBlank = true;
                }
                // field("Course Code"; Rec."Course Code")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the Course Code field.';
                // }
            }
        }
    }
}


