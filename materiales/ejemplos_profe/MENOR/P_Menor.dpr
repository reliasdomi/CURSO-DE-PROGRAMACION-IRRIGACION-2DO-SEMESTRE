program P_Menor;

uses
  Forms,
  U_Menor in 'U_Menor.pas' {F_EStadisticas};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TF_EStadisticas, F_EStadisticas);
  Application.Run;
end.
