{ ==================================================================
  INTEGRANTES - Grupo 4A - Irrigacion - U.A. Chapingo:
    - ELIAS DOMINGUEZ RUBEN
    - BISTRAIN BORRAZ ANGEL GABRIEL
    - CRUZ SIBAJA GIBRAN FRANCISCO
    - TORRES VALENCIA MARIO ALBERTO
  ================================================================== }
unit U_Comun;

{ ------------------------------------------------------------------
  U_Comun.pas - Helpers de conversion estilo profesor (Val / Str).
  Usados por todos los formularios del sistema (como las "Librerias"
  del profe). Sin formularios: solo funciones y constantes.
  ------------------------------------------------------------------ }

interface

uses
  SysUtils;

const
  MAXP = 75;   { tope de datos, estilo profe Array[1..75] }

type
  TArregloReal = array[1..MAXP] of real;
  TArregloByte = array[1..MAXP] of byte;

var
  Codigo_de_error : integer;

function Cadena_a_byte(cadena: string): byte;
function Cadena_a_entero(cadena: string): integer;
function Cadena_a_real(cadena: string): real;
function Byte_a_Cadena(Numero, campo: byte): string;
function Entero_a_Cadena(Numero: integer; campo: byte): string;
function real_a_Cadena(Numero: real; campo, decimales: byte): string;

implementation

function Cadena_a_byte(cadena: string): byte;
var Numero_byte: byte;
begin
  if cadena <> '' then Val(cadena, Numero_byte, Codigo_de_error)
  else Numero_byte := 0;
  if Codigo_de_error <> 0 then Numero_byte := 0;
  Cadena_a_byte := Numero_byte;
end;

function Cadena_a_entero(cadena: string): integer;
var Numero_int: integer;
begin
  if cadena <> '' then Val(cadena, Numero_int, Codigo_de_error)
  else Numero_int := 0;
  if Codigo_de_error <> 0 then Numero_int := 0;
  Cadena_a_entero := Numero_int;
end;

function Cadena_a_real(cadena: string): real;
var Numero_real: real;
begin
  if cadena <> '' then Val(cadena, Numero_real, Codigo_de_error)
  else Numero_real := 0;
  if Codigo_de_error <> 0 then Numero_real := 0;
  Cadena_a_real := Numero_real;
end;

function Byte_a_Cadena(Numero, campo: byte): string;
var cadena: string;
begin
  Str(Numero:campo, cadena);
  Byte_a_Cadena := cadena;
end;

function Entero_a_Cadena(Numero: integer; campo: byte): string;
var cadena: string;
begin
  Str(Numero:campo, cadena);
  Entero_a_Cadena := cadena;
end;

function real_a_Cadena(Numero: real; campo, decimales: byte): string;
var cadena: string;
begin
  Str(Numero:campo:decimales, cadena);
  real_a_Cadena := cadena;
end;

end.
