page 80130 "ISE Ship Alert Card New"
{
    PageType = Card;
    SourceTable = "ISE Customer Order Header";
    Caption = 'Mail Room';
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Order Request Type"; Rec."Order Request Type")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Mail Room Completed"; Rec."Mail Room Completed")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Mail Room Completed By"; Rec."Mail Room Completed By")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Mail Room Completed DT"; Rec."Mail Room Completed DT")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Mail Room Comments"; Rec."Mail Room Comments 95000")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    Caption = 'Mail Room Comments';
                }
            }
            group("Shipment Details")
            {
                Visible = false;

                //field("No. of Boxes"; rec."No. of Boxes") { ApplicationArea = All; }
                field("No. of Cartons"; rec."No. of Cartons")
                {
                    ApplicationArea = All;
                }
                field("Dispatch Date"; rec."Dispatch Date")
                {
                    ApplicationArea = All;
                }
                field("Tracking Number"; rec."Tracking Number")
                {
                    ApplicationArea = All;
                }
                field("Shipped By"; rec."Shipped By")
                {
                    ApplicationArea = All;
                }
                field("Contact Details"; rec."Contact Details")
                {
                    ApplicationArea = All;
                }
            }
            group(Status)
            {
                field("Ship Alert Approved"; rec."Ship Alert Approved")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(ApproveShipAlert)
            {
                Caption = 'Approve Ship Alert';
                ApplicationArea = All;
                Image = Approve;
                Visible = false;

                trigger OnAction()
                begin
                    if rec.FieldNo(rec."Order Source") <> 0 then if not(Rec."Order Source" in[Rec."Order Source"::Manual, Rec."Order Source"::MES])then Error('Only Manual/MES orders can be approved here.');
                    if rec.FieldNo(rec."Skip Ship Alert") <> 0 then if Rec."Skip Ship Alert" then Error('This order bypasses Ship Alert.');
                    Rec."Ship Alert Approved":=true;
                    Rec.Modify(true);
                    Message('Ship Alert approved.');
                end;
            }
            action(Release)
            {
                trigger OnAction()
                var
                    CU: Codeunit "ISE Release Mgt";
                    ReceivingStatusMgt: Codeunit "ISE Receiving Status Mgt";
                begin
                    CU.ReleaseDocument(Rec);
                    Rec."Ship Alert Approved":=true;
                    Rec.Modify(true);
                    //sMessage('Mail Room %1 has been released.', Rec."No.");
                    //ApplicationArea = All;
                    //Caption = 'Mail Completed';
                    //Image = Completed;
                    //Promoted = true;
                    //PromotedCategory = Process;
                    //ToolTip = 'Mark Mail Room processing as completed.';
                    //trigger OnAction()
                    ReceivingStatusMgt.MarkMailRoomCompleted(Rec);
                    CurrPage.Update(false);
                    Message('Mail Room processing has been completed for %1.', Rec."No.");
                end;
            }
            action(SendToReceive)
            {
                Caption = 'Send to Receive Team';
                ApplicationArea = All;
                Image = SendTo;

                trigger OnAction()
                begin
                    //if not Rec."Ship Alert Approved" then
                    //Error('Approve Ship Alert before sending to Receive Team.');
                    // Point 2 & 3 routing: Lot cannot go directly from Mail Room to Receiving
                    if Rec.Status <> rec.Status::Released then error('Status has to be released');
                    if Rec.Lot then Error('Lot packages cannot be sent to Receiving from Mail Room. Please process via Manual Orders and then send to Receiving.');
                    // Allowed only when Tray and/or Hardware is selected.
                    // If you want STRICT Tray AND Hardware (per some variants), change to: if not (Rec.Tray and Rec.Hardware) then Error(...)
                    if not(Rec.Tray or Rec.Hardware)then Error('Select Tray and/or Hardware to send to Receiving from Mail Room.');
                    if Rec.FieldNo(Rec.Stage) <> 0 then Rec.Validate(Stage, Rec.Stage::Receiving);
                    Rec.Modify(true);
                    if not Rec."Ship Alert Approved" then Error('Approve Ship Alert before sending to Receive Team.');
                    if rec.FieldNo(rec."Stage") <> 0 then Rec.Validate("Stage", Rec."Stage"::Receiving);
                    Rec.Modify(true);
                    Message('Sent to Receive Team.');
                end;
            }
        }
    }
    trigger OnOpenPage()
    begin
        if rec.FieldNo(rec."Order Source") <> 0 then rec.SetFilter(rec."Order Source", '%1|%2', Rec."Order Source"::Manual, Rec."Order Source"::MES);
    //if rec.FieldNo(rec."Skip Ship Alert") <> 0 then
    //  rec.SetRange(rec."Skip Ship Alert", false);
    //if rec.FieldNo(rec."Stage") <> 0 then
    //  rec.SetRange(rec."Stage", Rec."Stage"::ShipAlert);
    end;
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean begin
        rec."Skip Ship Alert":=true;
        Rec.Stage:=Rec.Stage::ShipAlert;
        rec."Ship Alert Approved":=true;
        Rec."Recipient/Attention To":=UserId;
        rec."Order Request Type":=Rec."Order Request Type"::Receipt;
    end;
    trigger OnNewRecord(BelowxRec: Boolean)
    var
        NoMgt: Codeunit "No. Series";
        ISESetup: Record "ISE Setup";
    begin
        ISESetup.get('SETUP');
        Rec.Validate(rec."Order Source", Rec."Order Source"::Manual);
        rec."No.":=NoMgt.GetNextNo(ISESetup."Manual Order No. Series");
    end;
}
