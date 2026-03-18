unit fmuMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ActiveX, ComObj, Registry,
  fmuAppName,
  BDcomPrm;

type
  TDCOMPermissionObject = (dpoAccess, dpoLaunch);

  TDCOMDataRec = record
    Default: Boolean;
    AppName: String;
    PermissionObject: TDCOMPermissionObject;
    Principal: String;
    SetPrincipal: Boolean;
    Permit: Boolean;
  end;

  TfmMain = class(TForm)
    btnReadPermssions: TButton;
    edtPermissions: TMemo;
    lblKeyName: TLabel;
    cboKeyName: TComboBox;
    lblPermissionObject: TLabel;
    cboPermissionObject: TComboBox;
    Label3: TLabel;
    lblAppName: TLabel;
    edtAppName: TEdit;
    lblPrincipalName: TLabel;
    edtPrincipalName: TEdit;
    lblPricipalAction: TLabel;
    cboPrincipalAction: TComboBox;
    btnWritePermission: TButton;
    btnClose: TButton;
    btnAppName: TButton;
    Label1: TLabel;
    cboAccess: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnWritePermissionClick(Sender: TObject);
    procedure btnReadPermssionsClick(Sender: TObject);
    procedure ControlChanged(Sender: TObject);
    procedure btnAppNameClick(Sender: TObject);
  private
    fData: TDCOMDataRec;
    fLockChanged: Boolean;
    procedure UpdatePage;
  end;

var
  fmMain: TfmMain;

implementation

{$R *.DFM}

procedure SetDefaultDCOMDataRec(var Data: TDCOMDataRec);
begin
  with Data do
  begin
    Default := True;
    AppName := ExtractFileName(ParamStr(0));
    Principal := 'Everyone';
    SetPrincipal := True;
    PermissionObject := dpoAccess;
    Permit := True;
  end;
end;

function AppNameToAppID(const AppName: String; var AppID: String): Boolean;
var
  Reg: TRegistry;
begin
  Result := False;
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CLASSES_ROOT;
    if Reg.OpenKey('AppID\' + AppName, False) then
    begin
      if Reg.ValueExists('AppID') then
      begin
        AppID := Reg.ReadString('AppID');
        Result := True;
      end;
    end;
  finally
    Reg.Free;
  end;
end;

{ TfmMain }

procedure TfmMain.FormCreate(Sender: TObject);
begin
  SetDefaultDCOMDataRec(fData);
  UpdatePage;
end;

procedure TfmMain.UpdatePage;
const
  BoolToInt: array[Boolean] of Integer = (0, 1);
begin
  fLockChanged := True;
  try
    cboKeyName.ItemIndex := BoolToInt[not fData.Default];
    edtAppName.Enabled := not fData.Default;
    lblAppName.Enabled := not fData.Default;
    btnAppName.Enabled := not fData.Default;
    if fData.Default then
      edtAppName.Clear
    else
      edtAppName.Text := fData.AppName;
    cboPermissionObject.ItemIndex := Ord(fData.PermissionObject);
    edtPrincipalName.Text := fData.Principal;
    cboPrincipalAction.ItemIndex := BoolToInt[not fData.SetPrincipal];
    cboAccess.ItemIndex := BoolToInt[not fData.Permit];
  finally
    fLockChanged := False;
  end;
end;

procedure TfmMain.ControlChanged(Sender: TObject);
begin
  if fLockChanged then Exit;
  
  if Sender = cboKeyName then
    fData.Default := cboKeyName.ItemIndex = 0
  else
  if Sender = edtAppName then
    fData.AppName := edtAppName.Text
  else
  if Sender = cboPermissionObject then
    fData.PermissionObject := TDCOMPermissionObject(cboPermissionObject.ItemIndex)
  else
  if Sender = edtPrincipalName then
    fData.Principal := edtPrincipalName.Text
  else
  if Sender = cboPrincipalAction then
    fData.SetPrincipal := cboPrincipalAction.ItemIndex = 0
  else  
  if Sender = cboAccess then
    fData.Permit := cboAccess.ItemIndex = 0;
  UpdatePage;
end;

procedure TfmMain.btnReadPermssionsClick(Sender: TObject);
var
  S: String;
  AppID: String;
begin
  if fData.Default then
  begin
    if fData.PermissionObject = dpoAccess then
      ListDefaultAccessACL(S)
    else
      ListDefaultLaunchACL(S)
  end
  else
  begin
    if not AppNameToAppID(fData.AppName, AppID) then
      S := 'Class not registered'
    else
    begin
      if fData.PermissionObject = dpoAccess then
        ListAppIDAccessACL(PChar(AppID), S)
      else
        ListAppIDLaunchACL(PChar(AppID), S);
    end;
  end;
  edtPermissions.Lines.Text := S;
end;

procedure TfmMain.btnWritePermissionClick(Sender: TObject);
var
  AppID: String;
begin
  if fData.Default then
  begin
    if fData.PermissionObject = dpoAccess then
      ChangeDefaultAccessACL(PChar(fData.Principal), fData.SetPrincipal, fData.Permit)
    else
      ChangeDefaultLaunchACL(PChar(fData.Principal), fData.SetPrincipal, fData.Permit)
  end
  else
  begin
    if not AppNameToAppID(fData.AppName, AppID) then
      with Application do
        MessageBox('Class not registered', PChar(Title), mb_IconStop or mb_Ok)
    else
    begin
      if fData.PermissionObject = dpoAccess then
        ChangeAppIDAccessACL(PChar(AppID), PChar(fData.Principal),
          fData.SetPrincipal, fData.Permit)
      else
        ChangeAppIDLaunchACL(PChar(AppID), PChar(fData.Principal),
          fData.SetPrincipal, fData.Permit)
    end;
  end;
end;

procedure TfmMain.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfmMain.btnAppNameClick(Sender: TObject);
begin
  if ExecuteAppName(fData.AppName) then
    UpdatePage;
end;

end.
