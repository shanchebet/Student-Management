table 60100 "Applicant Registration"
{
    Caption = 'Applicant Registration';
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "Application No."; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
            Caption = 'Application No';

            trigger OnValidate()
            var
                MSMSStudentSetup: Record "Student Management Setup";
                NoSeriesManagement: Codeunit NoSeriesManagement;
            begin
                if "Application No." <> xRec."Application No." then begin
                    MSMSStudentSetup.Get();
                    MSMSStudentSetup.TestField("Application Nos");
                    NoSeriesManagement.TestManual(MSMSStudentSetup."Application Nos");

                end;
            END;

        }
        field(60120; "First Name"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'First Name';
            trigger OnValidate()
            begin
                "Full Name" := "First Name" + ' ' + "Middle Name" + ' ' + SurName;
            end;
        }
        field(60121; "Middle Name"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Middle Name';
            trigger OnValidate()
            begin
                "Full Name" := "First Name" + ' ' + "Middle Name" + ' ' + SurName;
            end;

        }
        field(60122; "SurName"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'SurName';
            trigger OnValidate()
            begin
                "Full Name" := "First Name" + ' ' + "Middle Name" + ' ' + SurName;
            end;
        }
        field(2; "Full Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Full Name';
            Editable = false;

        }
        field(60100; "Gender"; Enum "Gender Type")
        {
            DataClassification = CustomerContent;
            Caption = 'Gender';
        }
        field(60101; "DOB"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Date of Birth';

            trigger OnValidate()

            begin

                if Rec.DOB <> 0D then begin
                    MSMSStudentSetup.Get();
                    MSMSStudentSetup.TestField("No. of Days In A Year");

                    Rec.Age := Round((Today - Rec.DOB) / MSMSStudentSetup."No. of Days In A Year", 1, '<');

                    if Rec.Age < MSMSStudentSetup."Minimum Age" then begin
                        Error('You do not qualify for this');

                    end else
                        if Rec.Age > MSMSStudentSetup."Maximum Age" then begin
                            Error('Your Age is More than Expected');
                        end else
                            exit;
                end;

            end;
        }
        field(60102; "Age"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Age';

        }
        field(9; "Phone Number"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Phone Number';
            ExtendedDatatype = PhoneNo;

            trigger OnValidate()
            var
                Char: DotNet Char;
                i: Integer;
                PhoneNumberCannotContainLettersErr: Label 'must not contain letters';
            begin
                for i := 1 to StrLen("Phone Number") do
                    if Char.IsLetter("Phone Number"[i]) then
                        FieldError("Phone Number", PhoneNumberCannotContainLettersErr);
            end;
        }
        field(60103; "Marital Status"; Enum "Marital Status")
        {
            DataClassification = CustomerContent;
            Caption = 'Marital Status';
        }
        field(60104034; "Approval Status"; Enum "Approval Status")
        {
            DataClassification = CustomerContent;
            Caption = 'Approval Status';
        }

        field(102; "Email"; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'Email Address';
            ExtendedDatatype = EMail;

            trigger OnValidate()
            begin
                ValidateEmail();
            end;
        }

        field(107; "No Series"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(5; Address; Text[100])
        {
            Caption = 'Address';
            DataClassification = ToBeClassified;
        }
        field(7; City; Text[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'city';

            TableRelation = IF ("Country/Region Code" = CONST('')) "Post Code".City
            ELSE
            IF ("Country/Region Code" = FILTER(<> '')) "Post Code".City WHERE("Country/Region Code" = FIELD("Country/Region Code"));

            ValidateTableRelation = false;

            trigger OnLookup()
            begin

                PostCode.LookupPostCode(City, "Post Code", County, "Country/Region Code");
            end;

            trigger OnValidate()
            begin
                PostCode.ValidateCity(City, "Post Code", County, "Country/Region Code", (CurrFieldNo <> 0) and GuiAllowed);
            end;
        }
        field(35; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(91; "Post Code"; Code[20])
        {
            Caption = 'Post Code';

            TableRelation = IF ("Country/Region Code" = CONST('')) "Post Code"
            ELSE
            IF ("Country/Region Code" = FILTER(<> '')) "Post Code" WHERE("Country/Region Code" = FIELD("Country/Region Code"));
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
                PostCode.LookupPostCode(City, "Post Code", County, "Country/Region Code");
            end;

            trigger OnValidate()
            begin
                PostCode.ValidatePostCode(City, "Post Code", County, "Country/Region Code", (CurrFieldNo <> 0) and GuiAllowed);
            end;
        }
        field(92; County; Text[30])
        {

            Caption = 'County';
        }
        field(60104; "Level Of Study"; Text[100])
        {
            DataClassification = CustomerContent;
            TableRelation = "Level Of Study";

            trigger OnValidate()
            var
                School: Record "Level Of Study";
            begin
                if School.Get("Level Of Study") then
                    "LOS Description" := School."LOS Description";
            end;
        }

        field(60105; "Course Of Study"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = '';
            TableRelation = Courses where("LOS Code" = FIELD("Level Of Study"));
            trigger OnValidate()
            var
                CurrCourse: record Courses;
            begin
                if CurrCourse.Get("Course Of Study") then begin
                    "Course Description" := CurrCourse."Course Description";
                    "Department Description" := CurrCourse."Department Description";
                    "School Description" := CurrCourse."School Description";
                end;
            end;
        }
        field(60106; "Customer Type"; Enum "Customer Type")
        {
            DataClassification = CustomerContent;
            Caption = 'Type of applicant';
        }
        field(60109; "Course Description"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Course Description';
        }
        field(60107; "School Description"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'School Description';
        }
        field(60108; "Department Description"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Department Description';
        }
        field(6010402; "LOS Description"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'level of study Description';

        }
        field(6010401; "Grade Attain"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Grade Attained';
            TableRelation = "Cluster Points".Grade;

        }
        field(6010400; "Points"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Points Attained';
            trigger OnValidate()

            begin
                Stud.CheckClusterPointsRange(Rec);
            end;
        }


    }

    keys
    {
        key(PK; "Application No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        if "Application No." = '' then begin
            MSMSStudentSetup.Get();
            MSMSStudentSetup.TestField("Application Nos");
            NoSeriesManagement.InitSeries(MSMSStudentSetup."Application Nos", MSMSStudentSetup."Application Nos", WorkDate(), "Application No.", MSMSStudentSetup."Application Nos");
            Rec."Approval Status" := Rec."Approval Status"::OPen;
            Rec."Customer Type" := Rec."Customer Type"::Student;
        end;
    end;

    var
        MSMSStudentSetup: Record "Student Management Setup";
        NoSeriesManagement: Codeunit NoSeriesManagement;
        PostCode: Record "Post Code";
        Course: Record "Courses";
        Stud: Codeunit "Student Management";



    procedure AssistEdit(StudentApp: Record "Applicant Registration"): Boolean
    var
        MSMSStudentApp: Record "Applicant Registration";
        MSMSStudentSetup: Record "Student Management Setup";
        NoSeriesManagement: Codeunit NoSeriesManagement;
    begin
        MSMSStudentApp := Rec;
        MSMSStudentSetup.Get();
        MSMSStudentSetup.TestField("Application Nos");
        if NoSeriesManagement.SelectSeries(MSMSStudentSetup."Application Nos", '', MSMSStudentApp."No Series") then begin
            NoSeriesManagement.SetSeries(MSMSStudentApp."Application No.");
            Rec := MSMSStudentApp;
            exit(true);
        end;

    end;

    local procedure ValidateEmail()
    var
        MailManagement: Codeunit "Mail Management";
        IsHandled: Boolean;
    begin
        IsHandled := false;

        if IsHandled then
            exit;

        if "EMail" = '' then
            exit;
        MailManagement.CheckValidEmailAddresses("EMail");
    end;

}
