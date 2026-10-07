codeunit 80112 "ISE Release Mgt"
{
    procedure ReleaseDocument(var Rec: Record "ISE Customer Order Header")
    begin
        //TODO: add validation of mandatory fields
        Rec.Status:=Rec.Status::Released;
        Rec.Modify(true);
    end;
}
