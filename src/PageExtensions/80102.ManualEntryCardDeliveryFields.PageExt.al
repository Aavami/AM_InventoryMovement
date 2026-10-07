pageextension 80102 "ManualEntryCardDeliveryFields" extends "ISE Manual Entry Card"
{
    layout
    {
        // Hide base customer fields
        modify("Customer No.")
        {
            Visible = false;
        }
        modify("Customer Name")
        {
            Visible = false;
        }
        addafter("No.")
        {
            field("Vendor/Customer"; Rec."Vendor/Customer")
            {
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    CurrPage.Update(false);
                end;
            }
            field("Customer/Vendor No."; Rec."Customer/Vendor No.")
            {
                ApplicationArea = All;

                trigger OnLookup(var Text: Text): Boolean var
                    Cust: Record Customer;
                    DummyVend: Record "ISE Vendor";
                begin
                    if Rec."Vendor/Customer" = Rec."Vendor/Customer"::Customer then begin
                        if Page.RunModal(Page::"ISE Customer Lookup", Cust) = Action::LookupOK then begin
                            Text:=Cust."No.";
                            exit(true);
                        end;
                    end
                    else
                    begin
                        if Page.RunModal(Page::"ISE Vendor List", DummyVend) = Action::LookupOK then begin
                            Text:=DummyVend."No.";
                            exit(true);
                        end;
                    end;
                    exit(false);
                end;
            }
            field("Vendor/Customer Names"; PartyName)
            {
                ApplicationArea = All;
                Editable = false;
                Visible = false;
            }
            field("Behalf of Customer"; Rec."Behalf of Customer")
            {
                ApplicationArea = All;
                Enabled = Rec."Vendor/Customer" = Rec."Vendor/Customer"::Vendor;
            }
        }
        addlast(General)
        {
            field("Sender Company Name"; Rec."Sender Company Name")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Requestor / Sender Name"; Rec."Requestor/Sender Name")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Recipient / Attention To"; Rec."Recipient/Attention To")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field(Information; Rec.Notes)
            {
                ApplicationArea = All;
                MultiLine = true;
            }
            field("ISE Destination Locations"; Rec."ISE Destination Locations")
            {
                ApplicationArea = All;
                Caption = 'ISE Recieving Location';
            }
            field(Lot; Rec.Lot)
            {
                ApplicationArea = All;
            }
            field(Tray; Rec.Tray)
            {
                ApplicationArea = all;
            }
            field(Hardware; Rec.Hardware)
            {
                ApplicationArea = all;
            }
            field("Package Other"; Rec."Package Other")
            {
                ApplicationArea = all;
            }
        }
        addlast(content)
        {
            group("Delivery")
            {
                Caption = 'Delivery';

                field("Delivery Method"; Rec."Delivery Method 2")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        SetDeliveryFlags();
                    end;
                }
                // ✅ ALWAYS READ ONLY + LOOKUP FIX
                field("Delivery Code"; Rec."Delivery Code")
                {
                    ApplicationArea = All;
                    Editable = not IsPickUp;
                // trigger OnLookup(var Text: Text): Boolean
                // var
                //     ShipTo: Record "Ship-to Address";
                //     VendAddr: Record "Vendor Address";
                // begin
                //     if Rec."Vendor/Customer" = Rec."Vendor/Customer"::Customer then begin
                //         ShipTo.SetRange("Customer No.", Rec."Customer/Vendor No.");
                //         if Page.RunModal(Page::"Ship-to Address List", ShipTo) = Action::LookupOK then begin
                //             Rec."Delivery Code" := ShipTo.Code;
                //             exit(true);
                //         end;
                //     end else begin
                //         VendAddr.SetRange("Vendor No.", Rec."Customer/Vendor No.");
                //         if Page.RunModal(Page::"Vendor Address List", VendAddr) = Action::LookupOK then begin
                //             Rec."Delivery Code" := VendAddr.Code;
                //             exit(true);
                //         end;
                //     end;
                //     exit(false);
                // end;
                }
                field("Courier/Forwarder Name"; Rec."Courier/Forwarder Name")
                {
                    ApplicationArea = All;
                    Editable = IsCourierForwarder;
                }
                field("Air Way Bill (AWB)"; Rec."Air Way Bill (AWB)")
                {
                    ApplicationArea = All;
                    Editable = IsCourierForwarder;
                }
                field("Expected Date / Time of Arrival / Pick Up"; Rec."Expected Date Time")
                {
                    ApplicationArea = All;
                }
                field("Pick up Address"; Rec."Pick up Address")
                {
                    ApplicationArea = All;
                    Editable = IsPickUp;
                    Visible = false;
                }
                field("ISE Address Code"; Rec."ISE Address Code")
                {
                    ApplicationArea = All;
                    Caption = 'Pickup Address';
                    ToolTip = 'Select a Customer Ship-to Address when the type is Customer, or a Vendor address when the type is Vendor.';
                    Editable = IsPickUp;

                    trigger OnValidate()
                    begin
                        CurrPage.Update(false);
                    end;
                }
                field("ISE Address Name"; Rec."ISE Address Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("ISE Address Line 1"; Rec."ISE Address Line 1")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("ISE Address Line 2"; Rec."ISE Address Line 2")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("ISE Address City"; Rec."ISE Address City")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("ISE Address State"; Rec."ISE Address State")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("ISE Address Post Code"; Rec."ISE Address Post Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("ISE Address Country Code"; Rec."ISE Address Country Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("ISE Address Full"; Rec."ISE Address Full")
                {
                    ApplicationArea = All;
                    Editable = false;
                    MultiLine = true;
                    Caption = 'Full Address';
                }
                field("Contact Person"; Rec."Pick up Contact Person")
                {
                    ApplicationArea = All;
                    Editable = IsContactEditable;
                }
                field("Contact Phone Number"; Rec."Contact Phone Number")
                {
                    ApplicationArea = All;
                    Editable = IsContactEditable;
                }
                // ✅ NEW EMAIL FIELD
                field("Email"; Rec."Email")
                {
                    ApplicationArea = All;
                    Editable = IsEmailEditable;
                }
                field("Special Instructions"; Rec."Special Instructions")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    Editable = IsPickUp;
                }
            }
        }
    }
    var IsCourierForwarder: Boolean;
    IsPickUp: Boolean;
    IsContactEditable: Boolean;
    IsEmailEditable: Boolean;
    PartyName: Text[100];
    // ✅ UPDATED LOGIC
    local procedure SetDeliveryFlags()
    begin
        IsCourierForwarder:=false;
        IsPickUp:=false;
        IsContactEditable:=false;
        IsEmailEditable:=false;
        case Rec."Delivery Method 2" of Rec."Delivery Method 2"::"Pick Up": begin
            IsPickUp:=true;
            IsContactEditable:=true;
            IsEmailEditable:=true;
        end;
        Rec."Delivery Method 2"::"Drop Off": begin
            IsContactEditable:=true;
            IsEmailEditable:=true;
        end;
        Rec."Delivery Method 2"::Courier, Rec."Delivery Method 2"::Forwarder: begin
            IsCourierForwarder:=true;
        end;
        end;
        CurrPage.Update(false);
    end;
    trigger OnAfterGetRecord()
    begin
        PartyName:=GetPartyName();
        SetDeliveryFlags();
    end;
    trigger OnOpenPage()
    begin
        PartyName:=GetPartyName();
        SetDeliveryFlags();
    end;
    local procedure GetPartyName(): Text[100]var
        Cust: Record Customer;
        Vend: Record Vendor;
    begin
        if Rec."Vendor/Customer" = Rec."Vendor/Customer"::Vendor then begin
            if(Rec."Customer/Vendor No." <> '') and Vend.Get(Rec."Customer/Vendor No.")then exit(Vend.Name);
        end
        else
        begin
            if(Rec."Customer/Vendor No." <> '') and Cust.Get(Rec."Customer/Vendor No.")then exit(Cust.Name);
        end;
        exit('');
    end;
}
