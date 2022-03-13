---------------------------------------------------------------------------
-- FILE    : server_logger.adb
-- SUBJECT : Body of a log management package.
-- AUTHOR  : (C) Copyright 2022 by Peter Chapin
--
-- Please send comments or bug reports to
--
--      Peter Chapin <chapinp@acm.org>
---------------------------------------------------------------------------
pragma SPARK_Mode(Off);

with Ada.Text_IO;
with Ada.Calendar;
use Ada.Calendar;
with Ada.Strings.Fixed;
use Ada.Strings.Fixed;
with Ada.Strings;
use Ada.Strings;


package body Server_Logger is

   function Format_Timestamp return String is
   now : Time;
   now_String : String(1..19) := (others => ' ');
   now_Year : Integer;
   now_Month : Integer;
   now_Day : Integer;
   now_Second_Duration : Day_Duration;
   now_Second : Positive;
   now_Hour : Positive;
   now_Minute : Positive;
   now_Seconds : Positive;
   begin
      now := Clock;
      Ada.Calendar.Split(Date => now, Year => now_Year, Month => now_Month, Day => now_Day, Seconds => now_Second_Duration);
      now_Second := Integer(now_Second_Duration);
      now_Hour := now_Second/3600;
      now_Minute := (now_Second - (now_Hour * 3600)) / 60;
      now_Seconds := now_second - (now_Hour * 3600) - (now_Minute * 60);
      --now_String :=;
      now_String := Trim(Integer'Image(now_Year),Both) & "-" & 
      Trim((if now_Month < 10 then "0" & Trim(Integer'Image(now_Month),Both) else Integer'Image(now_Month)),Both) & "-" & 
      Trim((if now_Day < 10 then "0" & Trim(Integer'Image(now_Day),Both) else Integer'Image(now_Day)),Both) & " " & 
      Trim((if now_Hour < 10 then "0" & Trim(Integer'Image(now_Hour),Both) else Integer'Image(now_Hour)),Both) & ":" & 
      Trim((if now_Minute < 10 then "0" & Trim(Integer'Image(now_Minute),Both) else Integer'Image(now_Minute)),Both) & ":" & 
      Trim((if now_Seconds < 10 then "0" & Trim(Integer'Image(now_Seconds),Both) else Integer'Image(now_Seconds)),Both);
      return now_String;
   end Format_Timestamp;

   procedure Write_Error(Message : in String) is
   begin
      Ada.Text_IO.Put_Line("*** ERROR: " & Format_Timestamp & " " & Message);
   end Write_Error;

   procedure Write_Information(Message: in String) is
   begin
      Ada.Text_IO.Put_Line ("*** Info: " & Format_Timestamp & " " & Message);
   end Write_Information;

   procedure Write_Warning(Message : in String) is
   begin
      Ada.Text_IO.Put_Line("*** Warning: " & Format_Timestamp & " " & Message);
   end Write_Warning;

end Server_Logger;
