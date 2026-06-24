{ ==================================================================
  INTEGRANTES - Grupo 4A - Irrigacion - U.A. Chapingo:
    - ELIAS DOMINGUEZ RUBEN
    - BISTRAIN BORRAZ ANGEL GABRIEL
    - CRUZ SIBAJA GIBRAN FRANCISCO
    - TORRES VALENCIA MARIO ALBERTO
  ================================================================== }
program ProgramasChapingo;
{ App VCL (RAD Studio / Delphi 12) - Los 42 programas del Grupo 4A.
  Universidad Autonoma Chapingo - Departamento de Irrigacion.
  Abrir ProgramasChapingo.dproj en RAD Studio y compilar con F9. }

uses
  Vcl.Forms,
  uPrincipal in 'uPrincipal.pas' {FormPrincipal},
  uLogica in 'uLogica.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Programas 4A - Chapingo';
  Application.CreateForm(TFormPrincipal, FormPrincipal);
  Application.Run;
end.
