tableextension 80128 "ISE Transfer Line Ext" extends "ISE Transfer Line"
{
    fields
    {
    }
    trigger OnInsert()
    var
        Hdr: Record "ISE Transfer Header";
        RemQty: Decimal;
    begin
        if Hdr.Get("Document No.")then begin
            //rec."Transfer Type" := Hdr."Transfer Type";
            "From Location Code":=Hdr."From Location Code";
            "To Location Code":=Hdr."To Location Code";
        //if Hdr.FieldNo("From Bin Code") <> 0 then
        //     "From Bin Code" := Hdr."From Bin Code";
        // if Hdr.FieldNo("To Bin Code") <> 0 then
        //    "To Bin Code" := Hdr."To Bin Code";
        // if Hdr.FieldNo("Vendor No.") <> 0 then
        //    "Vendor No." := Hdr."Vendor No.";
        end;
        // Default Qty. to Post to remaining
        RemQty:=Quantity - "Qty. Shipped";
        if RemQty < 0 then RemQty:=0;
        if("Qty. to Post" = 0) and (RemQty > 0)then "Qty. to Post":=RemQty;
    end;
}
