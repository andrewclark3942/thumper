---------------------------------------------------------------------------
-- FILE    : thumper_client.adb
-- SUBJECT : Main procedure of the Thumper client.
-- AUTHOR  : (C) Copyright 2014 by Peter Chapin
--
-- Please send comments or bug reports to
--
--      Peter Chapin <PChapin@vtc.vsc.edu>
---------------------------------------------------------------------------
with SPARK.Text_IO;
with Messages;
with Network.Addresses;
with Network.Socket;

use type Network.Addresses.Status_Type;
use type Network.Socket.Status_Type;

procedure Thumper_Client
  with
    Global => (In_Out => SPARK.Text_IO.Standard_Output)
is

   procedure Make_Request
     with
       Global => (In_Out => SPARK.Text_IO.Standard_Output)
   is
      Local_Host      : Network.Addresses.IPv4;
      Request_Message : Messages.Message;
      Address_Status  : Network.Addresses.Status_Type;
   begin
      Network.Addresses.To_IPv4_Address("127.0.0.1", Local_Host, Address_Status);
      if Address_Status /= Network.Addresses.Success then
         SPARK.Text_IO.Put_Line("Failed to convert target address to binary form!");
      else
         Request_Message(1) := Character'Pos('X');
         Network.Socket.Send(Network.Addresses.To_UDPv4_Address(Local_Host, 318), Request_Message, 1);
      end if;
   end Make_Request;

   Network_Status : Network.Socket.Status_Type;
begin
   Network.Socket.Create_Socket(Network_Status);
   if Network_Status /= Network.Socket.Success then
      SPARK.Text_IO.Put_Line("Unable to create the client socket. Aborting!");
   else
      Make_Request;
   end if;
end Thumper_Client;
