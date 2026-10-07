tableextension 80137 "ISE COL Receiving Ext 95000" extends "ISE Customer Order Line"
{
    fields
    {
        field(95000; "Receiving Line Status";Enum "ISE Receiving Line Status")
        {
            Caption = 'Receiving Line Status';
            DataClassification = CustomerContent;
            Editable = false;
        }
        modify("Qty. Received")
        {
        trigger OnAfterValidate()
        var
            ReceivingStatusMgt: Codeunit "ISE Receiving Status Mgt";
        begin
            // ISE95000: Update status after posted/received quantity changes.
            ReceivingStatusMgt.UpdateLineStatus(Rec);
            ReceivingStatusMgt.UpdateHeaderReceivingStatus("Document No.");
        end;
        }
        modify("Qty. to Post")
        {
        trigger OnAfterValidate()
        var
            ReceivingStatusMgt: Codeunit "ISE Receiving Status Mgt";
        begin
            // ISE95000: Update status if old UI still updates Qty. to Post directly.
            ReceivingStatusMgt.UpdateLineStatus(Rec);
            ReceivingStatusMgt.UpdateHeaderReceivingStatus("Document No.");
        end;
        }
        modify("Received Quantity")
        {
        trigger OnAfterValidate()
        var
            ReceivingStatusMgt: Codeunit "ISE Receiving Status Mgt";
        begin
            // ISE95000: Keep Qty. to Post and the receiving line status in sync when Receiving team edits Received Quantity.
            Validate("Qty. to Post", "Received Quantity");
            ReceivingStatusMgt.UpdateLineStatus(Rec);
            ReceivingStatusMgt.UpdateHeaderReceivingStatus("Document No.");
        end;
        }
    }
}
