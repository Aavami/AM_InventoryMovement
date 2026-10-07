pageextension 80101 "ShipAlertCardNewManualFields" extends "ISE Ship Alert Card New"
{
    layout
    {
        addfirst(FactBoxes)
        {
            part(DocAttach; "Doc. Attachment List Factbox")
            {
                Caption = 'Attachments';
                ApplicationArea = All;
                SubPageLink = "Table ID"=CONST(80103), "No."=FIELD("No.");
            }
            systempart(Notes; Notes)
            {
                Caption = 'Notes';
                ApplicationArea = All;
            }
        }
        addafter(General)
        {
            group("Quick Tab")
            {
                Caption = 'Quick Entry';

                field("Number of Packages"; Rec."Number of Packages")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Partial Delivery"; Rec."Partial Delivery")
                {
                    ApplicationArea = All;
                    Editable = True;
                }
            }
            group("Manual/Delivery Details")
            {
                Caption = 'Mail Room';

                field("Vendor/Customer"; Rec."Vendor/Customer")
                {
                    ApplicationArea = All;
                    Editable = True;
                }
                field("Customer/Vendor No."; Rec."Customer/Vendor No.")
                {
                    ApplicationArea = All;
                    Editable = True;
                }
                field("AWB/ISE Mailroom Barcode"; Rec."AWB/ISE Mailroom Barcode")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Sender Company Name"; Rec."Sender Company Name")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Requestor / Sender Name"; Rec."Requestor/Sender Name")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Recipient / Attention To"; Rec."Recipient/Attention To")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                /* field("ISE Destination Location"; Rec."ISE Destination Location") { ApplicationArea = All; Editable = false; }
                field(Notes; Rec.Notes) { ApplicationArea = All; Editable = false; }
                field("Delivery Method"; Rec."Delivery Method 2") { ApplicationArea = All; Editable = false; }
                field("Delivery Code"; Rec."Delivery Code") { ApplicationArea = All; }
                field("Courier/Forwarder Name"; Rec."Courier/Forwarder Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = IsCourierForwarder;
                }
                field("Air Way Bill (AWB)"; Rec."Air Way Bill (AWB)")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = IsCourierForwarder;
                }
                field("Expected Date / Time of Arrival / Pick Up"; Rec."Expected Date Time") { ApplicationArea = All; Editable = false; }

                field("Pick up Address"; Rec."Pick up Address")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = Rec."Delivery Method 2" = Rec."Delivery Method 2"::"Pick Up";
                }
                field("Pick up Contact Person"; Rec."Pick up Contact Person")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = Rec."Delivery Method 2" = Rec."Delivery Method 2"::"Pick Up";
                }
                field("Contact Phone Number"; Rec."Contact Phone Number")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = Rec."Delivery Method 2" = Rec."Delivery Method 2"::"Pick Up";
                }
                field("Special Instructions"; Rec."Special Instructions")
                {
                    ApplicationArea = All;
                    Editable = false;
                    MultiLine = true;
                    Visible = Rec."Delivery Method 2" = Rec."Delivery Method 2"::"Pick Up";
                }
 */
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
                group("Package Category")
                {
                    Caption = 'Package Category';

                    field(Tray; Rec.Tray)
                    {
                        ApplicationArea = All;
                        Editable = true;
                    }
                    field(Hardware; Rec.Hardware)
                    {
                        ApplicationArea = All;
                        Editable = true;
                    }
                    field(Lot; Rec.Lot)
                    {
                        ApplicationArea = All;
                        Editable = True;
                    }
                    field("Package Other"; Rec."Package Other")
                    {
                        ApplicationArea = All;
                        Editable = True;
                    }
                }
                field("ISE PO"; Rec."ISE PO")
                {
                    ApplicationArea = All;
                    Editable = True;
                }
                field(Damages; Rec.Damages)
                {
                    ApplicationArea = All;
                    Editable = True;
                }
            //field(Information; Rec.Information) { ApplicationArea = All; Editable = true; MultiLine = true; }
            //field("Behalf of Customer"; Rec."Behalf of Customer") { ApplicationArea = All; Editable = false; }
            }
        }
        addlast(content)
        {
            part(Lines; "ISE Customer Order Subform")
            {
                ApplicationArea = All;
                SubPageLink = "Document No."=FIELD("No.");
                Editable = false;
                Visible = false;
            }
            group("Tray Lines")
            {
                Visible = Rec.Tray;

                part(TrayLines; "ISE Manual Tray Lines")
                {
                    ApplicationArea = All;
                    SubPageLink = "Document No."=field("No.");
                }
            }
            group("Hardware Lines")
            {
                Visible = Rec.Hardware;

                part(HardwareLines; "ISE Harware Lines")
                {
                    ApplicationArea = All;
                    SubPageLink = "Document No."=field("No.");
                }
            }
            group("Lot Lines")
            {
                Visible = Rec.Lot;

                part(LotLines; "ISE Lot Lines")
                {
                    ApplicationArea = All;
                    SubPageLink = "Document No."=field("No.");
                }
            }
        }
    }
    var IsCourierForwarder: Boolean;
    IsPickUp: Boolean;
    sCourierForwarder: Boolean;
    IsContactEditable: Boolean;
    IsEmailEditable: Boolean;
    PartyName: Text[100];
    local procedure SetDeliveryFlags()
    begin
        IsCourierForwarder:=(Rec."Delivery Method 2" = Rec."Delivery Method 2"::Courier) or (Rec."Delivery Method 2" = Rec."Delivery Method 2"::Forwarder);
        IsPickUp:=Rec."Delivery Method 2" = Rec."Delivery Method 2"::"Pick Up";
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
        SetDeliveryFlags();
    end;
}
