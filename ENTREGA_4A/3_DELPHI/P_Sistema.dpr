program P_Sistema;

{ ------------------------------------------------------------------
  SISTEMA DE PROGRAMAS 4A  (Delphi VCL, estilo profesor)
  Universidad Autonoma Chapingo - Departamento de Irrigacion.

  Menu principal (U_System) con TMainMenu que abre un formulario por
  categoria. Los 42 programas del curso. Compilar con RAD Studio (F9).
  ------------------------------------------------------------------ }

uses
  Forms,
  U_Comun in 'U_Comun.pas',
  U_System in 'U_System.pas' {F_System},
  U_Figuras in 'U_Figuras.pas' {F_Figuras},
  U_Estadistica in 'U_Estadistica.pas' {F_Estadistica},
  U_Personas in 'U_Personas.pas' {F_Personas},
  U_Matrices in 'U_Matrices.pas' {F_Matrices},
  U_Miscelaneos in 'U_Miscelaneos.pas' {F_Miscelaneos};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Sistema de Programas 4A - Irrigacion';
  Application.CreateForm(TF_System, F_System);
  Application.CreateForm(TF_Figuras, F_Figuras);
  Application.CreateForm(TF_Estadistica, F_Estadistica);
  Application.CreateForm(TF_Personas, F_Personas);
  Application.CreateForm(TF_Matrices, F_Matrices);
  Application.CreateForm(TF_Miscelaneos, F_Miscelaneos);
  Application.Run;
end.
