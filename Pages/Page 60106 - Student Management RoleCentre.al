page 60106 "Student Management RoleCentre"
{
    Caption = 'Student Management RC';
    PageType = RoleCenter;

    layout
    {
        area(RoleCenter)
        {
            part(headlines; "Headline RC Administrator")
            {
                ApplicationArea = All;
            }
            part("Student ManagementCues"; "Student ManagementCues")
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }



    actions
    {
        area(Sections)
        {
            group("Applications Portal")
            {
                // action("Applicant Registration")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Applicant Registration';
                //     RunObject = page "Applicant Registration";
                // }
                action("Applicant Registration List")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Applicant Registration';
                    RunObject = page "Applicant Registration List";
                }
            }
            group("Registar Student Affairs")
            {
                action("Open Applicant Registration")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Open Applicant Registration';
                    RunObject = page "Open Applicant Registration";
                }
                action("Pending Applicant Registration")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pending Applicant Registration';
                    RunObject = page "Pending Applicant Registration";
                }
                action("Approved Applicant Registration")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approved Applicant Registration';
                    RunObject = page "Approved ApplicantRegistration";
                }
                action("Rejected Applicant Registration")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Rejected Applicant Registration';
                    RunObject = page "Rejected ApplicantRegistration";
                }
                action("Registered Student List")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Registered Student List";
                }

            }
            group("Administration")
            {
                action("Cluster Mapping")
                {
                    ApplicationArea = all;
                    Caption = 'Cluster Mapping';
                    RunObject = page "Cluster Points List";
                }

                action("School Registration")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Schools';
                    RunObject = page "Type of school List";
                }


                action("Departments")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Departments';
                    RunObject = page "Department List";
                }


                action("Course")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Courses';
                    RunObject = page "Courses List";
                }
                action("Academic Year")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Academic Year Setup';
                    RunObject = page "Academic Year";
                }
                action("Semester")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Semester Setup';
                    RunObject = page "Semester";
                }
                action("Level Of Study ")
                {

                    ApplicationArea = Basic, Suite;
                    Caption = 'Level Of Study';
                    RunObject = page "Level Of Study List";
                }
            }
            group("Department")
            {
                action("Session")
                {

                    ApplicationArea = Basic, Suite;
                    Caption = 'Student Session';
                    RunObject = page "Student Session List ";
                }

                action("Unit")
                {

                    ApplicationArea = Basic, Suite;
                    Caption = 'Units';
                    RunObject = page "Units List";
                }
                action("Unit Matrix")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Unit Matrix Setup';
                    RunObject = page "Unit Matrix";
                }
                action("Units Registration")
                {
                    ApplicationArea = basic, Suite;
                    RunObject = page "Unit Registration List";
                }
                action("Exam Entries")
                {
                    ApplicationArea = all;
                    RunObject = page "Exam Entries";
                }

            }
            group("Finance Transactions")
            {
                action("Finance Structure")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Finance Structure Setup';
                    RunObject = page "Finance Structure";

                }

                group("Student Billing")
                {
                    action("Invoices")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Invoices Lists';
                        RunObject = page "Student Invoice Lists";
                        Visible = false;
                    }
                    action("Open Invoices")
                    {
                        ApplicationArea = all;
                        Caption = 'Open Invoice';
                        RunObject = page "Open Invoice List";
                    }
                    action("pending Approval Invoices")
                    {
                        ApplicationArea = all;
                        Caption = 'Pending Approval Invoice';
                        RunObject = page "Pending Approval Invoice List";
                    }
                    action("Approved Invoice List")
                    {
                        ApplicationArea = all;
                        Caption = 'Approved Invoice List';
                        RunObject = page "Approved Invoice List";
                    }
                    action("Posted Invoice List")
                    {
                        Caption = 'Posted Invoice';
                        ApplicationArea = all;
                        RunObject = page "Posted Invoice List";
                    }
                    action("Rejected Invoice")
                    {
                        ApplicationArea = all;
                        Caption = 'Rejected Invoice';
                        RunObject = page "Rejected Invoice List";
                    }
                    action("Reversed Invoice List")
                    {
                        ApplicationArea = all;
                        Caption = 'Reveresed Invoice List';
                        RunObject = page "Reversed Invoice List";
                    }

                }
                group("Receipts")
                {
                    action("Receipts ")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Receipts List';
                        Visible = false;
                        RunObject = page "Receipt Header List";
                    }
                    action("Open Receipt List")
                    {
                        ApplicationArea = all;
                        Caption = 'Open Receipt List';
                        RunObject = page "Open Receipt List";
                    }
                    action("Pending Approval Receipt")
                    {
                        ApplicationArea = all;
                        Caption = 'Pending Approval Receipt';
                        RunObject = page "Pending Approval Receipt ";

                    }
                    action("Rejected Receipt")
                    {
                        ApplicationArea = all;
                        Caption = 'Rejected Receipt';
                        RunObject = page "Rejected Receipt";
                    }
                    action("Approved Receipt")
                    {
                        ApplicationArea = all;
                        Caption = 'Approved Receipt';
                        RunObject = page "Approved Receipts";
                    }
                    action("Reversed Receipt")
                    {
                        ApplicationArea = all;
                        Caption = 'Reversed Receipt';
                        RunObject = page "Reversed Receipt";
                    }
                    action("Posted Receipt")
                    {
                        ApplicationArea = all;
                        Caption = 'Posted Receipt';
                        RunObject = page "Posted Receipt";
                    }
                }
            }
            group(Reports)
            {
                action("Registered Students Report")
                {
                    ApplicationArea = All;
                    RunObject = report "Registered Student Report";
                }
                action("Applicant Registration")
                {
                    ApplicationArea = all;
                    RunObject = report "Applicant Registration Report";
                }
                action("Unit Registration Report")
                {
                    ApplicationArea = all;
                    RunObject = report "Unit Registration Report";
                }
            }
            group("Setups")
            {

                action("Student Management Setup")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Student Management Setup';
                    RunObject = page "Student Management Setup";
                }
            }

        }
    }
}