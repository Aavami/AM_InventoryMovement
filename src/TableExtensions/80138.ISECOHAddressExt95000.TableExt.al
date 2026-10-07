tableextension 80138 "ISE COH Address Ext 95000" extends "ISE Customer Order Header"
{
    fields
    {
        field(95020; "ISE Address Code"; Code[20])
        {
            Caption = 'Address Code';
            DataClassification = CustomerContent;
            // ISE95000:
            // If Vendor/Customer = Customer, lookup Customer Ship-to Address.
            // If Vendor/Customer = Vendor, lookup Vendor Order Address.
            //
            // Note:
            // Standard Business Central vendor additional address table is "Order Address".
            // If your project has a custom table named "Vendor Other Address", replace
            // "Order Address" below with that table name.
            TableRelation = if("Vendor/Customer"=const(Customer))"Ship-to Address".Code where("Customer No."=field("Customer/Vendor No."))
            else if("Vendor/Customer"=const(Vendor))"Order Address".Code where("Vendor No."=field("Customer/Vendor No."));

            trigger OnValidate()
            begin
                // ISE95000: Populate full address snapshot based on selected address code.
                PopulateISEAddressFromCode();
            end;
        }
        field(95021; "ISE Address Name"; Text[100])
        {
            Caption = 'Address Name';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(95022; "ISE Address Line 1"; Text[100])
        {
            Caption = 'Address Line 1';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(95023; "ISE Address Line 2"; Text[100])
        {
            Caption = 'Address Line 2';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(95024; "ISE Address City"; Text[50])
        {
            Caption = 'City';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(95025; "ISE Address State"; Text[50])
        {
            Caption = 'State / County';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(95026; "ISE Address Post Code"; Code[20])
        {
            Caption = 'Post Code';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(95027; "ISE Address Country Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "Country/Region".Code;
        }
        field(95028; "ISE Address Full"; Text[500])
        {
            Caption = 'Full Address';
            DataClassification = CustomerContent;
            Editable = false;
        }
        modify("Customer/Vendor No.")
        {
        trigger OnAfterValidate()
        begin
            // ISE95000:
            // When customer/vendor no. changes, clear the selected address
            // so user must select a valid address for the new party.
            ClearISEAddressFields();
        end;
        }
        modify("Vendor/Customer")
        {
        trigger OnAfterValidate()
        begin
            // ISE95000:
            // When party type changes from Customer to Vendor or Vendor to Customer,
            // clear the selected address because the lookup source changes.
            ClearISEAddressFields();
        end;
        }
    }
    local procedure PopulateISEAddressFromCode()
    var
        ShipToAddress: Record "Ship-to Address";
        VendorOrderAddress: Record "Order Address";
    begin
        ClearISEAddressFieldsExceptCode();
        if "ISE Address Code" = '' then exit;
        case "Vendor/Customer" of "Vendor/Customer"::Customer: begin
            if "Customer/Vendor No." = '' then Error('Customer/Vendor No. must be selected before selecting a customer ship-to address.');
            if not ShipToAddress.Get("Customer/Vendor No.", "ISE Address Code")then Error('Customer Ship-to Address %1 was not found for Customer %2.', "ISE Address Code", "Customer/Vendor No.");
            "ISE Address Name":=ShipToAddress.Name;
            "ISE Address Line 1":=ShipToAddress.Address;
            "ISE Address Line 2":=ShipToAddress."Address 2";
            "ISE Address City":=ShipToAddress.City;
            "ISE Address State":=ShipToAddress.County;
            "ISE Address Post Code":=ShipToAddress."Post Code";
            "ISE Address Country Code":=ShipToAddress."Country/Region Code";
        end;
        "Vendor/Customer"::Vendor: begin
            if "Customer/Vendor No." = '' then Error('Customer/Vendor No. must be selected before selecting a vendor address.');
            // Standard BC vendor additional address table is Order Address.
            // Replace this with your custom Vendor Other Address table if required.
            if not VendorOrderAddress.Get("Customer/Vendor No.", "ISE Address Code")then Error('Vendor address %1 was not found for Vendor %2.', "ISE Address Code", "Customer/Vendor No.");
            "ISE Address Name":=VendorOrderAddress.Name;
            "ISE Address Line 1":=VendorOrderAddress.Address;
            "ISE Address Line 2":=VendorOrderAddress."Address 2";
            "ISE Address City":=VendorOrderAddress.City;
            "ISE Address State":=VendorOrderAddress.County;
            "ISE Address Post Code":=VendorOrderAddress."Post Code";
            "ISE Address Country Code":=VendorOrderAddress."Country/Region Code";
        end;
        end;
        BuildISEFullAddress();
    end;
    local procedure ClearISEAddressFields()
    begin
        "ISE Address Code":='';
        ClearISEAddressFieldsExceptCode();
    end;
    local procedure ClearISEAddressFieldsExceptCode()
    begin
        "ISE Address Name":='';
        "ISE Address Line 1":='';
        "ISE Address Line 2":='';
        "ISE Address City":='';
        "ISE Address State":='';
        "ISE Address Post Code":='';
        "ISE Address Country Code":='';
        "ISE Address Full":='';
    end;
    local procedure BuildISEFullAddress()
    var
        FullAddress: Text[500];
    begin
        FullAddress:='';
        AddAddressPart(FullAddress, "ISE Address Name");
        AddAddressPart(FullAddress, "ISE Address Line 1");
        AddAddressPart(FullAddress, "ISE Address Line 2");
        AddAddressPart(FullAddress, "ISE Address City");
        AddAddressPart(FullAddress, "ISE Address State");
        AddAddressPart(FullAddress, "ISE Address Post Code");
        AddAddressPart(FullAddress, "ISE Address Country Code");
        "ISE Address Full":=FullAddress;
    end;
    local procedure AddAddressPart(var FullAddress: Text[500]; AddressPart: Text)
    begin
        if AddressPart = '' then exit;
        if FullAddress <> '' then FullAddress+='\';
        FullAddress+=CopyStr(AddressPart, 1, MaxStrLen(FullAddress) - StrLen(FullAddress));
    end;
}
