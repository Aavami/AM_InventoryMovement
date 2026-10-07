pageextension 80115 ISE_BusManager_RC_Ext extends "Business Manager Role Center"
{
    actions
    {
        addlast(Sections)
        {
            group("ISE Inventory")
            {
                Caption = 'ISE Inventory';

                action(ManualOrders)
                {
                    Caption = 'Ship Alert';
                    ApplicationArea = All;
                    RunObject = page "ISE Manual Orders";
                    Image = Document;
                }
                action(MESOrders)
                {
                    Caption = 'MES Orders';
                    ApplicationArea = All;
                    RunObject = page "ISE MES Orders";
                    Image = Document;
                }
                action(AdhocOrders)
                {
                    Caption = 'Adhoc Orders';
                    ApplicationArea = All;
                    RunObject = page "ISE Adhoc Orders";
                    Image = Document;
                }
                action(ShipAlertOrders)
                {
                    Caption = 'Mail Orders';
                    ApplicationArea = All;
                    RunObject = page "ISE Ship Alert List";
                    Image = SendTo;
                }
                action(ReceivingOrders)
                {
                    Caption = 'Receiving Orders';
                    ApplicationArea = All;
                    RunObject = page "ISE Receiving Orders";
                    Image = Receipt;
                }
                action(ShippingOrders)
                {
                    Caption = 'Shipping Orders';
                    ApplicationArea = All;
                    RunObject = page "ISE Shipping List";
                    Image = Shipment;
                }
                group(Transfers)
                {
                    action(InterTransfers)
                    {
                        Caption = 'Interlocation Transfers';
                        ApplicationArea = All;
                        RunObject = page "ISE Interlocation Transfers";
                        Image = TransferOrder;
                    }
                    action(IntraTransfers)
                    {
                        Caption = 'Intralocation Transfers';
                        ApplicationArea = All;
                        RunObject = page "ISE Intralocation Transfers";
                        Image = TransferOrder;
                    }
                    action(SubconTransfers)
                    {
                        Caption = 'Subcontractor Transfers';
                        ApplicationArea = All;
                        RunObject = page "ISE Subcontractor Transfers";
                        Image = TransferOrder;
                    }
                }
                group(Posted)
                {
                    action(PostedReceipts)
                    {
                        Caption = 'Posted Receipts (Orders)';
                        ApplicationArea = All;
                        RunObject = page "ISE Posted Receipts";
                        Image = PostedOrder;
                    }
                    action(PostedShipments)
                    {
                        Caption = 'Posted Shipment (Orders)';
                        ApplicationArea = All;
                        RunObject = page "ISE Posted Shipment List";
                        Image = PostedOrder;
                    }
                    action(PostedTransShips)
                    {
                        Caption = 'Posted Transfer Shipments';
                        ApplicationArea = All;
                        RunObject = page "ISE Posted Transfer Shipments";
                        Image = PostedOrder;
                    }
                    action(PostedTransRecvs)
                    {
                        Caption = 'Posted Transfer Receipts';
                        ApplicationArea = All;
                        RunObject = page "ISE Posted Transfer Receipts";
                        Image = PostedOrder;
                    }
                }
                action(ISESetup)
                {
                    Caption = 'ISE Setup';
                    ApplicationArea = All;
                    RunObject = page "ISE Setup";
                    Image = Setup;
                }
                action(CombinedMovements)
                {
                    Caption = 'Combined Movements';
                    ApplicationArea = All;
                    RunObject = page "ISE Combined Movements";
                    Image = ItemLedger;
                }
                action(InventoryExplorer)
                {
                    Caption = 'Inventory Explorer';
                    ApplicationArea = All;
                    RunObject = page "ISE Inventory Explorer";
                    Image = ItemLedger;
                }
            }
        }
    }
}
