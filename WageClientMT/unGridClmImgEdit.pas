unit unGridClmImgEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, ComCtrls, ToolWin, StdCtrls, unxModal,
  Menus, Placemnt;

type
  TfmGridClmImgEdit = class(TfmxModal)
    cbxColor: TComboBoxEx;
    Label1: TLabel;
    Label2: TLabel;
    edtValue: TEdit;
    edtDescr: TEdit;
    Label3: TLabel;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    procedure actSaveExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses unDm;

{$R *.dfm}

procedure TfmGridClmImgEdit.actSaveExecute(Sender: TObject);
begin
  if (Trim(edtValue.Text) = '') or
     (Trim(edtDescr.Text) = '') then MessageDlg('Вы не заполнили обязательные поля!', mtError, [mbOk], 0)
    else inherited;
end;

procedure TfmGridClmImgEdit.FormCreate(Sender: TObject);
var
  i: integer;
begin
  inherited;
  //---Загрузка иконок в список
  for i:=0 to DM.imgMain.Count - 1 do
  with cbxColor.ItemsEx.Add do
  begin
    Caption := IntToStr(i);
    ImageIndex := i;
  end;
end;

end.
