


TYPE

   BuffReader = Record
      f : File;
      buffer : Array[1..1024] of byte;
      i, buff_len : Integer;
      done : Boolean;
   end;

PROCEDURE OpenReader (
   var reader : BuffReader;
   fpath : String
);
BEGIN
   Assign (reader.f, fpath);
   Reset (reader.f, 1);
   reader.done := False;
END;

PROCEDURE CloseReader (
   var reader : BuffReader
);
BEGIN
   Close (reader.f);
END;


PROCEDURE Rebuffer (
   var br : BuffReader
);
BEGIN

   br.i := 0;

   if EOF(br.f) then begin
      br.done := true;
      br.buff_len := 0;
      exit;  
   end;

   BlockRead (br.f, br.buffer, Sizeof(br.buffer), br.buff_len);

END;

FUNCTION HasNext (
   var br : BuffReader
) : Boolean;
BEGIN
   HasNext := br.done;
END;



FUNCTION IsSpace (c : Char) : Boolean;
BEGIN
   IsSpace := (c = ' ') or (c = #10) or (c = #13);
END;


FUNCTION Next (
   var br : BuffReader
) : String;
VAR
   char_count : Integer;
BEGIN
END;

BEGIN
END.


