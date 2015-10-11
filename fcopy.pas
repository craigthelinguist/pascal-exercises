

PROGRAM
   fcopy;

USES
   {- For FileExists function. -}
   sysutils;


   (* Copy the contents from one file to another.
         file2read : name of file to copy from.
         file2write : name of file to copy to. *)
PROCEDURE FileCopy (
   file2read, file2write : String
);
VAR
   num_read, num_written : SmallInt; {- Keep track of how much is being read/written. -}
   total : Longint; {- Counts total number of bytes written. -}
   buffer : Array[1..1024] of byte;
   filein, fileout : File;
BEGIN
   {- Initialise values. -}
   num_read := 0;
   num_written := 0;
   total := 0;

   {- Open files for reading and writing.
      Specify logical records of the files to be 1 byte. -}
   Assign (filein, file2read);
   Reset (filein, 1);
   Assign (fileout, file2write);
   Rewrite (fileout, 1);

   {- Copy contents from file1 -> file2. -}
   Repeat
      BlockRead (filein, buffer, Sizeof(buffer), num_read);
      Blockwrite (fileout, buffer, num_read, num_written);
      inc (total, num_written);
   Until (num_read = 0) or (num_written <> num_read);
   writeln ('Copied ', total, ' bytes in total.');

   {- Close files. -}
   close(filein);
   close(fileout);
END;

   (* Main *)
VAR
   input : Char;
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

   {- If destination file exists, check if user wants to overwrite. -}
   if FileExists (ParamStr(2)) then begin
      Writeln ('Destination file ', ParamStr(2), ' already exists!');
      Writeln ('Overwrite anyway? (y/n)');
      repeat
         Readln (input);
      until ((input = 'y') or (input = 'n'));
      if input = 'n' then exit;
   end;

   {- Begin copying. -}
   Writeln ('Copying from ', ParamStr(1), ' to ', ParamStr(2));
   FileCopy (ParamStr(1), ParamStr(2));
   Writeln ('Finished copying contents.');
END.
