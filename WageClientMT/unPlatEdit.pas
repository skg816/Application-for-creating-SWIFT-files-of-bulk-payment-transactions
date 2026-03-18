unit unPlatEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unxModal, ComCtrls, Menus, Placemnt, ActnList, ToolWin,
  StdCtrls, Mask, DBCtrls, Halcn6DB, RxLookup, ExtCtrls, DB, ToolEdit,
  RXDBCtrl, Buttons, IdGlobal;

type
  TfmPlatEdit = class(TfmxModal)
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    Label17: TLabel;
    Label18: TLabel;
    dbeDOC_DATE: TDBDateEdit;
    Label19: TLabel;
    Label20: TLabel;
    dbeDoc_num: TDBEdit;
    Label21: TLabel;
    dbeCCY_DATE: TDBDateEdit;
    Label8: TLabel;
    lcbLico: TRxDBLookupCombo;
    Label1: TLabel;
    hdsLico: THalcyonDataSet;
    dsrLico: TDataSource;
    hdsLico1: THalcyonDataSet;
    dsrLico1: TDataSource;
    lcbLico1: TRxDBLookupCombo;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    dbeKnp: TDBEdit;
    dbeASSIGN: TDBMemo;
    dsrFrom: TDataSource;
    hdsFrom: THalcyonDataSet;
    procedure DBEdit4KeyPress(Sender: TObject; var Key: Char);
    procedure lcbLicoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lcbLico1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure actOkExecute(Sender: TObject);
    procedure dbeKnpKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbeASSIGNKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  procedure PlatEditExec(aOwner: TComponent; aTable: THalcyonDataSet; const aMode, aCopy: integer);

implementation

uses unSql, unInitialize, unLico;

{$R *.dfm}

procedure PlatEditExec(aOwner: TComponent; aTable: THalcyonDataSet; const aMode, aCopy: integer);
var
  fmPlatEdit: TfmPlatEdit;
  vRecID, vDoc_num: string;
  vRes: boolean;

  procedure LoadLico(aLico, aLico1: THalcyonDataSet);
  begin
    with aTable do
    begin
      FieldByName('NAME').AsString := aLico.FieldByName('NAME').AsString;
      FieldByName('BIC').AsString := aLico.FieldByName('BIC').AsString;
      FieldByName('ACCOUNT').AsString := aLico.FieldByName('ACCOUNT').AsString;
      FieldByName('CHIEF').AsString := aLico.FieldByName('CHIEF').AsString;
      FieldByName('MAINBK').AsString := aLico.FieldByName('MAINBK').AsString;
      FieldByName('RNN').AsString := aLico.FieldByName('RNN').AsString;
      FieldByName('IRS').AsString := aLico.FieldByName('IRS').AsString;
      FieldByName('SECO').AsString := aLico.FieldByName('SECO').AsString;

      FieldByName('NAME1').AsString := aLico1.FieldByName('NAME').AsString;
      FieldByName('BIC1').AsString := aLico1.FieldByName('BIC').AsString;
      FieldByName('ACCOUNT1').AsString := aLico1.FieldByName('ACCOUNT').AsString;
      FieldByName('RNN1').AsString := aLico1.FieldByName('RNN').AsString;
      FieldByName('IRS1').AsString := aLico1.FieldByName('IRS').AsString;
      FieldByName('SECO1').AsString := aLico1.FieldByName('SECO').AsString;
    end;
  end;

begin
  vRecID := '-1';
  vRes := false;
  try
    case aMode of
    1, 2:
        begin
          fmPlatEdit := TfmPlatEdit.Create(aOwner);
          with fmPlatEdit, aTable do
          try
            dsrFrom.DataSet := aTable;
            dsrLico.DataSet := nil;
            dsrLico1.DataSet := nil;
            hdsLico.DatabaseName := QR.qPathDB;
            hdsLico.TableName := 'lico.dbf';
            hdsLico.Open;
            hdsLico1.DatabaseName := QR.qPathDB;
            hdsLico1.TableName := 'lico.dbf';
            hdsLico1.Open;
            dsrLico.DataSet := hdsLico;
            dsrLico1.DataSet := hdsLico1;
            case aMode of
            1:
              begin
                Caption := 'Создание';
                vDoc_num := aTable.FieldByName('DOC_NUM').AsString;
                if aCopy=1 then
                  if not QR.Empty(aTable) then vRecID := FieldByName('ID').AsString else exit;
                aTable.Append;
                if aCopy = 1 then
                  QR.CopyFields(aTable.TableName, 'ID=' + vRecID, aTable, aTable.DatabaseName)
                else
                begin
                  FieldByName('AMOUNT').AsFloat := 0;
                  FieldByName('DOC_DATE').AsDateTime := Date;
                  FieldByName('CCY_DATE').AsDateTime := Date;
                end;
                vRecID := IntToStr(QR.GenID(aTable.TableName));
                FieldByName('ID').AsString := vRecID;
                FieldByName('DOC_NUM').AsInteger := QR.GenID('Plat.dbf', 'DOC_NUM');
                lcbLico.KeyValue := hdsLico.FieldByName('ID').AsInteger;
                lcbLico1.KeyValue := hdsLico1.FieldByName('ID').AsInteger;
                if ShowModal = mrOk then
                begin
                  LoadLico(hdsLico, hdsLico1);

                  if aCopy=1 then
                  begin
                    if CopyFileTo(aTable.DatabaseName + '\DOCS\doc_' + vDoc_num + '.DBF',
                                  aTable.DatabaseName + '\DOCS\doc_' + FieldByName('DOC_NUM').AsString + '.DBF') then
                    begin
                      Post;
                      vRes := true;
                    end
                    else
                      Cancel;
                  end
                  else
                  if CopyFileTo(aTable.DatabaseName + '\sotr.DBF',
                                aTable.DatabaseName + '\DOCS\doc_' + aTable.FieldByName('DOC_NUM').AsString +
                                '.DBF') then
                  begin
                    Post;
                    vRes := true;
                  end
                  else
                    Cancel;
                end
                else
                  Cancel;
              end;
            2:
              begin
                if QR.Empty(aTable) then exit;
                Caption := 'Редактирование';
                vRecID := FieldByName('ID').AsString;
                dbeDoc_num.ReadOnly := true;
                Edit;
                if ShowModal = mrOk then
                begin
                  LoadLico(hdsLico, hdsLico1);
                  Post;
                  vRes := true;
                end
                else
                  Cancel;
              end;
            end;
          finally
            dsrFrom.DataSet := nil;
            hdsLico.Close;
            hdsLico1.Close;
            Release;
          end;
        end;
    3:  begin
          if QR.Empty(aTable) or
             (MessageDlg('Вы действительно желаете удалить запись ?',
                        mtConfirmation, [mbYes, mbNo], 0) <> mrYes) then Exit
          else
          begin
            vDoc_num := aTable.FieldByName('DOC_NUM').AsString;
            aTable.Delete;
            vRes := true;
            if FileExists(aTable.DatabaseName + '\DOCS\doc_' + vDoc_num + '.DBF') then
              DeleteFile(aTable.DatabaseName + '\DOCS\doc_' + vDoc_num + '.dbf');
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

procedure TfmPlatEdit.DBEdit4KeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  IZ.OnDigitPress(Sender, Key);
end;

procedure TfmPlatEdit.lcbLicoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Lico_GetId(Self, TRxDBLookupCombo(Sender), Key, 1);
end;

procedure TfmPlatEdit.lcbLico1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Lico_GetId(Self, TRxDBLookupCombo(Sender), Key, 0);
end;

procedure TfmPlatEdit.SpeedButton1Click(Sender: TObject);
begin
  inherited;
  Lico_GetId(Self, lcbLico, VK_INSERT, 1);
end;

procedure TfmPlatEdit.SpeedButton2Click(Sender: TObject);
begin
  inherited;
  Lico_GetId(Self, lcbLico1, VK_INSERT, 0);
end;

procedure TfmPlatEdit.actOkExecute(Sender: TObject);
var
  s: string;
  vErr: boolean;
  aTable: THalcyonDataSet;

  function fs(const aFieldName: string; const a0: boolean = false): string;
  begin
    Result := Trim(aTable.FieldByName(aFieldName).AsString);
    if (Result = '0') and (a0) then Result := '';
  end;

  function Repl(const aStr: string): string;
  begin
    Result := StringReplace(aStr, #13#10, ' ', [rfReplaceAll, rfIgnoreCase]);
    Result := StringReplace(Result, #13, ' ', [rfReplaceAll, rfIgnoreCase]);
    Result := StringReplace(Result, #10, ' ', [rfReplaceAll, rfIgnoreCase]);
  end;

begin
  s := '';
  vErr := false;
  aTable := THalcyonDataSet(dbeDoc_num.DataSource.DataSet);

  dbeDoc_num.SetFocus;
  if fs('DOC_NUM') = '' then s := IZ.AddErr(s, 'Не заполнено поле № документа', vErr);
  if fs('DOC_DATE') = '' then s := IZ.AddErr(s, 'Не заполнено поле Дата рег.', vErr);
  if fs('CCY_DATE') = '' then s := IZ.AddErr(s, 'Не заполнено поле Дата валютирования', vErr);
  if dbeCCY_DATE.Field.AsDateTime < dbeDoc_DATE.Field.AsDateTime then
    s := IZ.AddErr(s, 'Дата валютирования меньше даты документа', vErr);
  if fs('ID_LICO') = '' then s := IZ.AddErr(s, 'Не заполнено поле Отправитель', vErr);
  if fs('ID_LICO1') = '' then s := IZ.AddErr(s, 'Не заполнено поле Получатель', vErr);
  if fs('ID_LICO') = fs('ID_LICO1') then s := IZ.AddErr(s, 'Отправитель и Получатель одинаковый', vErr);
  if fs('KNP') = '' then s := IZ.AddErr(s, 'Не заполнено поле КНП', vErr);
  if length(fs('KNP'))< 3 then s := IZ.AddErr(s, 'Длина поля Код Назначения Платежа должна = 3', vErr);
  if fs('ASSIGN') = '' then s := IZ.AddErr(s, 'Не заполнено поле Назначение платежа', vErr);

  if  (Pos(#13, fs('ASSIGN')) > 0) or
      (Pos(#10, fs('ASSIGN')) > 0) then dbeASSIGN.Field.AsString := Repl(fs('ASSIGN'));
  if length(fs('ASSIGN')) > 473 then
    dbeASSIGN.Field.AsString := copy(fs('ASSIGN'), 1, 473);

  if vErr then
  begin
    MessageDlg('Присутствуют ошибки:'#13 + s, mtError, [mbOk], 0);
    Exit;
  end;

  inherited;
end;

procedure TfmPlatEdit.dbeKnpKeyPress(Sender: TObject; var Key: Char);
begin
  IZ.OnDigitPress(Sender, Key);
end;

procedure TfmPlatEdit.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //-- Если списки не закрыть, то будет ошибка
  lcbLico.CloseUp(true);
  lcbLico1.CloseUp(true);
end;

procedure TfmPlatEdit.dbeASSIGNKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if (Key in ['{', '}', '/', #13]) or
     (dbeASSIGN.Lines.Count > 6) then Key := #0;
end;

end.
