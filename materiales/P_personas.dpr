program P_personas;

uses
  Forms,
  U_personas in 'U_personas.pas' {F_Personas};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TF_Personas, F_Personas);
  Application.Run;
end.
