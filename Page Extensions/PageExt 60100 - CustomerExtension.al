pageextension 60110 "CustomerExt Card" extends "Customer Card"
{
    layout

    {
        addafter(Name)
        {
            field("Customer Type"; Rec."Customer Type")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Customer Type field.';
            }

            field(DOB; Rec.DOB)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Date of Birth field.';
            }

            field(Age; Rec.Age)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Age field.';
            }
            field(Gender; Rec.Gender)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Gender field.';
            }
            field("Marital Status"; Rec."Marital Status")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Marital Status field.';
            }
            field("Level Of Study"; Rec."Level Of Study")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Level of Study field.';
            }
            field("Course Of Study"; Rec."Course Of Study")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Course of Study field.';
            }
            field("Course Description"; Rec."Course Description")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Course Description field.';
            }
            field("School Description"; Rec."School Description")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the School Description field.';
            }
            field("Department Description"; Rec."Department Description")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Department Description field.';
            }


        }

    }



    var
        myInt: Integer;
}