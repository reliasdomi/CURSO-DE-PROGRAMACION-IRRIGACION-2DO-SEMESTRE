{ ==================================================================
  INTEGRANTES - Grupo 4A - Irrigacion - U.A. Chapingo:
    - ELIAS DOMINGUEZ RUBEN
    - BISTRAIN BORRAZ ANGEL GABRIEL
    - CRUZ SIBAJA GIBRAN FRANCISCO
    - TORRES VALENCIA MARIO ALBERTO
  ================================================================== }
unit Librerias;

{ ------------------------------------------------------------------
  Librerias.pas  -  RECONSTRUCCION de la unidad del profesor.

  Helpers de cadena que usa el ejemplo (archivos.PAS):
    - existe_punto             : True si la cadena trae un '.'
    - elima_espacios_derechos_de_cadena : recorta los espacios de la derecha

  Reconstruida porque solo quedaba el .dcu de Delphi 7. Compila igual en
  Delphi 12 Athens y Free Pascal 3.2.2.

  'uses Console' porque la version sin parametro de existe_punto lee el
  global 'cadena' que vive en Console (dependencia en un solo sentido:
  Console NO usa Librerias, asi no hay ciclo).
  ------------------------------------------------------------------ }

{$IFDEF FPC}{$MODE DELPHI}{$ENDIF}
{$H+}

interface

uses
  SysUtils,
  Console;

{ archivos.PAS la llama con argumento; archivos.dpr sin el (lee 'cadena').
  Se ofrecen ambas formas para que las dos versiones enlacen. }
function existe_punto(const s: string): Boolean; overload;
function existe_punto: Boolean; overload;

function elima_espacios_derechos_de_cadena(cadena: string): string;

implementation

function existe_punto(const s: string): Boolean;
begin
  Result := Pos('.', s) > 0;
end;

function existe_punto: Boolean;
begin
  Result := Pos('.', cadena) > 0;
end;

{ Cuerpo recuperado de archivos.dpr (lineas 45-52), con guarda para
  cadena vacia (el original indexa cadena[length]=cadena[0] y se cae). }
function elima_espacios_derechos_de_cadena(cadena: string): string;
begin
  while (Length(cadena) > 0) and (cadena[Length(cadena)] = ' ') do
    Delete(cadena, Length(cadena), 1);
  Result := cadena;
end;

end.
