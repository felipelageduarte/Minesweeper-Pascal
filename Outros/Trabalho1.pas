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
program elevador;


{A variavel chamadaN indica se houve uma chamada (externa) do andar N}
{A variavel destinoN indica se houve uma ordem (interna) para o andar N}

var chamada0, chamada1, chamada2, chamada3 : boolean;
var destino0, destino1, destino2, destino3 : boolean;

{A variavel paradaN indica o N-esimo ponto de parada do itinerario}
{A variavel direcaoN indica a direcao a seguir depois da N-esima parada}


var parada0,  parada1,  parada2,  parada3  : integer;
var direcao0, direcao1, direcao2, direcao3 : integer;

{Constantes auxiliares para clareza do codigo-fonte}

const sobe  = 2;
const desce = 1;
const para = 0;
	
{Verifica se houve uma chamada em ANDAR}
   {Entrada: 's' ou 'n'. Saida: true ou false}

function verifica_chamada (andar : integer) : boolean;
var
   CA: char;
   A,B: boolean;

begin
   B:=false;
   while (B=false)
     do
     write ('Chamada no andar ', andar, ' ?   (s/n)' );
     readln(CA);
     case CA of
     'S','s': begin
                A:=true;
                B:=true;
              end;
     'N','n': begin
                A:=false;
                B:=true;
              end;
     else
      begin
         writeln('Erro!!!');
         B:=false;
      end
   end;
   verifica_chamada:=A;
end;

{ Verifica se houve uma ordem para o destino ANDAR }
   {Entrada: 's' ou 'n'. Saida: true ou false}

function verifica_destino (andar : integer) : boolean;
var
   VD: char;
   B,C: boolean;

begin
   C:=false;
   while (C=false)
   do
   write ('Destino ', andar, ' selecionado? (s/n) ');
   readln(VD);
   case VD of
   'S','s': begin
              B:=true;
              C:= true;
            end;
   'N','n': begin
              B:=false;
              C:=true;
            end;
   else
      begin
         writeln('Erro!!!');
         C:=false;
      end
   end;
   verifica_destino:=B;
   {Implemente esta funcao}
end;

{Mostra o estado atual dos pedidos: chamadas e ordens}

procedure mostra_estado ();
begin
   write ('Chamadas nos andares   ');
   if (chamada0 = true) then write(' 0');
   if (chamada1 = true) then write(' 1');
   if (chamada2 = true) then write(' 2');
   if (chamada3 = true) then write(' 3');
   writeln();
   write ('Destinos selecionados ');
   if (destino0 = true) then write(' 0');
   if (destino1 = true) then write(' 1');
   if (destino2 = true) then write(' 2');
   if (destino3 = true) then write(' 3');
   writeln ('');
   writeln();
end;

{Calcula o itinerario: uma sequencia de paradas e direcoes em cada uma}

procedure calcula_itinerario ();
begin

   {Implemente este procedimento para alterar os valores de paradaN e
   direcaoN, de acordo com o itinerario}

end;

{Funcao auxiliar para converter o valor de DIRECAO em uma string legivel}

function escreve_direcao (direcao : integer) : string;
var texto : string;
begin
   case direcao of
     sobe  : texto := 'sobe';
     desce : texto := 'desce';
     para  : texto := 'para';
   end;
   escreve_direcao := texto;
end;

{Mostra o itinerario atual (paradas e direcoes)}

procedure mostra_itinerario();
begin
   if (parada0 >= 0) then
      writeln ('Parada 1: ', parada0, ' andar; direcao: ', escreve_direcao (direcao0) );
   if (parada1 >= 0) then
      writeln ('Parada 2: ', parada0, ' andar; direcao: ', escreve_direcao (direcao1) );
   if (parada2 >= 0) then
      writeln ('Parada 3: ', parada0, ' andar; direcao: ', escreve_direcao (direcao2) );
   if (parada3 > 0) then
      writeln ('Parada 4: ', parada0, ' andar; direcao: ', escreve_direcao (direcao3) );
   writeln ('');
end;


{Corpo do programa}
{Efetue modificacoes se necessario para sua solucao}

begin

   while (true) do
   begin

      {Elevador chega ao andar}

      {Verifica chamadas}

      chamada0 := verifica_chamada(0);
      chamada1 := verifica_chamada(1);
      chamada2 := verifica_chamada(2);
      chamada3 := verifica_chamada(3);

      {Verifica ordens}

      destino0 := verifica_destino (0);
      destino1 := verifica_destino (1);
      destino2 := verifica_destino (2);
      destino3 := verifica_destino (3);

      mostra_estado ();

      {Calcula e mostra o itinerario}
      calcula_itinerario();
      mostra_itinerario();

      {Segue para o proximo andar}

   end;

end.
