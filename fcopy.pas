

PROGRAM
   fcopy;

USES
   {- For FileExists function. -}
   sysutils;

TYPE
   FMode = (Overwrite, Append);

   (* Append contents of file in on to the end of fileout.
         filein : file whose contents will be appended.
         fileout : file to append onto.
         returns : number of bytes written. *)
FUNCTION FileAppend (
   var filein, fileout : File
) : Longint;
VAR
   num_read, num_written : SmallInt;
   buffer : Array[1..1024] of byte;
BEGIN

   {- Initialise values. -}
   num_read := 0;
   num_written := 0;
   FileAppend := 0;

   {- Open files for reading/writing.
      Specify logical records to be 1 byte.
      Move to end of output file for appending. -}
   Reset (filein, 1);
   Reset (fileout, 1);
   Seek (fileout, filesize(fileout));

   {- Copy contents from file1 -> file2. -}
   Repeat
      BlockRead (filein, buffer, Sizeof(buffer), num_read);
      Blockwrite (fileout, buffer, num_read, num_written);
      inc (FileAppend, num_written);
   Until (num_read = 0) or (num_written <> num_read);

END;


   (* Copy contents from filein to fileout.
      The contents of fileout will be overwritten.
         filein : name of file to copy from.
         fileout : name of file to copy to.
         returns : number of bytes written. *)
FUNCTION FileOverwrite (
   var filein, fileout : File
) : Longint;
VAR
   num_read, num_written : SmallInt; {- Keep track of how much is being read/written. -}
   buffer : Array[1..1024] of byte;
BEGIN

   {- Initialise values. -}
   num_read := 0;
   num_written := 0;
   FileOverwrite := 0;

   {- Open files for reading/writing.
      Specify logical records to be 1 byte. -}
   Reset (filein, 1);
   Rewrite (fileout, 1);

   {- Copy contents from file1 -> file2. -}
   Repeat
      BlockRead (filein, buffer, Sizeof(buffer), num_read);
      Blockwrite (fileout, buffer, num_read, num_written);
      inc (FileOverwrite, num_written);
   Until (num_read = 0) or (num_written <> num_read);

END;



   (* Main *)
VAR
   input : Char;
   mode : FMode;
   filein, fileout : File;
   amt_written : longint;
BEGIN
   {- Check cmd args. -}
   if ParamCount <> 2 then begin
      Writeln ('Usage: fcopy <file_in> <file_out>');
      exit;   
   end;

   {- Check source file exists. -}
   if not FileExists (ParamStr(1)) then begin
      Writeln ('Source file ', ParamStr(1), ' does not exist!');
      exit;   
   end;

   {- Default mode: append. -}
   mode := Overwrite;

   {- If destination file exists, check if user wants to overwrite or append. -}
   if FileExists (ParamStr(2)) then begin
      Writeln ('Destination file ', ParamStr(2), ' already exists!');
      Writeln ('Do you want to overwrite, append, or quit? (o/a/q)');
      repeat
         Readln (input);
      until ((input = 'o') or (input = 'a') or (input = 'q'));
      if input = 'q' then
         begin
            Writeln ('Aborting.');
            exit;
         end
      else if input = 'a' then mode := Append
   end;

   {- Open files. -}
   Assign (filein, ParamStr(1));
   Assign (fileout, ParamStr(2));

   {- File writing. -}
   {- Overwriting. -}
   if mode = Overwrite then
      begin
         Writeln ('Copying from ', ParamStr(1), ' to ', ParamStr(2));
         amt_written := FileOverwrite (filein, fileout);
         Writeln ('Copied ', amt_written, ' bytes.');
      end

   {- Appending. -}
   else if mode = Append then
      begin
         Writeln ('Appending ', ParamStr(1), ' onto ', ParamStr(2));
         amt_written := FileAppend (filein, fileout);
         Writeln ('Appended ', amt_written, ' bytes.');
      end;

   {- Close files. -}
   Close (filein);
   Close (fileout);

END.
