program WageClientMT;

uses
  Forms,
  unxBase in 'SHARED\unxBase.pas' {fmxBase},
  unxModal in 'SHARED\unxModal.pas' {fmxModal},
  unDM in 'unDM.pas' {DM: TDataModule},
  unMain in 'unMain.pas' {fmMain},
  unInitialize in 'unInitialize.pas',
  unAbout in 'unAbout.pas' {fmAbout},
  unMsgMemo in 'unMsgMemo.pas' {fmMsgMemo},
  unGrid in 'unGrid.pas' {frmGrid: TFrame},
  unGridEditTools in 'unGridEditTools.pas' {fmGridEditTools},
  unGridClmImg in 'unGridClmImg.pas' {fmGridClmImg},
  unGridClmImgEdit in 'unGridClmImgEdit.pas' {fmGridClmImgEdit},
  unLico in 'unLico.pas' {fmLico},
  unTools in 'unTools.pas' {fmTools},
  unSql in 'unSql.pas',
  unLicoOrgEdit in 'unLicoOrgEdit.pas' {fmLicoOrgEdit},
  unPlat in 'unPlat.pas' {fmPlat},
  unPlatEdit in 'unPlatEdit.pas' {fmPlatEdit},
  unNachEdit in 'unNachEdit.pas' {fmNachEdit},
  unSetAmount in 'unSetAmount.pas' {fmSetAmount},
  unTRtfWriter in 'unTRtfWriter.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'WageClientMT';
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TfmMain, fmMain);
  Application.CreateForm(TfmTools, fmTools);
  Application.Run;
end.
