unit unMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unxModal, Menus, Placemnt, ActnList, ComCtrls, ToolWin, StdActns,
  ShellApi, ExtCtrls, dxCntner, dxTL, dxDBCtrl, dxDBTL, StdCtrls, IniFiles;

type
  TfmMain = class(TfmxModal)
    actExit: TAction;
    menMain: TMainMenu;
    N1: TMenuItem;
    N5: TMenuItem;
    window: TMenuItem;
    actWinClose: TWindowClose;
    actWinCascade: TWindowCascade;
    actWinTitleHoriz: TWindowTileHorizontal;
    actWinTitleVert: TWindowTileVertical;
    actWinMinAll: TWindowMinimizeAll;
    actWinArrange: TWindowArrange;
    Arrange1: TMenuItem;
    Cascade1: TMenuItem;
    Close1: TMenuItem;
    MinimizeAll1: TMenuItem;
    ileHorizontally1: TMenuItem;
    ileVertically1: TMenuItem;
    N6: TMenuItem;
    actAbout: TAction;
    N7: TMenuItem;
    N8: TMenuItem;
    actHelp: TAction;
    N9: TMenuItem;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    actCloseAll: TAction;
    N10: TMenuItem;
    actLico: TAction;
    N2: TMenuItem;
    N3: TMenuItem;
    actTools: TAction;
    N4: TMenuItem;
    N11: TMenuItem;
    actPlat: TAction;
    N12: TMenuItem;
    N13: TMenuItem;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure actExitExecute(Sender: TObject);
    procedure actAboutExecute(Sender: TObject);
    procedure actHelpExecute(Sender: TObject);
    procedure actCloseAllExecute(Sender: TObject);
    procedure actLicoExecute(Sender: TObject);
    procedure actToolsExecute(Sender: TObject);
    procedure actPlatExecute(Sender: TObject);
  private
    { Private declarations }
    procedure AppException(Sender: TObject; E: Exception);
  public
    function SeekForShowChild(aFormName: string): boolean;
    { Public declarations }
  end;

var
  fmMain: TfmMain;

implementation

uses unDM, unInitialize, unAbout, unLico, unTools, unSql, unPlat;

{$R *.dfm}

procedure TfmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  strModal.SaveFormPlacement;

  QR.Free;
  IZ.Free;
  actCloseAll.Execute;
end;

procedure TfmMain.FormShow(Sender: TObject);
var
  i: integer;
  s: string;
begin
  inherited;
  Application.OnException := AppException;

  QR := TQry.Create(fmTools.dedBase.Text);
end;

procedure TfmMain.FormCreate(Sender: TObject);
begin
  inherited;
  IZ := TInit.Create;

  strModal.IniSection := 'Main';
  strModal.IniFileName := IZ.AppIni;
end;

procedure TfmMain.actExitExecute(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfmMain.actAboutExecute(Sender: TObject);
begin
  inherited;
  OpenForm;
end;

procedure TfmMain.actHelpExecute(Sender: TObject);
begin
  inherited;
  ShellExecute(Handle, 'open', PChar(IZ.AppDoc), nil, nil, SW_RESTORE);
end;

procedure TfmMain.AppException(Sender: TObject; E: Exception);
begin
  MessageDlg('Произошла непредвиденная ошибка!'#13 +
             'В случае повторного проявления сообщите об ошибке администратору!'#13#13'[' + E.Message + ']', mtError, [mbOk], 0);
  IZ.Log('Application Error: ' + E.Message);
end;

function TfmMain.SeekForShowChild(aFormName: string): boolean;
var
  i: integer;
begin
  Result := false;
  for i:=0 to fmMain.MDIChildCount -1 do
  with fmMain.MDIChildren[i] do
  if UpperCase(Name) = UpperCase(aFormName) then
  begin
    Result := true;
    Show;
    Break;
  end;
end;

procedure TfmMain.actCloseAllExecute(Sender: TObject);
var
  i: integer;
begin
  for i := MDIChildCount - 1 downto 0 do MDIChildren[i].Close;
end;

procedure TfmMain.actLicoExecute(Sender: TObject);
var
  fmLico: TfmLico;
begin
  inherited;
  if not SeekForShowChild('fmLico') then
  if fmTools.dedBase.Text = '' then
    ShowMessage('Введите в настройках путь к базам данных')
  else
    fmLico := TfmLico.Create(Self);
end;

procedure TfmMain.actToolsExecute(Sender: TObject);
begin
  inherited;
  fmTools.ShowModal;
end;

procedure TfmMain.actPlatExecute(Sender: TObject);
var
  fmPlat: TfmPlat;
begin
  inherited;
  if not SeekForShowChild('fmPlat') then
  if fmTools.dedBase.Text = '' then
    ShowMessage('Введите в настройках путь к базам данных')
  else
    fmPlat := TfmPlat.Create(Self);
end;

end.
