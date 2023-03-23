page 60113 "Academic Year"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Academic Year";

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field("Code"; Rec."Academic year Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Academic Year Code field.';
                    NotBlank = true;
                }
                field(Description; Rec."Academic Year Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Academic Year Description field.';
                    NotBlank = true;
                }
            }
        }
        area(Factboxes)
        {

        }
    }


}