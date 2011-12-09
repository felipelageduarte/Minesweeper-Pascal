program MENU;
uses crt;

var

I: integer;
C: char;
X:integer;

begin

X:=0;
C:=#0;
I:=7;
clrscr;

writeln('':32,'CAMPO MINADO');

writeln;
writeln;
writeln;

while (c<>#13) do begin
         case I of
              7:
begin
gotoxy(1,7);
textcolor(red);
writeln('*','':32,'Novo Jogo');
textcolor(white);
writeln('*','':30,'Carregar Jogo');
writeln('*','':30,'Configuracoes');
writeln('*','':34,'Sair');
writeln;
gotoxy(1,I);
C:=readkey;
end;

8:

begin
gotoxy(1,7);
writeln('*','':32,'Novo Jogo');
textcolor(red);
writeln('*','':30,'Carregar Jogo');
textcolor(white);
writeln('*','':30,'Configuracoes');
writeln('*','':34,'Sair');
writeln;
gotoxy(1,I);
C:=readkey;
end;


9:
begin
gotoxy(1,7);
writeln('*','':32,'Novo Jogo');
writeln('*','':30,'Carregar Jogo');
textcolor(red);
writeln('*','':30,'Configuracoes');
textcolor(white);
writeln('*','':34,'Sair');
writeln;
gotoxy(1,I);
C:=readkey;
end;

10:

begin
gotoxy(1,7);
writeln('*','':32,'Novo Jogo');
writeln('*','':30,'Carregar Jogo');
writeln('*','':30,'Configuracoes');
textcolor(red);
writeln('*','':34,'Sair');
textcolor(white);
writeln;
gotoxy(1,I);
C:=readkey;
end;

end;


case C of

#72: if I=7
     then I:=10
     else I:= I-1;

#80: if I=10
     then I:=7
     else I:= I+1;

#13: case I of 7: X:=1;
               8: X:=2;
               9: X:=3;
              10: X:=4;

     end;


end;

end;

end.
