page 60114 Semester
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Semester;

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {

                field("Semester Code"; Rec."Semester Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Semester Code field.';
                    NotBlank = true;
                }
                field("Semester Description"; Rec."Semester Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Semester Description field.';
                    NotBlank = true;
                }
                field(" Academic Year Code"; Rec." Academic Year Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Academic Year Code field.';
                }
                field("Academic Year Description"; Rec."Academic Year Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Academic Year Description field.';
                }
            }
        }
    }
}
