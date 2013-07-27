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
type matrix = array [1..10,1..10] of integer;
var
  M : matrix;
  c : char;
  i,j : shortint;
  lin,col: shortint;

procedure mostra_matrix (x,y: shortint; N: matrix);
var a,b : shortint;
begin
 for a:=1 to 10 do
   begin
    for b:=1 to 10 do
     begin
      if (a=x) and (b=y)
      then begin
            textcolor(128);
            write(N[a,b]);
            textattr:=(0*16)+7;
            write(' ');
           end
      else write(N[a,b],' ');
     end;
   writeln;
   end;
end;

begin
  clrscr;
  for j:=1 to 10 do
  begin
   for i:=1 to 10 do
    M[i,j]:=abs(i-j);
  end;
  mostra_matrix(1,1,M);
  lin:=1;
  col:=1;
  while c<>#120 do
  begin
   c:=readkey;
   case c of
     #72: begin
            if j>1 then
             begin
              lin:=lin-1;
              clrscr;
              mostra_matrix(lin,col,M);
             end;
          end;
     #75: begin
            if i>1 then col:=col-1;
            clrscr;
            mostra_matrix(lin,col,M);
          end;
     #77: begin
            if i<10 then col:=col+1;
            clrscr;
            mostra_matrix(lin,col,M);
          end;
     #80: begin
            if j<10 then lin:=lin+1;
            clrscr;
            mostra_matrix(lin,col,M);
          end;
     #120: writeln('Coordenadas selecionadas: ',lin,',',col,'.');
   end;
  end;
  writeln('Valor do campo [',lin,',',col,'] =',M[lin,col]);
  readln;
end.
