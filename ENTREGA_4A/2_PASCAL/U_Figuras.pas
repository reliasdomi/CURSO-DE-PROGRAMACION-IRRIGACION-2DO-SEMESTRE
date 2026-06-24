unit U_Figuras;

{ ------------------------------------------------------------------
  U_Figuras.pas - Figuras geometricas (programas 1-6 y 38).
  VARIANTE UNA VENTANA: datos pedidos dentro de la ventana grafica
  (Lee_real_positivo dibuja el prompt en pantalla), y la figura se
  dibuja en la MISMA ventana con primitivas de la unit Graph.
  ------------------------------------------------------------------ }

{$mode objfpc}{$H+}

interface

procedure Op_cuadrado;
procedure Op_rectangulo;
procedure Op_triangulo;
procedure Op_circulo;
procedure Op_rombo;
procedure Op_trapecio;
procedure Op_poligono;

implementation

uses U_Comun, Graph, Math;

procedure Op_cuadrado;
var lado, area, perimetro, s: real; m, cx, cy: integer;
begin
  Abre_ventana('CUADRADO');
  lado := Lee_real_positivo('Lado: ');
  area := lado * lado;
  perimetro := 4 * lado;
  if Abre_ventana('CUADRADO') then
  begin
    s := Escala(lado, lado);
    m := Round(lado * s) div 2;
    cx := CentroX; cy := CentroY;
    SetColor(White);
    Rectangle(cx - m, cy - m, cx + m, cy + m);
    Pie_de_pagina('Area = ' + real_a_Cadena(area, 1, 2) +
                  '    Perimetro = ' + real_a_Cadena(perimetro, 1, 2));
    Espera_y_cierra;
  end;
end;

procedure Op_rectangulo;
var base, altura, area, perimetro, s: real; bw, bh, cx, cy: integer;
begin
  Abre_ventana('RECTANGULO');
  base   := Lee_real_positivo('Base: ');
  altura := Lee_real_positivo('Altura: ');
  area := base * altura;
  perimetro := 2 * (base + altura);
  if Abre_ventana('RECTANGULO') then
  begin
    s := Escala(base, altura);
    bw := Round(base * s) div 2;
    bh := Round(altura * s) div 2;
    cx := CentroX; cy := CentroY;
    SetColor(White);
    Rectangle(cx - bw, cy - bh, cx + bw, cy + bh);
    Pie_de_pagina('Area = ' + real_a_Cadena(area, 1, 2) +
                  '    Perimetro = ' + real_a_Cadena(perimetro, 1, 2));
    Espera_y_cierra;
  end;
end;

procedure Op_triangulo;
var base, altura, lado2, lado3, area, perimetro, s: real;
    bw, bh, cx, cy: integer;
begin
  Abre_ventana('TRIANGULO');
  base   := Lee_real_positivo('Base: ');
  altura := Lee_real_positivo('Altura: ');
  lado2  := Lee_real_positivo('Lado 2: ');
  lado3  := Lee_real_positivo('Lado 3: ');
  area := base * altura / 2;
  perimetro := base + lado2 + lado3;
  if Abre_ventana('TRIANGULO') then
  begin
    s := Escala(base, altura);
    bw := Round(base * s) div 2;
    bh := Round(altura * s) div 2;
    cx := CentroX; cy := CentroY;
    SetColor(White);
    Line(cx, cy - bh, cx - bw, cy + bh);
    Line(cx - bw, cy + bh, cx + bw, cy + bh);
    Line(cx + bw, cy + bh, cx, cy - bh);
    Pie_de_pagina('Area = ' + real_a_Cadena(area, 1, 2) +
                  '    Perimetro = ' + real_a_Cadena(perimetro, 1, 2));
    Espera_y_cierra;
  end;
end;

procedure Op_circulo;
var radio, area, circunferencia, s: real; pr, cx, cy: integer;
begin
  Abre_ventana('CIRCULO');
  radio := Lee_real_positivo('Radio: ');
  area := Pi * radio * radio;
  circunferencia := 2 * Pi * radio;
  if Abre_ventana('CIRCULO') then
  begin
    s := Escala(2 * radio, 2 * radio);
    pr := Round(radio * s);
    cx := CentroX; cy := CentroY;
    SetColor(White);
    Circle(cx, cy, pr);
    Pie_de_pagina('Area = ' + real_a_Cadena(area, 1, 2) +
                  '    Circunferencia = ' + real_a_Cadena(circunferencia, 1, 2));
    Espera_y_cierra;
  end;
end;

procedure Op_rombo;
var diag1, diag2, lado, area, perimetro, s: real; hw, hh, cx, cy: integer;
begin
  Abre_ventana('ROMBO');
  diag1 := Lee_real_positivo('Diagonal mayor (horizontal): ');
  diag2 := Lee_real_positivo('Diagonal menor (vertical): ');
  area := diag1 * diag2 / 2;
  lado := Sqrt(Sqr(diag1 / 2) + Sqr(diag2 / 2));
  perimetro := 4 * lado;
  if Abre_ventana('ROMBO') then
  begin
    s := Escala(diag1, diag2);
    hw := Round(diag1 * s) div 2;
    hh := Round(diag2 * s) div 2;
    cx := CentroX; cy := CentroY;
    SetColor(White);
    Line(cx, cy - hh, cx + hw, cy);
    Line(cx + hw, cy, cx, cy + hh);
    Line(cx, cy + hh, cx - hw, cy);
    Line(cx - hw, cy, cx, cy - hh);
    Pie_de_pagina('Area = ' + real_a_Cadena(area, 1, 2) +
                  '    Perimetro = ' + real_a_Cadena(perimetro, 1, 2));
    Espera_y_cierra;
  end;
end;

procedure Op_trapecio;
var baseMayor, baseMenor, altura, lado, area, perimetro, s: real;
    bM, bm2, h2, topY, botY, cx, cy: integer;
begin
  Abre_ventana('TRAPECIO');
  baseMayor := Lee_real_positivo('Base mayor: ');
  baseMenor := Lee_real_positivo('Base menor: ');
  altura    := Lee_real_positivo('Altura: ');
  area := (baseMayor + baseMenor) / 2 * altura;
  lado := Sqrt(Sqr(altura) + Sqr((baseMayor - baseMenor) / 2));
  perimetro := baseMayor + baseMenor + 2 * lado;
  if Abre_ventana('TRAPECIO') then
  begin
    s := Escala(baseMayor, altura);
    bM  := Round(baseMayor * s) div 2;
    bm2 := Round(baseMenor * s) div 2;
    h2  := Round(altura * s) div 2;
    cx := CentroX; cy := CentroY;
    topY := cy - h2; botY := cy + h2;
    SetColor(White);
    Line(cx - bm2, topY, cx + bm2, topY);
    Line(cx + bm2, topY, cx + bM, botY);
    Line(cx + bM, botY, cx - bM, botY);
    Line(cx - bM, botY, cx - bm2, topY);
    Pie_de_pagina('Area = ' + real_a_Cadena(area, 1, 2) +
                  '    Perimetro = ' + real_a_Cadena(perimetro, 1, 2));
    Espera_y_cierra;
  end;
end;

procedure Op_poligono;
var n: integer; lado, radio, apotema, area, perimetro, s, ang: real;
    pr, cx, cy, i, x0, y0, x1, y1: integer;
begin
  Abre_ventana('POLIGONO REGULAR');
  n    := Lee_entero_rango('Numero de lados (3 a 20): ', 3, 20);
  lado := Lee_real_positivo('Longitud del lado: ');
  apotema := lado / (2 * Tan(Pi / n));
  radio   := lado / (2 * Sin(Pi / n));
  perimetro := n * lado;
  area := perimetro * apotema / 2;
  if Abre_ventana('POLIGONO REGULAR') then
  begin
    s  := Escala(2 * radio, 2 * radio);
    pr := Round(radio * s);
    cx := CentroX; cy := CentroY;
    SetColor(White);
    x0 := cx + Round(pr * Cos(-Pi / 2));
    y0 := cy + Round(pr * Sin(-Pi / 2));
    for i := 1 to n do
    begin
      ang := -Pi / 2 + 2 * Pi * i / n;
      x1 := cx + Round(pr * Cos(ang));
      y1 := cy + Round(pr * Sin(ang));
      Line(x0, y0, x1, y1);
      x0 := x1; y0 := y1;
    end;
    Pie_de_pagina('Area = ' + real_a_Cadena(area, 1, 2) +
                  '    Perimetro = ' + real_a_Cadena(perimetro, 1, 2));
    Espera_y_cierra;
  end;
end;

end.
