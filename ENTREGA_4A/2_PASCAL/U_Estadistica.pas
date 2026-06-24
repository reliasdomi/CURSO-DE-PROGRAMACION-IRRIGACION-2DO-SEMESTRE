unit U_Estadistica;

{ ------------------------------------------------------------------
  U_Estadistica.pas - Estadistica (programas 9-15, 36, 37).
    9  Numero mayor          13 Moda
    10 Numero menor          14 Ordenar de menor a mayor
    11 Media aritmetica      15 Ordenar de mayor a menor
    12 Mediana               36 Regresion lineal simple
                             37 Varianza y desviacion estandar
  VARIANTE UNA VENTANA: captura y resultados dentro de la ventana grafica.
  ------------------------------------------------------------------ }

{$mode objfpc}{$H+}

interface

procedure Op_mayor;
procedure Op_menor;
procedure Op_media;
procedure Op_mediana;
procedure Op_moda;
procedure Op_ordenar_asc;
procedure Op_ordenar_desc;
procedure Op_regresion;
procedure Op_varianza;

implementation

uses U_Comun;

{ ---- auxiliares ---- }

procedure Ordena(var D: TArregloReal; N: integer; ascendente: boolean);
var i, j: integer; t: real; intercambia: boolean;
begin
  for i := 1 to N - 1 do
    for j := 1 to N - i do
    begin
      if ascendente then intercambia := D[j] > D[j + 1]
                    else intercambia := D[j] < D[j + 1];
      if intercambia then
      begin t := D[j]; D[j] := D[j + 1]; D[j + 1] := t; end;
    end;
end;

function Suma_de(const D: TArregloReal; N: integer): real;
var i: integer; s: real;
begin
  s := 0;
  for i := 1 to N do s := s + D[i];
  Suma_de := s;
end;

{ Arma lineas "v1, v2, v3, ..." de a 8 valores por linea para el panel. }
function Lineas_de_vector(const D: TArregloReal; N: integer): TStringArray;
var i, k: integer; linea: string; res: TStringArray;
begin
  SetLength(res, 0);
  linea := ''; k := 0;
  for i := 1 to N do
  begin
    linea := linea + real_a_Cadena(D[i], 1, 2);
    if i < N then linea := linea + ', ';
    Inc(k);
    if (k = 8) or (i = N) then
    begin
      SetLength(res, Length(res) + 1);
      res[High(res)] := linea;
      linea := ''; k := 0;
    end;
  end;
  Lineas_de_vector := res;
end;

{ ---- programas ---- }

procedure Op_mayor;
var D: TArregloReal; N, i: integer; mayor: real;
begin
  Captura_datos(D, N, 1, MAXP);
  mayor := D[1];
  for i := 2 to N do if D[i] > mayor then mayor := D[i];
  Muestra_panel('NUMERO MAYOR',
    ['Cantidad de datos: ' + Entero_a_Cadena(N, 1),
     'El numero mayor es: ' + real_a_Cadena(mayor, 1, 2)]);
end;

procedure Op_menor;
var D: TArregloReal; N, i: integer; menor: real;
begin
  Captura_datos(D, N, 1, MAXP);
  menor := D[1];
  for i := 2 to N do if D[i] < menor then menor := D[i];
  Muestra_panel('NUMERO MENOR',
    ['Cantidad de datos: ' + Entero_a_Cadena(N, 1),
     'El numero menor es: ' + real_a_Cadena(menor, 1, 2)]);
end;

procedure Op_media;
var D: TArregloReal; N: integer; media: real;
begin
  Captura_datos(D, N, 1, MAXP);
  media := Suma_de(D, N) / N;
  Muestra_panel('MEDIA ARITMETICA',
    ['Cantidad de datos: ' + Entero_a_Cadena(N, 1),
     'Suma: ' + real_a_Cadena(Suma_de(D, N), 1, 2),
     'Media: ' + real_a_Cadena(media, 1, 4)]);
end;

procedure Op_mediana;
var D: TArregloReal; N: integer; mediana: real;
begin
  Captura_datos(D, N, 1, MAXP);
  Ordena(D, N, True);
  if N mod 2 = 1 then mediana := D[(N + 1) div 2]
                 else mediana := (D[N div 2] + D[N div 2 + 1]) / 2;
  Muestra_panel('MEDIANA',
    ['Datos ordenados: ' + Entero_a_Cadena(N, 1) + ' valores',
     'La mediana es: ' + real_a_Cadena(mediana, 1, 4)]);
end;

procedure Op_moda;
var D: TArregloReal; N, i, j, conteo, mejor: integer; moda: real;
begin
  Captura_datos(D, N, 1, MAXP);
  moda := D[1]; mejor := 0;
  for i := 1 to N do
  begin
    conteo := 0;
    for j := 1 to N do if D[j] = D[i] then Inc(conteo);
    if conteo > mejor then begin mejor := conteo; moda := D[i]; end;
  end;
  Muestra_panel('MODA',
    ['Cantidad de datos: ' + Entero_a_Cadena(N, 1),
     'La moda es: ' + real_a_Cadena(moda, 1, 2),
     'Se repite ' + Entero_a_Cadena(mejor, 1) + ' veces']);
end;

procedure Op_ordenar_asc;
var D: TArregloReal; N: integer;
begin
  Captura_datos(D, N, 1, MAXP);
  Ordena(D, N, True);
  Muestra_panel('ORDEN ASCENDENTE', Lineas_de_vector(D, N));
end;

procedure Op_ordenar_desc;
var D: TArregloReal; N: integer;
begin
  Captura_datos(D, N, 1, MAXP);
  Ordena(D, N, False);
  Muestra_panel('ORDEN DESCENDENTE', Lineas_de_vector(D, N));
end;

procedure Op_regresion;
var X, Y: TArregloReal; N, i: integer;
    sx, sy, sxy, sxx, b, a: real;
begin
  Abre_ventana('REGRESION LINEAL  Y = a + b X');
  N := Lee_entero_rango('Cuantos pares (X,Y) (2 a ' + Entero_a_Cadena(MAXP, 1) +
       '): ', 2, MAXP);
  for i := 1 to N do
  begin
    X[i] := Lee_real('X' + Entero_a_Cadena(i, 1) + ': ');
    Y[i] := Lee_real('Y' + Entero_a_Cadena(i, 1) + ': ');
  end;
  sx := 0; sy := 0; sxy := 0; sxx := 0;
  for i := 1 to N do
  begin
    sx  := sx  + X[i];
    sy  := sy  + Y[i];
    sxy := sxy + X[i] * Y[i];
    sxx := sxx + X[i] * X[i];
  end;
  b := (N * sxy - sx * sy) / (N * sxx - sx * sx);
  a := (sy - b * sx) / N;
  Muestra_panel('REGRESION LINEAL',
    ['Pares (X,Y): ' + Entero_a_Cadena(N, 1),
     'Pendiente  b = ' + real_a_Cadena(b, 1, 4),
     'Ordenada   a = ' + real_a_Cadena(a, 1, 4),
     'Modelo: Y = ' + real_a_Cadena(a, 1, 4) + ' + ' +
        real_a_Cadena(b, 1, 4) + ' X']);
end;

procedure Op_varianza;
var D: TArregloReal; N, i: integer;
    media, sumcuad, var_pob, var_mues, desv_pob, desv_mues: real;
begin
  Captura_datos(D, N, 2, MAXP);
  media := Suma_de(D, N) / N;
  sumcuad := 0;
  for i := 1 to N do sumcuad := sumcuad + Sqr(D[i] - media);
  var_pob  := sumcuad / N;
  var_mues := sumcuad / (N - 1);
  desv_pob  := Sqrt(var_pob);
  desv_mues := Sqrt(var_mues);
  Muestra_panel('VARIANZA Y DESVIACION',
    ['Datos: ' + Entero_a_Cadena(N, 1) + '   Media: ' + real_a_Cadena(media, 1, 4),
     'Varianza poblacional: ' + real_a_Cadena(var_pob, 1, 4),
     'Desv. poblacional:    ' + real_a_Cadena(desv_pob, 1, 4),
     'Varianza muestral:    ' + real_a_Cadena(var_mues, 1, 4),
     'Desv. muestral:       ' + real_a_Cadena(desv_mues, 1, 4)]);
end;

end.
