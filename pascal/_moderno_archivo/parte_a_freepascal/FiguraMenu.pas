{ ==================================================================
  INTEGRANTES - Grupo 4A - Irrigacion - U.A. Chapingo:
    - ELIAS DOMINGUEZ RUBEN
    - BISTRAIN BORRAZ ANGEL GABRIEL
    - CRUZ SIBAJA GIBRAN FRANCISCO
    - TORRES VALENCIA MARIO ALBERTO
  ================================================================== }
program FiguraMenu;
{ Menu general (consola) de FIGURAS GEOMETRICAS en modo grafico real.
  El menu vive en la consola; al elegir una figura se piden los datos,
  se calculan area/perimetro y se DIBUJA la figura en una ventana grafica
  (unit Graph de Free Pascal). Equivalente grafico del menu BASIC.

  Universidad Autonoma Chapingo - Departamento de Irrigacion.
  Autores: Bistrain Borraz Angel Gabriel; Cruz Sibaja Gibran Francisco;
           Elias Dominguez Ruben; Ortiz Ugarte Jonatan; Torres Valencia Mario Alberto.

  Compilar:  fpc -O2 FiguraMenu.pas
  Ejecutar:  FiguraMenu }

{$mode objfpc}{$H+}

uses
  SysUtils, uFigurasCalc, uFigurasDibujo;

{ ---- Lectura validada desde consola ---- }

function LeerRealPositivo(const Mensaje: string): Double;
var s: string; v: Double;
begin
  repeat
    Write(Mensaje);
    ReadLn(s);
    if not TryStrToFloat(Trim(s), v) then
      WriteLn('  Entrada invalida. Use numeros (ej: 5 o 5.5).')
    else if v <= 0 then
      WriteLn('  El valor debe ser mayor que cero.')
    else
      Exit(v);
  until False;
end;

function LeerEnteroMinimo(const Mensaje: string; Minimo: Integer): Integer;
var s: string; v: Integer;
begin
  repeat
    Write(Mensaje);
    ReadLn(s);
    if not TryStrToInt(Trim(s), v) then
      WriteLn('  Entrada invalida. Use un numero entero.')
    else if v < Minimo then
      WriteLn('  El valor debe ser mayor o igual que ', Minimo, '.')
    else
      Exit(v);
  until False;
end;

procedure EsperarYCerrar;
begin
  WriteLn;
  Write('Observe la ventana grafica. Pulse ENTER aqui para volver al menu...');
  ReadLn;
  CerrarGrafico;
end;

function F(X: Double): string;
begin
  Result := FormatFloat('0.00', X);
end;

{ ---- Opciones ---- }

procedure OpCuadrado;
var lado: Double; r: TResultado;
begin
  WriteLn; WriteLn('-- AREA Y PERIMETRO DEL CUADRADO --');
  lado := LeerRealPositivo('Lado del cuadrado (> 0): ');
  r := CalcCuadrado(lado);
  WriteLn('Area      = ', F(r.Area), ' u2');
  WriteLn('Perimetro = ', F(r.Perimetro), ' u');
  DibCuadrado(lado, 'Area=' + F(r.Area) + '  Perimetro=' + F(r.Perimetro));
  EsperarYCerrar;
end;

procedure OpRectangulo;
var base, alt: Double; r: TResultado;
begin
  WriteLn; WriteLn('-- AREA Y PERIMETRO DEL RECTANGULO --');
  base := LeerRealPositivo('Base (> 0): ');
  alt  := LeerRealPositivo('Altura (> 0): ');
  r := CalcRectangulo(base, alt);
  WriteLn('Area      = ', F(r.Area), ' u2');
  WriteLn('Perimetro = ', F(r.Perimetro), ' u');
  DibRectangulo(base, alt, 'Area=' + F(r.Area) + '  Perimetro=' + F(r.Perimetro));
  EsperarYCerrar;
end;

procedure OpTriangulo;
var base, alt, l1, l2: Double; r: TResultado;
begin
  WriteLn; WriteLn('-- AREA Y PERIMETRO DEL TRIANGULO --');
  base := LeerRealPositivo('Base (> 0): ');
  alt  := LeerRealPositivo('Altura (> 0): ');
  l1   := LeerRealPositivo('Lado 1 para perimetro (> 0): ');
  l2   := LeerRealPositivo('Lado 2 para perimetro (> 0): ');
  r := CalcTriangulo(base, alt, l1, l2);
  WriteLn('Area      = ', F(r.Area), ' u2');
  WriteLn('Perimetro = ', F(r.Perimetro), ' u');
  DibTriangulo(base, alt, 'Area=' + F(r.Area) + '  Perimetro=' + F(r.Perimetro));
  EsperarYCerrar;
end;

procedure OpCirculo;
var radio: Double; r: TResultado;
begin
  WriteLn; WriteLn('-- AREA Y CIRCUNFERENCIA DEL CIRCULO --');
  radio := LeerRealPositivo('Radio (> 0): ');
  r := CalcCirculo(radio);
  WriteLn('Area           = ', F(r.Area), ' u2');
  WriteLn('Circunferencia = ', F(r.Perimetro), ' u');
  DibCirculo(radio, 'Area=' + F(r.Area) + '  Circunf=' + F(r.Perimetro));
  EsperarYCerrar;
end;

procedure OpRombo;
var diagMayor, diagMenor, lado: Double; r: TResultado;
begin
  WriteLn; WriteLn('-- AREA Y PERIMETRO DEL ROMBO --');
  diagMayor := LeerRealPositivo('Diagonal mayor (> 0): ');
  diagMenor := LeerRealPositivo('Diagonal menor (> 0): ');
  lado      := LeerRealPositivo('Lado del rombo (> 0): ');
  r := CalcRombo(diagMayor, diagMenor, lado);
  WriteLn('Area      = ', F(r.Area), ' u2');
  WriteLn('Perimetro = ', F(r.Perimetro), ' u');
  DibRombo(diagMayor, diagMenor, 'Area=' + F(r.Area) + '  Perimetro=' + F(r.Perimetro));
  EsperarYCerrar;
end;

procedure OpTrapecio;
var baseMayor, baseMenor, alt, l1, l2: Double; r: TResultado;
begin
  WriteLn; WriteLn('-- AREA Y PERIMETRO DEL TRAPECIO --');
  baseMayor := LeerRealPositivo('Base mayor (> 0): ');
  baseMenor := LeerRealPositivo('Base menor (> 0): ');
  alt       := LeerRealPositivo('Altura (> 0): ');
  l1        := LeerRealPositivo('Lado no paralelo 1 (> 0): ');
  l2        := LeerRealPositivo('Lado no paralelo 2 (> 0): ');
  r := CalcTrapecio(baseMayor, baseMenor, alt, l1, l2);
  WriteLn('Area      = ', F(r.Area), ' u2');
  WriteLn('Perimetro = ', F(r.Perimetro), ' u');
  DibTrapecio(baseMayor, baseMenor, alt, 'Area=' + F(r.Area) + '  Perimetro=' + F(r.Perimetro));
  EsperarYCerrar;
end;

procedure OpPoligono;
var n: Integer; lado: Double; r: TResultado;
begin
  WriteLn; WriteLn('-- AREA DEL POLIGONO REGULAR --');
  n    := LeerEnteroMinimo('Numero de lados (>= 3): ', 3);
  lado := LeerRealPositivo('Longitud de cada lado (> 0): ');
  r := CalcPoligono(n, lado);
  WriteLn('Perimetro = ', F(r.Perimetro), ' u');
  WriteLn('Area      = ', F(r.Area), ' u2');
  DibPoligono(n, lado, 'Lados=' + IntToStr(n) + '  Area=' + F(r.Area));
  EsperarYCerrar;
end;

{ ---- Menu ---- }

procedure MostrarMenu;
begin
  WriteLn;
  WriteLn('==============================================');
  WriteLn('   UNIVERSIDAD AUTONOMA CHAPINGO - IRRIGACION');
  WriteLn('   FIGURAS GEOMETRICAS EN MODO GRAFICO');
  WriteLn('==============================================');
  WriteLn('  1. Cuadrado');
  WriteLn('  2. Rectangulo');
  WriteLn('  3. Triangulo');
  WriteLn('  4. Circulo');
  WriteLn('  5. Rombo');
  WriteLn('  6. Trapecio');
  WriteLn('  7. Poligono regular');
  WriteLn('  0. Salir');
  WriteLn('----------------------------------------------');
  Write('  Seleccione una opcion: ');
end;

var
  op: string;
begin
  repeat
    MostrarMenu;
    ReadLn(op);
    case Trim(op) of
      '1': OpCuadrado;
      '2': OpRectangulo;
      '3': OpTriangulo;
      '4': OpCirculo;
      '5': OpRombo;
      '6': OpTrapecio;
      '7': OpPoligono;
      '0': WriteLn('Gracias.');
    else
      WriteLn('Opcion no valida.');
    end;
  until Trim(op) = '0';
  CerrarGrafico;
end.
