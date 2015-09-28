
program Exercises;

type
   Complex = Record
      re : Real;
      im : Real;
   End;

(* Assignment of real to Complex. *)
operator := (r : real) z : Complex;
begin
   z.re := r;
   z.im := 0.0;
end;

(* Assignment of integer to Complex. *)
operator := (i : Integer) z: Complex;
begin
   z.re := i;
   z.im := 0.0;
end;

(* Addition of complex w/ complex. *)
operator + (z1, z2 : Complex) z : Complex;
begin
   z.re := z1.re + z2.re;
   z.im := z1.im + z2.im;
end;

(* Addition of complex w/ real numbers. *)
operator + (z1 : Complex; r : Real)  z: Complex;
begin
   z.re := z1.re + r;
   z.im := z.im;
end;

operator + (r : Real; z1 : Complex) z : Complex;
begin
   z.re := z1.re + r;
   z.im := z.im;
end;


(* Computes the sqrt of the specified integer. Uses Newton's method to
   approximate to within a certain error.
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

(* An iterative implementation of the factorial function.
      n : specifies the n'th factorial to compute. *)
function FactIter (n : Integer) : LongInt;
var i : Integer;
begin
   FactIter := n;
   for i := n-1 downto 1 do
      FactIter := FactIter * i;
end;

(* Recursive implementation of the factorial function.
      n : specifies n'th factorial to compute. *)
function FactRec (n : Integer) : LongInt;
begin
   if ((n = 0) or (n = 1)) then FactRec := 1
   else FactRec := n * FactRec(n-1);
end;

(* Computes n choose k, the binomial choice function.
   This is the number of ways to choose k-sized subsets from a set of size n. *)
function BinomialClosed (n : Integer; k : Integer) : LongInt;
var nFact, kFact : LongInt;
begin
   nFact := FactIter(n);
   kFact := FactIter(k);
   BinomialClosed := round(nFact/(kFact*(nFact-kFact)));
end;

(* Computes n choose k using the recursive definition.
   This is the number of ways to choose k-sized subsets from a set of size n. *)
function BinomialRec (n : Integer; k : Integer) : LongInt;
begin
   if ((k=0) or (k=n)) then BinomialRec := 1
   else if ((k=1) or (k=n-1)) then BinomialRec := n
   else BinomialRec := BinomialRec(n-1,k) + BinomialRec(n-1,k-1);
end;

(* Compute sum of first n computers using a closed-form expression.
      n : specifies first n numbers to sum. *)
function ClosedSum (n : Integer) : Integer;
begin
   ClosedSum := round(n*(n+1)/2);
end;

(* Compute sum of the numbers between start and finish.
      start : start point of numbers
      finish : end point of numbers. *)
function ClosedSum (start, finish : Integer) : Integer;
begin
   ClosedSum := ClosedSum(finish) - ClosedSum(start);
end;

(* Iteratively sums the first n numbers.
      n : specifies the first n numbers to sum. *)
function Sum (n : Integer) : Integer;
var i : Integer;
begin
   Sum := 0;
   for i := 1 to n do
      Sum := Sum + i;
end;

(* Recursively computes Fibonacci numbers.
      n : specifies the n'th Fibonacci to compute. *)
function FibRec (n : Integer) : Integer;
begin
   if ((n=1) or (n=0)) then FibRec := 1
   else FibRec := FibRec(n-1) + FibRec(n-2)
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

(* Computes the two-variable version of the Ackermann function.
      m,n : integers to the function. *)
function Ack (m, n : Integer) : LongInt;
begin
   if (m = 0) then Ack := n + 1
   else if ((m > 0) and (n = 0)) then Ack := Ack(m-1, 1)
   else Ack := Ack(m-1, Ack(m,n-1));
end;

begin
end.
