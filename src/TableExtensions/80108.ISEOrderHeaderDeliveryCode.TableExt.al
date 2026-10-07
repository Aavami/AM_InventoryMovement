tableextension 80108 "ISEOrderHeaderDeliveryCode" extends "ISE Customer Order Header"
{
    fields
    {
        field(50960; "Delivery Code"; Code[20])
        {
            Caption = 'Delivery Code';
            // ✅ Filter codes by selected Delivery Method 2
            TableRelation = "ISE Delivery Method Code".Code where("Delivery Method 2"=field("Delivery Method 2"));

            trigger OnValidate()
            var
                DeliveryRec: Record "ISE Delivery Method Code";
            begin
                if "Delivery Code" = '' then exit;
                // Validate code → derive enum
                DeliveryRec.SetRange(Code, "Delivery Code");
                if not DeliveryRec.FindFirst()then Error('Delivery Code %1 is not valid.', "Delivery Code");
                Validate("Delivery Method 2", DeliveryRec."Delivery Method 2");
            end;
        }
    }
}
