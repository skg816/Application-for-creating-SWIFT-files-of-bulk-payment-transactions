program properties;

{%File '..\DemoUtils\dxDemo.inc'}

uses
  Forms,
  main in 'main.pas' {fmWizardForm},
  MaskEd in 'MaskEd.pas' {dxEditMaskForm},
  preview in 'preview.pas' {fmPreview},
  popup in 'popup.pas' {fmPopupTree},
  dxDemoUtils in '..\DemoUtils\dxDemoUtils.pas',
  dxEditUtils in '..\DemoUtils\dxEditUtils.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Standalone Editors [Original Properties]';
  Application.CreateForm(TfmWizardForm, fmWizardForm);
  Application.CreateForm(TdxEditMaskForm, dxEditMaskForm);
  Application.CreateForm(TfmPreview, fmPreview);
  Application.CreateForm(TfmPopupTree, fmPopupTree);
  Application.Run;
end.
