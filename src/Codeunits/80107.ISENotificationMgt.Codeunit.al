codeunit 80107 "ISE Notification Mgt."
{
    procedure NotifyShipAlertApproved(var OrderHdr: Record "ISE Customer Order Header")
    var
        N: Notification;
    begin
        N.Message:=StrSubstNo('Ship Alert approved for Order %1.', OrderHdr."No.");
        N.Send();
    end;
    procedure NotifySentToReceiving(var OrderHdr: Record "ISE Customer Order Header")
    var
        N: Notification;
    begin
        N.Message:=StrSubstNo('Order %1 sent to Receiving (approval completed).', OrderHdr."No.");
        N.Send();
    end;
}
