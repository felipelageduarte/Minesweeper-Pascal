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

Program CAMPO_MINADO;
uses crt;

type CASAMATRIZ = record
                      MINA:integer;
                      QTDMINA:integer;
                      ABRIU:boolean;
                      MEMORIA:integer;
                      ATUAL:char;
                      TAMANHOM:integer;
                      TAMANHON:integer;
                  end;
type MATRIZB = array[1..20,1..60] of CASAMATRIZ;
type SAVED = file of MATRIZB;


const
TRACO='--------------------------------------------------------------------------------';


var X, Y:integer;{variaveis para seleçao/utilização dos MENU}
var M, N:integer;{variaveis para determinar a dimensão do tabuleiro do jogo}
var QTDMINA:integer;{variavel que determina a quantidade de minas no jogo}
var MATRIZ:MATRIZB;
var OPT:boolean;
var SAVE:SAVED;


{XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX}

procedure MENU (var OPT: integer );
{Procedimento que escreve na tela do usuario o menu principal e retorna para o
       corpo principal do programa a opçao escolhida pelo mesmo}

var I: integer;
var C: char;

begin
   C:=#0;
   I:=7;
   clrscr;
   writeln; writeln;
   writeln (TRACO);
   writeln('':27,'Felipe Duarte - Junho/2008');
   writeln('':34,'CAMPO MINADO');
   writeln;
   writeln('':32,' MENU PRICIPAL ');
   write(TRACO);
   writeln; writeln; writeln;
   repeat
     if I=7 then begin
                OPT:=1;
                gotoxy(1,14);
                textcolor(red);
                writeln('':32,'Iniciar o Jogo');
                textcolor(white);
                writeln('':33,'Configuracao');
                writeln('':34,'Load Game');
                writeln('':36,'Exit');
                writeln;
                gotoxy(1,I);
              end;
     if I=8 then begin
                OPT:=2;
                gotoxy(1,14);
                writeln('':32,'Iniciar o Jogo');
                textcolor(red);
                writeln('':33,'Configuracao');
                textcolor(white);
                writeln('':34,'Load Game');
                writeln('':36,'Exit');
                writeln;
                gotoxy(1,I);
              end;
     if I=9 then begin
                OPT:=3;
                gotoxy(1,14);
                writeln('':32,'Iniciar o Jogo');
                writeln('':33,'Configuracao');
                textcolor(red);
                writeln('':34,'Load Game');
                textcolor(white);
                writeln('':36,'Exit');
                writeln;
                gotoxy(1,I);
              end;
     if I=10 then begin
                 OPT:=0;
                 gotoxy(1,14);
                 writeln('':32,'Iniciar o Jogo');
                 writeln('':33,'Configuracao');
                 writeln('':34,'Load Game');
                 textcolor(red);
                 writeln('':36,'Exit');
                 textcolor(white);
                 writeln;
                 gotoxy(1,I);
               end;
     C:=readkey;
     case C of
        #72: if I=7 then I:=10
             else I:= I-1;
        #80: if I=10 then I:=7
             else I:= I+1;
     end;
   until C=#13;
end;

Begin
  MENU(X);
end.
