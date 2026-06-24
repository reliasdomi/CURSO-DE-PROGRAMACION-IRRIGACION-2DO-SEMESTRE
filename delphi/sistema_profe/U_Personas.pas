{ ==================================================================
  INTEGRANTES - Grupo 4A - Irrigacion - U.A. Chapingo:
    - ELIAS DOMINGUEZ RUBEN
    - BISTRAIN BORRAZ ANGEL GABRIEL
    - CRUZ SIBAJA GIBRAN FRANCISCO
    - TORRES VALENCIA MARIO ALBERTO
  ================================================================== }
unit U_Personas;

{ Datos poblacionales (programas 16-35). Replica el formulario U_personas
  del profesor: rejillas paralelas (i, Nombre, Edad, Estatura, Sexo) en
  arreglos [1..75]. Un ComboBox elige cual de las 20 consultas resolver. }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, U_Comun;

type
  TF_Personas = class(TForm)
    P_Cabecera: TPanel;
    L_Titulo: TLabel;
    L_NDatos: TLabel;
    E_N: TEdit;
    B_Generar: TButton;
    G_i: TStringGrid;
    G_Nombre: TStringGrid;
    G_Edad: TStringGrid;
    G_Estatura: TStringGrid;
    G_Sexo: TStringGrid;
    L_Consulta: TLabel;
    CB_Consulta: TComboBox;
    B_Consultar: TButton;
    B_Limpiar: TButton;
    B_Salir: TButton;
    L_Resultado: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure B_GenerarClick(Sender: TObject);
    procedure B_ConsultarClick(Sender: TObject);
    procedure B_LimpiarClick(Sender: TObject);
    procedure B_SalirClick(Sender: TObject);
    procedure E_NKeyPress(Sender: TObject; var Key: Char);
  private
    N: integer;
    Nombre: array[1..MAXP] of string;
    Sexo: array[1..MAXP] of char;
    Edad: array[1..MAXP] of byte;
    Estatura: array[1..MAXP] of real;
    procedure Genera_filas;
    procedure Lee_datos;
    function Cuenta_sexo(s: char): integer;
    function Cuenta_edad(filtro: char; mayores: boolean): integer;
    function Agrega(campo, filtro, metrica: char; var valor: real): boolean;
  public
  end;

var
  F_Personas: TF_Personas;

implementation

{$R *.dfm}

procedure TF_Personas.E_NKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9', #8]) then Key := #0;
end;

procedure TF_Personas.Genera_filas;
var i: integer;
begin
  N := Cadena_a_entero(E_N.Text);
  if N < 2 then N := 2;
  if N > MAXP then N := MAXP;
  G_i.RowCount := N + 1;
  G_Nombre.RowCount := N + 1;
  G_Edad.RowCount := N + 1;
  G_Estatura.RowCount := N + 1;
  G_Sexo.RowCount := N + 1;
  G_i.Cells[0, 0] := '  i';
  G_Nombre.Cells[0, 0] := '  NOMBRE';
  G_Edad.Cells[0, 0] := '  Edad';
  G_Estatura.Cells[0, 0] := ' Estatura';
  G_Sexo.Cells[0, 0] := ' Sexo';
  for i := 1 to N do G_i.Cells[0, i] := Entero_a_Cadena(i, 3);
end;

procedure TF_Personas.B_GenerarClick(Sender: TObject);
begin
  Genera_filas;
end;

procedure TF_Personas.Lee_datos;
var i: integer; s: string;
begin
  for i := 1 to N do
  begin
    Nombre[i] := G_Nombre.Cells[0, i];
    Edad[i] := Cadena_a_byte(G_Edad.Cells[0, i]);
    Estatura[i] := Cadena_a_real(G_Estatura.Cells[0, i]);
    s := UpperCase(Trim(G_Sexo.Cells[0, i]));
    if s = 'M' then Sexo[i] := 'M' else Sexo[i] := 'H';
  end;
end;

function TF_Personas.Cuenta_sexo(s: char): integer;
var i, c: integer;
begin
  c := 0;
  for i := 1 to N do if Sexo[i] = s then Inc(c);
  Cuenta_sexo := c;
end;

function TF_Personas.Cuenta_edad(filtro: char; mayores: boolean): integer;
var i, c: integer; pasa: boolean;
begin
  c := 0;
  for i := 1 to N do
  begin
    pasa := (filtro = 'T') or (Sexo[i] = filtro);
    if pasa then
      if mayores then begin if Edad[i] >= 18 then Inc(c); end
                 else begin if Edad[i] < 18 then Inc(c); end;
  end;
  Cuenta_edad := c;
end;

function TF_Personas.Agrega(campo, filtro, metrica: char; var valor: real): boolean;
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
  if c = 0 then begin Agrega := False; Exit; end;
  if metrica = 'p' then valor := acum / c;
  Agrega := True;
end;

procedure TF_Personas.B_ConsultarClick(Sender: TObject);
var
  prog: integer;
  vmin, vmax, v: real;
  hay: boolean;
begin
  if E_N.Text <> '' then N := Cadena_a_entero(E_N.Text);
  if N < 2 then Exit;
  Lee_datos;
  prog := 16 + CB_Consulta.ItemIndex;
  case prog of
    16: L_Resultado.Caption := 'Hombres en el grupo: ' + Entero_a_Cadena(Cuenta_sexo('H'), 1);
    17: L_Resultado.Caption := 'Mujeres en el grupo: ' + Entero_a_Cadena(Cuenta_sexo('M'), 1);
    18: begin Agrega('E', 'T', 'm', vmin); Agrega('E', 'T', 'M', vmax);
          L_Resultado.Caption := 'Edad menor: ' + real_a_Cadena(vmin, 1, 0) +
            '   Edad mayor: ' + real_a_Cadena(vmax, 1, 0); end;
    19: begin Agrega('S', 'T', 'm', vmin); Agrega('S', 'T', 'M', vmax);
          L_Resultado.Caption := 'Estatura menor: ' + real_a_Cadena(vmin, 1, 2) +
            '   mayor: ' + real_a_Cadena(vmax, 1, 2); end;
    20: begin hay := Agrega('E', 'M', 'm', vmin); Agrega('E', 'M', 'M', vmax);
          if hay then L_Resultado.Caption := 'Mujeres - edad menor: ' +
            real_a_Cadena(vmin, 1, 0) + '   mayor: ' + real_a_Cadena(vmax, 1, 0)
          else L_Resultado.Caption := 'No hay mujeres.'; end;
    21: begin hay := Agrega('E', 'H', 'm', vmin); Agrega('E', 'H', 'M', vmax);
          if hay then L_Resultado.Caption := 'Hombres - edad menor: ' +
            real_a_Cadena(vmin, 1, 0) + '   mayor: ' + real_a_Cadena(vmax, 1, 0)
          else L_Resultado.Caption := 'No hay hombres.'; end;
    22: L_Resultado.Caption := 'Mayores de edad (>=18): ' + Entero_a_Cadena(Cuenta_edad('T', True), 1);
    23: L_Resultado.Caption := 'Menores de edad (<18): ' + Entero_a_Cadena(Cuenta_edad('T', False), 1);
    24: L_Resultado.Caption := 'Mujeres mayores de edad: ' + Entero_a_Cadena(Cuenta_edad('M', True), 1);
    25: L_Resultado.Caption := 'Mujeres menores de edad: ' + Entero_a_Cadena(Cuenta_edad('M', False), 1);
    26: L_Resultado.Caption := 'Hombres mayores de edad: ' + Entero_a_Cadena(Cuenta_edad('H', True), 1);
    27: L_Resultado.Caption := 'Hombres menores de edad: ' + Entero_a_Cadena(Cuenta_edad('H', False), 1);
    28: begin hay := Agrega('S', 'M', 'm', vmin); Agrega('S', 'M', 'M', vmax);
          if hay then L_Resultado.Caption := 'Mujeres - estatura menor: ' +
            real_a_Cadena(vmin, 1, 2) + '   mayor: ' + real_a_Cadena(vmax, 1, 2)
          else L_Resultado.Caption := 'No hay mujeres.'; end;
    29: begin hay := Agrega('S', 'H', 'm', vmin); Agrega('S', 'H', 'M', vmax);
          if hay then L_Resultado.Caption := 'Hombres - estatura menor: ' +
            real_a_Cadena(vmin, 1, 2) + '   mayor: ' + real_a_Cadena(vmax, 1, 2)
          else L_Resultado.Caption := 'No hay hombres.'; end;
    30: begin Agrega('E', 'T', 'p', v); L_Resultado.Caption := 'Promedio edad (grupo): ' + real_a_Cadena(v, 1, 2); end;
    31: begin Agrega('S', 'T', 'p', v); L_Resultado.Caption := 'Promedio estatura (grupo): ' + real_a_Cadena(v, 1, 2); end;
    32: begin if Agrega('E', 'M', 'p', v) then L_Resultado.Caption := 'Promedio edad (mujeres): ' + real_a_Cadena(v, 1, 2) else L_Resultado.Caption := 'No hay mujeres.'; end;
    33: begin if Agrega('E', 'H', 'p', v) then L_Resultado.Caption := 'Promedio edad (hombres): ' + real_a_Cadena(v, 1, 2) else L_Resultado.Caption := 'No hay hombres.'; end;
    34: begin if Agrega('S', 'M', 'p', v) then L_Resultado.Caption := 'Promedio estatura (mujeres): ' + real_a_Cadena(v, 1, 2) else L_Resultado.Caption := 'No hay mujeres.'; end;
    35: begin if Agrega('S', 'H', 'p', v) then L_Resultado.Caption := 'Promedio estatura (hombres): ' + real_a_Cadena(v, 1, 2) else L_Resultado.Caption := 'No hay hombres.'; end;
  end;
end;

procedure TF_Personas.B_LimpiarClick(Sender: TObject);
var i: integer;
begin
  for i := 1 to G_Nombre.RowCount - 1 do
  begin
    G_Nombre.Cells[0, i] := '';
    G_Edad.Cells[0, i] := '';
    G_Estatura.Cells[0, i] := '';
    G_Sexo.Cells[0, i] := '';
  end;
  L_Resultado.Caption := '';
end;

procedure TF_Personas.B_SalirClick(Sender: TObject);
begin
  Close;
end;

procedure TF_Personas.FormCreate(Sender: TObject);
begin
  CB_Consulta.ItemIndex := 0;
  E_N.Text := '5';
  Genera_filas;
  L_Resultado.Caption := '';
end;

end.
