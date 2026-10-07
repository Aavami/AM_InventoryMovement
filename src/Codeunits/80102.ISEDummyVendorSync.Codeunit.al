codeunit 80102 "ISE Dummy Vendor Sync"
{
    [EventSubscriber(ObjectType::Table, Database::Vendor, 'OnAfterInsertEvent', '', false, false)]
    local procedure OnVendorInserted(var Rec: Record Vendor)
    begin
        CreateOrUpdateDummyVendor(Rec);
    end;
    [EventSubscriber(ObjectType::Table, Database::Vendor, 'OnAfterModifyEvent', '', false, false)]
    local procedure OnVendorModified(var Rec: Record Vendor)
    begin
        CreateOrUpdateDummyVendor(Rec);
    end;
    local procedure CreateOrUpdateDummyVendor(VendorRec: Record Vendor)
    var
        Dummy: Record "ISE Vendor";
    begin
        if not Dummy.Get(VendorRec."No.")then begin
            Dummy.Init();
            Dummy."No.":=VendorRec."No.";
            Dummy."Source Vendor No.":=VendorRec."No.";
            Dummy.Insert();
        end;
        Dummy.Name:=VendorRec.Name;
        Dummy.Address:=VendorRec.Address;
        Dummy."Address 2":=VendorRec."Address 2";
        Dummy.City:=VendorRec.City;
        Dummy."Post Code":=VendorRec."Post Code";
        Dummy.Country:=VendorRec."Country/Region Code";
        Dummy.Phone:=VendorRec."Phone No.";
        Dummy.Email:=VendorRec."E-Mail";
        Dummy."Tray Vendor":=VendorRec."Tray Vendor";
        Dummy.Modify();
    end;
}
