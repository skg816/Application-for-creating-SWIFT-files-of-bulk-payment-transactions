unit fmuAppName;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Registry, ComObj, ActiveX;

type
  TfmAppName = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    btnOk: TButton;
    btnCancel: TButton;
    LBoxAppName: TListBox;
    procedure FormCreate(Sender: TObject);
    procedure LBoxAppNameClick(Sender: TObject);
    procedure LBoxAppNameDblClick(Sender: TObject);
  private
    procedure SetData(const AppName: String);
    procedure GetData(var AppName: String);
  end;

function ExecuteAppName(var AppName: String): Boolean;

implementation

{$R *.DFM}

function ExecuteAppName(var AppName: String): Boolean;
var
  fm: TfmAppName;
begin
  fm := TfmAppName.Create(nil);
  try
    fm.SetData(AppName);
    Result := fm.ShowModal = mrOk;
    if Result then
      fm.GetData(AppName);
  finally
    fm.Free;
  end;
end;

{ TfmAppName }

procedure TfmAppName.FormCreate(Sender: TObject);
var
  Reg: TRegistry;
  AppNames: TStringList;
  guid: TGUID;
  I: Integer;
begin
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CLASSES_ROOT;
    if not Reg.OpenKey('AppID', False) then Exit;
    AppNames := TStringList.Create;
    try
      Reg.GetKeyNames(AppNames);
      for I := AppNames.Count - 1 downto 0 do
      begin
        if Succeeded(CLSIDFromString(PWideChar(WideString(AppNames[I])), guid)) then
          AppNames.Delete(I);
      end;
      AppNames.Sort;
      LBoxAppName.Items := AppNames;
    finally
      AppNames.Free;
    end;
    LBoxAppName.ItemIndex := 0;
    LBoxAppNameClick(LBoxAppName);
  finally
    Reg.Free;
  end;
end;

procedure TfmAppName.GetData(var AppName: String);
begin
  with LBoxAppName do
   if (0 <= ItemIndex) and (ItemIndex < Items.Count) then
     AppName := Items[ItemIndex];
end;

procedure TfmAppName.SetData(const AppName: String);
begin
  with LBoxAppName do
    ItemIndex := Items.IndexOf(AppName);
  LBoxAppNameClick(LBoxAppName);
end;

procedure TfmAppName.LBoxAppNameClick(Sender: TObject);
begin
  with LBoxAppName do
    btnOk.Enabled := (0 <= ItemIndex) and (ItemIndex < Items.Count);
end;

procedure TfmAppName.LBoxAppNameDblClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

end.
