program ExLookup;

uses
  Forms,
  main in 'main.pas' {fmMain},
  lookup in 'lookup.pas' {fmPopup};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfmMain, fmMain);
  Application.CreateForm(TfmPopup, fmPopup);
  Application.Run;
end.
