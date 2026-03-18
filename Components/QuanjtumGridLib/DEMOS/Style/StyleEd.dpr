program StyleEd;

uses
  Forms,
  main in 'main.pas' {MainForm},
  fGradient in 'fGradient.pas' {fmGradient},
  fWeb in 'fWeb.pas' {fmWebStyle},
  fReal in 'fReal.pas' {fmRealBlank},
  fFlat in 'fFlat.pas' {fmFlat},
  fStandard in 'fStandard.pas' {fmStandard},
  dxDemoUtils in '..\DemoUtils\dxDemoUtils.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Standalone Editors [Styles and Style Controllers]';
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TfmGradient, fmGradient);
  Application.CreateForm(TfmWebStyle, fmWebStyle);
  Application.CreateForm(TfmRealBlank, fmRealBlank);
  Application.CreateForm(TfmFlat, fmFlat);
  Application.CreateForm(TfmStandard, fmStandard);
  Application.Run;
end.
