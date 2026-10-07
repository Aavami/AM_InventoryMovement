pageextension 80100 "CustOrderSubformManualLines" extends "ISE Customer Order Subform"
{
    layout
    {
        modify(Type)
        {
            Visible = false;
        }
        addafter("Line No.")
        {
            field("Manual Line Type"; Rec."Manual Line Type")
            {
                ApplicationArea = All;
                Caption = 'Goods Type';

                trigger OnValidate()
                begin
                    CurrPage.Update(false);
                end;
            }
        }
        addafter("Customer Lot No.")
        {
            //field("Lot"; Rec."Lot#") { ApplicationArea = All; Visible = IsLot; }
            //field("Internal Lot No."; Rec."Internal Lot No.") { ApplicationArea = All; Visible = IsLot; }
            field("Internal Lot No."; Rec."Internal Lot No.")
            {
                ApplicationArea = All;
                Visible = IsLot;

                trigger OnAssistEdit()
                var
                    PostingMgt: Codeunit "ISE Posting Mgt.";
                    NewLot: Code[20];
                begin
                    if Rec."Internal Lot No." = '' then begin
                        NewLot:=PostingMgt.GenerateInternalLot();
                        Rec.Validate("Internal Lot No.", NewLot);
                        rec.Modify;
                    end;
                    CurrPage.Update(false);
                end;
            }
            field("Customer Lot"; Rec."Customer Lot#")
            {
                ApplicationArea = All;
                Editable = IsLot;
            }
            field("Serial No."; Rec."Serial No.")
            {
                ApplicationArea = All;
                Editable = not IsLot;
            }
            field(DeviceName; Rec.DeviceName)
            {
                ApplicationArea = All;
                Editable = IsLot or IsHardware;
            }
            field(Expedite; Rec.Expedite)
            {
                ApplicationArea = All;
                Editable = IsLot;
            }
            field("IQA Optional"; Rec."IQA Optional")
            {
                ApplicationArea = All;
                Editable = IsLot;
            }
            field("Lot Owner"; Rec."Lot Owner")
            {
                ApplicationArea = All;
                Editable = IsLot;
            }
            field("Date Code"; Rec."Date Code")
            {
                ApplicationArea = All;
                Editable = IsLot;
            }
            field(COO; Rec.COO)
            {
                ApplicationArea = All;
                Editable = IsLot;
            }
            field(Hold; Rec.Hold)
            {
                ApplicationArea = All;
                Editable = IsLot;
            }
            field(Status; Rec.Status)
            {
                ApplicationArea = All;
            }
        }
        addafter("Customer Lot No.")
        {
            field("HW Details"; Rec."HW Details")
            {
                ApplicationArea = All;
                Editable = IsHardware;
            }
            field("Tray Vendor"; Rec."Tray Vendor")
            {
                ApplicationArea = All;
                Editable = IsTray;
            }
            field("Tray Part"; Rec."Tray Part#")
            {
                ApplicationArea = All;
                Editable = IsTray;
            }
        }
        modify(Quantity)
        {
            Caption = 'Expected Qty';
        }
        modify("Qty. Received")
        {
            Caption = 'Received Qty';
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Type:=Rec.Type::NonInventory;
    //Rec."Manual Line Type":= Rec."Manual Line Type"::
    end;
    trigger OnAfterGetRecord()
    begin
        SetTypeFlags();
    end;
    trigger OnAfterGetCurrRecord()
    begin
        SetTypeFlags();
    end;
    var IsLot: Boolean;
    IsHardware: Boolean;
    IsTray: Boolean;
    local procedure SetTypeFlags()
    begin
        IsLot:=Rec."Manual Line Type" = Rec."Manual Line Type"::Lot;
        IsHardware:=Rec."Manual Line Type" = Rec."Manual Line Type"::Hardware;
        IsTray:=Rec."Manual Line Type" = Rec."Manual Line Type"::Tray;
    end;
}
