unit uFiguras;
{ Figuras geometricas (ejercicios 01-06 y 38) en modo grafico real.
  Pide datos por consola, calcula area/perimetro y DIBUJA la figura a escala
  en la ventana grafica de uComun.
  Universidad Autonoma Chapingo - Departamento de Irrigacion. Grupo 4A. }

{$mode objfpc}{$H+}

interface

procedure OpCuadrado;
procedure OpRectangulo;
procedure OpTriangulo;
procedure OpCirculo;
procedure OpRombo;
procedure OpTrapecio;
procedure OpPoligono;

implementation

uses Graph, Math, SysUtils, uComun;

{ Escala para que un objeto AnchoU x AltoU quepa en el area util. }
function Escala(AnchoU, AltoU: Double): Double;
begin
  if AnchoU <= 0 then AnchoU := 1;
  if AltoU  <= 0 then AltoU  := 1;
  Result := Min((ANCHO - 2 * MARGEN) / AnchoU, (ALTO - 2 * MARGEN) / AltoU);
end;

procedure OpCuadrado;
var lado, area, per, s: Double; m: Integer;
begin
  WriteLn; WriteLn('-- 01: AREA Y PERIMETRO DEL CUADRADO --');
  lado := LeerRealPos('Lado (> 0): ');
  area := lado * lado;  per := 4 * lado;
  WriteLn('Area      = ', Fmt(area), ' u2');
  WriteLn('Perimetro = ', Fmt(per), ' u');
  if not AbrirVentana('01: CUADRADO') then Exit;
  s := Escala(lado, lado);  m := Round(lado * s) div 2;
  SetColor(White);
  Rectangle(CentroX - m, CentroY - m, CentroX + m, CentroY + m);
  PiePagina('Area=' + Fmt(area) + '  Perimetro=' + Fmt(per));
  EsperarYCerrar;
end;

procedure OpRectangulo;
var base, alt, area, per, s: Double; bw, bh: Integer;
begin
  WriteLn; WriteLn('-- 02: AREA Y PERIMETRO DEL RECTANGULO --');
  base := LeerRealPos('Base (> 0): ');
  alt  := LeerRealPos('Altura (> 0): ');
  area := base * alt;  per := 2 * (base + alt);
  WriteLn('Area      = ', Fmt(area), ' u2');
  WriteLn('Perimetro = ', Fmt(per), ' u');
  if not AbrirVentana('02: RECTANGULO') then Exit;
  s := Escala(base, alt);
  bw := Round(base * s) div 2;  bh := Round(alt * s) div 2;
  SetColor(White);
  Rectangle(CentroX - bw, CentroY - bh, CentroX + bw, CentroY + bh);
  PiePagina('Area=' + Fmt(area) + '  Perimetro=' + Fmt(per));
  EsperarYCerrar;
end;

procedure OpTriangulo;
var base, alt, l1, l2, area, per, s: Double; bw, bh: Integer;
begin
  WriteLn; WriteLn('-- 03: AREA Y PERIMETRO DEL TRIANGULO --');
  base := LeerRealPos('Base (> 0): ');
  alt  := LeerRealPos('Altura (> 0): ');
  l1   := LeerRealPos('Lado 1 (> 0): ');
  l2   := LeerRealPos('Lado 2 (> 0): ');
  area := base * alt / 2;  per := base + l1 + l2;
  WriteLn('Area      = ', Fmt(area), ' u2');
  WriteLn('Perimetro = ', Fmt(per), ' u');
  if not AbrirVentana('03: TRIANGULO') then Exit;
  s := Escala(base, alt);
  bw := Round(base * s) div 2;  bh := Round(alt * s) div 2;
  SetColor(White);
  Line(CentroX, CentroY - bh, CentroX - bw, CentroY + bh);
  Line(CentroX - bw, CentroY + bh, CentroX + bw, CentroY + bh);
  Line(CentroX + bw, CentroY + bh, CentroX, CentroY - bh);
  PiePagina('Area=' + Fmt(area) + '  Perimetro=' + Fmt(per));
  EsperarYCerrar;
end;

procedure OpCirculo;
var radio, area, circ, s: Double; pr: Integer;
begin
  WriteLn; WriteLn('-- 04: AREA Y CIRCUNFERENCIA DEL CIRCULO --');
  radio := LeerRealPos('Radio (> 0): ');
  area := Pi * Sqr(radio);  circ := 2 * Pi * radio;
  WriteLn('Area           = ', Fmt(area), ' u2');
  WriteLn('Circunferencia = ', Fmt(circ), ' u');
  if not AbrirVentana('04: CIRCULO') then Exit;
  s := Escala(2 * radio, 2 * radio);  pr := Round(radio * s);
  SetColor(White);
  Circle(CentroX, CentroY, pr);
  PiePagina('Area=' + Fmt(area) + '  Circunf=' + Fmt(circ));
  EsperarYCerrar;
end;

procedure OpRombo;
var dM, dm_, lado, area, per, s: Double; hw, hh: Integer;
begin
  WriteLn; WriteLn('-- 05: AREA Y PERIMETRO DEL ROMBO --');
  dM   := LeerRealPos('Diagonal mayor (> 0): ');
  dm_  := LeerRealPos('Diagonal menor (> 0): ');
  lado := LeerRealPos('Lado (> 0): ');
  area := dM * dm_ / 2;  per := 4 * lado;
  WriteLn('Area      = ', Fmt(area), ' u2');
  WriteLn('Perimetro = ', Fmt(per), ' u');
  if not AbrirVentana('05: ROMBO') then Exit;
  s := Escala(dM, dm_);
  hw := Round(dM * s) div 2;  hh := Round(dm_ * s) div 2;
  SetColor(White);
  Line(CentroX, CentroY - hh, CentroX + hw, CentroY);
  Line(CentroX + hw, CentroY, CentroX, CentroY + hh);
  Line(CentroX, CentroY + hh, CentroX - hw, CentroY);
  Line(CentroX - hw, CentroY, CentroX, CentroY - hh);
  PiePagina('Area=' + Fmt(area) + '  Perimetro=' + Fmt(per));
  EsperarYCerrar;
end;

procedure OpTrapecio;
var bMay, bMen, alt, l1, l2, area, per, s, anchoU: Double;
    bM, bm2, h2, topY, botY: Integer;
begin
  WriteLn; WriteLn('-- 06: AREA Y PERIMETRO DEL TRAPECIO --');
  bMay := LeerRealPos('Base mayor (> 0): ');
  bMen := LeerRealPos('Base menor (> 0): ');
  alt  := LeerRealPos('Altura (> 0): ');
  l1   := LeerRealPos('Lado no paralelo 1 (> 0): ');
  l2   := LeerRealPos('Lado no paralelo 2 (> 0): ');
  area := (bMay + bMen) * alt / 2;  per := bMay + bMen + l1 + l2;
  WriteLn('Area      = ', Fmt(area), ' u2');
  WriteLn('Perimetro = ', Fmt(per), ' u');
  if not AbrirVentana('06: TRAPECIO') then Exit;
  anchoU := Max(bMay, bMen);
  s := Escala(anchoU, alt);
  bM  := Round(bMay * s) div 2;
  bm2 := Round(bMen * s) div 2;
  h2  := Round(alt * s) div 2;
  topY := CentroY - h2;  botY := CentroY + h2;
  SetColor(White);
  Line(CentroX - bm2, topY, CentroX + bm2, topY);
  Line(CentroX + bm2, topY, CentroX + bM, botY);
  Line(CentroX + bM, botY, CentroX - bM, botY);
  Line(CentroX - bM, botY, CentroX - bm2, topY);
  PiePagina('Area=' + Fmt(area) + '  Perimetro=' + Fmt(per));
  EsperarYCerrar;
end;

procedure OpPoligono;
var n: Integer; lado, area, per, apo, R, s, ang: Double;
    pr, i, x0, y0, x1, y1: Integer;
begin
  WriteLn; WriteLn('-- 38: AREA DEL POLIGONO REGULAR --');
  n    := LeerEnteroRango('Numero de lados (3 a 60): ', 3, 60);
  lado := LeerRealPos('Longitud de cada lado (> 0): ');
  per := n * lado;
  apo := lado / (2 * Tan(Pi / n));
  area := per * apo / 2;
  WriteLn('Perimetro = ', Fmt(per), ' u');
  WriteLn('Apotema   = ', Fmt(apo), ' u');
  WriteLn('Area      = ', Fmt(area), ' u2');
  if not AbrirVentana('38: POLIGONO REGULAR') then Exit;
  R := lado / (2 * Sin(Pi / n));
  s := Escala(2 * R, 2 * R);  pr := Round(R * s);
  SetColor(White);
  x0 := CentroX + Round(pr * Cos(-Pi / 2));
  y0 := CentroY + Round(pr * Sin(-Pi / 2));
  for i := 1 to n do
  begin
    ang := -Pi / 2 + 2 * Pi * i / n;
    x1 := CentroX + Round(pr * Cos(ang));
    y1 := CentroY + Round(pr * Sin(ang));
    Line(x0, y0, x1, y1);
    x0 := x1; y0 := y1;
  end;
  PiePagina('Lados=' + IntToStr(n) + '  Area=' + Fmt(area));
  EsperarYCerrar;
end;

end.
