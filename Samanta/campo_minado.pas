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

program CAMPO_MINADO;

uses crt;

type REGISTRO = record
                  BOMBA:integer; {campo em que sera distribuida as bombas}
                  NUMERO:integer; {campo em que mostrarao numero de bombsem volta}
                  EXIBIR:integer; {campo que exibira os caracteres do jogo}
                  ABERTO:boolean; {campo em que mostra se a area foiabert ou nao}
                end;
type MATRIZ = array [1..20,1..60] of REGISTRO;
type SAVED = file of MATRIZ;


var  M,N: integer; {variavel corresponde numero de linhas e colunas}
     B: integer; {variavel corresponde numero de bombas}
     OP: integer; {variavel corresponde numero opcao do menu}
     GAME:SAVED;  {variavel de arquivo de matriz}
     MATRIZ1:MATRIZ;{variavel da matriz}
     P,GANHOU,PERDEU:boolean;




procedure MENU(var OP:integer);
{procedimento que mostra o menu inicial do jogo em que o usuario podera escolher
qual opcao deseja; numero 1 representa iniciar do jogo com o tamanho do campo ja
pre-definida(10 linhas,10 colunas e 20 bombas);numero 2 possibilita continuar um
jogo ja iniciado;numero 3 possibilita alteraçao a quantidade de linhas , bombas e
colunas ;numero 4 sai do jogo;}
begin
 clrscr;
 writeln;
 writeln;
 writeln;
 textcolor(12);
 write ('':32, 'CAMPO MINADO');
 writeln;
 writeln;
 writeln;
 writeln;
 textcolor(yellow);
 writeln ('':27,'Menu de opcoes');
 textcolor(white);
 writeln;
 writeln;
 writeln ('':25,'(1)- Nova partida');
 writeln ('':25,'(2)- Continuar');
 writeln('':25,'(3)- Configuracoes');
 writeln ('':25,'(4)- Sair');
 write ('':25,' Digite a opcao desejada: ');
 readln (OP);
end;
{------------------------------------------------------------------------------}

procedure CONF ( var M:integer; var N:integer; var B: integer);
{procedimento que possibilita realizar alteraçoes no numero de linhas (min 8 , max 10),
colunas (min 8 max 60) e fornecer o numero de bombas (10% a 80% da quantidade de campos }
var max, min: integer;
begin
 clrscr;
 writeln;
 writeln;
 write('':10,' Forneca o valor de linhas minimo 8 e maximo 20: ');
 readln( M);
 while (M<8) or (M> 20) do
 begin
   writeln ('':10, ' Opcao invalida');
   write('':10,' Forneca o valor de linhas minimo 8 e maximo 20: ');
   readln( M);
 end;
 write ('':10,' Forneca o valor de colunas minimo 8 e maximo 60: ');
 readln (N);
 while (N<8) or (N> 60) do
 begin
   writeln ( '':10, ' Opcao invalida');
   write('':10,' Forneca o valor de colunas minimo 8 e maximo 60: ');
   readln(N );
 end;
 writeln ('':11,'Numero de Bombas');
 min:= trunc( M * N * 0.1);
 max:= trunc(M * N * 0.8);
 write ( '':11,'Digite um  numero entre ',min,' e ',max,': ');
 readln(B);
 while (B<min) or (B> max) do
 begin
   writeln ('':10, ' Opcao invalida');
   write ('':11,'Digite um  numero entre ',min,' e ',max,': ');
   readln(B);
 end;
end;
{------------------------------------------------------------------------------}

procedure SAVE(var GAME:SAVED; MATRIZ1:MATRIZ);
{procedimento em que abre o arquivo jogo e salva este}
 begin
   rewrite(GAME);
   write (GAME, MATRIZ1);
   close (GAME);
 end;
{------------------------------------------------------------------------------}

procedure LOAD ( var GAME:SAVED;var MATRIZ1:MATRIZ);
{procedimento abre um arquivo ja salvo , possibilitando assim continurar o jogo
ja iniciado}
 begin
  reset (GAME);
  read (GAME, MATRIZ1);
  close (GAME);
 end;
{------------------------------------------------------------------------------}

procedure DISTRIBUIR( M:integer; N:integer; B:integer; var MATRIZ1:MATRIZ);
{procedimento que distribui as minas no jogo, utilizando a funcao random n vezes ,
ate que o numero de bombas distribuidas seja igual ao numero de bombas desejadas}

 var S:integer; {contador para o numero de bombas}
     I, J : integer; { variavel para indices da matriz}
     X:boolean;  {variavel booleana que controla se a quantidade de bombas distribuidas
                  é igual a quantidade de bombas desejadas}

 begin

  for I:= 1 to M do
    begin
      for J:= 1 to N do
        begin
           MATRIZ1[I,J].BOMBA:=0;
        end;
    end;
  X:=false;
  S:=0;
  randomize;
  repeat
     i:=0;
     repeat
        i:=i+1;
        j:=0;
        repeat
          j:=j+1;
          if MATRIZ1[I,J].BOMBA=0 then
            begin
               MATRIZ1[I,J].BOMBA:= random(10);
               if MATRIZ1[I,J].BOMBA<>1 then
                begin
                  MATRIZ1[I,J].BOMBA:= 0;
                end;
               if MATRIZ1[I,J].BOMBA=1 then
                begin
                  S:= S+ 1;
                  if (S=B) then x:= true;
                end;
            end;
        until (j=n) or (X= true);
     until (i=m) or (x= true);
  until(x=true);
 end;

{------------------------------------------------------------------------------}

procedure DICAS( M:integer; N:integer; var MATRIZ1:MATRIZ);
{procedimento que possui um contador em que mostra o numero de bombas em volta
do campo selecionado}

var I,J,K,L:integer;
    C:integer; {variavel que representa a soma e bombas em volta}
 begin
  C:=0;
  for I:= 1 to M do begin;
    for J:= 1 to N do begin;
      for K:= (I-1) to (I+1) do begin;
        for L:= (J-1) to (J+1) do begin;
          if MATRIZ1[K,L].BOMBA= 1 then
            begin
               C:=C + 1;
            end;
        end;
      end;
      MATRIZ1[I,J].NUMERO:= C;
      C:=0;
    end;
  end;
 end;

{------------------------------------------------------------------------------}

procedure CAMPO_INICIAL ( M:integer; N:integer; var MATRIZ1:MATRIZ);
{procedimento que no incio do jogo mantem todas os campos fechados mostrando o
caracter -}

var I,J:integer;

 begin
  for I:= 1 to M do begin
    for J:=1 to N do begin
     MATRIZ1[I,J].EXIBIR:= 2;
     MATRIZ1[I,J].ABERTO:=false;
    end;
  end;
 end;

{-----------------------------------------------------------------------------}

procedure TELA(M:integer;N:integer;I:integer;J:integer;B:integer;GANHOU:boolean;
               PERDEU:boolean; var MATRIZ1:MATRIZ);
{procedimento tela contem a interface do jogo ,apresentado o campo e os comandos
necessarios para a articulaçao do jogo}


var X:integer;
    K,L,V:integer;
 begin
   clrscr;
   writeln;
   writeln;
   if (GANHOU= true) then begin
                          writeln('':22,'PARABENS!!');
                        end;
   if (PERDEU=true) then begin
                          writeln('':22,'FIM DE JOGO!!');
                         end;
   writeln;
   writeln;
   writeln;
   textcolor(12);
   write ('':34, 'CAMPO MINADO');
   writeln;
   writeln;
   writeln;
   writeln;
   writeln;
   textcolor(white);
   x:=round((78-N)div 2);
   write('':x,#201);
   for v:= 1 to N do begin
                       write(#205);
                     end;
   write(#187);
   writeln;
   for k:=1 to M do begin
     write('':x,#186);
     for L:=1 to N do begin
                        textbackground(black);

       if (K=I) and (L=J) then begin
                                 textbackground(yellow);
                               end;

       if MATRIZ1[K,L].EXIBIR=1 then write(' ');
       if MATRIZ1[K,L].EXIBIR=2 then begin
                                       textcolor(white);
                                       write(#22);
                                       textcolor(white);
                                     end;
       if MATRIZ1[K,L].EXIBIR=3 then begin
                                       textcolor(lightred);
                                       write(#3);
                                       textcolor(white);
                                     end;
       if MATRIZ1[K,L].EXIBIR=4 then begin
                                       textcolor(blue);
                                       write( MATRIZ1[K,L].NUMERO);
                                       textcolor(white);
                                     end;
       if MATRIZ1[K,L].EXIBIR=5 then begin
                                       textcolor(red);
                                       write ('@');
                                       textcolor(white);

                                     end;
     textbackground(black);
    end;

    write( #186);
    writeln;



   end;
   write ('':x,#200);
   for v:= 1 to N do begin
                       write(#205);
                     end;
   write(#188);
   writeln;
   writeln;
   writeln ('':23,'Bandeiras (#3): ',B);
   writeln('********************************************************************************');
   writeln('':23,' Teclas de comando.');
   writeln;
   writeln;
   writeln('':5,'Z:Para detonar a posicao escolhida');
   writeln('':5,'X:Para marca o espaço com bandeira');
   writeln('':5,'S:Abandonar o jogo');
   writeln;
   writeln;
   writeln('********************************************************************************');
   writeln('':5,'Para movimentar-se na tela do campo utilize as setas do teclado');
   writeln('********************************************************************************');
 end;

{------------------------------------------------------------------------------}

procedure RECURSIVO(M:integer;N:integer;I:integer;J:integer; var MATRIZ1:MATRIZ);
{procedimento em que campo vazio relaciona a outros campos vazios ,abrindo os campos
ao redondor, melhorando a articulacao do jogo}

var K,L:integer;

 begin
   for K:= (I-1) to (I+1) do begin;
       for L:= (J-1) to (J+1) do begin;
           if (K>=1) and (K<=N) and (L>=1) and (L<=M) and
           (MATRIZ1[K,L].ABERTO=false) then begin
                if MATRIZ1[K,L].BOMBA=0 then begin
                   if (MATRIZ1[K,L].NUMERO=0) then begin
                                                 MATRIZ1[K,L].EXIBIR:=1;
                                                 MATRIZ1[K,L].ABERTO:=true;
                                                 RECURSIVO(M,N,K,L,MATRIZ1);
                                                 end;
                   if (MATRIZ1[K,L].NUMERO<>0) then MATRIZ1[K,L].EXIBIR:=4;
                end;
           end;
       end;
   end;
 end;
{------------------------------------------------------------------------------}

procedure DETONA (M:integer;N:integer;I:integer;J:integer; var MATRIZ1:MATRIZ);
{procedimento que quando a tecla 'z' for acionada , revelara se no campo escolhido
ha um bomba ou nao }

begin
  if MATRIZ1[I,J].BOMBA=0 then begin
     if (MATRIZ1[I,J].NUMERO=0) then begin
                                       MATRIZ1[I,J].EXIBIR:=1;
                                       MATRIZ1[I,J].ABERTO:=true;
                                       RECURSIVO(M,N,I,J,MATRIZ1);
                                     end;
     if (MATRIZ1[I,J].NUMERO<>0) then MATRIZ1[I,J].EXIBIR:=4;
  end;
  if MATRIZ1[I,J].BOMBA=1 then MATRIZ1[I,J].EXIBIR:=5;

end;

{-----------------------------------------------------------------------------}


procedure JOGO( M:integer; N:integer; B:integer;var MATRIZ1:MATRIZ;
                var GAME:SAVED; var PERDEU:boolean; var GANHOU:boolean);
{procedimento  para a manipulacao do jogo,com as setas do teclado é possibivel
posicionar o cursor no campo desejado,a tecla 'Z','z' detona o campo selecionado
assim sendo possivel descobrir o que a atras daquele campo, a tecla 'X','x' é
possivel marcar e desmarcar o campo com bandeirinhae finalmente com a tecla 'S','s'
é possivel abandonar o jogo. }

var c:char;
    I,J,L,K:integer;

begin
  clrscr;
  I:=1;
  J:=1;
  GANHOU:=false;
  PERDEU:= false;
  TELA(M,N,I,J,B,GANHOU,PERDEU,MATRIZ1);

  repeat
    c:=readkey;
    case c of
         #72: begin {para cima}
                if (j>=1) and (j<=N) and (i>=1) and (i<=M) then{define o tamanho do tabuleiro}
                  begin
                    if (i<>1) then I:=I-1;
                    TELA(M,N,I,J,B,GANHOU,PERDEU,MATRIZ1);
                  end;
               end;
         #75: begin {para esquerda}
                if (j>=1) and (j<=N) and (i>=1) and (i<=M) then
                   begin
                     if (j<>1) then J:=J-1;
                     TELA(M,N,I,J,B,GANHOU,PERDEU,MATRIZ1);
                   end;
              end;
         #77: begin {para direita}
                if (j>=1) and (j<=N) and (i>=1) and (i<=M) then
                   begin
                    if (J<>N) then J:=J+1;
                    TELA(M,N,I,J,B,GANHOU,PERDEU,MATRIZ1);
                   end;
              end;
         #80: begin {para baixo}
                if (j>=1) and (j<=N) and (i>=1) and (i<=M) then
                    begin
                      if (I<>M) then I:=I+1;
                      TELA(M,N,I,J,B,GANHOU,PERDEU,MATRIZ1);
                    end;
              end;
         'Z','z': begin {detona a posicao escolhida}
                    DETONA(M,N,I,J,MATRIZ1);

                    if MATRIZ1[I,J].BOMBA=1
                     then begin

                            for K:=1 to M do begin
                                for L := 1 to N do begin
                                     if (MATRIZ1[K,L].EXIBIR=3) and (MATRIZ1[K,L].BOMBA=1)then
                                        begin
                                               MATRIZ1[K,L].EXIBIR:=3;
                                        end;
                                     if (MATRIZ1[K,L].EXIBIR=3) and (MATRIZ1[K,L].BOMBA<>1) then
                                         begin
                                               MATRIZ1[K,L].EXIBIR:=6;
                                         end;
                                     if (MATRIZ1[K,L].BOMBA=1) then
                                         begin
                                              MATRIZ1[K,L].EXIBIR:=5;
                                         end;
                                      write (MATRIZ1[K,L].EXIBIR)

                                end;
                            end;
                            PERDEU:=true;

                          end;
                    TELA(M,N,I,J,B,GANHOU,PERDEU,MATRIZ1);
                    SAVE(GAME, MATRIZ1);
                  end;
         'X','x': begin {marca o espaco com uma bandeira}
                    if (MATRIZ1[I,J].EXIBIR=2) then begin
                                                      MATRIZ1[I,J].EXIBIR:=3;
                                                      B:=B-1;
                                                    end
                    else if (MATRIZ1[I,J].EXIBIR=3) then begin
                                                           MATRIZ1[I,J].EXIBIR:=2;
                                                           B:=B+1;
                                                         end;
                    TELA(M,N,I,J,B,GANHOU,PERDEU,MATRIZ1);
                    SAVE(GAME, MATRIZ1);
                  end;
     end;
  until (C=#115)or (GANHOU=true)or(PERDEU=true)  ; {finalizar o jogo}
  TELA(M,N,I,J,B,GANHOU,PERDEU,MATRIZ1);

end;
{------------------------------------------------------------------------------}


begin {inicio do programa principal}
 assign(GAME, 'game.dat');
 M:=10;
 N:=10;
 B:=20;
 repeat
   MENU(OP);
   if(OP=1) then
    begin
      DISTRIBUIR(M,N,B,MATRIZ1);
      DICAS(M,N,MATRIZ1);
      CAMPO_INICIAL(M,N,MATRIZ1);
      JOGO(M,N,B,MATRIZ1,GAME,PERDEU,GANHOU);
   end;
   if(OP=2) then
    begin
     LOAD (GAME, MATRIZ1);
     JOGO(M,N,B,MATRIZ1,GAME,PERDEU,GANHOU);
    end;
   if(OP=3) then
    begin
     CONF(M,N,B);
    end;
 until OP=4;
end.












