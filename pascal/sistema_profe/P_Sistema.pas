{ ==================================================================
  INTEGRANTES - Grupo 4A - Irrigacion - U.A. Chapingo:
    - ELIAS DOMINGUEZ RUBEN
    - BISTRAIN BORRAZ ANGEL GABRIEL
    - CRUZ SIBAJA GIBRAN FRANCISCO
    - TORRES VALENCIA MARIO ALBERTO
  ================================================================== }
program P_Sistema;

{ ------------------------------------------------------------------
  P_Sistema.pas - SISTEMA DE PROGRAMAS 4A  (Free Pascal, estilo profesor)
  Universidad Autonoma Chapingo - Departamento de Irrigacion.

  Terminal con menus numerados + figuras dibujadas con la unit Graph
  (modo grafico real, paridad con QBASIC). Los 42 programas del curso.

  Compilar:  fpc -O2 -FEbin P_Sistema.pas
  ------------------------------------------------------------------ }

{$mode objfpc}{$H+}

uses
  Crt,
  U_Comun,
  U_Figuras,
  U_Estadistica,
  U_Personas,
  U_Matrices,
  U_Miscelaneos;

procedure Encabezado(const Titulo: string);
begin
  ClrScr;
  WriteLn('===========================================================');
  WriteLn('   UNIVERSIDAD AUTONOMA CHAPINGO - IRRIGACION  -  GRUPO 4A');
  WriteLn('   Integrantes: Elias Dominguez Ruben, Bistrain Borraz Angel Gabriel,');
  WriteLn('                Cruz Sibaja Gibran Francisco, Torres Valencia Mario Alberto');
  WriteLn('   ', Titulo);
  WriteLn('===========================================================');
end;

procedure Menu_figuras;
var op: integer;
begin
  repeat
    Encabezado('FIGURAS GEOMETRICAS');
    WriteLn('  1. Cuadrado');
    WriteLn('  2. Rectangulo');
    WriteLn('  3. Triangulo');
    WriteLn('  4. Circulo');
    WriteLn('  5. Rombo');
    WriteLn('  6. Trapecio');
    WriteLn('  7. Poligono regular');
    WriteLn('  0. Volver');
    WriteLn('-----------------------------------------------------------');
    op := Lee_entero_rango('Opcion: ', 0, 7);
    case op of
      1: Op_cuadrado;
      2: Op_rectangulo;
      3: Op_triangulo;
      4: Op_circulo;
      5: Op_rombo;
      6: Op_trapecio;
      7: Op_poligono;
    end;
  until op = 0;
end;

procedure Menu_estadistica;
var op: integer;
begin
  repeat
    Encabezado('ESTADISTICA');
    WriteLn('  1. Numero mayor');
    WriteLn('  2. Numero menor');
    WriteLn('  3. Media aritmetica');
    WriteLn('  4. Mediana');
    WriteLn('  5. Moda');
    WriteLn('  6. Ordenar de menor a mayor');
    WriteLn('  7. Ordenar de mayor a menor');
    WriteLn('  8. Regresion lineal simple');
    WriteLn('  9. Varianza y desviacion estandar');
    WriteLn('  0. Volver');
    WriteLn('-----------------------------------------------------------');
    op := Lee_entero_rango('Opcion: ', 0, 9);
    case op of
      1: Op_mayor;
      2: Op_menor;
      3: Op_media;
      4: Op_mediana;
      5: Op_moda;
      6: Op_ordenar_asc;
      7: Op_ordenar_desc;
      8: Op_regresion;
      9: Op_varianza;
    end;
  until op = 0;
end;

procedure Menu_matrices;
var op: integer;
begin
  repeat
    Encabezado('MATRICES');
    WriteLn('  1. Suma de matrices');
    WriteLn('  2. Resta de matrices');
    WriteLn('  3. Matriz transpuesta');
    WriteLn('  4. Matriz inversa 2x2');
    WriteLn('  0. Volver');
    WriteLn('-----------------------------------------------------------');
    op := Lee_entero_rango('Opcion: ', 0, 4);
    case op of
      1: Op_suma;
      2: Op_resta;
      3: Op_transpuesta;
      4: Op_inversa;
    end;
  until op = 0;
end;

procedure Menu_miscelaneos;
var op: integer;
begin
  repeat
    Encabezado('MISCELANEOS');
    WriteLn('  1. Numero par o impar');
    WriteLn('  2. Formula cuadratica');
    WriteLn('  0. Volver');
    WriteLn('-----------------------------------------------------------');
    op := Lee_entero_rango('Opcion: ', 0, 2);
    case op of
      1: Op_par_impar;
      2: Op_cuadratica;
    end;
  until op = 0;
end;

var
  op: integer;
begin
  repeat
    Encabezado('MENU PRINCIPAL');
    WriteLn('  1. Figuras geometricas');
    WriteLn('  2. Estadistica');
    WriteLn('  3. Personas / Poblacionales');
    WriteLn('  4. Matrices');
    WriteLn('  5. Miscelaneos');
    WriteLn('  0. Salir');
    WriteLn('-----------------------------------------------------------');
    op := Lee_entero_rango('Opcion: ', 0, 5);
    case op of
      1: Menu_figuras;
      2: Menu_estadistica;
      3: Menu_personas;
      4: Menu_matrices;
      5: Menu_miscelaneos;
    end;
  until op = 0;
  ClrScr;
  WriteLn('Gracias. Programa terminado.');
end.
