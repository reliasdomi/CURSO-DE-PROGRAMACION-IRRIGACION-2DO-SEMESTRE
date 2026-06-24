program MenuPrincipal;
{ MENU PRINCIPAL - Paquete PASCAL (modo grafico real) - Grupo 4A
  Universidad Autonoma Chapingo - Departamento de Irrigacion.

  Equivalente en Free Pascal del paquete BASIC (qb64): los 42 programas
  organizados en 4 submenus, pero con SALIDA GRAFICA usando la unit Graph
  (backend ptcgraph) en vez de ASCII en consola.

  Autores: Bistrain Borraz Angel Gabriel; Cruz Sibaja Gibran Francisco;
           Elias Dominguez Ruben; Ortiz Ugarte Jonatan; Torres Valencia Mario Alberto.

  Compilar:  fpc -O2 -FEbin MenuPrincipal.pas
  Ejecutar:  bin/MenuPrincipal }

{$mode objfpc}{$H+}

uses
  SysUtils, uComun, uFiguras, uEstadistica, uMatrices, uMiscelaneos;

procedure Encabezado(const Titulo: string);
begin
  WriteLn;
  WriteLn('==================================================');
  WriteLn('  UNIVERSIDAD AUTONOMA CHAPINGO - IRRIGACION');
  WriteLn('  ', Titulo);
  WriteLn('==================================================');
end;

procedure MenuFiguras;
var op: string;
begin
  repeat
    Encabezado('FIGURAS GEOMETRICAS');
    WriteLn('  1. Cuadrado          5. Rombo');
    WriteLn('  2. Rectangulo        6. Trapecio');
    WriteLn('  3. Triangulo         7. Poligono regular');
    WriteLn('  4. Circulo           0. Volver');
    Write('  Opcion: ');
    ReadLn(op);
    case Trim(op) of
      '1': OpCuadrado;   '2': OpRectangulo; '3': OpTriangulo;
      '4': OpCirculo;    '5': OpRombo;      '6': OpTrapecio;
      '7': OpPoligono;   '0': ;
    else WriteLn('Opcion no valida.');
    end;
  until Trim(op) = '0';
end;

procedure MenuEstadistica;
var op: string;
begin
  repeat
    Encabezado('ESTADISTICA');
    WriteLn('  1. Media aritmetica');
    WriteLn('  2. Mediana');
    WriteLn('  3. Moda');
    WriteLn('  4. Ordenar de menor a mayor');
    WriteLn('  5. Ordenar de mayor a menor');
    WriteLn('  6. Estadistica de grupo (16-35)');
    WriteLn('  7. Regresion lineal simple');
    WriteLn('  8. Varianza y desviacion estandar');
    WriteLn('  0. Volver');
    Write('  Opcion: ');
    ReadLn(op);
    case Trim(op) of
      '1': OpMedia;     '2': OpMediana;   '3': OpModa;
      '4': OpOrdenAsc;  '5': OpOrdenDesc; '6': MenuGrupo;
      '7': OpRegresion; '8': OpDesviacion; '0': ;
    else WriteLn('Opcion no valida.');
    end;
  until Trim(op) = '0';
end;

procedure MenuMatrices;
var op: string;
begin
  repeat
    Encabezado('MATRICES');
    WriteLn('  1. Suma de matrices');
    WriteLn('  2. Resta de matrices');
    WriteLn('  3. Transpuesta');
    WriteLn('  4. Inversa 2x2');
    WriteLn('  0. Volver');
    Write('  Opcion: ');
    ReadLn(op);
    case Trim(op) of
      '1': OpSuma; '2': OpResta; '3': OpTranspuesta; '4': OpInversa; '0': ;
    else WriteLn('Opcion no valida.');
    end;
  until Trim(op) = '0';
end;

procedure MenuMiscelaneos;
var op: string;
begin
  repeat
    Encabezado('MISCELANEOS');
    WriteLn('  1. Par o impar');
    WriteLn('  2. Ecuacion cuadratica');
    WriteLn('  3. Numero mayor');
    WriteLn('  4. Numero menor');
    WriteLn('  0. Volver');
    Write('  Opcion: ');
    ReadLn(op);
    case Trim(op) of
      '1': OpParImpar; '2': OpCuadratica; '3': OpMayor; '4': OpMenor; '0': ;
    else WriteLn('Opcion no valida.');
    end;
  until Trim(op) = '0';
end;

var
  op: string;
begin
  repeat
    Encabezado('MENU PRINCIPAL - PROGRAMAS 4A');
    WriteLn('  1. Figuras geometricas');
    WriteLn('  2. Estadistica');
    WriteLn('  3. Matrices');
    WriteLn('  4. Miscelaneos');
    WriteLn('  0. Salir');
    Write('  Seleccione una opcion: ');
    ReadLn(op);
    case Trim(op) of
      '1': MenuFiguras;
      '2': MenuEstadistica;
      '3': MenuMatrices;
      '4': MenuMiscelaneos;
      '0': WriteLn('Gracias. Hasta luego.');
    else WriteLn('Opcion no valida.');
    end;
  until Trim(op) = '0';
  CerrarVentana;
end.
