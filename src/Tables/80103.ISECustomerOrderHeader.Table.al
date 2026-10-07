table 80103 "ISE Customer Order Header"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            Editable = false;
        }
        field(2; "Order Source";Enum "ISE Order Source")
        {
        }
        field(3; "Customer No."; Code[20])
        {
            TableRelation = Customer."No.";

            trigger OnValidate()
            var
                Cust: Record Customer;
            begin
                if Cust.Get("Customer No.")then "Customer Name":=Cust.Name;
            end;
        }
        field(4; "Customer Name"; Text[100])
        {
            Editable = false;
        }
        field(5; "Customer Lot No."; Code[50])
        {
        }
        field(6; "Internal Lot No."; Code[20])
        {
            Editable = false;
        }
        field(7; "Created DateTime"; DateTime)
        {
        }
        field(8; Status; Option)
        {
            OptionMembers = Open, Released, Closed;
        }
        field(9; "Delivery Method"; Code[20])
        {
        }
        field(10; "Payment Terms Code"; Code[10])
        {
            TableRelation = "Payment Terms";
        }
        field(20; "Customer Hardware No."; Code[50])
        {
        }
        field(30; "Ship Alert Required"; Boolean)
        {
            InitValue = true;
        }
        //field(31; "Ship Alert Approved"; Boolean) { }
        field(32; "Ship Alert Approved By"; Code[50])
        {
            Editable = false;
        }
        field(33; "Ship Alert Approved DT"; DateTime)
        {
            Editable = false;
        }
        field(34; "Ship Alert Notes"; Text[250])
        {
        }
        field(35; "Ship Alert Nature";Enum "ISE Nature")
        {
        }
        field(36; "Ship Alert Courier"; Code[30])
        {
        }
        field(37; "Ship Alert Driver"; Text[80])
        {
            Caption = 'Driver/Drop-off';
        }
        field(38; "Ship Alert Cartons"; Integer)
        {
        }
        field(39; "Ship Alert Type";Enum "ISE Request Type")
        {
        }
        field(40; "Receiving Approved"; Boolean)
        {
        }
        field(41; "Receiving Approved By"; Code[50])
        {
            Editable = false;
        }
        field(42; "Receiving Approved DT"; DateTime)
        {
            Editable = false;
        }
        field(43; "Receiving Notes"; Text[250])
        {
        }
        field(44; "Order Request Type";Enum "ISE Request Type")
        {
            Caption = 'Order Request Type (Shipment/Receipt)';
        }
        field(45; "Direction Locked"; Boolean)
        {
            Caption = 'Direction Locked (after stage approval)';
            Editable = false;
        }
        field(46; "Posting Date"; Date)
        {
        }
        field(47; Location; code[20])
        {
            TableRelation = Location.Code;
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
    var Setup: Record "ISE Setup";
    local procedure GetSetup()
    begin
        if not Setup.Get('SETUP')then begin
            Setup.Init();
            Setup."Primary Key":='SETUP';
            Setup.Insert(true);
        end;
    end;
    /* local procedure AssignNo()
    var
        Series: Code[20];
        NewNo: Code[20];
        NoMgmt: Codeunit "No. Series";

    begin
        GetSetup();
        case "Order Source" of
            "Order Source"::Manual:
                Series := Setup."Manual Order No. Series";
            "Order Source"::MES:
                Series := Setup."MES Order No. Series";
            else
                Series := Setup."Adhoc Order No. Series";
        end;
        if Series = '' then Error('No. Series for %1 orders is not configured in ISE Setup.', Format("Order Source"));
        //NewNo := NoMgmt.GetNextNo(Series, WorkDate(), true);
        "No." := NewNo;
    end; */
    /*  trigger OnInsert()
     begin
         if "No." = '' then AssignNo();
         if ("Order Request Type" <> "Order Request Type"::Shipment) and ("Order Request Type" <> "Order Request Type"::Receipt) then
             "Order Request Type" := "Order Request Type"::Receipt;
     end; */
    trigger OnModify()
    begin
        if xRec."Order Request Type" <> Rec."Order Request Type" then if Rec."Direction Locked" then Error('Order Request Type is locked after stage approval.');
    end;
}
