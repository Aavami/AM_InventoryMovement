tableextension 80135 "ISE DeviceName Lookup Ext" extends "ISE Customer Order Line"
{
    fields
    {
        modify(DeviceName)
        {
        Caption = 'Device';
        TableRelation = "ISE Device".Device;
        }
    }
}
