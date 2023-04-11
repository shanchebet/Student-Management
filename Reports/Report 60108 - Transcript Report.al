report 60108 "Transcript Report"
{
    Caption = 'Transcript Report';
    ApplicationArea = All;
    UsageCategory = Administration;
    RDLCLayout = './Reports/Report 60108 - Transcript Report.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.";
            column(No_Customer; "No.")
            {
            }
            column(Name_Customer; Name)
            {
            }
            column(LevelOfStudy_Customer; "Level Of Study")
            {
            }
            column(CourseOfStudy_Customer; "Course Of Study")
            {
            }
            column(CourseDescription_Customer; "Course Description")
            {
            }
            column(CompLogo; CompInfo.Picture)
            {

            }
            column(CompName; CompInfo.Name)
            {

            }
            column(CompAddress; CompInfo.Address)
            {

            }
            column(CompCity; CompInfo.City)
            {

            }
            column(CompEmail; CompInfo."E-Mail")
            {

            }
            column(PreparedBy; UserId)
            {

            }
            column(DatePrepared; Today())
            {

            }
            dataitem("Exam Entries"; "Exam Entries")
            {
                DataItemLink = "Student No." = field("No.");
                column(No_ExamEntries; "No.")
                {
                }
                column(StudentNo_ExamEntries; "Student No.")
                {
                }

                column(StudentName_ExamEntries; "Student Name")
                {
                }
                column(LevelOfStudy_ExamEntries; "Level Of Study")
                {
                }
                column(CourseOfStudy_ExamEntries; "Course Of Study")
                {
                }
                column(Semester_ExamEntries; Semester)
                {
                }
                column(AcademicYearCode_ExamEntries; "Academic Year Code")
                {
                }

                dataitem("Exam Entries Lines"; "Exam Entries Lines")
                {
                    DataItemLink = "Document No." = field("No.");

                    column(UnitCode_ExamEntriesLines; "Unit Code")
                    {
                    }
                    column(UnitDescription_ExamEntriesLines; "Unit Description")
                    {
                    }
                    column(CatMarks_ExamEntriesLines; "Cat Marks")
                    {
                    }
                    column(ExamMarks_ExamEntriesLines; "Exam Marks")
                    {
                    }
                    column(FinalMark_ExamEntriesLines; "Final Mark")
                    {
                    }
                    column(Grade_ExamEntriesLines; Grade)
                    {
                    }
                    column(Remarks_ExamEntriesLines; Remarks)
                    {
                    }
                }
            }
        }
    }
    trigger OnPreReport()
    begin
        CompInfo.Get();
        CompInfo.CalcFields(Picture);
    end;

    var
        CompInfo: Record "Company Information";
        UserSetup: Record "User Setup";
}
