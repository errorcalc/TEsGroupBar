program TEsGroupBarDemo;

{$R *.dres}

uses
  Forms,
  uMain in 'uMain.pas' {MainForm},
  Es.Vcl.GroupBar in '..\Source\Es.Vcl.GroupBar.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
