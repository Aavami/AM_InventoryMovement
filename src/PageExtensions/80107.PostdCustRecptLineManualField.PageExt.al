pageextension 80107 "PostdCustRecptLineManualField" extends "Posted Customer Reciept Lines"
{
    layout
    {
        addlast(General)
        {
            field("Manual Line Type"; Rec."Manual Line Type")
            {
                ApplicationArea = All;
            }
            field("Lot#"; Rec."Lot#")
            {
                ApplicationArea = All;
            }
            field("Customer Lot#"; Rec."Customer Lot")
            {
                ApplicationArea = All;
            }
            field(DeviceName; Rec.DeviceName)
            {
                ApplicationArea = All;
            }
            field(Expedite; Rec.Expedite)
            {
                ApplicationArea = All;
            }
            field("IQA Optional"; Rec."IQA Optional")
            {
                ApplicationArea = All;
            }
            field("Lot Owner"; Rec."Lot Owner")
            {
                ApplicationArea = All;
            }
            field("Date Code"; Rec."Date Code")
            {
                ApplicationArea = All;
            }
            field(COO; Rec.COO)
            {
                ApplicationArea = All;
            }
            field(Hold; Rec.Hold)
            {
                ApplicationArea = All;
            }
            field("HW Details"; Rec."HW Details")
            {
                ApplicationArea = All;
            }
            field("Tray Vendor"; Rec."Tray Vendor")
            {
                ApplicationArea = All;
            }
            field("Tray Part#"; Rec."Tray Part")
            {
                ApplicationArea = All;
            }
        }
    }
}
