tableextension 80134 "ISECustOrderLineCOOExt" extends "ISE Customer Order Line"
{
    fields
    {
        modify("COO")
        {
        Caption = 'Country of Origin';
        TableRelation = "ISE COO".COO;
        }
    }
}
