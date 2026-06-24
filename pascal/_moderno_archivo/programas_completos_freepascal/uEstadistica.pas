{ ==================================================================
  INTEGRANTES - Grupo 4A - Irrigacion - U.A. Chapingo:
    - ELIAS DOMINGUEZ RUBEN
    - BISTRAIN BORRAZ ANGEL GABRIEL
    - CRUZ SIBAJA GIBRAN FRANCISCO
    - TORRES VALENCIA MARIO ALBERTO
  ================================================================== }
unit uEstadistica;
{ Estadistica (ejercicios 11-15, 36, 37) y estadistica de grupo (16-35).
  Salida en la ventana grafica de uComun: panel de texto, grafica de barras
  y diagrama de dispersion con recta de regresion.
  Universidad Autonoma Chapingo - Departamento de Irrigacion. Grupo 4A. }

{$mode objfpc}{$H+}

interface

procedure OpMedia;
procedure OpMediana;
procedure OpModa;
procedure OpOrdenAsc;
procedure OpOrdenDesc;
procedure OpRegresion;
procedure OpDesviacion;
procedure MenuGrupo;

implementation

uses Graph, SysUtils, Math, uComun;

{ ---- helpers ---- }

procedure Ordena(var D: TDatos; N: Integer; ascendente: Boolean);
var i, j: Integer; t: Double;
begin
  for i := 1 to N - 1 do
    for j := 1 to N - i do
      if (ascendente and (D[j] > D[j + 1])) or
         ((not ascendente) and (D[j] < D[j + 1])) then
      begin
        t := D[j]; D[j] := D[j + 1]; D[j + 1] := t;
      end;
end;

function ListaTexto(const D: TDatos; N: Integer): string;
var i: Integer;
begin
  Result := '';
  for i := 1 to N do
  begin
    Result := Result + Fmt(D[i]);
    if i < N then Result := Result + '  ';
  end;
end;

{ ============ 11-15, 36, 37 ============ }

procedure OpMedia;
var D: TDatos; n, i: Integer; suma, media: Double;
begin
  WriteLn; WriteLn('-- 11: MEDIA ARITMETICA --');
  CapturarDatos(D, n, 1, MAXP);
  suma := 0;
  for i := 1 to n do suma := suma + D[i];
  media := suma / n;
  WriteLn('Suma  = ', Fmt(suma));
  WriteLn('Media = ', Fmt(media));
  GraficarBarras('11: MEDIA ARITMETICA', D, n,
    ['Suma = ' + Fmt(suma), 'Media = ' + Fmt(media)]);
end;

procedure OpMediana;
var D: TDatos; n: Integer; mediana: Double;
begin
  WriteLn; WriteLn('-- 12: MEDIANA --');
  CapturarDatos(D, n, 1, MAXP);
  Ordena(D, n, True);
  if (n mod 2) = 1 then mediana := D[(n + 1) div 2]
  else mediana := (D[n div 2] + D[n div 2 + 1]) / 2;
  WriteLn('Mediana = ', Fmt(mediana));
  GraficarBarras('12: MEDIANA (datos ordenados)', D, n,
    ['Datos ordenados de menor a mayor', 'Mediana = ' + Fmt(mediana)]);
end;

procedure OpModa;
var D: TDatos; n, i, j, frec, maxfrec: Integer; moda: Double;
begin
  WriteLn; WriteLn('-- 13: MODA --');
  CapturarDatos(D, n, 1, MAXP);
  maxfrec := 0; moda := D[1];
  for i := 1 to n do
  begin
    frec := 0;
    for j := 1 to n do if D[j] = D[i] then Inc(frec);
    if frec > maxfrec then begin maxfrec := frec; moda := D[i]; end;
  end;
  if maxfrec <= 1 then
  begin
    WriteLn('No hay moda: todos los valores aparecen una sola vez.');
    GraficarBarras('13: MODA', D, n, ['No hay moda', 'todos aparecen una vez']);
  end
  else
  begin
    WriteLn('Moda = ', Fmt(moda), '  (frecuencia ', maxfrec, ')');
    GraficarBarras('13: MODA', D, n,
      ['Moda = ' + Fmt(moda), 'Frecuencia = ' + IntToStr(maxfrec)]);
  end;
end;

procedure OpOrdenAsc;
var D: TDatos; n: Integer;
begin
  WriteLn; WriteLn('-- 14: ORDENAR DE MENOR A MAYOR --');
  CapturarDatos(D, n, 1, MAXP);
  Ordena(D, n, True);
  WriteLn('Ordenados: ', ListaTexto(D, n));
  GraficarBarras('14: ORDEN MENOR A MAYOR', D, n, ['Ascendente']);
end;

procedure OpOrdenDesc;
var D: TDatos; n: Integer;
begin
  WriteLn; WriteLn('-- 15: ORDENAR DE MAYOR A MENOR --');
  CapturarDatos(D, n, 1, MAXP);
  Ordena(D, n, False);
  WriteLn('Ordenados: ', ListaTexto(D, n));
  GraficarBarras('15: ORDEN MAYOR A MENOR', D, n, ['Descendente']);
end;

procedure OpRegresion;
var
  px, py: TDatos; n, i, gx, gy, gxAnt, gyAnt: Integer;
  sx, sy, sxy, sx2, den, a, b: Double;
  xmin, xmax, ymin, ymax, ex, ey: Double;
  function MapX(v: Double): Integer;
  begin MapX := MARGEN + Round((v - xmin) * ex); end;
  function MapY(v: Double): Integer;
  begin MapY := (ALTO - 90) - Round((v - ymin) * ey); end;
begin
  WriteLn; WriteLn('-- 36: REGRESION LINEAL SIMPLE --');
  n := LeerCuantos('Cuantos pares (x,y) (2 a 100): ', 2, MAXP);
  for i := 1 to n do
  begin
    px[i] := LeerReal('  x' + IntToStr(i) + ' = ');
    py[i] := LeerReal('  y' + IntToStr(i) + ' = ');
  end;
  sx := 0; sy := 0; sxy := 0; sx2 := 0;
  for i := 1 to n do
  begin
    sx := sx + px[i]; sy := sy + py[i];
    sxy := sxy + px[i] * py[i]; sx2 := sx2 + px[i] * px[i];
  end;
  den := n * sx2 - sx * sx;
  if Abs(den) < 1E-12 then
  begin
    WriteLn('No se puede calcular: la X no varia.');
    MostrarPanel('36: REGRESION LINEAL',
      ['No se puede calcular la regresion.', 'Todos los valores de X son iguales.']);
    Exit;
  end;
  b := (n * sxy - sx * sy) / den;   { pendiente }
  a := (sy - b * sx) / n;           { intercepto }
  WriteLn('Ecuacion:  Y = ', Fmt(a), ' + ', Fmt(b), ' X');

  { Dispersion + recta }
  xmin := px[1]; xmax := px[1]; ymin := py[1]; ymax := py[1];
  for i := 2 to n do
  begin
    xmin := Min(xmin, px[i]); xmax := Max(xmax, px[i]);
    ymin := Min(ymin, py[i]); ymax := Max(ymax, py[i]);
  end;
  if xmax = xmin then xmax := xmin + 1;
  if ymax = ymin then ymax := ymin + 1;
  ex := (ANCHO - 2 * MARGEN) / (xmax - xmin);
  ey := (ALTO - 140) / (ymax - ymin);

  if not AbrirVentana('36: REGRESION LINEAL') then Exit;
  SetColor(DarkGray);
  Line(MARGEN, ALTO - 90, ANCHO - MARGEN, ALTO - 90);
  Line(MARGEN, 50, MARGEN, ALTO - 90);
  { puntos }
  SetColor(LightCyan);
  for i := 1 to n do
  begin
    gx := MapX(px[i]); gy := MapY(py[i]);
    Circle(gx, gy, 3);
  end;
  { recta de regresion entre xmin y xmax }
  SetColor(Yellow);
  gxAnt := MapX(xmin); gyAnt := MapY(a + b * xmin);
  gx := MapX(xmax);    gy := MapY(a + b * xmax);
  Line(gxAnt, gyAnt, gx, gy);
  SetTextStyle(DefaultFont, HorizDir, 1);
  OutTextXY(MARGEN, ALTO - 78, 'Y = ' + Fmt(a) + ' + ' + Fmt(b) + ' X');
  PiePagina('Puntos (cian) y recta de regresion (amarillo)');
  EsperarYCerrar;
end;

procedure OpDesviacion;
var
  D: TDatos; n, i: Integer;
  suma, media, sumdif, vmin, vmax, varPob, desvPob, varMue, desvMue: Double;
begin
  WriteLn; WriteLn('-- 37: VARIANZA Y DESVIACION ESTANDAR --');
  CapturarDatos(D, n, 1, MAXP);
  suma := 0; vmin := D[1]; vmax := D[1];
  for i := 1 to n do
  begin
    suma := suma + D[i];
    vmin := Min(vmin, D[i]); vmax := Max(vmax, D[i]);
  end;
  media := suma / n;
  sumdif := 0;
  for i := 1 to n do sumdif := sumdif + Sqr(D[i] - media);
  varPob := sumdif / n;
  desvPob := Sqrt(varPob);
  WriteLn('Suma   = ', Fmt(suma));
  WriteLn('Media  = ', Fmt(media));
  WriteLn('Minimo = ', Fmt(vmin), '   Maximo = ', Fmt(vmax));
  WriteLn('Varianza poblacional   = ', Fmt(varPob));
  WriteLn('Desv. estandar pobl.   = ', Fmt(desvPob));
  if n > 1 then
  begin
    varMue := sumdif / (n - 1);
    desvMue := Sqrt(varMue);
    WriteLn('Varianza muestral      = ', Fmt(varMue));
    WriteLn('Desv. estandar muestral= ', Fmt(desvMue));
    GraficarBarras('37: DESVIACION ESTANDAR', D, n,
      ['Media = ' + Fmt(media) + '   Desv.pob = ' + Fmt(desvPob),
       'Desv.muestral = ' + Fmt(desvMue)]);
  end
  else
    GraficarBarras('37: DESVIACION ESTANDAR', D, n,
      ['Media = ' + Fmt(media), 'Desv. estandar pobl. = ' + Fmt(desvPob)]);
end;

{ ============ GRUPO (16-35) ============ }

procedure GrContar(const G: TGrupo; const Titulo, Etiqueta: string;
                   filtroSexo: Char; umbralEdad, signo: Integer);
{ signo: 0=todos, 1=edad>=umbral, -1=edad<umbral. filtroSexo: ' '=ambos. }
var i, c: Integer;
begin
  c := 0;
  for i := 1 to G.n do
    if ((filtroSexo = ' ') or (G.sexo[i] = filtroSexo)) and
       ((signo = 0) or
        ((signo = 1) and (G.edad[i] >= umbralEdad)) or
        ((signo = -1) and (G.edad[i] < umbralEdad))) then Inc(c);
  WriteLn(Etiqueta, ' ', c);
  MostrarPanel(Titulo, [Etiqueta + ' ' + IntToStr(c)]);
end;

procedure GrMaxMinEdad(const G: TGrupo; const Titulo: string; filtroSexo: Char;
                       const noHay: string);
var i: Integer; hay: Boolean; mx, mn: Integer;
begin
  hay := False; mx := 0; mn := 0;
  for i := 1 to G.n do
    if (filtroSexo = ' ') or (G.sexo[i] = filtroSexo) then
    begin
      if not hay then begin mx := G.edad[i]; mn := G.edad[i]; hay := True; end
      else begin mx := Max(mx, G.edad[i]); mn := Min(mn, G.edad[i]); end;
    end;
  if not hay then
  begin WriteLn(noHay); MostrarPanel(Titulo, [noHay]); Exit; end;
  WriteLn('Edad mayor: ', mx, '   Edad menor: ', mn);
  MostrarPanel(Titulo, ['Edad mayor: ' + IntToStr(mx),
                        'Edad menor: ' + IntToStr(mn)]);
end;

procedure GrMaxMinEst(const G: TGrupo; const Titulo: string; filtroSexo: Char;
                      const noHay: string);
var i: Integer; hay: Boolean; mx, mn: Double;
begin
  hay := False; mx := 0; mn := 0;
  for i := 1 to G.n do
    if (filtroSexo = ' ') or (G.sexo[i] = filtroSexo) then
    begin
      if not hay then begin mx := G.est[i]; mn := G.est[i]; hay := True; end
      else begin mx := Max(mx, G.est[i]); mn := Min(mn, G.est[i]); end;
    end;
  if not hay then
  begin WriteLn(noHay); MostrarPanel(Titulo, [noHay]); Exit; end;
  WriteLn('Estatura mayor: ', Fmt(mx), ' m   menor: ', Fmt(mn), ' m');
  MostrarPanel(Titulo, ['Estatura mayor: ' + Fmt(mx) + ' m',
                        'Estatura menor: ' + Fmt(mn) + ' m']);
end;

procedure GrPromEdad(const G: TGrupo; const Titulo: string; filtroSexo: Char;
                     const noHay, etiqueta: string);
var i, c: Integer; suma: Double;
begin
  suma := 0; c := 0;
  for i := 1 to G.n do
    if (filtroSexo = ' ') or (G.sexo[i] = filtroSexo) then
    begin suma := suma + G.edad[i]; Inc(c); end;
  if c = 0 then begin WriteLn(noHay); MostrarPanel(Titulo, [noHay]); Exit; end;
  WriteLn(etiqueta, ' ', Fmt(suma / c), ' anos');
  MostrarPanel(Titulo, [etiqueta + ' ' + Fmt(suma / c) + ' anos']);
end;

procedure GrPromEst(const G: TGrupo; const Titulo: string; filtroSexo: Char;
                    const noHay, etiqueta: string);
var i, c: Integer; suma: Double;
begin
  suma := 0; c := 0;
  for i := 1 to G.n do
    if (filtroSexo = ' ') or (G.sexo[i] = filtroSexo) then
    begin suma := suma + G.est[i]; Inc(c); end;
  if c = 0 then begin WriteLn(noHay); MostrarPanel(Titulo, [noHay]); Exit; end;
  WriteLn(etiqueta, ' ', Fmt(suma / c), ' m');
  MostrarPanel(Titulo, [etiqueta + ' ' + Fmt(suma / c) + ' m']);
end;

procedure MostrarMenuGrupo;
begin
  WriteLn;
  WriteLn('===== ESTADISTICA DE GRUPO =====');
  WriteLn('  1. Hombres en el grupo        11. Hombres mayores de edad');
  WriteLn('  2. Mujeres en el grupo        12. Hombres menores de edad');
  WriteLn('  3. Edad mayor y menor         13. Estatura mayor/menor mujeres');
  WriteLn('  4. Estatura mayor y menor     14. Estatura mayor/menor hombres');
  WriteLn('  5. Edad may/men mujeres       15. Promedio edad grupo');
  WriteLn('  6. Edad may/men hombres       16. Promedio estatura grupo');
  WriteLn('  7. Mayores de edad (>=18)     17. Promedio edad mujeres');
  WriteLn('  8. Menores de edad (<18)      18. Promedio edad hombres');
  WriteLn('  9. Mujeres mayores de edad    19. Promedio estatura mujeres');
  WriteLn(' 10. Mujeres menores de edad    20. Promedio estatura hombres');
  WriteLn('  0. Volver (recaptura el grupo)');
  Write('  Opcion: ');
end;

procedure MenuGrupo;
var G: TGrupo; op: string;
begin
  WriteLn; WriteLn('-- ESTADISTICA DE GRUPO (16-35) --');
  CapturarGrupo(G);
  repeat
    MostrarMenuGrupo;
    ReadLn(op);
    case Trim(op) of
      '1':  GrContar(G, '16: HOMBRES EN EL GRUPO', 'Numero de hombres:', 'H', 0, 0);
      '2':  GrContar(G, '17: MUJERES EN EL GRUPO', 'Numero de mujeres:', 'M', 0, 0);
      '3':  GrMaxMinEdad(G, '18: EDAD MAYOR Y MENOR', ' ', 'Grupo vacio.');
      '4':  GrMaxMinEst (G, '19: ESTATURA MAYOR Y MENOR', ' ', 'Grupo vacio.');
      '5':  GrMaxMinEdad(G, '20: EDAD MAY/MEN MUJERES', 'M', 'No hay mujeres.');
      '6':  GrMaxMinEdad(G, '21: EDAD MAY/MEN HOMBRES', 'H', 'No hay hombres.');
      '7':  GrContar(G, '22: MAYORES DE EDAD', 'Personas de 18 anos o mas:', ' ', 18, 1);
      '8':  GrContar(G, '23: MENORES DE EDAD', 'Personas menores de 18:', ' ', 18, -1);
      '9':  GrContar(G, '24: MUJERES MAYORES DE EDAD', 'Mujeres de 18 o mas:', 'M', 18, 1);
      '10': GrContar(G, '25: MUJERES MENORES DE EDAD', 'Mujeres menores de 18:', 'M', 18, -1);
      '11': GrContar(G, '26: HOMBRES MAYORES DE EDAD', 'Hombres de 18 o mas:', 'H', 18, 1);
      '12': GrContar(G, '27: HOMBRES MENORES DE EDAD', 'Hombres menores de 18:', 'H', 18, -1);
      '13': GrMaxMinEst (G, '28: ESTATURA MAY/MEN MUJERES', 'M', 'No hay mujeres.');
      '14': GrMaxMinEst (G, '29: ESTATURA MAY/MEN HOMBRES', 'H', 'No hay hombres.');
      '15': GrPromEdad(G, '30: PROMEDIO EDAD GRUPO', ' ', 'Grupo vacio.', 'Promedio edad grupo:');
      '16': GrPromEst (G, '31: PROMEDIO ESTATURA GRUPO', ' ', 'Grupo vacio.', 'Promedio estatura grupo:');
      '17': GrPromEdad(G, '32: PROMEDIO EDAD MUJERES', 'M', 'No hay mujeres.', 'Promedio edad mujeres:');
      '18': GrPromEdad(G, '33: PROMEDIO EDAD HOMBRES', 'H', 'No hay hombres.', 'Promedio edad hombres:');
      '19': GrPromEst (G, '34: PROMEDIO ESTATURA MUJERES', 'M', 'No hay mujeres.', 'Promedio estatura mujeres:');
      '20': GrPromEst (G, '35: PROMEDIO ESTATURA HOMBRES', 'H', 'No hay hombres.', 'Promedio estatura hombres:');
      '0':  ;
    else
      WriteLn('Opcion no valida.');
    end;
  until Trim(op) = '0';
end;

end.
