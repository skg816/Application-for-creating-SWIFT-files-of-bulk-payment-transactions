program SummaryDemo;

uses
  Forms,
  main in 'main.pas' {MainForm},
  dxGridMenus in '..\DemoUtils\dxGridMenus.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
