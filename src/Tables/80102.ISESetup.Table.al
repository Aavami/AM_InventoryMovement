table 80102 "ISE Setup"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            DataClassification = SystemMetadata;
        }
        field(10; "Internal Lot No. Series"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(11; "Posted Shipment No. Series"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(12; "Posted Receipt No. Series"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(13; "Manual Order No. Series"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(14; "MES Order No. Series"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(15; "Adhoc Order No. Series"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(16; "Transfer No. Series"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(17; "Posted Trans-Ship No. Series"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(18; "Posted Trans-Recv No. Series"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(20; "Item Jnl. Template"; Code[10])
        {
            TableRelation = "Item Journal Template".Name;
        }
        field(21; "Item Jnl. Batch"; Code[10])
        {
            TableRelation = "Item Journal Batch".Name WHERE("Journal Template Name"=FIELD("Item Jnl. Template"));
        }
        field(31; "Serial No. Series"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(30; "Default In-Transit Location"; Code[10])
        {
            TableRelation = Location.Code;
        }
        field(32; "Order No. Series"; Code[20])
        {
            TableRelation = "No. Series";
        }
    }
    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}
