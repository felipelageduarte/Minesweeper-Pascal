{
********************************************************************************
*                CAMPO MINADO - ICMC/USP - JUNHO/2008                          *
*                                                                              *
* Autor: Felipe S. L. G. Duarte - <felipelageduarte at gmail dot com>          *
*                                                                              *
* This work is licensed under the Creative Commons Attribution-ShareAlike 3.0  *
*        Unported License. To view a copy of this license, visit               *
*           http://creativecommons.org/licenses/by-sa/3.0/.                    *
********************************************************************************
}

program trap_arrow;
uses crt;
var
  M : array [1..10,1..10] of integer;
  c : char;
  i,j : shortint;

begin
  clrscr;
  for j:=1 to 10 do
  begin
   for i:=1 to 10 do
    M[i,j]:=abs(i-j)
  end;
  M[3,1]:=7;
  for i:=1 to 10 do
  begin
   for j:=1 to 10 do
    begin
     write(M[i,j],' ');
    end;
   writeln;
  end;
  i:=1;
  j:=1;
  while c<>#120 do
  begin
   c:=readkey;
   case c of
     #72: begin
            if j>1 then i:=i-1;
            writeln('[',i,',',j,']')
          end;
     #75: begin
            if i>1 then j:=j-1;
            writeln('[',i,',',j,']')
          end;
     #77: begin
            if i<10 then j:=j+1;
            writeln('[',i,',',j,']')
          end;
     #80: begin
            if j<10 then i:=i+1;
            writeln('[',i,',',j,']')
          end;
     else writeln(c)
   end;
  end;
  writeln('Valor do campo [',i,',',j,'] =',M[i,j]);
  readln;
end.
