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

Program MENU;
uses crt;

procedure MENU (var OPT:integer);


begin
  clrscr;
  writeln;  writeln;
  writeln (TRACO);
  writeln('':27,'Felipe Duarte - Junho/2008');
  writeln('':34,'CAMPO MINADO');
  writeln (TRACO);
  writeln;  writeln;  writeln;  writeln;  writeln;  writeln;  writeln;
  textcolor(red);
  writeln (' 1) Iniciar o Jogo');
  textcolor(black);
  writeln (' 2) Configuracoes');
  writeln (' 3) Load Game');
  writeln (' 4) Exit ');
  repeat
    c:=readkey;
    case c of
         #72: begin

              end;
         #80: begin

              end;
     end;
  until C=#13;
  writeln(' FUNCIONO!!!!!!');
  readln;

end;
