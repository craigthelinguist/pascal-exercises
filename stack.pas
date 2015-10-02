
(* This is a stack of integers. *)

type

   P_Node = ^Node;

   Node = record
      data : Integer;
      next : P_Node;
   end;
   
   Stack = record
      head : P_Node;
      size : Integer;
   end;

(* Initialise a Stack.
      stk : Stack to be initialised. *)
procedure Stack_Init (var stk : Stack);
begin
   stk.head := Nil;
   stk.size := 0;
end;

(* Deallocate the contents of a stack.
      stk : Stack to be destroyed. *)
procedure Stack_Dispose (var stk : Stack);
var
   nodePtr, tmp : P_Node;
begin

   { Deallocate each node in the stack. }
   nodePtr := stk.head;
   while (nodePtr <> Nil) do
   begin
      tmp := nodePtr^.next;
      Dispose(nodePtr);
      nodePtr := tmp;
   end;

end;

(* Push an item onto the stack.
      stk : Stack you're modifying.
      val : item to push onto the stack. *)
procedure Stack_Push (var stk : Stack; val : Integer);
var nodePtr : P_Node;
begin
   New(nodePtr);
   nodePtr^.data := val;
   nodePtr^.next := stk.head;
   stk.head := nodePtr;
end;

(* Look at the item on the top of the stack.
      stk : Stack you're looking at.
      return : the item on top of the stack. *)
function Stack_Peek (var stk : Stack) : Integer;
begin
   Stack_Peek := stk.head^.data;
end;

(* Remove the item on top of the stack and return it to
   the caller.
      stk : Stack to be popped.
      return : the value that was on top of the stack. *)
function Stack_Pop (var stk : Stack) : Integer;
var nodePtr : P_Node;
begin
   Stack_Pop := stk.head^.data;
   nodePtr := stk.head;
   stk.head := nodePtr^.next;
   Dispose(nodePtr);
end;

(* Check whether the stack is empty.
      stk : Stack to check.
      return : true if the stack has nothing in it. *)
function Stack_IsEmpty (var stk : Stack) : Boolean;
begin
   Stack_IsEmpty := stk.size > 0;
end;

(* Check the size of the stack.
      stk : Stack to check.
      return : how many items are in the stack. *)
function Stack_Size (var stk : Stack) : Integer;
begin
   Stack_Size := stk.size;
end;

