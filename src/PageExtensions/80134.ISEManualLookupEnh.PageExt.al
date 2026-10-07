pageextension 80134 "ISE Manual Lookup Enh" extends "ISE Manual Entry Card"
{
    layout
    {
        modify("Customer/Vendor No.")
        {
            trigger OnLookup(var Text: Text): Boolean var
                Cust: Record Customer;
                Vend: Record "ISE Vendor";
            begin
                if Rec."Vendor/Customer" = Rec."Vendor/Customer"::Customer then begin
                    if Page.RunModal(Page::"ISE Customer Lookup", Cust) = Action::LookupOK then begin
                        Rec.Validate("Customer/Vendor No.", Cust."No.");
                        Rec.Validate("Vendor/Customer Name", Cust.Name);
                        CurrPage.Update(false);
                        exit(true);
                    end;
                end
                else
                begin
                    if Page.RunModal(Page::"ISE Vendor List", Vend) = Action::LookupOK then begin
                        Rec.Validate("Customer/Vendor No.", Vend."No.");
                        Rec.Validate("Vendor/Customer Name", Vend.Name);
                        CurrPage.Update(false);
                        exit(true);
                    end;
                end;
                exit(false);
            end;
            trigger OnafterValidate()
            begin
                ResolveTextToParty(Rec."Customer/Vendor No.");
            end;
        }
        addafter("Customer/Vendor No.")
        {
            field("Vendor/Customer Name"; Rec."Vendor/Customer Name")
            {
                ApplicationArea = All;

                trigger OnLookup(var Text: Text): Boolean var
                    Cust: Record Customer;
                    Vend: Record "ISE Vendor";
                begin
                    if Rec."Vendor/Customer" = Rec."Vendor/Customer"::Customer then begin
                        if Rec."Vendor/Customer Name" <> '' then Cust.SetFilter(Name, '@*' + Rec."Vendor/Customer Name" + '*');
                        if Page.RunModal(Page::"ISE Customer Lookup", Cust) = Action::LookupOK then begin
                            Rec.Validate("Customer/Vendor No.", Cust."No.");
                            Rec.Validate("Vendor/Customer Name", Cust.Name);
                            CurrPage.Update(false);
                            exit(true);
                        end;
                    end
                    else
                    begin
                        if Rec."Vendor/Customer Name" <> '' then Vend.SetFilter(Name, '@*' + Rec."Vendor/Customer Name" + '*');
                        if Page.RunModal(Page::"ISE Vendor List", Vend) = Action::LookupOK then begin
                            Rec.Validate("Customer/Vendor No.", Vend."No.");
                            Rec.Validate("Vendor/Customer Name", Vend.Name);
                            CurrPage.Update(false);
                            exit(true);
                        end;
                    end;
                    exit(false);
                end;
                trigger OnValidate()
                begin
                    ResolveTextToParty(Rec."Vendor/Customer Name");
                end;
            }
        }
        modify("Vendor/Customer")
        {
            trigger OnafterValidate()
            begin
                HandleTypeChange();
            end;
        }
    }
    trigger OnAfterGetRecord()
    begin
        PopulateNameFromNo();
    end;
    trigger OnAfterGetCurrRecord()
    begin
        PopulateNameFromNo();
    end;
    local procedure HandleTypeChange()
    begin
        if Rec."Vendor/Customer" = xRec."Vendor/Customer" then exit;
        if(xRec."Customer/Vendor No." <> '') or (xRec."Vendor/Customer Name" <> '')then begin
            Message('Changing Vendor/Customer will clear the existing Customer/Vendor values and related fields.');
            ClearPartyRelatedValues();
            CurrPage.Update(false);
        end;
    end;
    local procedure ClearPartyRelatedValues()
    begin
        Rec.Validate("Customer/Vendor No.", '');
        Rec.Validate("Vendor/Customer Name", '');
        Rec.Validate("Behalf of Customer", '');
        Rec.Validate("Delivery Code", '');
        Rec.Validate("Pick up Address", '');
        Rec.Validate("Pick up Contact Person", '');
        Rec.Validate("Contact Phone Number", '');
        Rec.Validate("Email", '');
    end;
    local procedure ResolveTextToParty(SearchText: Text[100])
    var
        Cust: Record Customer;
        Vend: Record "ISE Vendor";
    begin
        if SearchText = '' then begin
            if Rec."Customer/Vendor No." <> '' then Rec.Validate("Customer/Vendor No.", '');
            if Rec."Vendor/Customer Name" <> '' then Rec.Validate("Vendor/Customer Name", '');
            exit;
        end;
        if Rec."Vendor/Customer" = Rec."Vendor/Customer"::Customer then begin
            if Cust.Get(SearchText)then begin
                Rec.Validate("Customer/Vendor No.", Cust."No.");
                Rec.Validate("Vendor/Customer Name", Cust.Name);
                exit;
            end;
            Cust.Reset();
            Cust.SetFilter("No.", '@*' + SearchText + '*');
            if Cust.FindFirst()then begin
                Rec.Validate("Customer/Vendor No.", Cust."No.");
                Rec.Validate("Vendor/Customer Name", Cust.Name);
                exit;
            end;
            Cust.Reset();
            Cust.SetFilter(Name, '@*' + SearchText + '*');
            if Cust.FindFirst()then begin
                Rec.Validate("Customer/Vendor No.", Cust."No.");
                Rec.Validate("Vendor/Customer Name", Cust.Name);
                exit;
            end;
        end
        else
        begin
            if Vend.Get(SearchText)then begin
                Rec.Validate("Customer/Vendor No.", Vend."No.");
                Rec.Validate("Vendor/Customer Name", Vend.Name);
                exit;
            end;
            Vend.Reset();
            Vend.SetFilter("No.", '@*' + SearchText + '*');
            if Vend.FindFirst()then begin
                Rec.Validate("Customer/Vendor No.", Vend."No.");
                Rec.Validate("Vendor/Customer Name", Vend.Name);
                exit;
            end;
            Vend.Reset();
            Vend.SetFilter(Name, '@*' + SearchText + '*');
            if Vend.FindFirst()then begin
                Rec.Validate("Customer/Vendor No.", Vend."No.");
                Rec.Validate("Vendor/Customer Name", Vend.Name);
                exit;
            end;
        end;
    end;
    local procedure PopulateNameFromNo()
    var
        Cust: Record Customer;
        Vend: Record "ISE Vendor";
    begin
        if Rec."Customer/Vendor No." = '' then begin
            if Rec."Vendor/Customer Name" <> '' then Rec."Vendor/Customer Name":='';
            exit;
        end;
        if Rec."Vendor/Customer" = Rec."Vendor/Customer"::Customer then begin
            if Cust.Get(Rec."Customer/Vendor No.")then if Rec."Vendor/Customer Name" <> Cust.Name then Rec."Vendor/Customer Name":=Cust.Name;
        end
        else
        begin
            if Vend.Get(Rec."Customer/Vendor No.")then if Rec."Vendor/Customer Name" <> Vend.Name then Rec."Vendor/Customer Name":=Vend.Name;
        end;
    end;
}
