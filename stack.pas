
program LinkedList;

type

   Node = record
      data : Integer;
      next : ^Node;
   end;

   Stack = record
      head : ^Node;
      size : Integer;
   end;

(* Construct and return a new stack. *)
function StackMake : Stack;
begin
   StackMake.head := Nil;
   StackMake.size := 0;
end;

(* Look at the top item on the stack, but don't remove it.
      stk : stack to look at. *)
function StackTop (stk : Stack) : Integer;
begin
   StackTop := (stk.head^).data;
end;

(* Push integer onto the top of the stack.
      stk : stack to push onto. *)
procedure StackPush (i : Integer; var stk : Stack);
var nodePtr, tmp : ^Node;
begin
   tmp := stk.head;
   New(nodePtr);
   (nodePtr^).next := tmp;
   (nodePtr^).data := i;
   stk.head := nodePtr;
end;

(* Pop and return top item on stack.
      stk : stack to pop off. *)
function StackPop (var stk : Stack) : Integer;
begin
   StackPop := (stk.head^).data;
   stk.head := (stk.head^).next;
end;

begin
end.
