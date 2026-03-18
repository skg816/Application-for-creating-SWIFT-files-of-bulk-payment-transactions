program ext_inpl;

uses
  Forms,
  main in 'main.pas' {fmMain},
  preview in 'preview.pas' {fmPreview};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfmMain, fmMain);
  Application.Run;
end.
