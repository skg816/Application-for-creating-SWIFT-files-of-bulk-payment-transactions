program ExGraphic;

uses
  Forms,
  main in 'main.pas' {fmMain};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Developer Express Inc. - ExGraphic Demo.';
  Application.CreateForm(TfmMain, fmMain);
  Application.Run;
end.
