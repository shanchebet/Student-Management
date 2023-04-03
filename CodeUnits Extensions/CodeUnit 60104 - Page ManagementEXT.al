codeunit 60104 "Page Management EXT"
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Codeunit, 700, 'OnAfterGetPageID', '', true, true)]
    local procedure OnAfterGetPageID(RecordRef: RecordRef; var PageId: Integer)
    begin
        case RecordRef.Number of
            database::"Applicant Registration":
                PageId := GetConditionalCardPageId(RecordRef);
            Database::"Student Invoice":
                PageId := GetConditionalCardPageId(RecordRef);
            Database::"Receipt Header":
                PageId := GetConditionalCardPageId(RecordRef);
        end;
    end;

    local procedure GetConditionalCardPageId(RecordRef: RecordRef): Integer
    begin
        case RecordRef.Number of
            database::"Applicant Registration":
                exit(page::"Applicant Registration");
            Database::"Student Invoice":
                exit(Page::"Student Invoice");
            Database::"Receipt Header":
                exit(Page::"Receipt Header");
        end;
    end;

    var
        myInt: Integer;
}