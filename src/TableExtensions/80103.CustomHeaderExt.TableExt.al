tableextension 80103 "CustomHeaderExt" extends "ISE Customer Order Header"
{
    fields
    {
        modify("ISE Destination Locations")
        {
        trigger OnAfterValidate()
        var
            CusrOrdLn: Record "ISE Customer Order Line";
            UpdateLinesQst: Label 'Do you want to update the Location Code on the sales lines?';
        begin
            // Ensure we only update lines if there actually are lines, and the location code has changed
            if(Rec."ISE Destination Locations" <> xRec."ISE Destination Locations")then begin
                CusrOrdLn.reset;
                CusrOrdLn.SetRange("Document No.", Rec."No.");
                // Optional: Only target lines where the type is an Item
                if not CusrOrdLn.IsEmpty()then begin
                    // Ask the user if they want to push the header change down to the lines
                    if CusrOrdLn.FindSet(true)then begin
                        repeat // Validate ensures that warehouse availability and tax logic are re-evaluated per line
                            CusrOrdLn.Validate("Location Code", Rec."ISE Destination Locations");
                            CusrOrdLn.Modify(true);
                        until CusrOrdLn.Next() = 0;
                    end;
                end;
            end;
        end;
        }
    }
}
