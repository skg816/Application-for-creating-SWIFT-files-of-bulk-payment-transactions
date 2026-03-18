program calcdemo;

uses
  Forms,
  main in 'main.pas' {fmMain};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Developer Express Calculator demo';
  Application.CreateForm(TfmMain, fmMain);
  Application.Run;
end.
