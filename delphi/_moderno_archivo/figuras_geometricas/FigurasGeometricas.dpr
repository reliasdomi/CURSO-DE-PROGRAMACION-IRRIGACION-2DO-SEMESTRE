// Autores:
// Bistrain Borraz Angel Gabriel
// Cruz Sibaja Gibran Francisco
// Elias Dominguez Ruben
// Ortiz Ugarte Jonatan
// Torres Valencia Mario Alberto

program FigurasGeometricas;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  Math;

function LeerRealPositivo(const Mensaje: string): Double;
begin
  repeat
    Write(Mensaje);
    ReadLn(Result);
    if Result <= 0 then
      WriteLn('Error: el valor debe ser mayor que cero.');
  until Result > 0;
end;

function LeerEnteroMinimo(const Mensaje: string; Minimo: Integer): Integer;
begin
  repeat
    Write(Mensaje);
    ReadLn(Result);
    if Result < Minimo then
      WriteLn('Error: el valor debe ser mayor o igual que ', Minimo, '.');
  until Result >= Minimo;
end;

procedure Pausa;
begin
  WriteLn;
  Write('Pulse ENTER para continuar...');
  ReadLn;
end;

procedure Encabezado(const Titulo: string);
begin
  WriteLn;
  WriteLn;
  WriteLn('UNIVERSIDAD AUTONOMA CHAPINGO');
  WriteLn('DEPARTAMENTO DE IRRIGACION');
  WriteLn('PROGRAMACION');
  WriteLn;
  WriteLn(Titulo);
  WriteLn(StringOfChar('-', Length(Titulo)));
  WriteLn;
end;

procedure CalcularCuadrado;
var
  Lado, Area, Perimetro: Double;
begin
  Encabezado('AREA Y PERIMETRO DEL CUADRADO');
  Lado := LeerRealPositivo('Lado del cuadrado (> 0): ');
  Area := Lado * Lado;
  Perimetro := 4 * Lado;
  WriteLn;
  WriteLn('Area      = ', FormatFloat('0.00', Area), ' unidades cuadradas');
  WriteLn('Perimetro = ', FormatFloat('0.00', Perimetro), ' unidades');
  Pausa;
end;

procedure CalcularRectangulo;
var
  Base, Altura, Area, Perimetro: Double;
begin
  Encabezado('AREA Y PERIMETRO DEL RECTANGULO');
  Base := LeerRealPositivo('Base (> 0): ');
  Altura := LeerRealPositivo('Altura (> 0): ');
  Area := Base * Altura;
  Perimetro := 2 * (Base + Altura);
  WriteLn;
  WriteLn('Area      = ', FormatFloat('0.00', Area), ' unidades cuadradas');
  WriteLn('Perimetro = ', FormatFloat('0.00', Perimetro), ' unidades');
  Pausa;
end;

procedure CalcularTriangulo;
var
  Base, Altura, Lado1, Lado2, Area, Perimetro: Double;
begin
  Encabezado('AREA Y PERIMETRO DEL TRIANGULO');
  Base := LeerRealPositivo('Base (> 0): ');
  Altura := LeerRealPositivo('Altura (> 0): ');
  Lado1 := LeerRealPositivo('Lado 1 para perimetro (> 0): ');
  Lado2 := LeerRealPositivo('Lado 2 para perimetro (> 0): ');
  Area := Base * Altura / 2;
  Perimetro := Base + Lado1 + Lado2;
  WriteLn;
  WriteLn('Area      = ', FormatFloat('0.00', Area), ' unidades cuadradas');
  WriteLn('Perimetro = ', FormatFloat('0.00', Perimetro), ' unidades');
  Pausa;
end;

procedure CalcularCirculo;
var
  Radio, Area, Circunferencia: Double;
begin
  Encabezado('AREA Y CIRCUNFERENCIA DEL CIRCULO');
  Radio := LeerRealPositivo('Radio (> 0): ');
  Area := Pi * Sqr(Radio);
  Circunferencia := 2 * Pi * Radio;
  WriteLn;
  WriteLn('Area           = ', FormatFloat('0.00', Area), ' unidades cuadradas');
  WriteLn('Circunferencia = ', FormatFloat('0.00', Circunferencia), ' unidades');
  Pausa;
end;

procedure CalcularRombo;
var
  DiagonalMayor, DiagonalMenor, Lado, Area, Perimetro: Double;
begin
  Encabezado('AREA Y PERIMETRO DEL ROMBO');
  DiagonalMayor := LeerRealPositivo('Diagonal mayor (> 0): ');
  DiagonalMenor := LeerRealPositivo('Diagonal menor (> 0): ');
  Lado := LeerRealPositivo('Lado del rombo (> 0): ');
  Area := DiagonalMayor * DiagonalMenor / 2;
  Perimetro := 4 * Lado;
  WriteLn;
  WriteLn('Area      = ', FormatFloat('0.00', Area), ' unidades cuadradas');
  WriteLn('Perimetro = ', FormatFloat('0.00', Perimetro), ' unidades');
  Pausa;
end;

procedure CalcularTrapecio;
var
  BaseMayor, BaseMenor, Altura, Lado1, Lado2, Area, Perimetro: Double;
begin
  Encabezado('AREA Y PERIMETRO DEL TRAPECIO');
  BaseMayor := LeerRealPositivo('Base mayor (> 0): ');
  BaseMenor := LeerRealPositivo('Base menor (> 0): ');
  Altura := LeerRealPositivo('Altura (> 0): ');
  Lado1 := LeerRealPositivo('Lado no paralelo 1 (> 0): ');
  Lado2 := LeerRealPositivo('Lado no paralelo 2 (> 0): ');
  Area := (BaseMayor + BaseMenor) * Altura / 2;
  Perimetro := BaseMayor + BaseMenor + Lado1 + Lado2;
  WriteLn;
  WriteLn('Area      = ', FormatFloat('0.00', Area), ' unidades cuadradas');
  WriteLn('Perimetro = ', FormatFloat('0.00', Perimetro), ' unidades');
  Pausa;
end;

procedure CalcularPoligonoRegular;
var
  NumeroLados: Integer;
  Lado, Perimetro, Apotema, Area: Double;
begin
  Encabezado('AREA DEL POLIGONO REGULAR');
  NumeroLados := LeerEnteroMinimo('Numero de lados (>= 3): ', 3);
  Lado := LeerRealPositivo('Longitud de cada lado (> 0): ');
  Perimetro := NumeroLados * Lado;
  Apotema := Lado / (2 * Tan(Pi / NumeroLados));
  Area := Perimetro * Apotema / 2;
  WriteLn;
  WriteLn('Perimetro = ', FormatFloat('0.00', Perimetro), ' unidades');
  WriteLn('Apotema   = ', FormatFloat('0.00', Apotema), ' unidades');
  WriteLn('Area      = ', FormatFloat('0.00', Area), ' unidades cuadradas');
  Pausa;
end;

procedure MostrarMenu;
begin
  Encabezado('MENU DE FIGURAS GEOMETRICAS');
  WriteLn('1. Cuadrado');
  WriteLn('2. Rectangulo');
  WriteLn('3. Triangulo');
  WriteLn('4. Circulo');
  WriteLn('5. Rombo');
  WriteLn('6. Trapecio');
  WriteLn('7. Poligono regular');
  WriteLn('8. Salir');
  WriteLn;
  Write('Seleccione una opcion: ');
end;

var
  Opcion: Integer;

begin
  repeat
    MostrarMenu;
    ReadLn(Opcion);
    case Opcion of
      1: CalcularCuadrado;
      2: CalcularRectangulo;
      3: CalcularTriangulo;
      4: CalcularCirculo;
      5: CalcularRombo;
      6: CalcularTrapecio;
      7: CalcularPoligonoRegular;
      8:
        begin
          WriteLn;
          WriteLn('Gracias.');
        end;
    else
      WriteLn('Opcion no valida.');
      Pausa;
    end;
  until Opcion = 8;
end.
