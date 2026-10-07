page 80107 "ISE Shipping Card"
{
    PageType = Document;
    SourceTable = "ISE Customer Order Header";
    ApplicationArea = All;
    Caption = 'ISE Shipping';

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Order Source"; Rec."Order Source")
                {
                    ApplicationArea = All;
                }
                field("Order Request Type"; Rec."Order Request Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Location; Rec.Location)
                {
                    ApplicationArea = All;
                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = All;
                }
                field("Shipping Region"; Rec."Shipping Region")
                {
                    ApplicationArea = All;
                }
                field("Delivery Method 2"; Rec."Delivery Method 2")
                {
                    ApplicationArea = All;
                }
                field("Courier/Forwarder Name"; Rec."Courier/Forwarder Name")
                {
                    ApplicationArea = All;
                }
                field("Courier Service Level"; Rec."Courier Service Level")
                {
                    ApplicationArea = All;
                }
                field("Air Way Bill (AWB)"; Rec."Air Way Bill (AWB)")
                {
                    ApplicationArea = All;
                }
                field("Expected Date Time"; Rec."Expected Date Time")
                {
                    ApplicationArea = All;
                }
                field("ISE PO"; Rec."ISE PO")
                {
                    ApplicationArea = All;
                }
            }
            group("Type Selection")
            {
                field(Lot; Rec.Lot)
                {
                    ApplicationArea = All;
                }
                field(Tray; Rec.Tray)
                {
                    ApplicationArea = All;
                }
                field(Hardware; Rec.Hardware)
                {
                    ApplicationArea = All;
                }
            }
            Group("Shipping Details")
            {
            }
            group("Pickup")
            {
                Visible = Rec."Delivery Method 2" = Rec."Delivery Method 2"::"Pick Up";

                field("Pick up Address"; Rec."Pick up Address")
                {
                    ApplicationArea = All;
                }
                field("Pick up Contact Person"; Rec."Pick up Contact Person")
                {
                    ApplicationArea = All;
                }
                field("Contact Phone Number"; Rec."Contact Phone Number")
                {
                    ApplicationArea = All;
                }
            }
            group("Drop Off")
            {
                Visible = Rec."Delivery Method 2" = Rec."Delivery Method 2"::"Drop Off";

                field("Drop-off Address"; Rec."Drop-off Address")
                {
                    ApplicationArea = All;
                }
                field("Drop-off Contact Person"; Rec."Drop-off Contact Person")
                {
                    ApplicationArea = All;
                }
                field("Drop-off Phone Number"; Rec."Drop-off Phone Number")
                {
                    ApplicationArea = All;
                }
            }
            group("Forwarder")
            {
                Visible = Rec."Delivery Method 2" = Rec."Delivery Method 2"::Forwarder;

                field("Forwarder Account No."; Rec."Forwarder Account No.")
                {
                    ApplicationArea = All;
                }
                field("Courier/Forwarder Name 2"; Rec."Courier/Forwarder Name")
                {
                    ApplicationArea = All;
                    Caption = 'Forwarder Name';
                }
                field("Shipping Contents"; Rec."Shipping Contents")
                {
                    ApplicationArea = All;
                }
            }
            group("Courier")
            {
                Visible = (Rec."Delivery Method 2" = Rec."Delivery Method 2"::Courier) or (Rec."Delivery Method 2" = Rec."Delivery Method 2"::Forwarder);

                field("FedEx Account No."; Rec."FedEx Account No.")
                {
                    ApplicationArea = All;
                    Visible = Rec."Courier/Forwarder Name" = 'FedEx';
                }
                field("UPS Account No."; Rec."UPS Account No.")
                {
                    ApplicationArea = All;
                    Visible = Rec."Courier/Forwarder Name" = 'UPS';
                }
                field("DHL Account No."; Rec."DHL Account No.")
                {
                    ApplicationArea = All;
                    Visible = Rec."Courier/Forwarder Name" = 'DHL';
                }
                field("Export Reason"; Rec."Export Reason")
                {
                    ApplicationArea = All;
                    Visible = Rec."Shipping Region" = Rec."Shipping Region"::International;
                }
            }
            group("Shipping Info")
            {
                Caption = 'Shipping Info';

                group("Address Details")
                {
                    Caption = 'Address Details';

                    field("Shipping Address 1"; Rec."Shipping Address 1")
                    {
                        ApplicationArea = All;
                    }
                    field("Shipping Address 2"; Rec."Shipping Address 2")
                    {
                        ApplicationArea = All;
                    }
                    field(City; Rec.City)
                    {
                        ApplicationArea = All;
                    }
                    field(State; Rec.State)
                    {
                        ApplicationArea = All;
                    }
                    field(Country; Rec.Country)
                    {
                        ApplicationArea = All;
                    }
                }
                group("Contact Information")
                {
                    Caption = 'Contact Information';

                    field("Contact Person"; Rec."Contact Person")
                    {
                        ApplicationArea = All;
                    }
                    field("Phone No."; Rec."Phone No.")
                    {
                        ApplicationArea = All;
                    }
                }
                group("Additional Details")
                {
                    Caption = 'Additional Details';

                    /* field(Comments; Rec.Comments)
                    {
                        ApplicationArea = All;
                        MultiLine = true;
                    } */
                    field("Special Instructions"; Rec."Special Instructions")
                    {
                        ApplicationArea = All;
                        MultiLine = true;
                    }
                    field("Number of Packages"; Rec."Number of Packages")
                    {
                        ApplicationArea = All;
                    }
                    field("Packing Slips"; Rec."Packing Slips")
                    {
                        ApplicationArea = All;
                        MultiLine = true;
                    }
                    field("Commercial Invoice"; Rec."Commercial Invoice")
                    {
                        ApplicationArea = All;
                        MultiLine = true;
                    }
                }
            }
            group("Attachments")
            {
                part(AttachmentPart; "Shipping Attachment Subpage")
                {
                    ApplicationArea = All;
                    SubPageLink = "Order No."=field("No.");
                }
            }
            group(Lines)
            {
                part(LotLines; "ISE Lot Lines")
                {
                    ApplicationArea = All;
                    Visible = Rec.Lot;
                    SubPageLink = "Document No."=field("No.");
                }
                part(HardwareLines; "ISE Harware Lines")
                {
                    ApplicationArea = All;
                    Visible = Rec.Hardware;
                    SubPageLink = "Document No."=field("No.");
                }
                part(TrayLines; "ISE Manual Tray Lines")
                {
                    ApplicationArea = All;
                    Visible = Rec.Tray;
                    SubPageLink = "Document No."=field("No.");
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(PostShipment)
            {
                Caption = 'Post Shipment';
                ApplicationArea = All;
                Image = SalesShipment;

                trigger OnAction()
                var
                    ShipMgt: Codeunit "ISE Posting Mgt.";
                begin
                    ShipMgt.PostOrder(Rec);
                    CurrPage.Update(false);
                end;
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Validate("Order Request Type", Rec."Order Request Type"::Shipment);
        Rec.Lot:=true;
        Rec.Tray:=false;
        Rec.Hardware:=false;
    end;
}
