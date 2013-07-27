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
uses crt;//diretriz para ultilizaçao do clrscr;

type CASAMATRIZ = record
                      MINA:integer; //campo que informa se ha ou nao mina no quadrante
                      QTDMINA:integer; //campo que informa a quantidade de mina que existe envolta do quadrante
                      ABRIU:boolean; //campo que informa se o quadrante já foi ou nao aberto pelo usuario
                      MEMORIA:integer; //campo que grava qual esta sendo a exibiçao do quadrante
                      TAMANHOM:integer; //campo que salva o numero de linhas do tabuleiro
                      TAMANHON:integer; //campo que salva o numero de colunas do tabuleiro
                  end;
type MATRIZB = array[1..20,1..60] of CASAMATRIZ;//matriz de registros
type SAVED = file of MATRIZB;//arquivo de matriz de registro

var X, Y:integer;//variaveis para seleçao/utilização dos MENU's
var M, N:integer;//variaveis para determinar a dimensão do tabuleiro do jogo
var QTDMINA:integer;//variavel que determina a quantidade de mina ao redor do quadrante
var MATRIZ:MATRIZB;//variavel do tipo matriz de registro
var SAVE:SAVED;//variavel do tipo arquivo de matriz de registro
var BAND:integer;//variavel para contagem das bandeiras ultilizadas no jogo

procedure MENU (var OPT: integer );

begin
   clrscr;
   writeln; writeln; writeln;
   writeln('':29,'Amir Jamal - Junho/2008');
   writeln('':34,'CAMPO MINADO');
   writeln;
   writeln('':32,' MENU PRICIPAL ');
   writeln; writeln; writeln; writeln;
   textcolor(red);//comando para deixar o texto abaixo em amarelo
   writeln('':30,'1) Iniciar o Jogo');
   textcolor(white);//comando para deixar o texto abaixo em branco
   writeln('':30,'2) Configuracao');
   writeln('':30,'3) Load Game');
   writeln('':30,'0) Exit');
   writeln;
   write('':30,'Digite a opcao desejada: ');
   readln(OPT);
end;

procedure MENU2 (var OPT: integer );

begin
  clrscr;
  writeln; writeln; writeln;
  writeln('':29,'Amir Jamal - Junho/2008');
  writeln('':34,'CAMPO MINADO');
  writeln;
  writeln('':32,' MENU PRICIPAL ');
  writeln; writeln; writeln; writeln;
  writeln('':30,'1) Tamanho do Jogo');
  writeln('':30,'2) Quantidade de Minas');
  writeln('':30,'3) Menu Principal');
  writeln;
  write('':30,'Digite a opçao desejada: ');
  readln(OPT);
end;

procedure PROC2_1( var M:integer; var N:integer; var QTD:integer; var Y:integer );

var XMIN1:real;//quantidade minima de minas
    XMIN2:integer;
    XMAX1:real;//quantidade maxima de minas
    XMAX2:integer;

begin
  clrscr;
  writeln;  writeln;
  writeln(' Tamanho do campo: minimo de 8x8 e maximo de 20x60 posicoes');
  write(' Digite o numero de linhas: '); readln(M);
  while (M<8) or (M>20) do begin 
       writeln(' Error!!! Minimo de 8x8 e maximo de 20x60 posicoes');
       write(' Digite o numero de linhas: '); readln(M);
  end;
  write(' Digite o numero de colunas: '); readln(N);
  while (N<8) or (N>60) do begin 
       writeln('error!!! Mínimo de 8x8 e máximo de 20x60 posições');
       write(' Digite o numero de colunas: '); readln(N);
  end;
  writeln;
  writeln(' Dimensao do Campo: ',M,'X',N); {exibi dimensão do campo}
  writeln;
  XMIN1 := (M*N)*(10/100);//calcula 10% da quantidade de posições do campo
  XMIN2 := trunc(XMIN1);//considera somente a inteira do numero
  XMAX1 := (M*N)*(80/100);//calcula 80% da quantidade de posições do campo
  XMAX2 := trunc(XMAX1);//considera somente a inteira do numero
  writeln(' Numero de minas: Minimo: ',XMIN2,' minas');
  writeln('':18,'Maximo: ',XMAX2,' minas');
  writeln;
  write(' Digite o Numero de minas desejada: '); readln(QTD);
  while (QTD<XMIN2) or (QTD>XMAX2) do begin 
        writeln(' Error!!!');
        writeln(' Numero de minas: Minimo: ',XMIN2,' minas');
        writeln('':18,'Maximo: ',XMAX2,' minas');
        writeln;
        write(' Digite o Numero de minas desejada: '); readln(QTD);
  end;
  writeln;
  writeln(' Precione <ENTER> para voltar');
  readln;
  Y:=0;//associaçao para que retorne ao menu pricipal ao invez de menu configuraçoes
end;

procedure PROC2_2(M:integer; N:integer;var QTD:integer; var Y:integer );

var XMIN1:real;//quantidade minima de minas
    XMIN2:integer;
    XMAX1:real;//quantidade maxima de minas
    XMAX2:integer;
begin
  clrscr;
  XMIN1 := (M*N)*(10/100);//calcula 10% da quantidade de posições do campo
  XMIN2 := trunc(XMIN1); //Considera somente a inteira do numero
  XMAX1 := (M*N)*(80/100);//calcula 80% da quantidade de posições do campo
  XMAX2 := trunc(XMAX1);//considera somente a inteira do numero
  writeln;   writeln;
  writeln(' Dimensao do Campo: ',M,'X',N);//exibi dimensão do campo
  writeln(' Numero de minas: Minimo: ',XMIN2,' minas');
  writeln('':18,'Maximo: ',XMAX2,' minas');
  writeln;
  write(' Digite o Numero de minas desejada: '); readln(QTD);
  while (QTD<XMIN2) or (QTD>XMAX2) do begin 
        writeln(' Error!!!');
        writeln(' Numero de minas: Minimo: ',XMIN2,' minas');
        writeln('':18,'Maximo: ',XMAX2,' minas');
        writeln;
        write(' Digite o Numero de minas desejada: '); readln(QTD);
  end;
  writeln;
  writeln(' Precione <ENTER> para voltar');
  readln;
  Y:=0;//associaçao para que retorne ao menu pricipal ao invez de menu configuraçoes
end;

procedure QUESTION (PERGUNTA:string[50]; var RESPOSTA_BOOLEAN:boolean);

var RESPOSTA:char;

begin
  write(PERGUNTA,' < S / N >: ');
  readln(RESPOSTA);
  RESPOSTA:= upcase(RESPOSTA);//funçao que deixa a letra digitada pela usuario maiuscula
  while (RESPOSTA <> 'S') and (RESPOSTA <> 'N') do// laço para garantia que a resposta seja S ou N
  begin
    writeln(' Opcao invalida!!! ');
    write(PERGUNTA,' < S / N >: ');
    readln(RESPOSTA);
    RESPOSTA:= upcase(RESPOSTA);
  end;
  if RESPOSTA='S' then RESPOSTA_BOOLEAN:=true;//caso o usuario escolha sim, a resposta sera verdadeira
  if RESPOSTA='N' then RESPOSTA_BOOLEAN:=false;//caso o usuario escolha nao, a resposta sera false
end;

procedure SAVEGAME(var SAVE:SAVED; var MATRIZ:MATRIZB);

begin
  rewrite(SAVE);{comando de criação do arquivo, uma vez que ele ja tenha sido criado,   o programa sobreescreve o arquivo}
  write(SAVE,MATRIZ);//comando para salvar no arquivo a matriz com as informaçoes do jogo
  close(SAVE);//comando para salvar informações do buffer e fechar o arquivo
end;


procedure LOADGAME(var SAVE:SAVED; var M:integer; var N:integer; var MATRIZ:MATRIZB);

begin
  clrscr;
  {$I-}
  reset(SAVE);
  {$I+}
  if ioresult <> 0 then begin  // diretriz para informar se existe ou nao jogo salvo
                          writeln(' Nehum Jogo salvo encontrado');
                          readln;
                        end
  else begin
         read(SAVE,MATRIZ);//comando para leitura do arquivo
         close(SAVE);//comando para salvar informações do buffer e fechar o arquivo
         clrscr;
         M:=MATRIZ[1,1].TAMANHOM;//comando para ler quantidade de colunas do jogo salvo
         N:=MATRIZ[1,1].TAMANHON;//comando para ler a quantidade de linhas do jogo aslvo
         gotoxy(24,24);
         writeln(' Arquivo carregado com sucesso');
         gotoxy(24,25);
         writeln(' Precione <Enter> para comecar');
         readln;
	   end;	 
end;


procedure INICIALIZAR(M:integer; N:integer; var MATRIZ:MATRIZB);

var a, b:integer;//contadores para funcionameto dos laços

begin
  for a := 1 to M do begin
      for b := 1 to N do begin
          MATRIZ[a,b].MEMORIA := 1;//escrever traços no tabuleiro em branco
          MATRIZ[a,b].ABRIU := false;//marca que todo quadrante nao foi aberto ainda
          MATRIZ[a,b].TAMANHOM := M;//escreve na matriz o numero de linhas
          MATRIZ[a,b].TAMANHON := N;//escreve na matriz o numero de colunas
      end;
   end;
end;

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
  randomize;
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

procedure CALCULO_ENVOLTA( M:integer; N:integer; var MATRIZ:MATRIZB);

var i, j:integer;//contador dos laços
var c, d:integer;//variaveis para analizar a matriz em volta
var k:integer;//contador de minas

begin
  for i := 1 to M do begin
      for j := 1 to N do begin
          k:=0;//zera o contador
          c:=i-1; d:=j-1;//verifica mina no quadrante superior esquerdo
           if (d>=1) and (d<=N) and (c>=1) and (c<=M) then
              if MATRIZ[c,d].MINA=1 then
                 K:=K+1;//progressao manual do contador de minas
          c:=i-1; d:=j;//verifica mina no quadrante superior do meio
           if (d>=1) and (d<=N) and (c>=1) and (c<=M) then
              if MATRIZ[c,d].MINA=1 then
                 K:=K+1;//progressao manual do contador de minas
          c:=i-1; d:=j+1;//verifica mina no quadrante superior direito
           if (d>=1) and (d<=N) and (c>=1) and (c<=M) then
              if MATRIZ[c,d].MINA=1 then
                 K:=K+1;//progressao manual do contador de minas

          c:=i; d:=j-1;//verifica mina no quadrante esquerdo
           if (d>=1) and (d<=N) and (c>=1) and (c<=M) then
              if MATRIZ[c,d].MINA=1 then
                 K:=K+1;//progressao manual do contador de minas
          c:=i; d:=j+1;//verifica mina no quadrante direito
           if (d>=1) and (d<=N) and (c>=1) and (c<=M) then
              if MATRIZ[c,d].MINA=1 then
                 K:=K+1;//progressao manual do contador de minas

          c:=i+1; d:=j-1;//verifica mina no quadrante inferior esquerdo
           if (d>=1) and (d<=N) and (c>=1) and (c<=M) then
              if MATRIZ[c,d].MINA=1 then
                 K:=K+1;//progressao manual do contador de minas
          c:=i+1; d:=j;//verifica mina no quadrante inferior do meio
           if (d>=1) and (d<=N) and (c>=1) and (c<=M) then
              if MATRIZ[c,d].MINA=1 then
                 K:=K+1;//progressao manual do contador de minas
          c:=i+1; d:=j+1;//verifica mina no quadrante inferior direito
           if (d>=1) and (d<=N) and (c>=1) and (c<=M) then
              if MATRIZ[c,d].MINA=1 then
                 K:=K+1;//progressao manual do contador de minas
          MATRIZ[i,j].QTDMINA:=K;//salva a quantidade de minas total encontradas
      end;
  end;
end;

procedure INTERFACE_EXIBIR( M:integer; N:integer; X:integer; var MATRIZ:MATRIZB );

var a, b:integer; {contadores}

begin
  writeln; writeln; writeln; writeln;
  writeln('':35,'Controles');
  writeln;
  writeln('':22,'<S> Sair    <Z> Detona   <X> Bandeira');
  writeln;
  writeln;
  write('':(X),#201);
  for a := 1 to N do write(#205);
  writeln(#187);
  for a := 1 to M do begin
      write('':X,#186);
      for b:= 1 to N do begin
          if MATRIZ[a,b].MEMORIA=1 then begin
                                           textcolor(white);
                                           write(#254);
                                           textcolor(white);
                                        end;
          if MATRIZ[a,b].MEMORIA=2 then begin
                                          textcolor(white);
                                          write(' ');
                                          textcolor(white);
                                        end;
          if MATRIZ[a,b].MEMORIA=3 then begin
                                          textcolor(red);
                                          write(#6);
                                          textcolor(white);
                                        end;
          if MATRIZ[a,b].MEMORIA=4 then begin
                                          textcolor(green);
                                          write(MATRIZ[a,b].QTDMINA);
                                          textcolor(white);
                                        end;
          if MATRIZ[a,b].MEMORIA=5 then begin
                                           textcolor(red);
                                           write(#11);
                                           textcolor(white);
                                        end;
      end;
      writeln(#186);
  end;
  write('':(X),#200);
  for a := 1 to N do write(#205);
  writeln(#188);
  writeln; writeln; writeln;
  writeln('':15,' Use as setas do teclado para movimentar o ponteiro');
  writeln;
  writeln('':35,'Para cima ');
  writeln('':39,#24); // codigo ASCII - seta para cima
  writeln('':29,'Esquerda ',#27,' ',#26,' Direita');
  writeln('':39,#25); // Codigo ASCII - seta para baixo
  writeln('':34,'Para Baixo');
  writeln;
end;

procedure SHOW_ALL( M: integer; N:integer; var MATRIZ:MATRIZB);

var a, b:integer;

begin
  for a := 1 to M do begin
      for b := 1 to N do begin
          if (MATRIZ[a,b].MINA=1) and (MATRIZ[a,b].MEMORIA<>3) then MATRIZ[a,b].MEMORIA:=5;
          if MATRIZ[a,b].MINA=0 then begin
               if MATRIZ[a,b].QTDMINA=0 then MATRIZ[a,b].MEMORIA := 2;
               if MATRIZ[a,b].QTDMINA<>0 then MATRIZ[a,b].MEMORIA := 4;
          end;
      end;
   end;
end;


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

procedure DETONA(M:integer; N:integer; i:integer ; j:integer; var MATRIZ:MATRIZB;
                 var GAMEOVER:boolean; var WIN:boolean; var BAND:integer);

var X, Z, K:integer;
var a, b:integer;

begin
  if MATRIZ[i,j].MEMORIA=3 then BAND:=BAND+1;
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


procedure SOBRESCREVER( M:integer; N:integer; var MATRIZ:MATRIZB);

var a, b:integer; {contadores}
var X,Y:integer;

begin
  for a := 1 to M do begin
      for b:= 1 to N do begin
          Y:=10+A;
          X:=( ( round( (78-N) / 2 ) +1 ) +B );
          gotoxy(X,Y);
          if MATRIZ[a,b].MEMORIA=1 then begin
                                           textcolor(white);
                                           write(#254);
                                           textcolor(white);
                                        end;
          if MATRIZ[a,b].MEMORIA=2 then begin
                                          textcolor(white);
                                          write(' ');
                                          textcolor(white);
                                        end;
          if MATRIZ[a,b].MEMORIA=3 then begin
                                          textcolor(red);
                                          write(#6);
                                          textcolor(white);
                                        end;
          if MATRIZ[a,b].MEMORIA=4 then begin
                                          textcolor(green);
                                          write(MATRIZ[a,b].QTDMINA);
                                          textcolor(white);
                                        end;
          if MATRIZ[a,b].MEMORIA=5 then begin
                                           textcolor(red);
                                           write(#11);
                                           textcolor(white);
                                        end;
      end;
      writeln;      
  end;
  writeln;
  textcolor(white);
end;

procedure JOGO ( M:integer; N:integer; var MATRIZ:MATRIZB; var SAVE:SAVED);

var Q:char;
var i,j: integer;
var A:string[50];
var Z:integer;
var X,Y:integer;
var GAMEOVER:boolean; {variavel que avisa se o jogador perdeu ou nao}
var WIN:boolean; {variavel que avisa se o jogador ganho ou nao}
var OPT:boolean;
var SAIR:boolean;

begin
  Z:=round((78-N)/2);
  i:=1;
  j:=1;
  Y:=11;
  GAMEOVER:=false;
  WIN:=false;
  SAIR:=false;

  clrscr; 
  INTERFACE_EXIBIR(M,N,Z,MATRIZ);
  X:=Z+2;
  gotoxy(X,Y);
  repeat
    Q:=readkey;
    case Q of
         #72: begin
                if (j>=1) and (j<=N) and (i>=1) and (i<=M) then
                   begin
                     if (i<>1) then begin
                                      i:=i-1; {seta para CIMA}
                                      Y:=Y-1;
                                      gotoxy(X,Y);
                                    end;
                   end;
              end;
         #75: begin
                if (j>=1) and (j<=N) and (i>=1) and (i<=M) then
                   begin
                     if (j<>1) then begin
                                      j:=j-1; {esquerda}
                                      X:=X-1;
                                      gotoxy(X,Y);
                                    end;
                   end;
              end;
         #77: begin
                if (j>=1) and (j<=N) and (i>=1) and (i<=M) then
                   begin
                     if (j<>N) then begin
                                      j:=j+1; {direita}
                                      X:=X+1;
                                      gotoxy(X,Y);
                                    end;
                   end;
              end;
         #80: begin
                if (j>=1) and (j<=N) and (i>=1) and (i<=M) then
                   begin
                     if (i<>M) then begin
                                      i:=i+1; {baixo}
                                      Y:=Y+1;
                                      gotoxy(X,Y);
                                    end;
                   end;
              end;
         'Z','z': begin
                    DETONA(M,N,i,j,MATRIZ,GAMEOVER,WIN,BAND);
                    SOBRESCREVER(M,N,MATRIZ);
                    gotoxy(X,Y);
                  end;
         'X','x': begin
                    if MATRIZ[i,j].MEMORIA=3 then MATRIZ[i,j].MEMORIA:=1                              
                    else if MATRIZ[i,j].MEMORIA=1 then MATRIZ[i,j].MEMORIA:=3;
                    SOBRESCREVER(M,N,MATRIZ);
					gotoxy(X,Y);
                  end;
         'S','s': begin
                    gotoxy(1,45);
                    A:='Deseja abandonar o jogo?';
                    QUESTION(A,SAIR);
                    gotoxy(X,Y);
                  end;
     end;
  until (SAIR=true) or (GAMEOVER=true) or (WIN=true);
  if GAMEOVER=true then begin
     clrscr;
	 SHOW_ALL(M,N,MATRIZ);
     INTERFACE_EXIBIR(M,N,Z,MATRIZ);
     writeln;
     textcolor(red);
     writeln('':30,'-.-" Perdeu -.-"');
     textcolor(white);
     writeln;    
  end;
  if WIN=true then begin
     clrscr;	 
     INTERFACE_EXIBIR(M,N,Z,MATRIZ);
     writeln;
     textcolor(yellow);
     writeln('':34,#1,' Vitoria ',#1);
     textcolor(white);
     writeln; 
  end;
  gotoxy(1,45);  
  A:=' Deseja Salvar o jogo?:  ';
  QUESTION(A,OPT);
  if OPT=true then SAVEGAME(SAVE,MATRIZ);
end;

Begin
  assign(SAVE,'saved game.dat');
  M:=10;  {se nada for determinado pelo usuário, o programa assumirá como }
  N:=10;      {valores padrões um campo de 10x10 contendo 20 minas.}
  QTDMINA:=20;
  repeat
     MENU(X);
     if X=1 then begin
                   clrscr; 
                   INICIALIZAR(M,N,MATRIZ);
                   SORTEIO_MINA(M,N,QTDMINA,MATRIZ);                   
                   CALCULO_ENVOLTA(M,N,MATRIZ);                   
                   JOGO (M,N,MATRIZ,SAVE);
                 end;
     if X=2 then begin
        repeat
           MENU2(Y);
           if Y=1 then PROC2_1(M,N,QTDMINA,Y);
           if Y=2 then PROC2_2(M,N,QTDMINA,Y);
        until Y=0;
     end;
     if X=3 then begin
                   LOADGAME(SAVE,M,N,MATRIZ);
                   JOGO (M,N,MATRIZ,SAVE);
                 end;
  until X=0;
end.
