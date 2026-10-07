pageextension 80104 "AdhocCardDeliveryFields" extends "ISE Adhoc Entry Card"
{
    layout
    {
        // Hide base customer fields and replace with unified
        modify("Customer No.")
        {
            Visible = false;
        }
        modify("Customer Name")
        {
            Visible = false;
        }
        addfirst(General)
        {
            field("Vendor/Customer"; Rec."Vendor/Customer")
            {
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    CurrPage.Update(false);
                end;
            }
            /*  field("Customer/Vendor No."; Rec."Customer/Vendor No.")
             {
                 ApplicationArea = All;
                 trigger OnValidate()
                 begin
                     CurrPage.Update(false);
                 end;
             } */
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
            field("Vendor/Customer Name"; PartyName)
            {
                ApplicationArea = All;
                Editable = false;
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
            }
            field("Requestor / Sender Name"; Rec."Requestor/Sender Name")
            {
                ApplicationArea = All;
            }
            field("Recipient / Attention To"; Rec."Recipient/Attention To")
            {
                ApplicationArea = All;
            }
            field("Number of Packages"; Rec."Number of Packages")
            {
                ApplicationArea = All;
            }
            field("ISE Destination Location"; Rec."ISE Destination Location")
            {
                ApplicationArea = All;
            }
            field(Information; Rec.Notes)
            {
                ApplicationArea = All;
                MultiLine = true;
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
                }
                field("Delivery Code"; Rec."Delivery Code")
                {
                    ApplicationArea = All;
                }
                field("Courier/Forwarder Name"; Rec."Courier/Forwarder Name")
                {
                    ApplicationArea = All;
                    Visible = IsCourierForwarder;
                }
                field("Air Way Bill (AWB)"; Rec."Air Way Bill (AWB)")
                {
                    ApplicationArea = All;
                    Visible = IsCourierForwarder;
                }
                field("Expected Date / Time of Arrival / Pick Up"; Rec."Expected Date Time")
                {
                    ApplicationArea = All;
                }
                field("Pick up Address"; Rec."Pick up Address")
                {
                    ApplicationArea = All;
                    Visible = Rec."Delivery Method 2" = Rec."Delivery Method 2"::"Pick Up";
                }
                field("Pick up Contact Person"; Rec."Pick up Contact Person")
                {
                    ApplicationArea = All;
                    Visible = Rec."Delivery Method 2" = Rec."Delivery Method 2"::"Pick Up";
                }
                field("Contact Phone Number"; Rec."Contact Phone Number")
                {
                    ApplicationArea = All;
                    Visible = Rec."Delivery Method 2" = Rec."Delivery Method 2"::"Pick Up";
                }
                field("Special Instructions"; Rec."Special Instructions")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    Visible = Rec."Delivery Method 2" = Rec."Delivery Method 2"::"Pick Up";
                }
            }
        /* group("Package Category")
            {
                Caption = 'Package Category (select all that apply)';
                field("Package Hardware"; Rec."Package Hardware") { ApplicationArea = All; }
                field("Package Lot"; Rec."Package Lot") { ApplicationArea = All; }
                field("Package Tray"; Rec."Package Tray") { ApplicationArea = All; }
                field("Package Other"; Rec."Package Other") { ApplicationArea = All; }
            } */
        }
    }
    var IsCourierForwarder: Boolean;
    IsPickUp: Boolean;
    local procedure SetDeliveryFlags()
    begin
        IsCourierForwarder:=(Rec."Delivery Method 2" = Rec."Delivery Method 2"::Courier) or (Rec."Delivery Method 2" = Rec."Delivery Method 2"::Forwarder);
        IsPickUp:=Rec."Delivery Method 2" = Rec."Delivery Method 2"::"Pick Up";
    end;
    trigger OnAfterGetRecord()
    begin
        PartyName:=GetPartyName();
        SetDeliveryFlags();
    end;
    var PartyName: Text[100];
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
