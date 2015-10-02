
{$MODE Delphi}

type

   Stack<T> = class

      { Records used to store data. }
      type Node = record
         data : T;
         next : ^Node;
      end;

      type PtrNode = ^Node;

      { Private fields. }
      private
         sz : Integer;
         head : ^Node;

      { Public fields. }
      public
         constructor init;
         destructor kill;
         function size : Integer;
         function top : T;
         function isEmpty : Boolean;
         function pop : T;
         procedure push (item : T);
   end;

constructor Stack<T>.init;
begin
   sz := 0;
   head := Nil;
end;

destructor Stack<T>.kill;
var nodeptr, tmp : PtrNode;
begin

   { Deallocate each node in turn. }
   nodeptr := head;
   while (nodeptr <> Nil) do
   begin
      tmp := nodeptr^.next;
      Dispose(nodeptr);
      nodeptr := tmp;
   end;

end;

procedure Stack<T>.push (item : T);
var nodeptr : PtrNode;
begin

   {Allocate memory for node. }
   New(nodeptr);
   nodeptr^.data := item;
   nodeptr^.next := head;
   head := nodeptr;
   size += 1;
      
end;

function Stack<T>.pop;
var nodeptr : PtrNode;
begin
   nodeptr := head;
   Result := head^.data;
   head := head^.next;
   Dispose(nodeptr);
   sz -= 1;
end;

function Stack<T>.size;
begin
   Result := sz;
end;

function Stack<T>.top;
begin
   Result := head^.data;
end;

function Stack<T>.isEmpty;
begin
   Result := sz = 0;
end;

