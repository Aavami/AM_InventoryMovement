table 80104 "ISE Customer Order Line"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            TableRelation = "ISE Customer Order Header"."No.";
        }
        field(2; "Line No."; Integer)
        {
        }
        field(3; Type; Option)
        {
            OptionMembers = Inventory, NonInventory;
        }
        field(4; "No."; Code[20])
        {
            Caption = 'Item/Non-Inv Code';

            //TableRelation = Item."No.";
            trigger OnValidate()
            var
                Item: Record Item;
            begin
                if Item.Get("No.")then Description:=Item.Description;
            end;
        }
        field(5; Description; Text[100])
        {
        }
        field(6; Quantity; Decimal)
        {
        }
        field(7; "Qty. to Post"; Decimal)
        {
        }
        field(8; "Qty. Shipped"; Decimal)
        {
            Editable = false;
        }
        field(9; "Qty. Received"; Decimal)
        {
            Editable = false;
        }
        field(10; "Location Code"; Code[10])
        {
            TableRelation = Location.Code;
        }
        field(11; "Zone Code"; Code[10])
        {
        }
        field(12; "Bin Code"; Code[20])
        {
            TableRelation = Bin.Code;
        }
        field(13; "Customer Lot No."; Code[50])
        {
        }
        field(14; "Internal Lot No."; Code[20])
        {
        }
        field(15; "Serial No."; Code[50])
        {
        }
        field(16; "Lab Code"; Code[20])
        {
            Caption = 'Environment/Lab';
        }
        field(17; "Rack Code"; Code[20])
        {
        }
    }
    keys
    {
        key(PK; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }
    local procedure LinesLockedAfterApproval(): Boolean var
        Hdr: Record "ISE Customer Order Header";
    begin
        if not Hdr.Get("Document No.")then exit(false);
        if Hdr."Ship Alert Approved" then exit(true);
        if(Hdr."Order Source" = Hdr."Order Source"::Adhoc) and Hdr."Receiving Approved" then exit(true);
        exit(false);
    end;
    local procedure GetNextLineNo(): Integer var
        Line: Record "ISE Customer Order Line";
    begin
        Line.SetRange("Document No.", "Document No.");
        if Line.FindLast()then exit(Line."Line No." + 10000)
        else
            exit(10000);
    end;
    trigger OnModify()
    begin
    //  if LinesLockedAfterApproval() then Error('Lines are locked after approval.');
    end;
    //trigger OnValidate(FieldNumber: Integer) begin if LinesLockedAfterApproval() then Error('Lines are locked after approval.'); end;
    trigger OnInsert()
    begin
        if "Line No." = 0 then "Line No.":=GetNextLineNo;
    end;
}
