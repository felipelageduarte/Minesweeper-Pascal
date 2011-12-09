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


const
TRACO='--------------------------------------------------------------------------------';


var X, Y:integer;//variaveis para seleçao/utilização dos MENU's
var M, N:integer;//variaveis para determinar a dimensão do tabuleiro do jogo
var QTDMINA:integer;//variavel que determina a quantidade de mina ao redor do quadrante
var MATRIZ:MATRIZB;//variavel do tipo matriz de registro
var SAVE:SAVED;//variavel do tipo arquivo de matriz de registro
var BAND:integer;//variavel para contagem das bandeiras ultilizadas no jogo
var i:integer;// contador do laço


{XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX}

//procedimentos de exibiçao/ultilizaçao dos menus

procedure MENU (var OPT: integer );
{Procedimento que escreve na tela do usuario o menu principal e retorna para o
       corpo principal do programa a opçao escolhida pelo mesmo}

var I: integer;// valor numerico para seleçao do menu
var C: char;// variavel para leitura da tecla ASCII

begin
   C:=#0;
   I:=7;
   clrscr;
   writeln; writeln;
   // inicio do cabeçalho do menu
   writeln (TRACO);
   writeln('':27,'Felipe Duarte - Junho/2008');
   writeln('':34,'CAMPO MINADO');
   writeln;
   writeln('':32,' MENU PRICIPAL ');
   write(TRACO);
   // fim do cabeçalho do menu
   writeln; writeln; writeln;
   repeat
     if I=7 then begin
                OPT:=1;//associaçao da opção escolhida pelo usuario a um valor numerico
                gotoxy(1,14);
                textcolor(yellow);//comando para deixar o texto abaixo em amarelo
                writeln('':32,'Iniciar o Jogo');
                textcolor(white);//comando para deixar o texto abaixo em branco
                writeln('':33,'Configuracao');
                writeln('':34,'Load Game');
                writeln('':36,'Exit');
                writeln;
                gotoxy(1,I);
              end;
     if I=8 then begin
                OPT:=2;//associaçao da opção escolhida pelo usuario a um valor numerico
                gotoxy(1,14);
                writeln('':32,'Iniciar o Jogo');
                textcolor(yellow);//comando para deixar o texto abaixo em amarelo
                writeln('':33,'Configuracao');
                textcolor(white);//comando para deixar o texto abaixo em branco
                writeln('':34,'Load Game');
                writeln('':36,'Exit');
                writeln;
                gotoxy(1,I);
              end;
     if I=9 then begin
                OPT:=3;//associaçao da opção escolhida pelo usuario a um valor numerico
                gotoxy(1,14);
                writeln('':32,'Iniciar o Jogo');
                writeln('':33,'Configuracao');
                textcolor(yellow);//comando para deixar o texto abaixo em amarelo
                writeln('':34,'Load Game');
                textcolor(white);//comando para deixar o texto abaixo em branco
                writeln('':36,'Exit');
                writeln;
                gotoxy(1,I);
              end;
     if I=10 then begin
                 OPT:=0;//associaçao da opção escolhida pelo usuario a um valor numerico
                 gotoxy(1,14);
                 writeln('':32,'Iniciar o Jogo');
                 writeln('':33,'Configuracao');
                 writeln('':34,'Load Game');
                 textcolor(yellow);//comando para deixar o texto abaixo em amarelo
                 writeln('':36,'Exit');
                 textcolor(white);//comando para deixar o texto abaixo em branco
                 writeln;
                 gotoxy(1,I);
               end;
     C:=readkey;//comando para ultilizaçao do teclado ( ASCII ).
     case C of
        #72: if I=7 then I:=10// #72- codigo ASCII para a tecla "seta para cima"
             else I:= I-1;
        #80: if I=10 then I:=7// #80- codigo ASCII para a tecla "seta para baixo"
             else I:= I+1;
     end;
   until C=#13;
end;
             {======================================}

procedure MENU2 (var OPT: integer );
{Procedimento que escreve na tela do usuario o menu de configuraçoes e retorna
     para o corpo principal do programa a opçao escolhida pelo mesmo}

var I: integer; // valor numerico para seleçao do menu
var C: char; // variavel para leitura da tecla ASCII

begin
  C:=#0;
  I:=7;
  clrscr;
  writeln; writeln;
  //inicio do cabeçalho do menu
  writeln (TRACO);
  writeln('':27,'Felipe Duarte - Junho/2008');
  writeln('':34,'CAMPO MINADO');
  writeln;
  writeln('':32,' MENU PRICIPAL ');
  write(TRACO);
  //fim do cabeçalho
  writeln; writeln; writeln;
  repeat
     if I=7 then begin
                OPT:=1;//associaçao da opção escolhida pelo usuario a um valor numerico
                gotoxy(1,14);
                textcolor(yellow);//comando para deixar o texto abaixo em amarelo
                writeln('':32,'Tamanho do Jogo');
                textcolor(white);//comando para deixar o texto abaixo em branco
                writeln('':31,'Quantidade de Minas');
                writeln('':33,'Menu Principal');
                writeln;
                gotoxy(1,I);
              end;
     if I=8 then begin
                OPT:=2;//associaçao da opção escolhida pelo usuario a um valor numerico
                gotoxy(1,14);
                writeln('':32,'Tamanho do Jogo');
                textcolor(yellow);//comando para deixar o texto abaixo em amarelo
                writeln('':31,'Quantidade de Minas');
                textcolor(white);//comando para deixar o texto abaixo em branco
                writeln('':33,'Menu Principal');
                writeln;
                gotoxy(1,I);
              end;
     if I=9 then begin
                OPT:=0;//associaçao da opção escolhida pelo usuario a um valor numerico
                gotoxy(1,14);
                writeln('':32,'Tamanho do Jogo');
                writeln('':31,'Quantidade de Minas');
                textcolor(yellow);//comando para deixar o texto abaixo em amarelo
                writeln('':33,'Menu Principal');
                textcolor(white);//comando para deixar o texto abaixo em branco
                writeln;
                gotoxy(1,I);
              end;
     C:=readkey;//comando para ultilizaçao do teclado ( ASCII ).
     case C of
        #72: if I=7 then I:=9// #72- codigo ASCII para a tecla "seta para cima"
             else I:= I-1;
        #80: if I=9 then I:=7// #80- codigo ASCII para a tecla "seta para baixo"
             else I:= I+1;
     end;
   until C=#13;
end;


{XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX}

//procedimentos responsaveis pela mudança de configurações do jogo

procedure PROC2_1( var M:integer; var N:integer; var QTD:integer; var Y:integer );
{Procedimento que altera o numero de linhas e colunas do tabulero do jogo,
     alterar tambem o numero de minas em jogo.
Quantidade de minas: entre 10% e 80% da quantidade de posições do campo}

var XMIN1:real;//quantidade minima de minas
    XMIN2:integer;
    XMAX1:real;//quantidade maxima de minas
    XMAX2:integer;

begin
  clrscr;
  writeln;  writeln;
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
  XMIN1 := (M*N)*(10/100);//calcula 10% da quantidade de posições do campo
  XMIN2 := trunc(XMIN1);//considera somente a inteira do numero
  XMAX1 := (M*N)*(80/100);//calcula 80% da quantidade de posições do campo
  XMAX2 := trunc(XMAX1);//considera somente a inteira do numero
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
  Y:=0;//associaçao para que retorne ao menu pricipal ao invez de menu configuraçoes
end;
             {======================================}

procedure PROC2_2(M:integer; N:integer;var QTD:integer; var Y:integer );
{procedimento para alterar o numero de minas no tabulero do jogo.
Quantidade de minas: entre 10% e 80% da quantidade de posições do campo}

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
  Y:=0;//associaçao para que retorne ao menu pricipal ao invez de menu configuraçoes
end;


{XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX}

//procedimentos para compreensao do funcionamento do jogo por parte do usuario

procedure QUESTION (PERGUNTA:string[50]; var RESPOSTA_BOOLEAN:boolean);
{procedimento que recebe uma pergunta, escreve a mesma para o usuario e
      devolve ao programa a resposta em formato booleano}

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
             {======================================}

procedure CABECA ();
{Procedimento que escreve no topo do jogo as instruções principais para
 melhor jogabilidade e compreensao por parte do usuario - Nao retorna nenhum
 valor para o corpo principal do programa}

begin
  writeln;
  writeln(TRACO); //constante que escreve um traço na tela
  writeln(' Pressione ''S'' a qualquer momento para sair ');
  writeln(' Pressione ''Z'' para detonar o lugar escolhido');
  writeln(' Pressione ''X'' para marcar o lugar com uma bandeira');
  writeln;
  writeln(TRACO);
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
  writeln('':15,' Use as setas do teclado para movimentar o ponteiro');
  writeln;
  writeln('':37,'Sobe ');
  writeln('':38,#24); // codigo ASCII - seta para cima
  writeln('':28,'Esquerda ',#27,' ',#26,' Direita'); { codigo ASCII - #27 seta para esquerda
                                                                      #26 seta para direita }
  writeln('':38,#25); // Codigo ASCII - seta para baixo
  writeln('':36,'Desce');
  writeln;
  writeln(TRACO);
end;


{XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX}

//procedimentos para manipulaçao do arquivo

procedure SAVEGAME(var SAVE:SAVED; var MATRIZ:MATRIZB);
//procedimento que salva o jogo com suas respectivas caracteristicas

begin
  rewrite(SAVE);{comando de criação do arquivo, uma vez que ele ja tenha sido criado,
                 o programa sobreescreve o arquivo}
  write(SAVE,MATRIZ);//comando para salvar no arquivo a matriz com as informaçoes do jogo
  close(SAVE);//comando para salvar informações do buffer e fechar o arquivo
end;

             {======================================}

procedure LOADGAME(var SAVE:SAVED; var M:integer; var N:integer; var MATRIZ:MATRIZB);
//procedimento para leitura do arquivo e do jogo la salvo

begin
  clrscr;
  {$I-}
  reset(SAVE);
  {$I+}
  if ioresult <> 0 then begin  // diretriz para informar se existe ou jogo salvo
                          writeln(' Nehum Jogo salvo encontrado');
                          readln;
                        end;
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

{XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX}

//procedimentos para funcionalidade e jogabilidade do jogo

procedure INICIALIZAR(M:integer; N:integer; var MATRIZ:MATRIZB);
//procedimento para inicializar o tabuleiro do jogo

var a, b:integer;//contadores para funcionameto dos laços

begin
  for a := 1 to M do begin
      for b := 1 to N do begin
          MATRIZ[a,b].MEMORIA := 1;//escrever traços no tabuleiro em branco
          MATRIZ[a,b].ABRIU :=false;//marca que todo quadrante nao foi aberto ainda
          MATRIZ[a,b].TAMANHOM := M;//escreve na matriz o numero de linhas
          MATRIZ[a,b].TAMANHON := N;//escreve na matriz o numero de colunas
      end;
   end;
end;
             {======================================}

procedure SORTEIO_MINA( M:integer ; N:integer; QTD:integer; var MATRIZ:MATRIZB );
// Sorteio randomico de minas no tabuleiro

var k:integer;// c
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

procedure INTERFACE_EXIBIR( M:integer; N:integer; X:integer; BAND:integer; var MATRIZ:MATRIZB );
{procedimento que exibe para o usuario a tela inicial do jogo}

var a, b:integer; {contadores}


begin
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
end;
             {======================================}

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

             {======================================}

procedure SOBRESCREVER( i:integer; j:integer; X:integer; Y:integer; MATRIZ:MATRIZB);

begin
  gotoxy(X,Y);
  if MATRIZ[i,j].MEMORIA=1 then begin
                                  textcolor(white);
                                  write(#254);
                                  textcolor(white);
                                end;
  if MATRIZ[i,j].MEMORIA=2 then begin
                                  textcolor(white);
                                  write(#255);
                                  textcolor(white);
                                end;
  if MATRIZ[i,j].MEMORIA=3 then begin
                                  textcolor(red);
                                  write(#6);
                                  textcolor(white);
                                end;
  if MATRIZ[i,j].MEMORIA=4 then begin
                                  textcolor(green);
                                  write(MATRIZ[i,j].QTDMINA);
                                  textcolor(white);
                                end;
  if MATRIZ[i,j].MEMORIA=5 then begin
                                  textcolor(red);
                                  write(#11);
                                  textcolor(white);
                                end;
  gotoxy(X,Y);
end;
             {======================================}

procedure SOBRESCREVERALL( M:integer; N:integer; var MATRIZ:MATRIZB);

var a, b:integer; {contadores}
var X,Y:integer;


begin
  for a := 1 to M do begin
      for b:= 1 to N do begin
          Y:=11+A;
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
                                           textcolor(black);
                                        end;
      end;
      writeln;
      textbackground(black);
  end;
  writeln;
  textcolor(white);
end;
             {======================================}

procedure JOGO ( M:integer; N:integer; var MATRIZ:MATRIZB; var SAVE:SAVED; BAND:integer);

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
  Y:=12;
  GAMEOVER:=false;
  WIN:=false;
  SAIR:=false;

  clrscr;
  CABECA();
  INTERFACE_EXIBIR(M,N,Z,BAND,MATRIZ);
  RODAPE();
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
                    SOBRESCREVERALL(M,N,MATRIZ);
                    gotoxy(X,Y);
                  end;
         'X','x': begin
                    if MATRIZ[i,j].MEMORIA=3 then begin
                                                    MATRIZ[i,j].MEMORIA:=1;
                                                    BAND:=BAND+1;
                                                  end
                   else if MATRIZ[i,j].MEMORIA=1 then begin
                                                    MATRIZ[i,j].MEMORIA:=3;
                                                    BAND:=BAND-1;
                                                  end;
                    SOBRESCREVER(i,j,X,Y,MATRIZ);
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
     CABECA();
     Sound(220); 	{ Beep }
     Delay(200);    { Espera 200 ms }
     NoSound;       { Para de fazer o barulho }
     writeln;
     textcolor(red);
     writeln('':30,'-.-" GAME OVER -.-"');
     textcolor(white);
     writeln;
     SHOW_ALL(M,N,MATRIZ);

     RODAPE();
  end;
  if WIN=true then begin
     clrscr;
     CABECA();
     writeln;
     textcolor(yellow);
     writeln('':34,#1,' YOU WIN ',#1);
     textcolor(white);
     writeln;
     Sound(220); 	{ Beep }
     Delay(800);    { Espera 200 ms }
     NoSound;       { Para de fazer o barulho }
     writeln;

     RODAPE();
  end;
  gotoxy(1,45);
  A:='Deseja Salvar o jogo?';
  QUESTION(A,OPT);
  if OPT=true then SAVEGAME(SAVE,MATRIZ);
end;

{XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX}


                  {INICIO DO PROGRAMA PRINCIPAL}

Begin
  assign(SAVE,'saved game.dat');
  M:=10;  {se nada for determinado pelo usuário, o programa assumirá como }
  N:=10;      {valores padrões um campo de 10x10 contendo 20 minas.}
  QTDMINA:=20;
  BAND:=QTDMINA;
  repeat
     MENU(X);
     if X=1 then begin
                   clrscr;
                   textcolor(4);
                   for i:= 1 to 3 do begin
                      gotoxy(35,12);
                      writeln('LOADING');
                      delay(250);
                      clrscr;
                      gotoxy(35,12);
                      writeln('LOADING.');
                      delay(250);
                      clrscr;
                      gotoxy(35,12);
                      writeln('LOADING..');
                      delay(250);
                      clrscr;
                      gotoxy(35,12);
                      writeln('LOADING...');
                      delay(250);
                      clrscr;
                   end;
                   textcolor(15);
                   INICIALIZAR(M,N,MATRIZ);
                   SORTEIO_MINA(M,N,QTDMINA,MATRIZ);
                   BAND:=QTDMINA;
                   CALCULO_ENVOLTA(M,N,MATRIZ);
                   clrscr;
                   JOGO (M,N,MATRIZ,SAVE,BAND);
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
                   JOGO (M,N,MATRIZ,SAVE,BAND);
                 end;
  until X=0;
end.
