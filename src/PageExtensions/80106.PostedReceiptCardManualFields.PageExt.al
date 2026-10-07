pageextension 80106 "PostedReceiptCardManualFields" extends "ISE Posted Receipt Card"
{
    layout
    {
        addafter(General)
        {
            group("Manual/Delivery Details")
            {
                field("Vendor/Customer"; Rec."Vendor/Customer")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Customer/Vendor No."; Rec."Customer/Vendor No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Sender Company Name"; Rec."Sender Company Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Requestor/Sender Name"; Rec."Requestor/Sender Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Recipient/Attention To"; Rec."Recipient/Attention To")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Number of Packages"; Rec."Number of Packages")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("ISE Destination Location"; Rec."ISE Destination Location")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Delivery Method"; Rec."Delivery Method")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                group(CourierForwarder)
                {
                    ShowCaption = false;
                    Visible = IsCourierForwarder;

                    field("Courier/Forwarder Name"; Rec."Courier/Forwarder Name")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Air Way Bill (AWB)"; Rec."Air Way Bill (AWB)")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                }
                field("Expected Date Time"; Rec."Expected Date Time")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                group(PickUp)
                {
                    ShowCaption = false;
                    Visible = IsPickUp;

                    field("Pick up Address"; Rec."Pick up Address")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Pick up Contact Person"; Rec."Pick up Contact Person")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Contact Phone Number"; Rec."Contact Phone Number")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Special Instructions"; Rec."Special Instructions")
                    {
                        ApplicationArea = All;
                        Editable = false;
                        MultiLine = true;
                    }
                }
                group(PackageCategory)
                {
                    Caption = 'Package Category';

                    field("Package Hardware"; Rec."Package Hardware")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Package Lot"; Rec."Package Lot")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Package Tray"; Rec."Package Tray")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Package Other"; Rec."Package Other")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                }
                field(Information; Rec.Information)
                {
                    ApplicationArea = All;
                    Editable = false;
                    MultiLine = true;
                }
                field("Behalf of Customer"; Rec."Behalf of Customer")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        SetDeliveryFlags();
    end;
    var IsCourierForwarder: Boolean;
    IsPickUp: Boolean;
    local procedure SetDeliveryFlags()
    begin
        IsCourierForwarder:=(Rec."Delivery Method" = Rec."Delivery Method"::Courier) or (Rec."Delivery Method" = Rec."Delivery Method"::Forwarder);
        IsPickUp:=(Rec."Delivery Method" = Rec."Delivery Method"::"Pick Up");
    end;
}
