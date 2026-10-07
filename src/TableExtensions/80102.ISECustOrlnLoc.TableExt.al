tableextension 80102 "ISECustOrlnLoc" extends "ISE Customer Order Line"
{
    fields
    {
    }
    trigger OnInsert()
    var
        CustOrdHeader: Record "ISE Customer Order Header";
    begin
        // Verify the parent Sales Header exists
        if CustOrdHeader.Get(rec."Document No.")then begin
            // Inherit the Location Code from the header if it's populated
            if CustOrdHeader."ISE Destination Locations" <> '' then begin
                Rec.Validate("Location Code", CustOrdHeader."ISE Destination Locations");
            end;
        end;
    end;
    trigger OnAfterModify()
    var
        CustOrdHeader: Record "ISE Customer Order Header";
    begin
        // Verify the parent Sales Header exists
        if CustOrdHeader.Get(rec."Document No.")then begin
            // Inherit the Location Code from the header if it's populated
            if CustOrdHeader."ISE Destination Locations" <> '' then begin
                Rec.Validate("Location Code", CustOrdHeader."ISE Destination Locations");
            end;
        end;
    end;
}
