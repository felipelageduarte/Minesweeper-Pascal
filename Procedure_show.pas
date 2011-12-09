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
