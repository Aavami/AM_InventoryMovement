tableextension 80107 "ISE Cust Order Header Ext" extends "ISE Customer Order Header"
{
    fields
    {
        field(90901; "AWB/ISE Mailroom Barcode"; Code[50])
        {
            DataClassification = CustomerContent;
            ExtendedDatatype = Barcode;
        }
        field(90902; "Staging Location Code"; Code[10])
        {
            Caption = 'Scan Staging Location';
            TableRelation = Location.Code where("ISE Staging Location"=const(true));
            DataClassification = CustomerContent;
        }
        field(90903; "Partial Delivery"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(90904; "Damages"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(90905; "ISE PO"; Code[20])
        {
            DataClassification = CustomerContent;
        }
    }
}
