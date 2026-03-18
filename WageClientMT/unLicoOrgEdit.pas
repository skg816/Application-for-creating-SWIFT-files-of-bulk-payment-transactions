unit unLicoOrgEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unxModal, ComCtrls, Menus, Placemnt, ActnList, ToolWin,
  StdCtrls, Mask, DBCtrls, Halcn6DB, ExtCtrls, RxLookup, DB;

type
  TfmLicoOrgEdit = class(TfmxModal)
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    Label1: TLabel;
    dbeNAME: TDBEdit;
    Label4: TLabel;
    DBEdit4: TDBEdit;
    Label5: TLabel;
    DBEdit5: TDBEdit;
    Label6: TLabel;
    DBEdit6: TDBEdit;
    Label7: TLabel;
    DBRadioGroup1: TDBRadioGroup;
    Label8: TLabel;
    hdsDict: THalcyonDataSet;
    dsrDict: TDataSource;
    lcbDict: TRxDBLookupCombo;
    pnlFio: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    hdsFrom: THalcyonDataSet;
    dsrFrom: TDataSource;
    procedure lcbDictKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBEdit5KeyPress(Sender: TObject; var Key: Char);
    procedure actOkExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  procedure LicoOrgEditExec(aOwner: TComponent; aTable: THalcyonDataSet; const aMode, aLtype: integer);

implementation

uses unSql, unInitialize, unTools;

{$R *.dfm}

procedure LicoOrgEditExec(aOwner: TComponent; aTable: THalcyonDataSet; const aMode, aLtype: integer);
var
  fmLicoOrgEdit: TfmLicoOrgEdit;
  vRecID: string;
  vRes: boolean;
begin
  vRecID := '-1';
  vRes := false;
  try
    case aMode of
    1, 2:
        begin
          fmLicoOrgEdit := TfmLicoOrgEdit.Create(aOwner);
          with fmLicoOrgEdit, aTable do
          try
            dsrFrom.DataSet := aTable;
            hdsDict.DatabaseName := QR.qPathDB;
            hdsDict.TableName := 'dict.dbf';
            hdsDict.Open;
            case aMode of
            1:
              begin
                Caption := 'Создание';
                vRecID := IntToStr(QR.GenID('lico.dbf'));
                if aLtype = 0 then pnlFio.Hide;
                aTable.Append;
                FieldByName('ID').AsString := vRecID;
                FieldByName('LTYPE').AsInteger := aLtype;
                FieldByName('IRS').AsString := '1';
                FieldByName('RNN').AsString := RnnPodgon;
                lcbDict.KeyValue := hdsDict.FieldByName('CODE').AsString;
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
                if QR.Empty(aTable) then exit;
                Caption := 'Редактирование';
                if aLtype = 0 then pnlFio.Hide;
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
            dsrFrom.DataSet := nil;
            hdsDict.Close;
            Release;
          end;
        end;
    3:  begin
          if QR.Empty(aTable) or
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

procedure TfmLicoOrgEdit.lcbDictKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  IZ.LookupKeyDown(Sender, Key);
end;

procedure TfmLicoOrgEdit.DBEdit5KeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  IZ.OnDigitPress(Sender, Key);
end;

procedure TfmLicoOrgEdit.actOkExecute(Sender: TObject);
var
  s, s1: string;
  vErr: boolean;
  aTable: THalcyonDataSet;

  function fs(const aFieldName: string; const a0: boolean = false): string;
  begin
    Result := Trim(aTable.FieldByName(aFieldName).AsString);
    if (Result = '0') and (a0) then Result := '';
  end;

begin
  s := '';
  vErr := false;
  aTable := THalcyonDataSet(dbeNAME.DataSource.DataSet);

  dbeNAME.SetFocus;
  if fs('NAME') = '' then s := IZ.AddErr(s, 'Не заполнено поле Наименование', vErr);
  if fs('BIC') = '' then s := IZ.AddErr(s, 'Не заполнено поле БИК Банка', vErr);
  if length(fs('BIC'))< 9 then s := IZ.AddErr(s, 'Длина поля БИК Банка должна = 9', vErr);
  if fs('ACCOUNT') = '' then s := IZ.AddErr(s, 'Не заполнено поле Счет', vErr);
  if length(fs('ACCOUNT'))< 9 then s := IZ.AddErr(s, 'Длина поля Счет должна = 9', vErr);
  if (fs('CHIEF') = '') and (pnlFio.Visible) then s := IZ.AddErr(s, 'Не заполнено поле ФИО руков', vErr);
  if (fs('MAINBK') = '') and (pnlFio.Visible) then s := IZ.AddErr(s, 'Не заполнено поле ФИО гл. бух', vErr);
  if fs('IRS') = '' then s := IZ.AddErr(s, 'Не заполнено поле Резиденство', vErr);
  if fs('SECO') = '' then s := IZ.AddErr(s, 'Не заполнено поле Сектор экон', vErr);
  if fs('RNN') = '' then s := IZ.AddErr(s, 'Не заполнено поле РНН', vErr);
  if length(fs('RNN'))< 12 then s := IZ.AddErr(s, 'Длина поля РНН должна = 12', vErr);
  if  (length(fs('BIC')) = 9) and (length(fs('ACCOUNT')) = 9) and
      (fmTools.chbBic.Checked) then
  begin
    s1 := IZ.CheckBic(fs('BIC'), fs('ACCOUNT'));
    if s1 <> '' then  s := IZ.AddErr(s, s1, vErr);
  end;
  if length(fs('RNN')) = 12 then
  begin
    s1 := IZ.CheckRNN(fs('RNN'));
    if s1 <> '' then  s := IZ.AddErr(s, 'Неверный 12-й разряд в РНН: ' + fs('RNN') + ', правильный: ' + s1[12], vErr);
  end;

  if vErr then
  begin
    MessageDlg('Присутствуют ошибки:'#13 + s, mtError, [mbOk], 0);
    Exit;
  end;

  if (QR.CheckRowUniq(aTable.TableName,
                      '(RNN=''' + fs('RNN') + ''') and ' + '(ID<>' + fs('ID') + ')', aTable.DatabaseName)) and
     (MessageDlg('Внимание РНН - ' + fs('RNN') + ' уже существует!'#13 +
               'Желаете все равно ввести ?', mtWarning, [mbYes, mbNo], 0) = mrNo) then exit;

  inherited;
end;

procedure TfmLicoOrgEdit.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  lcbDict.CloseUp(true);
end;

end.
