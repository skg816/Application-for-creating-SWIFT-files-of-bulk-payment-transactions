unit unNachEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unxModal, ComCtrls, Menus, Placemnt, ActnList, ToolWin,
  StdCtrls, Mask, DBCtrls, Halcn6DB, dxCntner, dxEditor, dxExEdtr, dxEdLib,
  dxDBELib, unGrid, DB;

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
    edtLA: TDBEdit;
    Label6: TLabel;
    DBEdit1: TDBEdit;
    dbeAmount: TdxDBCurrencyEdit;
    Label7: TLabel;
    lblLa: TLabel;
    hdsFrom: THalcyonDataSet;
    dsrFrom: TDataSource;
    procedure DBEdit4KeyPress(Sender: TObject; var Key: Char);
    procedure actOkExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtLAKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    pBic: string;
  end;

  procedure NachEditExec(aOwner: TComponent; aFrmPlat, aFrmNach: TfrmGrid; aTable: THalcyonDataSet; const aMode, aCopy: integer);

implementation

uses unPlat, unSql, unInitialize, dxTL, dxDBGrid, unTools;

{$R *.dfm}

procedure NachEditExec(aOwner: TComponent; aFrmPlat, aFrmNach: TfrmGrid; aTable: THalcyonDataSet; const aMode, aCopy: integer);
var
  fmNachEdit: TfmNachEdit;
  vRecID: string;
  vRes: boolean;

  procedure SelDel;
  var
    s: string;
    i, vInd: integer;
  begin
    s := '';
    vInd := aFrmNach.grdGrid.ColumnByFieldName('ID').Index;
    for i:=0 to aFrmNach.grdGrid.SelectedCount - 1 do
      s := s + 'or(ID=' + aFrmNach.grdGrid.SelectedNodes[i].Strings[vInd] + ')';
    system.delete(s, 1, 2);
    QR.DelByFilter(aTable.TableName, s, aTable.DatabaseName);
  end;

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
            dsrFrom.DataSet := aTable;
            pBic := aFrmPlat.hdsGrid.FieldByName('BIC1').AsString;
            case aMode of
            1:
              begin
                Caption := 'Создание';
                if aCopy=1 then
                  if not QR.Empty(aTable) then vRecID := FieldByName('ID').AsString else exit;
                aTable.Append;
                if aCopy = 1 then
                  QR.CopyFields(aTable.TableName, 'ID=' + vRecID, aTable, aTable.DatabaseName)
                else
                begin
                  FieldByName('AMOUNT').AsFloat := 0;
                  FieldByName('RNN').AsString := RnnPodgon;
                end;
                vRecID := IntToStr(QR.GenID(TableName, 'ID', aTable.DatabaseName));
                FieldByName('ID').AsString := vRecID;
                if ShowModal = mrOk then
                begin
                  Post;
                  SetPlatAmount(aFrmPlat, aFrmNach);
                  vRes := true;
                end
                else
                  Cancel;
              end;
            2:
              begin
                if QR.Empty(aTable) then exit;
                Caption := 'Редактирование';
                vRecID := FieldByName('ID').AsString;
                Edit;
                if ShowModal = mrOk then
                begin
                  Post;
                  SetPlatAmount(aFrmPlat, aFrmNach);
                  vRes := true;
                end
                else
                  Cancel;
              end;
            end;
          finally
            dsrFrom.DataSet := nil;
            Release;
          end;
        end;
    3:  begin
          if QR.Empty(aTable) or
             (MessageDlg('Вы действительно желаете удалить выделенные записи ?',
                        mtConfirmation, [mbYes, mbNo], 0) <> mrYes) then Exit
          else
          begin
            if aFrmNach.grdGrid.SelectedCount = 1 then
              aTable.Delete
            else
              SelDel;
            SetPlatAmount(aFrmPlat, aFrmNach);
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
  aTable := THalcyonDataSet(dbeFM.DataSource.DataSet);

  dbeFM.SetFocus;
  if fs('FM') = '' then s := IZ.AddErr(s, 'Не заполнено поле Фамилия', vErr);
  if fs('NM') = '' then s := IZ.AddErr(s, 'Не заполнено поле Имя', vErr);
  if fs('RNN') = '' then s := IZ.AddErr(s, 'Не заполнено поле РНН', vErr);
  if length(fs('RNN'))< 12 then s := IZ.AddErr(s, 'Длина поля РНН должна = 12', vErr);
  if fs('LA') = '' then s := IZ.AddErr(s, 'Не заполнено поле Счет', vErr);
{  if length(fs('RNN')) = 12 then
  begin
    s1 := IZ.CheckRNN(fs('RNN'));
    if s1 <> '' then  s := IZ.AddErr(s, s1, vErr);
  end;
}

  if vErr then
  begin
    MessageDlg('Присутствуют ошибки:'#13 + s, mtError, [mbOk], 0);
    Exit;
  end;

{  if (QR.CheckRowUniq(aTable.TableName,
                      '(RNN=''' + fs('RNN') + ''') and ' + '(ID<>' + fs('ID') + ')', aTable.DatabaseName)) and
     (MessageDlg('Внимание РНН - ' + fs('RNN') + ' уже существует!'#13 +
               'Желаете все равно ввести ?', mtWarning, [mbYes, mbNo], 0) = mrNo) then exit;

  if (QR.CheckRowUniq(aTable.TableName,
                      '(LA=''' + fs('LA') + ''') and ' + '(ID<>' + fs('ID') + ')', aTable.DatabaseName)) and
     (MessageDlg('Внимание Счет - ' + fs('LA') + ' уже существует!'#13 +
               'Желаете все равно ввести ?', mtWarning, [mbYes, mbNo], 0) = mrNo) then exit;
}
  inherited;
end;

procedure TfmNachEdit.FormCreate(Sender: TObject);
begin
  pBic := '';
end;

procedure TfmNachEdit.edtLAKeyPress(Sender: TObject; var Key: Char);
begin
  if fmTools.chbLa.Checked then IZ.OnDigitPress(Sender, Key);
end;

end.
