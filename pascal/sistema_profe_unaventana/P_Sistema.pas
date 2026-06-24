program P_Sistema;

{ ------------------------------------------------------------------
  P_Sistema.pas - SISTEMA DE PROGRAMAS 4A
  VARIANTE "UNA SOLA VENTANA" (modo grafico total, Free Pascal).
  Universidad Autonoma Chapingo - Departamento de Irrigacion.

  Todo ocurre dentro de UNA ventana grafica: menus, captura de datos,
  resultados y figuras. No aparece ventana de consola.

  Compilar:  fpc -O2 -FEbin -FUbin P_Sistema.pas
  ------------------------------------------------------------------ }

{$mode objfpc}{$H+}
{$APPTYPE GUI}

uses
  U_Comun,
  U_Figuras,
  U_Estadistica,
  U_Personas,
  U_Matrices,
  U_Miscelaneos;

procedure Menu_figuras;
var op: integer;
begin
  repeat
    op := Pantalla_menu('FIGURAS GEOMETRICAS',
      ['1. Cuadrado',
       '2. Rectangulo',
       '3. Triangulo',
       '4. Circulo',
       '5. Rombo',
       '6. Trapecio',
       '7. Poligono regular',
       '0. Volver'], 0, 7);
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
    op := Pantalla_menu('ESTADISTICA',
      ['1. Numero mayor',
       '2. Numero menor',
       '3. Media aritmetica',
       '4. Mediana',
       '5. Moda',
       '6. Ordenar de menor a mayor',
       '7. Ordenar de mayor a menor',
       '8. Regresion lineal simple',
       '9. Varianza y desviacion estandar',
       '0. Volver'], 0, 9);
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
    op := Pantalla_menu('MATRICES',
      ['1. Suma de matrices',
       '2. Resta de matrices',
       '3. Matriz transpuesta',
       '4. Matriz inversa 2x2',
       '0. Volver'], 0, 4);
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
    op := Pantalla_menu('MISCELANEOS',
      ['1. Numero par o impar',
       '2. Formula cuadratica',
       '0. Volver'], 0, 2);
    case op of
      1: Op_par_impar;
      2: Op_cuadratica;
    end;
  until op = 0;
end;

var
  op: integer;
begin
  Inicia_grafico;
  repeat
    op := Pantalla_menu('MENU PRINCIPAL',
      ['1. Figuras geometricas',
       '2. Estadistica',
       '3. Personas / Poblacionales',
       '4. Matrices',
       '5. Miscelaneos',
       '0. Salir'], 0, 5);
    case op of
      1: Menu_figuras;
      2: Menu_estadistica;
      3: Menu_personas;
      4: Menu_matrices;
      5: Menu_miscelaneos;
    end;
  until op = 0;
  Termina_grafico;
end.
