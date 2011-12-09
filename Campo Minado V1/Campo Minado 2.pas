

{==============================================================================}
procedure SHOW(M:integer; N: integer; i:integer; j:integer; var MATRIZ:MATRIZB);

var c, d:integer;

begin
  c:=i-1; d:=j-1;
  if (C>=1) and (C<=M) and (D>=1) and (D<=N) and (MATRIZ[c,d].ABRIU=false) then begin
     if (MATRIZ[c,d].MINA=0) and (MATRIZ[c,d].QTDMINA=0) then begin
                           MATRIZ[c,d].ABRIU:=true;
                           MATRIZ[c,d].MEMORIA:=2;
                           SHOW(M,N,i,j,MATRIZ);
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
                           SHOW(M,N,i,j,MATRIZ);
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
                           SHOW(M,N,i,j,MATRIZ);
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
                           SHOW(M,N,i,j,MATRIZ);
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
                           SHOW(M,N,i,j,MATRIZ);
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
                           SHOW(M,N,i,j,MATRIZ);
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
                           SHOW(M,N,i,j,MATRIZ);
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
                           SHOW(M,N,i,j,MATRIZ);
                           end;
     if (MATRIZ[c,d].MINA=0) and  (MATRIZ[c,d].QTDMINA<>0) then begin
                           MATRIZ[c,d].ABRIU:=true;
                           MATRIZ[c,d].MEMORIA:=4;
                           end;
  end;
end;
{==============================================================================}
procedure INTERFACE_EXIBIR( M:integer; N:integer; i:integer; j:integer; var MATRIZ:MATRIZB );
{procedimento que exibe para o usuario a tela inicial do jogo}

var a, b:integer; {contadores}

begin
  textcolor(blue);
  for a := 1 to M do begin
      for b:= 1 to N do begin
          if MATRIZ[a,b].MEMORIA = 1 then MATRIZ[a,b].ATUAL:='.';
          if MATRIZ[a,b].MEMORIA = 2 then MATRIZ[a,b].ATUAL:=' ';
          if MATRIZ[a,b].MEMORIA = 3 then MATRIZ[a,b].ATUAL:='P';
      end;
  end;
  {}
  writeln; writeln;
  for a := 1 to M do begin
      for b:= 1 to N do begin
          write(MATRIZ[a,b].MINA);
      end;
      writeln;
  end;
  {}
  for a := 1 to M do begin
      write('':5,' ');
      for b:= 1 to N do begin
          if (a=i) and (b=j) then textbackground(yellow);

          if (MATRIZ[a,b].MEMORIA<>4) and (MATRIZ[a,b].MEMORIA<>3) then begin
              textcolor(white);
              write(MATRIZ[a,b].ATUAL);
              textbackground(black);
          end;
          if (MATRIZ[a,b].MEMORIA<>4) and (MATRIZ[a,b].MEMORIA=3) then begin
              textcolor(red);
              write(MATRIZ[a,b].ATUAL);
              textbackground(black);
          end;
          if (MATRIZ[a,b].MEMORIA=4) then begin
                                            textcolor(white);
                                            write(MATRIZ[a,b].QTDMINA);
                                            textbackground(black);
                                          end;
      end;
      writeln;
  end;
  writeln;
  textcolor(white);
end;





procedure JOGO1(M:integer; N:integer ; var MATRIZ:MATRIZB);

begin
  JOGO(M,N,OPT,MATRIZ);
end;


