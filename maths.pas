
program Exercises;

(* Computes the sqrt of the specified integer. Uses Newton's method to
   apprxoimate to within a certain error.
      n: number whose sqrt will be computed.
      err: amount of imprecision allowed. *)
function MySqrt (n : Integer; err : Real) : Real;
var guess : Real;
begin
   guess := 1;
   while (abs(guess * guess - n) > err) do 
      guess := 0.5 * (guess + n/guess);
   MySqrt := guess;
end;

(* Iteratively sums the first n numbers.
      n : specifies the first n numbers to sum. *)
function Sum (n : Integer) : Integer;
var i : Integer;
begin
   Sum := 0;
   for i := 1 to n do
   begin
      Sum := Sum + i;
   end;
end;

(* Recursively computes Fibonacci numbers.
      n : specifies the n'th Fibonacci to compute. *)
function FibRecursive (n : Integer) : Integer;
begin
   if ((n=1) or (n=0)) then
      FibRecursive := 1
   else
      FibRecursive := FibRecursive(n-1) + FibRecursive(n-2)
end;

(* Iteratively computes Fibonacci numbers.
      n : specifies the n'th Fibonacci to compute. *)
function FibIter (n : Integer) : LongInt;
var
   i : Integer;
   x1, tmp : LongInt;
begin
   FibIter := 1;
   if ((n = 0) or (n = 1)) then exit;
   x1 := 1;
   for i := 1 to n-2 do
   begin
      tmp := x1 + FibIter;
      x1 := FibIter;
      FibIter := tmp;
   end;
end;

(* An iterative implementation of the factorial function.
      n : specifies the n'th factorial to compute. *)
function Fact (n : Integer) : LongInt;
var
   i : Integer;
begin
   Fact := n;
   for i := n-1 downto 1 do
   begin
      Fact := Fact * i;
   end;
end;

begin
end.
