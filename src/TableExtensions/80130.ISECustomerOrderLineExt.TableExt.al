tableextension 80130 "ISE Customer Order Line Ext" extends "ISE Customer Order Line"
{
    fields
    {
    }
    trigger OnInsert()
    var
        Hdr: Record "ISE Customer Order Header";
    begin
        if Hdr.Get("Document No.")then begin
            //if rec.FieldNo(order soour) <> 0 then
            //   "Order Type" := Hdr."Order Type";
            //if rec.FieldNo("Request Type") <> 0 then
            //      "Request Type" := Hdr."Request Type";
            if rec.FieldNo("Location Code") <> 0 then "Location Code":=Hdr."ISE Destination Locations";
        //if rec.FieldNo(rec."Stage") <> 0 then
        //   "Stage" := Hdr."Stage";
        //if rec.FieldNo("Ship Alert No.") <> 0 then
        //"Ship Alert No." := Hdr."Ship Alert No.";
        end;
    end;
}
