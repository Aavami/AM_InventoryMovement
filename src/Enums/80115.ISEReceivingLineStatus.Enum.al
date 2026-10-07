enum 80115 "ISE Receiving Line Status"
{
    Extensible = true;

    value(0; Pending)
    {
    Caption = 'Pending';
    }
    value(1; Partial)
    {
    Caption = 'Partial';
    }
    value(2; Received)
    {
    Caption = 'Received';
    }
    value(3; Cancelled)
    {
    Caption = 'Cancelled';
    }
}
