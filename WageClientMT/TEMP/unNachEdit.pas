unit unNachEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unxModal, ComCtrls, Menus, Placemnt, ActnList, ToolWin,
  StdCtrls, Mask, DBCtrls, Halcn6DB;

type
  TfmNachEdit = class(TfmxModal)
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    Label1: TLabel;
    dbeFM: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    Label4: TLabel;
    DBEdit4: TDBEdit;
    Label5: TLabel;
    DBEdit5: TDBEdit;
    Label6: TLabel;
    DBEdit1: TDBEdit;
    procedure DBEdit4KeyPress(Sender: TObject; var Key: Char);
    procedure actOkExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  procedure NachEditExec(aOwner: TComponent; aTable: THalcyonDataSet; const aMode, aLtype: integer);

implementation

uses unNach, unSql, unInitialize;

{$R *.dfm}

procedure NachEditExec(aOwner: TComponent; aTable: THalcyonDataSet; const aMode, aLtype: integer);
var
  fmNachEdit: TfmNachEdit;
  vRecID: string;
  vRes: boolean;
begin
  vRecID := '-1';
  vRes := false;
  try
    case aMode of
    1, 2:
        begin
          fmNachEdit := TfmNachEdit.Create(aOwner);
          with fmNachEdit, aTable do
          try
            case aMode of
            1:
              begin
                Caption := 'Создание';
                vRecID := IntToStr(QR.GenID('Nach.dbf'));
                aTable.Append;
                FieldByName('ID').AsString := vRecID;
                FieldByName('LTYPE').AsInteger := aLtype;
                if ShowModal = mrOk then
                begin
                  Post;
                  vRes := true;
                end
                else
                  Cancel;
              end;
            2:
              begin
                if RecordCount = 0 then exit;
                Caption := 'Редактирование';
                vRecID := FieldByName('ID').AsString;
                Edit;
                if ShowModal = mrOk then
                begin
                  Post;
                  vRes := true;
                end
                else
                  Cancel;
              end;
            end;
          finally
            Release;
          end;
        end;
    3:  begin
          if (aTable.RecordCount = 0) or
             (MessageDlg('Вы действительно желаете удалить запись ?',
                        mtConfirmation, [mbYes, mbNo], 0) <> mrYes) then Exit
          else
          begin
            aTable.Delete;
            vRes := true;
          end;
        end;
    end;
    if vRes then
    begin
      aTable.Close;
      aTable.Open;
      if (aMode < 3) and (not aTable.Locate('ID', vRecID, [])) then aTable.First;
    end;
  except
    on E:Exception do
    begin
      aTable.Cancel;
      IZ.MsgException(E);
    end;
  end;
end;

procedure TfmNachEdit.DBEdit4KeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  IZ.OnDigitPress(Sender, Key);
end;

procedure TfmNachEdit.actOkExecute(Sender: TObject);
var
  s: string;
  vErr: boolean;

  function fs(const aFieldName: string; const a0: boolean = false): string;
  begin
    Result := Trim(dbeFM.DataSource.DataSet.FieldByName(aFieldName).AsString);
    if (Result = '0') and (a0) then Result := '';
  end;

begin
  s := '';
  vErr := false;

  dbeFM.SetFocus;
  if fs('FM') = '' then s := IZ.AddErr(s, 'Не заполнено поле Фамилия', vErr);
  if fs('NM') = '' then s := IZ.AddErr(s, 'Не заполнено поле Имя', vErr);
  if fs('FT') = '' then s := IZ.AddErr(s, 'Не заполнено поле Отчество', vErr);
  if fs('RNN') = '' then s := IZ.AddErr(s, 'Не заполнено поле РНН', vErr);
  if length(fs('RNN'))< 12 then s := IZ.AddErr(s, 'Длина поля РНН должна = 12', vErr);
  if fs('LA') = '' then s := IZ.AddErr(s, 'Не заполнено поле Счет', vErr);

  if vErr then
  begin
    MessageDlg('Присутствуют ошибки:'#13 + s, mtError, [mbOk], 0);
    Exit;
  end;

  inherited;
end;

end.
