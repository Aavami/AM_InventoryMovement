codeunit 80100 "Shipping Field Sync"
{
    [EventSubscriber(ObjectType::Table, Database::"ISE Customer Order Header", 'OnAfterValidateEvent', 'Customer No.', false, false)]
    local procedure OnAfterValidateCustomerNo(var Rec: Record "ISE Customer Order Header"; var xRec: Record "ISE Customer Order Header"; CurrFieldNo: Integer)
    begin
        UpdateShippingFields(Rec);
    end;
    // 🔷 Core Logic
    local procedure UpdateShippingFields(var Rec: Record "ISE Customer Order Header")
    var
        Cust: Record Customer;
        ShipToAddr: Record "Ship-to Address";
    begin
        if Rec."Customer No." = '' then exit;
        // ✅ Priority 1: Ship-to Address
        /* if (Rec."Ship-to Code" <> '') and
           ShipToAddr.Get(Rec."Customer No.", Rec."Ship-to Code") then begin

            Rec."Shipping Address 1" := ShipToAddr.Address;
            Rec."Shipping Address 2" := ShipToAddr."Address 2";
            Rec.City := ShipToAddr.City;
            Rec.State := ShipToAddr.County;
            Rec.Country := ShipToAddr."Country/Region Code";
            Rec."Contact Person" := ShipToAddr.Contact;
            Rec."Phone No." := ShipToAddr."Phone No.";

        end else begin */
        // ✅ Fallback: Customer
        if Cust.Get(Rec."Customer No.")then begin
            Rec."Shipping Address 1":=Cust.Address;
            Rec."Shipping Address 2":=Cust."Address 2";
            Rec.City:=Cust.City;
            Rec.State:=Cust.County;
            Rec.Country:=Cust."Country/Region Code";
            Rec."Contact Person":=Cust.Contact;
            Rec."Phone No.":=Cust."Phone No.";
        end;
    //end;
    end;
}
