program CustomDrawDemo;

uses
  Forms,
  Main in 'Main.pas' {MainForm},
  dxDemoUtils in '..\DemoUtils\dxDemoUtils.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
