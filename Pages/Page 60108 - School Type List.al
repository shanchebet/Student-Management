page 60108 "Type of School List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Type of School";

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {

                field("School Code"; Rec."School Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the School Code field.';
                    NotBlank = true;

                }
                field(Description; Rec."School Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                    NotBlank = true;
                }
            }
        }

    }


}