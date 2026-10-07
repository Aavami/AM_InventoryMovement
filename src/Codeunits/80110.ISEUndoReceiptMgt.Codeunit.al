codeunit 80110 "ISE Undo Receipt Mgt"
{
    procedure Reopen(var PRecHdr: Record "ISE Posted Receipt Hdr")
    begin
        if PRecHdr.Reopened then Error('Already reopened.');
        PRecHdr.Validate(Reopened, true);
        PRecHdr.Modify(true);
    end;
    procedure Undo(var PRecHdr: Record "ISE Posted Receipt Hdr")
    var
        PRecLine: Record "ISE Posted Receipt Line";
    begin
        PRecLine.SetRange("Document No.", PRecHdr."No.");
        if PRecLine.FindSet()then repeat if not PRecLine.Reversed then begin
                    PRecLine.Validate(Reversed, true);
                    PRecLine.Modify(true);
                end;
            until PRecLine.Next() = 0;
    end;
}
