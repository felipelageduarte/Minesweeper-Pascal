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
var QTDMINA:integer;
var MATRIZ:MATRIZB;
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
             {======================================}

procedure MENU2 (var OPT: integer );
{Procedimento que escreve na tela do usuario o menu de configuraçoes e retorna
     para o corpo principal do programa a opçao escolhida pelo mesmo}

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
                writeln('':32,'Tamanho do Jogo');
                textcolor(white);
                writeln('':31,'Quantidade de Minas');
                writeln('':33,'Menu Principal');
                writeln;
                gotoxy(1,I);
              end;
     if I=8 then begin
                OPT:=2;
                gotoxy(1,14);
                writeln('':32,'Tamanho do Jogo');
                textcolor(red);
                writeln('':31,'Quantidade de Minas');
                textcolor(white);
                writeln('':33,'Menu Principal');
                writeln;
                gotoxy(1,I);
              end;
     if I=9 then begin
                OPT:=0;
                gotoxy(1,14);
                writeln('':32,'Tamanho do Jogo');
                writeln('':31,'Quantidade de Minas');
                textcolor(red);
                writeln('':33,'Menu Principal');
                textcolor(white);
                writeln;
                gotoxy(1,I);
              end;
     C:=readkey;
     case C of
        #72: if I=7 then I:=9
             else I:= I-1;
        #80: if I=9 then I:=7
             else I:= I+1;
     end;
   until C=#13;
end;


{XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX}


procedure PROC2_1( var M:integer; var N:integer; var QTD:integer );
{Procedimento que altera o numero de linhas e colunas do tabulero do jogo,
     alterar tambem o numero de minas no tabulero do jogo.
Quantidade de minas: entre 10% e 80% da quantidade de posições do campo}

var XMIN1:real; {quantidade minima de minas}
    XMIN2:integer;
    XMAX1:real; {quantidade maxima de minas}
    XMAX2:integer;

begin
  clrscr;
  writeln;
  writeln;
  writeln(' Tamanho do campo: minimo de 8x8 e maximo de 20x60 posicoes');
  write(' Digite o numero de linhas: '); readln(M);
  while (M<8) or (M>20) do begin {laço para que se o valor digitado for menor que 8
                                     ou maior que 20 não aceitar a configuração}
       writeln(' Error!!! Minimo de 8x8 e maximo de 20x60 posicoes');
       write(' Digite o numero de linhas: '); readln(M);
       end;
  write(' Digite o numero de colunas: '); readln(N);
  while (N<8) or (N>60) do begin {laço para que se o valor digitado for menor que 8}
                             {ou maior que 60 não aceitar a configuração}
       writeln('error!!! Mínimo de 8x8 e máximo de 20x60 posições');
       write(' Digite o numero de colunas: '); readln(N);
       end;
  writeln;
  writeln(' Dimensao do Campo: ',M,'X',N); {exibi dimensão do campo}
  writeln;
  XMIN1 := (M*N)*(10/100); {calcula 10% da quantidade de posições do campo}
  XMIN2 := trunc(XMIN1); {considera somente a inteira do numero}
  XMAX1 := (M*N)*(80/100); {calcula 80% da quantidade de posições do campo}
  XMAX2 := trunc(XMAX1); {considera somente a inteira do numero}
  writeln(' Numero de minas: Minimo: ',XMIN2,' minas');
  writeln('':18,'Maximo: ',XMAX2,' minas');
  writeln;
  write(' Digite o Numero de minas desejada: '); readln(QTD);
  while (QTD<XMIN2) or (QTD>XMAX2) do begin {laço que garante que a quantidade de
                                           minas esta entre o intervalo determinado}
        writeln(' Error!!!');
        writeln(' Numero de minas: Minimo: ',XMIN2,' minas');
        writeln('':18,'Maximo: ',XMAX2,' minas');
        writeln;
        write(' Digite o Numero de minas desejada: '); readln(QTD);
        end;
  writeln;
  writeln(' Precione <ENTER> para voltar');
  readln;
end;
             {======================================}

procedure PROC2_2(M:integer; N:integer;var QTD:integer);
{procedimento para alterar o numero de minas no tabulero do jogo.
Quantidade de minas: entre 10% e 80% da quantidade de posições do campo}

var XMIN1:real; {quantidade minima de minas}
    XMIN2:integer;
    XMAX1:real; {quantidade maxima de minas}
    XMAX2:integer;
begin
  clrscr;
  XMIN1 := (M*N)*(10/100); {calcula 10% da quantidade de posições do campo}
  XMIN2 := trunc(XMIN1); {considera somente a inteira do numero}
  XMAX1 := (M*N)*(80/100); {calcula 80% da quantidade de posições do campo}
  XMAX2 := trunc(XMAX1); {considera somente a inteira do numero}
  writeln;
  writeln;
  writeln(' Dimensao do Campo: ',M,'X',N); {exibi dimensão do campo}
  writeln(' Numero de minas: Minimo: ',XMIN2,' minas');
  writeln('':18,'Maximo: ',XMAX2,' minas');
  writeln;
  write(' Digite o Numero de minas desejada: '); readln(QTD);
  while (QTD<XMIN2) or (QTD>XMAX2) do begin {laço que garante que a quantidade de
                                           minas esta entre o intervalo determinado}
        writeln(' Error!!!');
        writeln(' Numero de minas: Minimo: ',XMIN2,' minas');
        writeln('':18,'Maximo: ',XMAX2,' minas');
        writeln;
        write(' Digite o Numero de minas desejada: '); readln(QTD);
        end;
  writeln;
  writeln(' Precione <ENTER> para voltar');
  readln;
end;


{XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX}

procedure QUESTION (PERGUNTA:string[50]; var RESPOSTA_BOOLEAN:boolean);
{procedimento que recebe uma pergunta, escreve a mesma para o usuario e
      devolve ao programa a resposta em formato booleano}

var RESPOSTA:char;

begin
  write(PERGUNTA,' < S / N >: ');
  readln(RESPOSTA);
  RESPOSTA:= upcase(RESPOSTA);
  while (RESPOSTA <> 'S') and (RESPOSTA <> 'N') do
  begin
    writeln(' Opcao invalida!!! ');
    write(PERGUNTA,' < S / N >: ');
    readln(RESPOSTA);
    RESPOSTA:= upcase(RESPOSTA);
  end;
  if RESPOSTA='S' then RESPOSTA_BOOLEAN:=true;
  if RESPOSTA='N' then RESPOSTA_BOOLEAN:=false;
end;
             {======================================}

procedure CABECA ();
{Procedimento que escreve no topo do jogo as instruções principais para
 melhor jogabilidade e compreensao por parte do usuario - Nao retorna nenhum
 valor para o corpo principal do programa}

begin
  writeln;
  writeln(TRACO);
  writeln(' Pressione ''S'' a qualquer momento para sair ');
  writeln(' Pressione ''Z'' para detonar o lugar escolhido');
  writeln(' Pressione ''X'' para marcar o lugar com uma bandeira');
  writeln;
  writeln(TRACO);
  writeln;
end;
             {======================================}

procedure RODAPE ();
{Procedimento que escreve no fim do jogo as instruções principais para
 movimentaçao do ponteiro - Nao retorna nenhum valor para o corpo principal
                         do programa}

begin
  textbackground(black);
  writeln;
  writeln(TRACO);
  writeln('':10,' Use as setas do teclado para movimentar o ponteiro');
  writeln;
  writeln('':32,'CIMA ');
  writeln('':32,' ^');
  writeln('':32,' |');
  writeln('':21,'Esquerda <- O -> Direita');
  writeln('':32,' |');
  writeln('':32,' v ');
  writeln('':30,' BAIXO');
  writeln;
  writeln(TRACO);
  writeln;
end;


{XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX}


procedure SAVEGAME(var SAVE:SAVED; var MATRIZ:MATRIZB);

begin
  rewrite(SAVE);
  write(SAVE,MATRIZ);
  close(SAVE);
end;

             {======================================}

procedure LOADGAME(var SAVE:SAVED; var M:integer; var N:integer; var MATRIZ:MATRIZB);

begin
  {$I-}
  reset(SAVE);
  {$I+}
  if ioresult <> 0 then begin
                          writeln(' Nehum Jogo salvo encontrado');
                          readln;
                        end;
  read(SAVE,MATRIZ);
  close(SAVE);
  clrscr;
  M:=MATRIZ[1,1].TAMANHOM;
  N:=MATRIZ[1,1].TAMANHON;
  writeln;  writeln;  writeln;  writeln;  writeln;  writeln;  writeln;  writeln;
  writeln(' Arquivo carregado com sucesso');
  writeln(' Precione <Enter> para comecar');
  readln;
end;

{XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX}


             {======================================}

procedure INICIALIZAR(M:integer; N:integer; var MATRIZ:MATRIZB);

var a, b:integer;

begin
  for a := 1 to M do begin
      for b := 1 to N do begin
          MATRIZ[a,b].MEMORIA := 1;
          MATRIZ[a,b].ABRIU :=false;
          MATRIZ[a,b].TAMANHOM := M;
          MATRIZ[a,b].TAMANHON := N;
      end;
   end;
end;
             {======================================}

procedure SORTEIO_MINA( M:integer ; N:integer; QTD:integer; var MATRIZ:MATRIZB );

var k:integer;
var a, b:integer;
var X:boolean;

begin
  for a := 1 to M do begin
      for b := 1 to N do begin
          MATRIZ[a,b].MINA:=0;
      end;
  end;
  X:=false;
  K:=0;
  repeat
     a:=0;
     repeat
       a:=a+1;
       b:=0;
       repeat
         b:=b+1;
         if (MATRIZ[a,b].MINA=0) then begin
            MATRIZ[a,b].MINA:=(random(15));
            if MATRIZ[a,b].MINA=1 then begin
                 K:=(K+1);
                 if (K=QTD) then X:=true;
                 end;
            If MATRIZ[a,b].MINA<>1 then MATRIZ[a,b].MINA:=0;
            end;
       until (b=N) or (X=true);
     until (a=M) or (X=true);
  until (X=true);
end;
             {======================================}

procedure CALCULO_ENVOLTA( M:integer; N:integer; var MATRIZ:MATRIZB);

var a, b, c, d:integer;
var k:integer;

begin
  k:=0;
  for a := 1 to M do begin
      for b := 1 to N do begin
          for c := (a-1) to (a+1) do begin
              for d := (b-1) to (b+1) do begin
                  if MATRIZ[c,d].MINA = 1 then k:=k+1;
              end;
          end;
          MATRIZ[a,b].QTDMINA:=K;
          k:=0;
      end;
  end;
end;
             {======================================}

procedure INTERFACE_EXIBIR( M:integer; N:integer; i:integer; j:integer; var MATRIZ:MATRIZB );
{procedimento que exibe para o usuario a tela inicial do jogo}

var a, b:integer; {contadores}

begin
  textcolor(blue);
  for a := 1 to M do begin
      for b:= 1 to N do begin
        if MATRIZ[a,b].MINA=1 then begin
               textcolor(red);
               write(MATRIZ[a,b].MINA);
               textcolor(white);
               end;
        if MATRIZ[a,b].MINA=0 then begin
               textcolor(white);
               write(MATRIZ[a,b].MINA);
               end;
      end;
      writeln;
  end;
end;
             {======================================}

procedure SHOW_ALL( M: integer; N:integer; var MATRIZ:MATRIZB);

var a, b:integer;

begin
  for a := 1 to M do begin
      for b := 1 to N do begin
          if MATRIZ[a,b].MINA=1 then MATRIZ[a,b].MEMORIA:=5;
          if MATRIZ[a,b].MINA=0 then begin
               if MATRIZ[a,b].QTDMINA=0 then MATRIZ[a,b].MEMORIA := 2;
               if MATRIZ[a,b].QTDMINA<>0 then MATRIZ[a,b].MEMORIA := 4;
          end;
      end;
   end;
end;
             {======================================}

procedure SHOW(M:integer; N: integer; i:integer; j:integer; var MATRIZ:MATRIZB);

var c, d:integer;

begin
  for c := (i-1) to (i+1) do begin
      for d := (j-1) to (j+1) do begin
          if (C>=1) and (C<=M) and (D>=1) and (D<=N) and (MATRIZ[c,d].ABRIU=false) then begin
                    if (MATRIZ[c,d].MINA=0) and (MATRIZ[c,d].QTDMINA=0) then begin
                                 MATRIZ[c,d].ABRIU:=true;
                                 MATRIZ[c,d].MEMORIA:=2;
                                 SHOW(M,N,c,d,MATRIZ);
                                 end;
                    if (MATRIZ[c,d].MINA=0) and  (MATRIZ[c,d].QTDMINA<>0) then begin
                                 MATRIZ[c,d].ABRIU:=true;
                                 MATRIZ[c,d].MEMORIA:=4;
                                 end;
          end;;
      end;
  end;
end;

             {======================================}


procedure DETONA(M:integer; N:integer; i:integer ; j:integer; var MATRIZ:MATRIZB; var GAMEOVER:boolean; var WIN:boolean);

var X, Z, K:integer;
var a, b:integer;

begin
  if MATRIZ[i,j].MINA=0 then begin
      if MATRIZ[i,j].QTDMINA=0 then begin
                                      MATRIZ[i,j].MEMORIA := 2;
                                      MATRIZ[i,j].ABRIU:=true;
                                      SHOW(M,N,i,j,MATRIZ);
                                    end;
      if MATRIZ[i,j].QTDMINA<>0 then begin
                                       MATRIZ[i,j].MEMORIA := 4;
                                       MATRIZ[i,j].ABRIU:=true;
                                     end;
  end;
  if MATRIZ[i,j].MINA=1 then GAMEOVER:=true;
  Z:=0;
  K:=0;
  for a := 1 to M do begin
      for B := 1 to N do begin
          if MATRIZ[a,b].ABRIU=true then Z:=Z+1;
          if MATRIZ[a,b].MINA=1 then K:=K+1;
      end;
  end;
  X :=((M*N) - K );
  if (Z=X) then WIN:=true;
end;

             {======================================}

procedure JOGO ( M:integer; N:integer; QTDMINA:integer; var MATRIZ:MATRIZB; var SAVE:SAVED);

var c:char;
var i, j: integer;
var X:string[50];
var GAMEOVER:boolean; {variavel que avisa se o jogador perdeu ou nao}
var WIN:boolean; {variavel que avisa se o jogador ganho ou nao}
var OPT:boolean;

begin

  clrscr;
  i:=1;
  j:=1;
  GAMEOVER:=false;
  WIN:=false;

  clrscr;
  gotoxy(35,12);
  textcolor(4);
  writeln('LOADING...');
  textcolor(15);
  INICIALIZAR(M,N,MATRIZ);
  SORTEIO_MINA(M,N,QTDMINA,MATRIZ);
  CALCULO_ENVOLTA(M,N,MATRIZ);
  clrscr;

  CABECA();
  INTERFACE_EXIBIR(M,N,i,j,MATRIZ);
  RODAPE();
  repeat
    c:=readkey;
    case c of
         #72: begin
                if (j>=1) and (j<=N) and (i>=1) and (i<=M) then
                   begin
                     clrscr;
                     CABECA();
                     if (i<>1) then i:=i-1; {seta para CIMA}
                     INTERFACE_EXIBIR(M,N,i,j,MATRIZ);
                     RODAPE();
                   end;
              end;
         #75: begin
                if (j>=1) and (j<=N) and (i>=1) and (i<=M) then
                   begin
                     clrscr;
                     CABECA();
                     if (j<>1) then j:=j-1; {esquerda}
                     INTERFACE_EXIBIR(M,N,i,j,MATRIZ);
                     RODAPE();
                   end;
              end;
         #77: begin
                if (j>=1) and (j<=N) and (i>=1) and (i<=M) then
                   begin
                     clrscr;
                     CABECA();
                     if (j<>N) then j:=j+1; {direita}
                     INTERFACE_EXIBIR(M,N,i,j,MATRIZ);
                     RODAPE();
                   end;
              end;
         #80: begin
                if (j>=1) and (j<=N) and (i>=1) and (i<=M) then
                   begin
                     clrscr;
                     CABECA();
                     if (i<>M) then i:=i+1; {baixo}
                     INTERFACE_EXIBIR(M,N,i,j,MATRIZ);
                     RODAPE();
                   end;
              end;
         'Z','z': begin
                    DETONA(M,N,i,j,MATRIZ,GAMEOVER,WIN);
                    clrscr;
                    CABECA();
                    INTERFACE_EXIBIR(M,N,i,j,MATRIZ);
                    RODAPE();
                  end;
         'X','x': begin
                    if MATRIZ[i,j].MEMORIA=3 then MATRIZ[i,j].MEMORIA:=1;
                    if MATRIZ[i,j].MEMORIA=1 then MATRIZ[i,j].MEMORIA:=3;
                    clrscr;
                    CABECA();
                    INTERFACE_EXIBIR(M,N,i,j,MATRIZ);
                    RODAPE();
                  end;
     end;
  until (C=#115) or (GAMEOVER=true) or (WIN=true);
  if GAMEOVER=true then begin
     clrscr;
     CABECA();
     Sound(220); 	{ Beep }
     Delay(200);    { Espera 200 ms }
     NoSound;       { Para de fazer o barulho }
     writeln;
     textcolor(red);
     writeln('':30,'-.-" GAME OVER -.-"');
     textcolor(white);
     SHOW_ALL(M,N,MATRIZ);
     INTERFACE_EXIBIR(M,N,i,j,MATRIZ);
     RODAPE();
  end;
  if WIN=true then begin
     clrscr;
     CABECA();
     writeln;
     textcolor(red);
     writeln('':25,' YOU WIN ');
     textcolor(white);
     Sound(220); 	{ Beep }
     Delay(800);    { Espera 200 ms }
     NoSound;       { Para de fazer o barulho }
     writeln;
     INTERFACE_EXIBIR(M,N,i,j,MATRIZ);
     RODAPE();
  end;
  X:='Deseja Salvar o jogo?';
  QUESTION(X,OPT);
  if OPT=true then SAVEGAME(SAVE,MATRIZ);
end;

{XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX}


                  {INICIO DO PROGRAMA PRINCIPAL}

Begin
  assign(SAVE,'saved game.dat');
  M:=10;  {se nada for determinado pelo usuário, o programa assumirá como }
  N:=10;      {valores padrões um campo de 10x10 contendo 20 minas.}
  QTDMINA:=20;
  repeat
     MENU(X);
     if X=1 then JOGO (M,N,QTDMINA,MATRIZ,SAVE);
     if X=2 then begin
        repeat
           MENU2(Y);
           if Y=1 then PROC2_1(M,N,QTDMINA);
           if Y=2 then PROC2_2(M,N,QTDMINA);
        until Y=0;
     end;
     if X=3 then begin
                   LOADGAME(SAVE,M,N,MATRIZ);
                   JOGO (M,N,QTDMINA,MATRIZ,SAVE);
                 end;
  until X=0;
end.
