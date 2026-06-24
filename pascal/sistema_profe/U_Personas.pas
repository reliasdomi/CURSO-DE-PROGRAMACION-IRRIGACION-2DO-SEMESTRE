{ ==================================================================
  INTEGRANTES - Grupo 4A - Irrigacion - U.A. Chapingo:
    - ELIAS DOMINGUEZ RUBEN
    - BISTRAIN BORRAZ ANGEL GABRIEL
    - CRUZ SIBAJA GIBRAN FRANCISCO
    - TORRES VALENCIA MARIO ALBERTO
  ================================================================== }
unit U_Personas;

{ ------------------------------------------------------------------
  U_Personas.pas - Datos poblacionales (programas 16-35).

  Captura un GRUPO de personas en arreglos paralelos [1..75]
  (Nombre, Sexo, Edad, Estatura), estilo profesor, y resuelve las
  20 consultas demograficas: conteos por sexo, mayores/menores de
  edad, edad y estatura mayor/menor por grupo y por sexo, y promedios.
  ------------------------------------------------------------------ }

{$mode objfpc}{$H+}

interface

procedure Menu_personas;

implementation

uses U_Comun, Crt;

var
  Nombre   : array[1..MAXP] of string;
  Sexo     : array[1..MAXP] of char;
  Edad     : array[1..MAXP] of byte;
  Estatura : array[1..MAXP] of real;
  N        : integer;
  Capturado: boolean = False;

{ ====================== captura ====================== }

procedure Captura_grupo;
var i: integer;
begin
  WriteLn; WriteLn('=== CAPTURA DEL GRUPO DE PERSONAS ===');
  N := Lee_entero_rango('Cuantas personas (2 a ' + Entero_a_Cadena(MAXP, 1) +
       '): ', 2, MAXP);
  for i := 1 to N do
  begin
    WriteLn('--- Persona ', i, ' ---');
    Write('  Nombre: '); ReadLn(Nombre[i]);
    Sexo[i]     := Lee_sexo('  Sexo (H/M): ');
    Edad[i]     := Lee_entero_rango('  Edad (0 a 130): ', 0, 130);
    Estatura[i] := Lee_real_positivo('  Estatura en metros (> 0): ');
  end;
  Capturado := True;
end;

{ ====================== helpers ====================== }

function Cuenta_por_sexo(s: char): integer;
var i, c: integer;
begin
  c := 0;
  for i := 1 to N do if Sexo[i] = s then Inc(c);
  Cuenta_por_sexo := c;
end;

{ filtro: 'T' todos, 'H' hombres, 'M' mujeres ; mayores: True >=18, False <18 }
function Cuenta_edad(filtro: char; mayores: boolean): integer;
var i, c: integer; pasa: boolean;
begin
  c := 0;
  for i := 1 to N do
  begin
    pasa := (filtro = 'T') or (Sexo[i] = filtro);
    if pasa then
      if mayores then begin if Edad[i] >= 18 then Inc(c); end
                 else begin if Edad[i] <  18 then Inc(c); end;
  end;
  Cuenta_edad := c;
end;

{ campo: 'E' edad, 'S' estatura ; filtro: 'T'/'H'/'M' ;
  metrica: 'm' menor, 'M' mayor, 'p' promedio. Devuelve False si no hay datos. }
function Agrega(campo, filtro, metrica: char; out valor: real): boolean;
var i, c: integer; v, acum: real; primero: boolean;
begin
  c := 0; acum := 0; valor := 0; primero := True;
  for i := 1 to N do
    if (filtro = 'T') or (Sexo[i] = filtro) then
    begin
      if campo = 'E' then v := Edad[i] else v := Estatura[i];
      Inc(c); acum := acum + v;
      if primero then begin valor := v; primero := False; end
      else if (metrica = 'm') and (v < valor) then valor := v
      else if (metrica = 'M') and (v > valor) then valor := v;
    end;
  if c = 0 then Exit(False);
  if metrica = 'p' then valor := acum / c;
  Agrega := True;
end;

procedure Resultado(const Titulo, Texto: string);
begin
  Muestra_panel(Titulo, [Texto]);
end;

procedure Resultado_minmax(const Titulo, campoNom: string;
                           campo, filtro: char; decimales: byte);
var vmin, vmax: real; hay: boolean;
begin
  hay := Agrega(campo, filtro, 'm', vmin);
  Agrega(campo, filtro, 'M', vmax);
  if hay then
    Muestra_panel(Titulo,
      [campoNom + ' menor: ' + real_a_Cadena(vmin, 1, decimales),
       campoNom + ' mayor: ' + real_a_Cadena(vmax, 1, decimales)])
  else
    Resultado(Titulo, 'No hay personas con ese filtro.');
end;

procedure Resultado_promedio(const Titulo, campoNom: string;
                             campo, filtro: char; decimales: byte);
var v: real;
begin
  if Agrega(campo, filtro, 'p', v) then
    Resultado(Titulo, 'Promedio de ' + campoNom + ': ' +
              real_a_Cadena(v, 1, decimales))
  else
    Resultado(Titulo, 'No hay personas con ese filtro.');
end;

{ ====================== submenu ====================== }

procedure Menu_personas;
var op: integer;
begin
  if not Capturado then Captura_grupo;
  repeat
    ClrScr;
    WriteLn('============ PERSONAS / POBLACIONALES (16-35) ============');
    WriteLn('  Grupo capturado: ', N, ' personas');
    WriteLn('  16. Hombres en el grupo        26. Hombres mayores de edad');
    WriteLn('  17. Mujeres en el grupo        27. Hombres menores de edad');
    WriteLn('  18. Edad mayor/menor grupo      28. Estatura may/men mujeres');
    WriteLn('  19. Estatura mayor/menor grupo  29. Estatura may/men hombres');
    WriteLn('  20. Edad may/men mujeres        30. Promedio edad grupo');
    WriteLn('  21. Edad may/men hombres        31. Promedio estatura grupo');
    WriteLn('  22. Mayores de edad (>=18)       32. Promedio edad mujeres');
    WriteLn('  23. Menores de edad (<18)        33. Promedio edad hombres');
    WriteLn('  24. Mujeres mayores de edad      34. Promedio estatura mujeres');
    WriteLn('  25. Mujeres menores de edad      35. Promedio estatura hombres');
    WriteLn('  98. Capturar otro grupo         0. Volver al menu principal');
    WriteLn('=========================================================');
    op := Lee_entero_rango('Opcion: ', 0, 98);
    case op of
      16: Resultado('HOMBRES EN EL GRUPO', 'Hombres: ' + Entero_a_Cadena(Cuenta_por_sexo('H'), 1));
      17: Resultado('MUJERES EN EL GRUPO', 'Mujeres: ' + Entero_a_Cadena(Cuenta_por_sexo('M'), 1));
      18: Resultado_minmax('EDAD MAYOR/MENOR (GRUPO)', 'Edad', 'E', 'T', 0);
      19: Resultado_minmax('ESTATURA MAYOR/MENOR (GRUPO)', 'Estatura', 'S', 'T', 2);
      20: Resultado_minmax('EDAD MAYOR/MENOR (MUJERES)', 'Edad', 'E', 'M', 0);
      21: Resultado_minmax('EDAD MAYOR/MENOR (HOMBRES)', 'Edad', 'E', 'H', 0);
      22: Resultado('MAYORES DE EDAD', 'Mayores de edad: ' + Entero_a_Cadena(Cuenta_edad('T', True), 1));
      23: Resultado('MENORES DE EDAD', 'Menores de edad: ' + Entero_a_Cadena(Cuenta_edad('T', False), 1));
      24: Resultado('MUJERES MAYORES DE EDAD', 'Mujeres mayores: ' + Entero_a_Cadena(Cuenta_edad('M', True), 1));
      25: Resultado('MUJERES MENORES DE EDAD', 'Mujeres menores: ' + Entero_a_Cadena(Cuenta_edad('M', False), 1));
      26: Resultado('HOMBRES MAYORES DE EDAD', 'Hombres mayores: ' + Entero_a_Cadena(Cuenta_edad('H', True), 1));
      27: Resultado('HOMBRES MENORES DE EDAD', 'Hombres menores: ' + Entero_a_Cadena(Cuenta_edad('H', False), 1));
      28: Resultado_minmax('ESTATURA MAYOR/MENOR (MUJERES)', 'Estatura', 'S', 'M', 2);
      29: Resultado_minmax('ESTATURA MAYOR/MENOR (HOMBRES)', 'Estatura', 'S', 'H', 2);
      30: Resultado_promedio('PROMEDIO EDAD (GRUPO)', 'edad', 'E', 'T', 2);
      31: Resultado_promedio('PROMEDIO ESTATURA (GRUPO)', 'estatura', 'S', 'T', 2);
      32: Resultado_promedio('PROMEDIO EDAD (MUJERES)', 'edad', 'E', 'M', 2);
      33: Resultado_promedio('PROMEDIO EDAD (HOMBRES)', 'edad', 'E', 'H', 2);
      34: Resultado_promedio('PROMEDIO ESTATURA (MUJERES)', 'estatura', 'S', 'M', 2);
      35: Resultado_promedio('PROMEDIO ESTATURA (HOMBRES)', 'estatura', 'S', 'H', 2);
      98: Captura_grupo;
    end;
  until op = 0;
end;

end.
