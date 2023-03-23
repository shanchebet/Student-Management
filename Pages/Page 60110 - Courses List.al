page 60110 "Courses List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Courses;

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Course Code field.';
                    NotBlank = true;
                }
                field("Course Description"; Rec."Course Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Course Description field.';
                    NotBlank = true;
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Department Code field.';
                }
                field("Department Description"; Rec."Department Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Department Description field.';
                }
                field("LOS Code"; Rec."LOS Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the level of study code field.';
                }
                field(Description; Rec."LOS Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the level of study Description field.';
                }


                field("School Code"; Rec."School Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the School Code field.';
                }
                field("School Description"; Rec."School Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the School Description field.';
                }
                field("Duration"; Rec."Duration")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Duration field.';
                }

            }
        }
    }


}