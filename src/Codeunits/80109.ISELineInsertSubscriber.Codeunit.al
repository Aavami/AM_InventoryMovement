codeunit 80109 "ISE Line Insert Subscriber"
{
    [EventSubscriber(ObjectType::Table, Database::"ISE Customer Order Line", 'OnAfterInsertEvent', '', false, false)]
    local procedure OnAfterInsertOrderLine(var Rec: Record "ISE Customer Order Line")
    var
        PostMgt: Codeunit "ISE Posting Mgt.";
    begin
        if Rec.Type <> Rec.Type::Inventory then exit;
        if Rec."Internal Lot No." = '' then Rec."Internal Lot No.":=PostMgt.GenerateInternalLot();
    end;
}
