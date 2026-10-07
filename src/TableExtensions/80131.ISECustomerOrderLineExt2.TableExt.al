tableextension 80131 "ISE Customer Order Line Ext 2" extends "ISE Customer Order Line"
{
    fields
    {
        modify("No.")
        {
        trigger OnAfterValidate()
        var
            Hdr: Record "ISE Customer Order Header";
        begin
            if Hdr.Get("Document No.")then begin
                //if FieldNo("Order Type") <> 0 then
                //"Order Type" := Hdr."Order Type";
                //if FieldNo("Request Type") <> 0 then
                // "Request Type" := Hdr."Request Type";
                if FieldNo("Location Code") <> 0 then "Location Code":=Hdr."ISE Destination Locations";
            //if FieldName()
            // if FieldNo("Stage") <> 0 then
            //    "Stage" := Hdr."Stage";
            // if FieldNo("Ship Alert No.") <> 0 then
            // "Ship Alert No." := Hdr."Ship Alert No.";
            end;
        end;
        }
    }
}
