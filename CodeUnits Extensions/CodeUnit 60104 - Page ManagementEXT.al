codeunit 60104 "Page Management EXT"
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Page Management", 'OnAfterGetPageID', '', true, true)]
    local procedure OnAfterGetPageID(RecordRef: RecordRef; var PageId: Integer)
    begin
        if PageId = 0 then
            PageId := GetConditionalCardPageId(RecordRef);

    end;

    local procedure GetConditionalCardPageId(RecordRef: RecordRef): Integer
    begin
        case RecordRef.Number of
            database::"Applicant Registration":
                exit(page::"Applicant Registration");
        end;
    end;

    var
        myInt: Integer;
}