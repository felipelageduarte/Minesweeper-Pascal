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
{

       O objetivo do trabalho é construir o jogo "Campo Minado" em linguagem
 pascal. Ultilizei de uma matriz de registro pois seria necessario gravar varias
 informaçoes em cada quadrante... assim o registro tem 4 campos:
     MINA - campo que informa se ha ou nao mina no quadrante, caso exista mina
            no quadrante, ele recebe o valor 1, se nao existir recebe o valor 0...
            as minas sao distribuidas randomicamente (aleatoriamente);
     QTDMINA - campo que informa a quantidade de mina que existe envolta do
               quadrante, esse valor é calculado logo apos a distribuição das
               minas e é exibido assim que o usuario detone o quadrante.
     ABRIU - campo que informa se o quadrante já foi ou nao aberto pelo usuario...
             A principal funçao deste campo é paralizar o procedimento progressivo,
             ou seja, assim que o procedimento acha algo aberto ele para de seguir
             abrindo as casas em branco naquele sentido (mais informaçoes no
             procedimento SHOW (abaixo).
     MEMORIA - campo que grava qual esta sendo a exibiçao do quadrante, se receber
               o valor 1 exibe um traço, se receber o valor 2 exibe um espaço em
               branco, se receber o valor 3 exibe uma bandeirinha, se receber o
               valor 4 exibe o numero de minas envolta e se receber o valor 5 ele
               exibe o caracter que significa bomba.
       Em um segundo arquivo foi armazenado um registro contendo 4 outros campos
 para que apos o load feito pelo o usuario, as configuraçoes do jogo se alterem
 para as configuraçoes estabelecidas no jogo salvo. 4 campo foram ultilizados para
 isto, sao eles:
     BAND - Campo que salva a quantidade de bandeirinhas ja distribuidas no tabuleiro
     TAMANHOM - Quando o jogo é salvo, é necessario salvar o numero de linhas
                que o tabuleiro tem, assim, este campo armazena o numero de linhas
                para que quando o load for feito, mantenha-se as mesmas caracteris-
                ticas do jogo salvo
     TAMANHON - Mesma necessidade sobre o numero de linhas, tem o numero de colunas,
                assim, esse campo salva o numero de linhas do jogo.
     NUMEROMINA - Campo que salva a quantidade de minas que esta distribuida no
                  tabuleiro do jogo
       O jogador tem a opçao de abandonar o jogo a qualquer momento apertando a
 tecla <S>, aparece uma mensagem para confirmar a opçao de abandonar o jogo e
 pergunta se ele deseja salva o jogo, caso ele deseje salvar o jogo, é criado dois
 arquivo (saved game.dat e info game.dat ) no mesmo diretorio onde esta o arquivo
 Campo Minado.exe que contem todo o jogo e as informaçoes necessarias.
 }

uses crt;//diretriz para ultilizaçao do clrscr;

type CASAMATRIZ = record
                      MINA:integer; //campo que informa se ha ou nao mina no quadrante
                      QTDMINA:integer; //campo que informa a quantidade de mina que existe envolta do quadrante
                      ABRIU:boolean; //campo que informa se o quadrante já foi ou nao aberto pelo usuario
                      MEMORIA:integer; //campo que grava qual esta sendo a exibiçao do quadrante
                  end;
type MATRIZB = array[1..20,1..60] of CASAMATRIZ;//matriz de registros
type SAVED = file of MATRIZB;//arquivo de matriz de registro

type GAMEINFO = record
                    BAND:integer; //Campo que salva quantidade de bandeirinhas colocadas no tabuleiro
                    TAMANHOM:integer; //campo que salva o numero de linhas do tabuleiro
                    TAMANHON:integer; //campo que salva o numero de colunas do tabuleiro
                    NUMEROMINA:integer; //Campo que salva quantas minas existem ao todo no tabuleiro
                end;
type GAMEARQ = file of GAMEINFO;//arquivo de registro

const//constantes a serem ultilizadas no programa
TRACO='--------------------------------------------------------------------------------';


var X, Y:integer;//variaveis para seleçao/utilização dos MENU's
var M, N:integer;//variaveis para determinar a dimensão do tabuleiro do jogo
var QTDMINA:integer;//variavel que determina a quantidade de mina ao redor do quadrante
var BAND:integer;//variavel para contagem das bandeiras ultilizadas no jogo

var MATRIZ:MATRIZB;//variavel do tipo matriz de registro
var SAVE:SAVED;//variavel do tipo arquivo de matriz de registro

var INFO:GAMEINFO;//variavel do tipo registro
var ARQ:GAMEARQ;//variavel do tipo arquivo de registro

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
   writeln; writeln; writeln;//desce 3 linhas
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
     C:=readkey;//atribuiçao do valor da tecla a variavel C ( ASCII ).
     case C of
        #72: if I=7 then I:=10// #72- codigo ASCII para a tecla "seta para cima"
             else I:= I-1;
        #80: if I=10 then I:=7// #80- codigo ASCII para a tecla "seta para baixo"
             else I:= I+1;
     end;
   until C=#13;// #13 - tecla <Enter>
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
  writeln; writeln;//desce 2 linhas
  //inicio do cabeçalho do menu
  writeln (TRACO);
  writeln('':27,'Felipe Duarte - Junho/2008');
  writeln('':34,'CAMPO MINADO');
  writeln;
  writeln('':32,' MENU PRICIPAL ');
  write(TRACO);
  //fim do cabeçalho
  writeln; writeln; writeln;//desce 3 linhas
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
     C:=readkey;//atribuiçao do valor da tecla a variavel C ( ASCII ).
     case C of
        #72: if I=7 then I:=9// #72- codigo ASCII para a tecla "seta para cima"
             else I:= I-1;
        #80: if I=9 then I:=7// #80- codigo ASCII para a tecla "seta para baixo"
             else I:= I+1;
     end;
   until C=#13;// #13 - tecla <Enter>
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
  while (N<8) or (N>60) do begin {laço para que se o valor digitado for menor que 8
                                     ou maior que 60 não aceitar a configuração}
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

var XMIN:integer;//quantidade minima de minas
    XMAX:integer;//quantidade maxima de minas

begin
  clrscr;
  XMIN := trunc((M*N)*(10/100));//calcula 10% da quantidade de posições do campo
  XMAX := trunc((M*N)*(80/100));//calcula 80% da quantidade de posições do campo
  writeln;   writeln;//desce 2 linhas;
  writeln(' Dimensao do Campo: ',M,'X',N);//exibi dimensão do campo
  writeln(' Numero de minas: Minimo: ',XMIN,' minas');
  writeln('':18,'Maximo: ',XMAX,' minas');
  writeln;
  write(' Digite o Numero de minas desejada: ');
  readln(QTD);//salva na variavel QTD a quantidade de minas desejadas pelo usuario
  while (QTD<XMIN) or (QTD>XMAX) do begin {laço que garante que a quantidade de
                                           minas esta entre o intervalo determinado}
        writeln(' Error!!!');
        writeln(' Numero de minas: Minimo: ',XMIN,' minas');
        writeln('':18,'Maximo: ',XMAX,' minas');
        writeln;
        write(' Digite o Numero de minas desejada: ');
        readln(QTD);//salva na variavel QTD a quantidade de minas desejadas pelo usuario
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
  // laço para garantia que a resposta seja S ou N
  while (RESPOSTA <> 'S') and (RESPOSTA <> 'N') do
    begin
      writeln(' Opcao invalida!!! ');
      write(PERGUNTA,' < S / N >: ');
      readln(RESPOSTA);
      RESPOSTA:= upcase(RESPOSTA);
    end;
  // fim do laço
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
  writeln(TRACO);//constante que escreve um traço na tela
end;
             {======================================}

procedure RODAPE ();
{Procedimento que escreve no fim do jogo as instruções principais para
 movimentaçao do ponteiro - Nao retorna nenhum valor para o corpo principal
                         do programa}

begin
  textbackground(black);
  writeln;
  writeln(TRACO); //constante que escreve um traço na tela
  writeln('':15,' Use as setas do teclado para movimentar o ponteiro');
  writeln;
  writeln('':37,'Sobe ');
  writeln('':38,#24); // codigo ASCII - desenha uma seta para cima
  writeln('':28,'Esquerda ',#27,' ',#26,' Direita');
                             { codigo ASCII - #27 desenha uma seta para esquerda
                                              #26 desenha uma seta para direita}
  writeln('':38,#25); // Codigo ASCII - desenha uma seta para baixo
  writeln('':36,'Desce');
  writeln;
  writeln(TRACO);//constante que escreve um traço na tela
end;


{XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX}

//procedimentos para manipulaçao do arquivo

procedure SAVEGAME(var SAVE:SAVED; var ARQ:GAMEARQ; var MATRIZ:MATRIZB; var INFO:GAMEINFO);
//procedimento que salva o jogo com suas respectivas caracteristicas

begin
  rewrite(SAVE);{comando de criação do arquivo, uma vez que ele ja tenha sido criado,
                 o programa sobreescreve o arquivo}
  rewrite(ARQ);//comando para criaçao do arquivo
  write(ARQ,INFO);//comando para salvar no arquivo o registro INFO com as informaçoes do jogo
  write(SAVE,MATRIZ);//comando para salvar no arquivo a matriz MATRIZ com as informaçoes do jogo
  close(SAVE);//comando para salvar informações do buffer e fechar o arquivo
  close(ARQ);//comando para salvar informações do buffer e fechar o arquivo
end;

             {======================================}

procedure LOADGAME(var SAVE:SAVED; var M:integer; var N:integer; var MATRIZ:MATRIZB;
                   var ARQ:GAMEARQ; var QTDMINA:integer; var BAND:integer );
//procedimento para leitura do arquivo e do jogo la salvo

var INFO:GAMEINFO;

begin
  clrscr;
  {$I-}
  reset(SAVE);//abre o arquivo SAVE
  reset(ARQ);//abre o arquivo ARQ
  {$I+}
  if ioresult <> 0 then begin  // diretriz para informar se existe ou jogo salvo
                          writeln(' Nehum Jogo salvo encontrado');
                          writeln(' Precione <Enter> para voltar');
                        end
  else begin
         read(SAVE,MATRIZ);//comando para leitura do arquivo
         read(ARQ,INFO);//comando para leitura do arquivo
         clrscr;
         M:=INFO.TAMANHOM;//comando para ler quantidade de colunas do jogo salvo
         N:=INFO.TAMANHON;//comando para ler a quantidade de linhas do jogo aslvo
         QTDMINA:=INFO.NUMEROMINA;//atribuiçao da quantidade de minas para a variavel QTDMINA
         BAND:=INFO.BAND;//informa a quantidade de bandeirinhas que ainda faltam
                         //colocar no tabuleiro
         gotoxy(24,24);//comando que envia o cursor para a coluna 24 linha 24
         writeln(' Arquivo carregado com sucesso');
         gotoxy(24,25);//comando que envia o cursor para a coluna 24 linha 25
         writeln(' Precione <Enter> para comecar');
       end;
  readln;
  close(SAVE);//comando para salvar informações do buffer e fechar o arquivo
  close(ARQ);//comando para salvar informações do buffer e fechar o arquivo
end;

{XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX}

//procedimentos para funcionalidade e jogabilidade do jogo

procedure INICIALIZAR(M:integer; N:integer; QTDMINA:integer; var INFO:GAMEINFO;
                      var MATRIZ:MATRIZB);
//procedimento para inicializar o tabuleiro do jogo

var a, b:integer;//contadores para funcionameto dos laços

begin
  for a := 1 to M do begin
      for b := 1 to N do begin
          MATRIZ[a,b].MEMORIA := 1;//escrever traços no tabuleiro em branco
          MATRIZ[a,b].ABRIU :=false;//marca que todo quadrante nao foi aberto ainda
          INFO.TAMANHOM := M;//salva no campo TAMANHOM da registro INFO o numero de linhas
          INFO.TAMANHON := N;//salva no campo TAMANHON da registro INFO o numero de colunas
          INFO.NUMEROMINA := QTDMINA;//salva no campo NUMEROMINA da registro INFO o numero minas
      end;
   end;
end;
             {======================================}

procedure SORTEIO_MINA( M:integer ; N:integer; QTD:integer; var MATRIZ:MATRIZB );
// Sorteio randomico de minas no tabuleiro onde (1 = mina) e (0 = não mina)

var k:integer;// contador para a quantidade de minas ja colocadas
var a, b:integer;// contador dos laços
var X:boolean;{   variavel que paraliza todos os laços quando o numero de minas
               colocadas pelo compudaor for igual ao numero de minas determinadas
                                       pelo usuario  }

begin
  for a := 1 to M do begin
      for b := 1 to N do begin
          MATRIZ[a,b].MINA:=0;//laço que coloca nao mina em toda a matriz
      end;
  end;
  X:=false;
  K:=0;//zera o contador
  randomize;
  repeat
     a:=0;//inicializa o contador de linhas
     repeat
       a:=a+1;//progressao manual do contador de linhas
       b:=0;//inicializa o contador de colunas
       repeat
         b:=b+1;//progressao manual do contador de colunas
         if (MATRIZ[a,b].MINA=0) then begin//somente campos com nao minas entram no sorteio
            MATRIZ[a,b].MINA:=(random(15));//funçao randon sortei um numero de 0 a 14
            if MATRIZ[a,b].MINA=1 then begin
                 K:=(K+1);// caso o numero sorteado for um, acrescenta-se 1 no contador
                 if (K=QTD) then X:=true;//verifica se o numero de bombas é igual ao
                 end;                    // ao numero de bombas determinado pelo usuario
            If MATRIZ[a,b].MINA<>1 then MATRIZ[a,b].MINA:=0;//todos os campos que nao
            end;                                            //foram sorteados com mina
       until (b=N) or (X=true);                             //são zerados novamente
     until (a=M) or (X=true);
  until (X=true);
end;
             {======================================}

procedure CALCULO_ENVOLTA( M:integer; N:integer; var MATRIZ:MATRIZB);
{ Procedimento que calcula a quantidade de minas em volta do quadrante e armazena
esse valor no campo MINA do registro}

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
             {======================================}

procedure INTERFACE_EXIBIR( M:integer; N:integer; i:integer; j:integer;
                            var MATRIZ:MATRIZB; BAND:integer );
{procedimento que exibe para o usuario o tabuleiro do jogo com o seu estado atual
e todas as casas já abertas ou marcadas com bandeira}

var a, b:integer;//contadores do laço

begin
  textcolor(yellow);//diretriz que muda a cor do texto para amarelo
  writeln('':round(80/2),BAND);//comando para centralizar o contador de bandeiras
  writeln;                     //no centro da tela
  for a := 1 to M do begin
      textbackground(black);//diretriz que grifa o texto de amarela
      write('':round((80-N)/2),' ');//comando para centralizar o tabuleiro na tela
      for b:= 1 to N do begin
          textbackground(7);//diretriz que grifa o texto de branca
          if (a=i) and (b=j) then begin
                 textbackground(6);
                 textcolor(128);
                 end;
          if MATRIZ[a,b].MEMORIA=1 then begin
          //Exibe um traço inicial para MATRIZ[a,b].MEMORIA=1
                                           textcolor(128);
                                           write(#45);
                                        //#45 - codigo ASCII para tranço simples
                                           textcolor(black);
                                        end;
          if MATRIZ[a,b].MEMORIA=2 then begin
          //Exibe um espaço em branco para MATRIZ[a,b].MEMORIA=2
                                          textcolor(2);
                                          write(' ');
                                          textcolor(black);
                                        end;
          if MATRIZ[a,b].MEMORIA=3 then begin
          //Exibe uma badeirinha para MATRIZ[a,b].MEMORIA=3
                                          textcolor(2);
                                          write(#6);
                                      //#6 - codigo ASCII para naipe de espadas
                                          textcolor(black);
                                        end;
          if MATRIZ[a,b].MEMORIA=4 then begin
          //exibe o numero de minas ao redor para MATRIZ[a,b].MEMORIA=4
                                          textcolor(blue);
                                          write(MATRIZ[a,b].QTDMINA);
                                          textcolor(black);
                                        end;
          if MATRIZ[a,b].MEMORIA=5 then begin
          //Exibe uma bomba para MATRIZ[a,b].MEMORIA=5
                                           textcolor(red);
                                           write(#11);
                             //#11 - codigo ASCII para simbulo do sexo masculino
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

procedure SHOW_ALL( M: integer; N:integer; var MATRIZ:MATRIZB);
//procedimento que mostra todo o tabuleiro quando acaba o jogo

var a, b:integer;//contadores do laço

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

procedure SHOW(M:integer; N: integer; i:integer; j:integer; var MATRIZ:MATRIZB;
                var BAND:integer);
//procedimento que altera indica oque sera exibido na tela do usuario ao detonar o quadrante

var c, d:integer;//contador de laço

begin
  for c := (i-1) to (i+1) do begin
      for d := (j-1) to (j+1) do begin
          if (C>=1) and (C<=M) and (D>=1) and (D<=N) and (MATRIZ[c,d].ABRIU=false) then begin
                    if (MATRIZ[c,d].MINA=0) and (MATRIZ[c,d].QTDMINA=0) then begin
                                 if MATRIZ[c,d].MEMORIA=3 then BAND:=BAND+1;
                                 MATRIZ[c,d].ABRIU:=true;
                                 MATRIZ[c,d].MEMORIA:=2;
                                 SHOW(M,N,c,d,MATRIZ,BAND);
                                {Recursividade foi ultilizada para que ao clicar
                                 em espaço em branco, abrisse todas as casa ate
                                 que chegasse ao limite do tabuleiro ou a uma casa
                                 com mina ao seu redor}
                                 end;
                    if (MATRIZ[c,d].MINA=0) and  (MATRIZ[c,d].QTDMINA<>0) then begin
                                 MATRIZ[c,d].ABRIU:=true;
                                 MATRIZ[c,d].MEMORIA:=4;
                                 if MATRIZ[c,d].MEMORIA=3 then BAND:=BAND+1;
                                 end;
          end;;
      end;
  end;
end;

             {======================================}


procedure DETONA(M:integer; N:integer; i:integer ; j:integer; var MATRIZ:MATRIZB;
                 var GAMEOVER:boolean; var WIN:boolean; var BAND:integer);
//procedimento que denota o quadrante desejado pelo usuario

var X, Z, K:integer;//contadores
var a, b:integer;//contadores de laço

begin
  if MATRIZ[i,j].MEMORIA=3 then BAND:=BAND+1;
  if MATRIZ[i,j].MINA=0 then begin
      if MATRIZ[i,j].QTDMINA=0 then begin
                                      MATRIZ[i,j].MEMORIA := 2;
                                      MATRIZ[i,j].ABRIU:=true;
                                      SHOW(M,N,i,j,MATRIZ,BAND);
                                    end;
      if MATRIZ[i,j].QTDMINA<>0 then begin
                                       MATRIZ[i,j].MEMORIA := 4;
                                       MATRIZ[i,j].ABRIU:=true;
                                     end;
  end;

  //caso um pessoa acerte uma mina acaba o jogo
  if MATRIZ[i,j].MINA=1 then GAMEOVER:=true;

  {se o numero de casas abertas, mais o numero de minas forem igual ao numero de
    quadrantes total do tabuleiro, o usuario venceu o jogo}
  Z:=0;
  K:=0;
  for a := 1 to M do begin
      for B := 1 to N do begin
          if MATRIZ[a,b].ABRIU=true then Z:=Z+1;//contador para numero de casas abertas
          if MATRIZ[a,b].MINA=1 then K:=K+1;//contador para numero de minas no jogo
      end;
  end;
  X :=((M*N) - K );//calculo para determinar se o jogador ganhou ou nao
  if (Z=X) then WIN:=true;
end;

             {======================================}

procedure JOGO ( M:integer; N:integer; BAND:integer; var MATRIZ:MATRIZB;
                 var SAVE:SAVED; var ARQ:GAMEARQ; var INFO:GAMEINFO);
//procedimento que controla o jogo chamando as funçoes e procedimentos que modificam
//o estado atual do tabuleiro

var c:char;//comando para leitura da tecla (codigo ASCII)
var i, j: integer;//numero da linha e coluna onde o cursor esta
var X:string[50];//variavel string
var GAMEOVER:boolean;//variavel que avisa se o jogador perdeu ou nao
var WIN:boolean;//variavel que avisa se o jogador ganho ou nao
var OPT:boolean;//variavel booleana que informa se o jo
var SAIR:boolean;//variavel que confirma a opçao de abandonar o jogo

begin
  clrscr;//diretriz para limpeza de tela
  i:=1;//linha inicial do cursor
  j:=1;//coluna inicial do cursor
  GAMEOVER:=false;//inicializaçao da variavel GAMEOVER
  WIN:=false;//inicializaçao da variavel WIN
  SAIR:=false;//inicializaçao da variavel SAIR
  CABECA();//Escreve o cabeçalho da tela do jogo
  INTERFACE_EXIBIR(M,N,i,j,MATRIZ,BAND);
  RODAPE();//Escreve o rodape da tela do jogo
  repeat
    c:=readkey;
    case c of
         #72: begin
                if (j>=1) and (j<=N) and (i>=1) and (i<=M) then
                   begin
                     clrscr;
                     CABECA();//Escreve o cabeçalho da tela do jogo
                     if (i<>1) then i:=i-1; {seta para CIMA}
                     INTERFACE_EXIBIR(M,N,i,j,MATRIZ,BAND);//Escreve o tabuleiro
                                                           //atualizado do jogo
                     RODAPE();//Escreve o rodape da tela do jogo
                   end;
              end;
         #75: begin
                if (j>=1) and (j<=N) and (i>=1) and (i<=M) then
                   begin
                     clrscr;//diretriz para limpeza de tela
                     CABECA();//Escreve o cabeçalho da tela do jogo
                     if (j<>1) then j:=j-1; {esquerda}
                     INTERFACE_EXIBIR(M,N,i,j,MATRIZ,BAND);//screve o tabuleiro
                                                           //atualizado do jogo
                     RODAPE();//Escreve o rodape da tela do jogo
                   end;
              end;
         #77: begin
                if (j>=1) and (j<=N) and (i>=1) and (i<=M) then
                   begin
                     clrscr;//diretriz para limpeza de tela
                     CABECA();//Escreve o cabeçalho da tela do jogo
                     if (j<>N) then j:=j+1; {direita}
                     INTERFACE_EXIBIR(M,N,i,j,MATRIZ,BAND);//Escreve o tabuleiro
                                                           //atualizado do jogo
                     RODAPE();//Escreve o rodape da tela do jogo
                   end;
              end;
         #80: begin
                if (j>=1) and (j<=N) and (i>=1) and (i<=M) then
                   begin
                     clrscr;//diretriz para limpeza de tela
                     CABECA();//Escreve o cabeçalho da tela do jogo
                     if (i<>M) then i:=i+1; {baixo}
                     INTERFACE_EXIBIR(M,N,i,j,MATRIZ,BAND);//Escreve o tabuleiro
                                                           //atualizado do jogo
                     RODAPE();//Escreve o rodape da tela do jogo
                   end;
              end;
         'Z','z': begin
                    DETONA(M,N,i,j,MATRIZ,GAMEOVER,WIN,BAND);
                    clrscr;//diretriz para limpeza de tela
                    CABECA();//Escreve o cabeçalho da tela do jogo
                    INTERFACE_EXIBIR(M,N,i,j,MATRIZ,BAND);//Escreve o tabuleiro
                                                           //atualizado do jogo
                    RODAPE();//Escreve o rodape da tela do jogo
                  end;
         'X','x': begin
                    //comando para colocar bandeirinhas
                    if (MATRIZ[i,j].MEMORIA=1) then begin
                                                    MATRIZ[i,j].MEMORIA:=3;
                                                    BAND:=BAND-1;
                                                  end
                     else if (MATRIZ[i,j].MEMORIA=3) then begin
                                                    MATRIZ[i,j].MEMORIA:=1;
                                                    BAND:=BAND+1;
                                                  end;
                    clrscr;//diretriz para limpeza de tela
                    CABECA();//Escreve o cabeçalho da tela do jogo
                    INTERFACE_EXIBIR(M,N,i,j,MATRIZ,BAND);
                    RODAPE();//Escreve o rodape da tela do jogo
                  end;
         'S','s': begin
                    clrscr;//diretriz para limpeza de tela
                    CABECA();//Escreve o cabeçalho da tela do jogo
                    INTERFACE_EXIBIR(M,N,i,j,MATRIZ,BAND);//Escreve o tabuleiro
                                                           //atualizado do jogo
                    RODAPE();//Escreve o rodape da tela do jogo
                    X:='Deseja abandonar o jogo?';
                    QUESTION(X,SAIR);
                    clrscr;//diretriz para limpeza de tela
                    CABECA();//Escreve o cabeçalho da tela do jogo
                    INTERFACE_EXIBIR(M,N,i,j,MATRIZ,BAND);
                    RODAPE();//Escreve o rodape da tela do jogo
                  end;
     end;
  until (SAIR=true) or (GAMEOVER=true) or (WIN=true);
  if GAMEOVER=true then begin
     clrscr;//diretriz para limpeza de tela
     CABECA();//Escreve o cabeçalho da tela do jogo
     Sound(220); 	{ Beep }
     Delay(200);    { Espera 200 ms }
     NoSound;       { Para de fazer o barulho }
     writeln;
     textcolor(red);
     writeln('':30,' O.o GAME OVER o.O');
     textcolor(white);
     writeln;
     SHOW_ALL(M,N,MATRIZ);
     INTERFACE_EXIBIR(M,N,i,j,MATRIZ,BAND);//Escreve o tabuleiro atualizado do jogo
     RODAPE();//Escreve o rodape da tela do jogo
  end;
  if WIN=true then begin
     clrscr;//diretriz para limpeza de tela
     CABECA();//Escreve o cabeçalho da tela do jogo
     writeln;
     textcolor(yellow);
     writeln('':34,#1,' YOU WIN ',#1);
     textcolor(white);
     writeln;
     Sound(220); 	{ Beep }
     Delay(800);    { Espera 200 ms }
     NoSound;       { Para de fazer o barulho }
     writeln;
     INTERFACE_EXIBIR(M,N,i,j,MATRIZ,BAND);//Escreve o tabuleiro atualizado do jogo
     RODAPE();//Escreve o rodape da tela do jogo
  end;
  X:='Deseja Salvar o jogo?';
  QUESTION(X,OPT);
  INFO.BAND:=BAND;
  if OPT=true then SAVEGAME(SAVE,ARQ,MATRIZ,INFO);
end;

{XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX}


                  {INICIO DO PROGRAMA PRINCIPAL}

Begin
  assign(SAVE,'saved game.dat');
  assign(ARQ,'info game.dat');
  M:=10;  {se nada for determinado pelo usuário, o programa assumirá como }
  N:=10;      {valores padrões um campo de 10x10 contendo 20 minas.}
  QTDMINA:=20;
  BAND:=QTDMINA;
  repeat
     MENU(X);
     if X=1 then begin//opçao inializar o jogo do menun principal
                   INICIALIZAR(M,N,QTDMINA,INFO,MATRIZ);
                   SORTEIO_MINA(M,N,QTDMINA,MATRIZ);
                   BAND:=QTDMINA;
                   CALCULO_ENVOLTA(M,N,MATRIZ);
                   JOGO (M,N,BAND,MATRIZ,SAVE,ARQ,INFO);
                 end;
     if X=2 then begin//opçao configuraçoes do menu principal
        repeat
           MENU2(Y);
           if Y=1 then PROC2_1(M,N,QTDMINA,Y);//opçao tamanho de jogo do menu 2
           if Y=2 then PROC2_2(M,N,QTDMINA,Y);//opçao quantidade de mina do menu 2
        until Y=0;//opçao voltar ao menu principal do menu 2
     end;
     if X=3 then begin//opçao loadgame do menun principal
                   LOADGAME(SAVE,M,N,MATRIZ,ARQ,QTDMINA,BAND);
                   JOGO ( M,N,BAND,MATRIZ,SAVE,ARQ,INFO );
                 end;
  until X=0;//opçao sair do menu principal
end.
