codeunit 80113 "ISE Receiving Status Mgt"
{
    procedure ReleaseShipAlert(var Header: Record "ISE Customer Order Header")
    begin
        // ISE95000: Release action replaces Send to Receive / Approve flow for Ship Alert.
        ValidateShipAlertMandatoryFields(Header);
        Header.Validate("Ship Alert Approved", true);
        Header.Validate("Ship Alert Approved By", UserId());
        Header.Validate("Ship Alert Approved DT", CurrentDateTime);
        Header.Validate("Direction Locked", true);
        Header.Validate(Status, Header.Status::Released);
        Header.Modify(true);
    end;
    procedure MarkMailRoomCompleted(var Header: Record "ISE Customer Order Header")
    begin
        // ISE95000: Mail Room has its own completion marker. Existing document Status remains Released.
        Header.Validate("Mail Room Completed", true);
        Header.Validate("Mail Room Completed By", UserId());
        Header.Validate("Mail Room Completed DT", CurrentDateTime);
        Header.Modify(true);
    end;
    procedure ReleaseReceiving(var Header: Record "ISE Customer Order Header")
    var
        SigMgt: Codeunit "ISE Signature Mgt";
    begin
        // ISE95000: Receiving is released only after all lines are fully received.
        UpdateHeaderReceivingStatus(Header."No.");
        Header.Get(Header."No.");
        if Header."Receiving Status" <> Header."Receiving Status"::Complete then Error('All line items must be marked as Received before the receiving record can be released.');
        if not SigMgt.HasSignature(Header)then Error('Signature is required before releasing receiving.');
        Header.Validate("Receiving Approved", true);
        Header.Validate("Receiving Approved By", UserId());
        Header.Validate("Receiving Approved DT", CurrentDateTime);
        Header.Validate("Receiving Released By", UserId());
        Header.Validate("Receiving Released DT", CurrentDateTime);
        Header.Validate(Status, Header.Status::Released);
        Header.Modify(true);
    end;
    procedure ValidateShipAlertMandatoryFields(Header: Record "ISE Customer Order Header")
    begin
        // ISE95000 mandatory header fields.
        if Header."Customer/Vendor No." = '' then Error('Vendor/Customer is mandatory before releasing Ship Alert.');
        if Header."Service Category" = Header."Service Category"::" " then Error('Service Category is mandatory before releasing Ship Alert.');
        if Header."ISE Destination Locations" = '' then Error('ISE Receiving Location is mandatory before releasing Ship Alert.');
        if Header."Delivery Method 2" = Header."Delivery Method 2"::"Pick Up" then begin
            if Header."Pick up Address" = '' then Error('Pick up Address is mandatory before releasing Ship Alert.');
        end
        else
        begin
            if Header."Delivery Code" = '' then Error('Delivery Code is mandatory before releasing Ship Alert.');
        end;
        if not HasAnyLine(Header."No.")then Error('At least one line item is mandatory in Lot, Tray, Hardware, or Other before releasing Ship Alert.');
    end;
    procedure UpdateLineStatus(var Line: Record "ISE Customer Order Line")
    var
        TotalReceivedOrEntered: Decimal;
    begin
        // ISE95000: Use the higher value between posted received qty and currently entered received qty.
        TotalReceivedOrEntered:=Line."Qty. Received";
        if Line."Received Quantity" > TotalReceivedOrEntered then TotalReceivedOrEntered:=Line."Received Quantity";
        if TotalReceivedOrEntered <= 0 then Line."Receiving Line Status":=Line."Receiving Line Status"::Pending
        else if TotalReceivedOrEntered < Line.Quantity then Line."Receiving Line Status":=Line."Receiving Line Status"::Partial
            else
                Line."Receiving Line Status":=Line."Receiving Line Status"::Received;
    end;
    procedure UpdateHeaderReceivingStatus(DocumentNo: Code[20])
    var
        Header: Record "ISE Customer Order Header";
        Line: Record "ISE Customer Order Line";
        AnyLine: Boolean;
        AnyProgress: Boolean;
        AllReceived: Boolean;
        TempLine: Record "ISE Customer Order Line";
    begin
        if not Header.Get(DocumentNo)then exit;
        AnyLine:=false;
        AnyProgress:=false;
        AllReceived:=true;
        Line.SetRange("Document No.", DocumentNo);
        if Line.FindSet(true)then repeat AnyLine:=true;
                TempLine:=Line;
                UpdateLineStatus(TempLine);
                if TempLine."Receiving Line Status" <> Line."Receiving Line Status" then begin
                    Line."Receiving Line Status":=TempLine."Receiving Line Status";
                    Line.Modify(true);
                end;
                if Line."Receiving Line Status" in[Line."Receiving Line Status"::Partial, Line."Receiving Line Status"::Received]then AnyProgress:=true;
                if Line."Receiving Line Status" <> Line."Receiving Line Status"::Received then AllReceived:=false;
            until Line.Next() = 0;
        if(not AnyLine) or (not AnyProgress)then Header."Receiving Status":=Header."Receiving Status"::Open
        else if AllReceived then Header."Receiving Status":=Header."Receiving Status"::Complete
            else
                Header."Receiving Status":=Header."Receiving Status"::"In Progress";
        Header.Modify(true);
    end;
    local procedure HasAnyLine(DocumentNo: Code[20]): Boolean var
        Line: Record "ISE Customer Order Line";
    begin
        Line.SetRange("Document No.", DocumentNo);
        exit(not Line.IsEmpty());
    end;
}
