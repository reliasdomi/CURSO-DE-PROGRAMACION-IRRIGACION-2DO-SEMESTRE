unit U_Miscelaneos;

{ ------------------------------------------------------------------
  U_Miscelaneos.pas - Misceláneos (programas 7-8).
    7 Numero par o impar
    8 Formula cuadratica (a x^2 + b x + c = 0)
  VARIANTE UNA VENTANA: entrada y resultados dentro de la ventana grafica.
  ------------------------------------------------------------------ }

{$mode objfpc}{$H+}

interface

procedure Op_par_impar;
procedure Op_cuadratica;

implementation

uses U_Comun, Math;

procedure Op_par_impar;
var n: integer; texto: string;
begin
  Abre_ventana('PAR O IMPAR');
  n := Lee_entero('Numero entero: ');
  if n mod 2 = 0 then texto := 'El numero ' + Entero_a_Cadena(n, 1) + ' es PAR'
                 else texto := 'El numero ' + Entero_a_Cadena(n, 1) + ' es IMPAR';
  Muestra_panel('PAR O IMPAR', [texto]);
end;

procedure Op_cuadratica;
var a, b, c, disc, x1, x2, re, im: real;
begin
  Abre_ventana('FORMULA CUADRATICA');
  repeat
    a := Lee_real('Coeficiente a (distinto de 0): ');
    if a = 0 then Aviso('a no puede ser 0 (no seria cuadratica).');
  until a <> 0;
  b := Lee_real('Coeficiente b: ');
  c := Lee_real('Coeficiente c: ');
  disc := b * b - 4 * a * c;
  if disc > 0 then
  begin
    x1 := (-b + Sqrt(disc)) / (2 * a);
    x2 := (-b - Sqrt(disc)) / (2 * a);
    Muestra_panel('CUADRATICA - DOS RAICES REALES',
      ['Discriminante = ' + real_a_Cadena(disc, 1, 2),
       'x1 = ' + real_a_Cadena(x1, 1, 4),
       'x2 = ' + real_a_Cadena(x2, 1, 4)]);
  end
  else if disc = 0 then
  begin
    x1 := -b / (2 * a);
    Muestra_panel('CUADRATICA - RAIZ DOBLE',
      ['Discriminante = 0', 'x1 = x2 = ' + real_a_Cadena(x1, 1, 4)]);
  end
  else
  begin
    re := -b / (2 * a);
    im := Sqrt(-disc) / (2 * a);
    Muestra_panel('CUADRATICA - RAICES COMPLEJAS',
      ['Discriminante = ' + real_a_Cadena(disc, 1, 2),
       'x1 = ' + real_a_Cadena(re, 1, 4) + ' + ' + real_a_Cadena(im, 1, 4) + 'i',
       'x2 = ' + real_a_Cadena(re, 1, 4) + ' - ' + real_a_Cadena(im, 1, 4) + 'i']);
  end;
end;

end.
