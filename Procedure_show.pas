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
{==============================================================================}
procedure SHOW(M:integer; N: integer; i:integer; j:integer; var MATRIZ:MATRIZB);

var c, d:integer;

begin
  c:=i-1; d:=j-1;
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
  end;
  {--------------------------------------}
  c:=i-1; d:=j;
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
  end;
  {--------------------------------------}
  c:=i-1; d:=j+1;
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
  end;
  {--------------------------------------}
  c:=i; d:=j-1;
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
  end;
  {--------------------------------------}
  c:=i; d:=j+1;
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
  end;
  {--------------------------------------}
  c:=i+1; d:=j-1;
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
  end;
  {--------------------------------------}
  c:=i+1; d:=j;
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
  end;
  {--------------------------------------}
  c:=i+1; d:=j+1;
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
  end;
end;
{==============================================================================}
