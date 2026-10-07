tableextension 80111 "ISE COL Receiving Fields" extends "ISE Customer Order Line"
{
    fields
    {
        field(51020; "Received Quantity"; Decimal)
        {
            Caption = 'Received Quantity';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                // Point 6: Received Quantity -> Qty. to Post automatically
                Validate("Qty. to Post", "Received Quantity");
            end;
        }
        field(51021; "Hold Comment"; Text[250])
        {
            Caption = 'Hold Comment';
            DataClassification = CustomerContent;
            Editable = true;
        }
        modify(Hold)
        {
        trigger OnAfterValidate()
        begin
            // Point 5: Hold comment mandatory when Hold is true
            if Hold and ("Hold Comment" = '')then Error('Hold Comment is required when Hold is true.');
        end;
        }
    }
}
