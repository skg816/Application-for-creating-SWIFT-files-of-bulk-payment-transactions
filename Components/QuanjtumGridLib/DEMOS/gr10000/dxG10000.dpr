program dxG10000;

uses
  Forms,
  main in 'main.pas' {fmMain},
  splash in 'splash.pas' {fmSplash},
  dxGridMenus in '..\DemoUtils\dxGridMenus.pas';

{$R *.RES}

begin
  fmSplash := TfmSplash.Create(nil);
  try
    fmSplash.Show;
    fmSplash.Update;
    Application.CreateForm(TfmMain, fmMain);
  finally
    fmSplash.Free;
    fmSplash := nil;
  end;
  Application.Run;
end.
