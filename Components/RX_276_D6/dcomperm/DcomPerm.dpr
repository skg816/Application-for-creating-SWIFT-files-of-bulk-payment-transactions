program DcomPerm;

uses
  Forms,
  fmuMain in 'FMU\fmuMain.pas' {fmMain},
  BDcomPrm in 'Units\BDcomPrm.pas',
  fmuAppName in 'FMU\fmuAppName.pas' {fmAppName};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfmMain, fmMain);
  Application.Run;
end.
