{ ==================================================================
  INTEGRANTES - Grupo 4A - Irrigacion - U.A. Chapingo:
    - ELIAS DOMINGUEZ RUBEN
    - BISTRAIN BORRAZ ANGEL GABRIEL
    - CRUZ SIBAJA GIBRAN FRANCISCO
    - TORRES VALENCIA MARIO ALBERTO
  ================================================================== }
unit uMiscelaneos;
{ Programas miscelaneos (ejercicios 07-10).
  07 Par/Impar, 08 Ecuacion cuadratica (con parabola), 09 Mayor, 10 Menor.
  Universidad Autonoma Chapingo - Departamento de Irrigacion. Grupo 4A. }

{$mode objfpc}{$H+}

interface

procedure OpParImpar;
procedure OpCuadratica;
procedure OpMayor;
procedure OpMenor;

implementation

uses Graph, SysUtils, Math, uComun;

procedure OpParImpar;
var n: Integer; res: string;
begin
  WriteLn; WriteLn('-- 07: NUMERO PAR O IMPAR --');
  n := LeerEntero('Numero entero: ');
  if (n mod 2) = 0 then res := IntToStr(n) + ' es PAR'
                   else res := IntToStr(n) + ' es IMPAR';
  WriteLn(res);
  MostrarPanel('07: PAR O IMPAR', ['Numero: ' + IntToStr(n), '', res]);
end;

procedure OpCuadratica;
var a, b, c, disc, x1, x2, sq, xv, yv, esc, paso, xu, yu: Double;
    i, px, py, pxAnt, pyAnt, ejeX, ejeY: Integer;
    lineas: array[0..3] of string;
    nlin: Integer;
begin
  WriteLn; WriteLn('-- 08: ECUACION CUADRATICA --');
  WriteLn('Forma: a*x^2 + b*x + c = 0');
  repeat
    a := LeerReal('a (distinto de 0): ');
    if a = 0 then WriteLn('  "a" no puede ser 0 (no seria cuadratica).');
  until a <> 0;
  b := LeerReal('b: ');
  c := LeerReal('c: ');
  disc := b * b - 4 * a * c;
  WriteLn('Discriminante = ', Fmt(disc));
  nlin := 0;
  lineas[0] := 'Ecuacion: ' + Fmt(a) + 'x^2 + ' + Fmt(b) + 'x + ' + Fmt(c);
  lineas[1] := 'Discriminante = ' + Fmt(disc);
  nlin := 2;
  if disc < 0 then
  begin
    WriteLn('No hay raices reales.');
    lineas[2] := 'No hay raices reales.'; nlin := 3;
  end
  else if disc = 0 then
  begin
    x1 := -b / (2 * a);
    WriteLn('Una raiz real doble: X = ', Fmt(x1));
    lineas[2] := 'Raiz doble X = ' + Fmt(x1); nlin := 3;
  end
  else
  begin
    sq := Sqrt(disc);
    x1 := (-b + sq) / (2 * a);
    x2 := (-b - sq) / (2 * a);
    WriteLn('X1 = ', Fmt(x1));
    WriteLn('X2 = ', Fmt(x2));
    lineas[2] := 'X1 = ' + Fmt(x1);
    lineas[3] := 'X2 = ' + Fmt(x2); nlin := 4;
  end;

  { Grafica de la parabola centrada en el vertice }
  if not AbrirVentana('08: ECUACION CUADRATICA') then Exit;
  xv := -b / (2 * a);              { vertice x }
  yv := a * xv * xv + b * xv + c;  { vertice y }
  ejeX := CentroX; ejeY := CentroY;
  esc := 30;                        { pixeles por unidad }
  SetColor(DarkGray);
  Line(MARGEN, ejeY, ANCHO - MARGEN, ejeY);   { eje X }
  Line(ejeX, 40, ejeX, ALTO - 30);            { eje Y }
  SetColor(LightCyan);
  paso := 0.1;
  pxAnt := 0; pyAnt := 0;
  i := 0;
  xu := -8;
  while xu <= 8 do
  begin
    yu := a * (xv + xu) * (xv + xu) + b * (xv + xu) + c - yv;
    px := ejeX + Round(xu * esc);
    py := ejeY - Round(yu * esc);
    if i > 0 then Line(pxAnt, pyAnt, px, py);
    pxAnt := px; pyAnt := py;
    Inc(i);
    xu := xu + paso;
  end;
  SetColor(Yellow);
  SetTextStyle(DefaultFont, HorizDir, 1);
  for i := 0 to nlin - 1 do
    OutTextXY(MARGEN, 40 + i * 14, lineas[i]);
  PiePagina('Parabola centrada en el vertice');
  EsperarYCerrar;
end;

procedure OpMayor;
var D: TDatos; n, i: Integer; mayor: Double;
begin
  WriteLn; WriteLn('-- 09: NUMERO MAYOR --');
  CapturarDatos(D, n, 1, MAXP);
  mayor := D[1];
  for i := 2 to n do if D[i] > mayor then mayor := D[i];
  WriteLn('El numero mayor es: ', Fmt(mayor));
  GraficarBarras('09: NUMERO MAYOR', D, n, ['Mayor = ' + Fmt(mayor)]);
end;

procedure OpMenor;
var D: TDatos; n, i: Integer; menor: Double;
begin
  WriteLn; WriteLn('-- 10: NUMERO MENOR --');
  CapturarDatos(D, n, 1, MAXP);
  menor := D[1];
  for i := 2 to n do if D[i] < menor then menor := D[i];
  WriteLn('El numero menor es: ', Fmt(menor));
  GraficarBarras('10: NUMERO MENOR', D, n, ['Menor = ' + Fmt(menor)]);
end;

end.
