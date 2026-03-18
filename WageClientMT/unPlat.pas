unit unPlat;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unxModal, Menus, Placemnt, ActnList, ToolWin, ComCtrls, unGrid,
  IdGlobal, ExtCtrls, StdCtrls, DB, dxTL, dxDBCtrl, dxDBGrid, Halcn6DB,
  DBCtrls, Buttons, Math, ShellApi;

type
  TfmPlat = class(TfmxModal)
    actNew: TAction;
    actEdit: TAction;
    actDel: TAction;
    pgcPlat: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    frmPlat: TfrmGrid;
    ToolBar1: TToolBar;
    tlbClose: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolBar2: TToolBar;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    frmNach: TfrmGrid;
    actNewN: TAction;
    actEditN: TAction;
    actDelN: TAction;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    actMakeMT: TAction;
    actImportE2b: TAction;
    actSetSum: TAction;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    actDelAmount: TAction;
    ToolButton1: TToolButton;
    actComAmount: TAction;
    ToolButton2: TToolButton;
    ToolButton14: TToolButton;
    actImportE2b1: TMenuItem;
    actNewNC: TAction;
    ToolButton15: TToolButton;
    ToolButton16: TToolButton;
    ToolButton17: TToolButton;
    actMakeE2b: TAction;
    e2b1: TMenuItem;
    e2b2: TMenuItem;
    actNewC: TAction;
    ToolButton18: TToolButton;
    actImpNach: TAction;
    N1: TMenuItem;
    Panel1: TPanel;
    Label1: TLabel;
    DBText1: TDBText;
    Label2: TLabel;
    DBText2: TDBText;
    Label3: TLabel;
    DBText3: TDBText;
    Label4: TLabel;
    DBText4: TDBText;
    actImp102: TAction;
    N1021: TMenuItem;
    actMakeRtf: TAction;
    ToolButton19: TToolButton;
    ToolButton20: TToolButton;
    actPodgon: TAction;
    ToolButton21: TToolButton;
    ToolButton22: TToolButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure actNewExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actDelExecute(Sender: TObject);
    procedure actOkExecute(Sender: TObject);
    procedure pgcPlatChange(Sender: TObject);
    procedure actNewNExecute(Sender: TObject);
    procedure actEditNExecute(Sender: TObject);
    procedure actDelNExecute(Sender: TObject);
    procedure actMakeMTExecute(Sender: TObject);
    procedure actImportE2bExecute(Sender: TObject);
    procedure actSetSumExecute(Sender: TObject);
    procedure actDelAmountExecute(Sender: TObject);
    procedure actComAmountExecute(Sender: TObject);
    procedure actNewNCExecute(Sender: TObject);
    procedure actMakeE2bExecute(Sender: TObject);
    procedure actNewCExecute(Sender: TObject);
    procedure actImpNachExecute(Sender: TObject);
    procedure actImp102Execute(Sender: TObject);
    procedure actMakeRtfExecute(Sender: TObject);
    procedure actPodgonExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function CheckNachMand: string;
    function CheckNachDubl: string;       //-- Внимание запускать только после CheckNachMand
    function Fs(const aFieldName: string; const aTableType: byte = 0): string;
    function ReplDec(const aStr: string; const aCvs: boolean = true): string;
  end;

  TRecVed = record
    Name : string;        //---Имя поля
    From,                 //---Смещение, т.е. начало вхождения подстроки
    Len: integer;         //---Дляна
  end;

  TArrVed = array [1..6] of TRecVed;

const
  LenArrVed = 6;

  //---Формат файла e2b
  FieldsVed : TArrVed =
    (( Name: 'ACCOUNT';         From: 1;     Len: 24 ),
     ( Name: 'NAME';            From: 25;    Len: 36 ),
     ( Name: 'AMOUNT';          From: 61;    Len: 15 ),
     ( Name: 'CUR';             From: 76;    Len: 3  ),
     ( Name: 'TAB_NUM';         From: 79;    Len: 24 ),
     ( Name: 'RNN';             From: 103;    Len: 12 ));

  procedure SetPlatAmount(aFrmPlat, aFrmNach: TfrmGrid);
  procedure CheckAmount(aFrmPlat, aFrmNach: TfrmGrid);

implementation

uses unInitialize, unMain, RxStrUtils, unTools, ToolEdit, unDM, unPlatEdit,
  unSql, unLico, unNachEdit, unSetAmount, dxEdLib, unTRtfWriter, Spin;

{$R *.dfm}

procedure TfmPlat.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfmPlat.FormShow(Sender: TObject);
begin
  inherited;
  pgcPlat.ActivePageIndex := 0;
  with frmPlat do
  begin
    FrmInit('Plat.dbf');
    hdsGrid.Open;
    LoadGridMy;
    SetSort('DOC_DATE', false);
  end;
  with frmNach do
  begin
    FrmInit('Sotr.dbf');
//    hdsGrid.Open;       //--Для настройки десктопа
    LoadGridMy;
    hdsGrid.DatabaseName := hdsGrid.DatabaseName + '\DOCS';   //-- ЗАКОММЕНТИР-ь ДЛЯ настрйк. десктопа!!!
    SetSort('FM');
  end;
  frmPlat.grdGrid.SetFocus;
end;

procedure TfmPlat.actNewCExecute(Sender: TObject);
begin
  PlatEditExec(Self, frmPlat.hdsGrid, 1, 1);
end;

procedure TfmPlat.actNewExecute(Sender: TObject);
begin
  PlatEditExec(Self, frmPlat.hdsGrid, 1, 0);
end;

procedure TfmPlat.actEditExecute(Sender: TObject);
begin
  PlatEditExec(Self, frmPlat.hdsGrid, 2, 0);
end;

procedure TfmPlat.actDelExecute(Sender: TObject);
begin
  PlatEditExec(Self, frmPlat.hdsGrid, 3, 0);
end;

procedure TfmPlat.actOkExecute(Sender: TObject);
begin
  if FormStyle = fsMDIChild then Close
    else ModalResult := mrOk;
end;

procedure TfmPlat.pgcPlatChange(Sender: TObject);
begin
  inherited;
  if pgcPlat.ActivePageIndex = 0 then
  begin
    frmNach.hdsGrid.Close;
    frmNach.actClearLocalFilter.Execute;
    frmPlat.grdGrid.SetFocus;
    exit;
  end;

  if QR.Empty(frmPlat.hdsGrid) then
  begin
    pgcPlat.ActivePageIndex := 0;
    exit;
  end;

  frmNach.grdGrid.SetFocus;
  with frmPlat.hdsGrid do
  if FileExists(DatabaseName + '\DOCS\doc_' +
     FieldByName('DOC_NUM').AsString + '.DBF') then
  begin
    frmNach.hdsGrid.Close;
    frmNach.hdsGrid.TableName := 'doc_' + FieldByName('DOC_NUM').AsString + '.DBF';
    frmNach.hdsGrid.Open;
  end
  else
    pgcPlat.ActivePageIndex := 0;
end;

procedure SetPlatAmount(aFrmPlat, aFrmNach: TfrmGrid);
begin
  //--Записываем реальную сумму
  aFrmPlat.D_off;
  with aFrmPlat.hdsGrid do
  try
    Edit;
    FieldByName('AMOUNT').AsFloat :=
      QR.GetAgregate(aFrmNach.hdsGrid.TableName, '', 'AMOUNT', aFrmNach.hdsGrid.DatabaseName);
//      IZ.Round2(QR.GetAgregate(aFrmNach.hdsGrid.TableName, '', 'AMOUNT', aFrmNach.hdsGrid.DatabaseName));
//      QR.GetAgregate(TableName, '', 'AMOUNT', DatabaseName);
    Post;
    aFrmPlat.actRefresh.Execute;
  finally
    aFrmPlat.D_on;
  end;
end;

procedure CheckAmount(aFrmPlat, aFrmNach: TfrmGrid);
var
  aV, aV1: Double;
begin
//  aV := QR.GetAgregate(aFrmNach.hdsGrid.TableName, '', 'AMOUNT', aFrmNach.hdsGrid.DatabaseName);
//  aV1 := aFrmPlat.hdsGrid.FieldByName('AMOUNT').AsFloat; //я так и не понял, почему обяз. округлять? иначе не равны!!!
  aV := IZ.Round2(QR.GetAgregate(aFrmNach.hdsGrid.TableName, '', 'AMOUNT', aFrmNach.hdsGrid.DatabaseName));
  aV1 := IZ.Round2(aFrmPlat.hdsGrid.FieldByName('AMOUNT').AsFloat); //я так и не понял, почему обяз. округлять? иначе не равны!!!
  if aV1 <> aV then
  begin
    aFrmPlat.D_off;
    with aFrmPlat.hdsGrid do
    try
      Edit;
      FieldByName('AMOUNT').AsFloat := aV;
      Post;
      aFrmPlat.actRefresh.Execute;
    finally
      aFrmPlat.D_on;
    end;
    MessageDlg('Внимание! Сумма документа подкорр-на. Т.к. не соотв. реальной.'#13 +
               'Старая сумма: ' + FloatToStr(aV1) + #13 +
               'Новая  сумма: ' + FloatToStr(aV), mtWarning, [mbOk], 0);
  end;
end;

procedure TfmPlat.actNewNExecute(Sender: TObject);
begin
  inherited;
  if pgcPlat.ActivePageIndex = 0 then exit;
  NachEditExec(Self, frmPlat, frmNach, frmNach.hdsGrid, 1, 0);
end;

procedure TfmPlat.actEditNExecute(Sender: TObject);
begin
  inherited;
  if pgcPlat.ActivePageIndex = 0 then exit;
  NachEditExec(Self, frmPlat, frmNach, frmNach.hdsGrid, 2, 0);
end;

procedure TfmPlat.actDelNExecute(Sender: TObject);
begin
  inherited;
  if pgcPlat.ActivePageIndex = 0 then exit;
  NachEditExec(Self, frmPlat, frmNach, frmNach.hdsGrid, 3, 0);
end;

procedure TfmPlat.actNewNCExecute(Sender: TObject);
begin
  inherited;
  if pgcPlat.ActivePageIndex = 0 then exit;
  NachEditExec(Self, frmPlat, frmNach, frmNach.hdsGrid, 1, 1);
end;

function TfmPlat.CheckNachMand: string;
var
  s, s1, s2: string;
begin
  Result := '';
  s := '';
  s1 := '';
  frmNach.D_off;
  with frmNach.hdsGrid do
  try
    First;
    while not frmNach.hdsGrid.Eof do
    begin
      s := '';
      if fs('FM', 1) = '' then s := s + 'Фамилия, ';
      if fs('NM', 1) = '' then s := s + 'Имя, ';
      if fs('LA', 1) = '' then s := s + 'Счет,';
      if (fs('RNN', 1) = '') or (length(fs('RNN', 1)) < 12) then s := s + 'РНН';
      if length(fs('RNN', 1)) = 12 then
      begin
        s2 := IZ.CheckRNN(fs('RNN', 1));
        if s2 <> '' then
          s2 := 'Неверный 12-й разряд в РНН: ' + fs('RNN', 1) + ', правильный: ' + s2[12] + ' или выполните для всех счетов операцию "Подогнать РНН"';
      end;
      if s2 <> '' then s := s + s2;
      if s <> '' then s1 := s1 + '(' +
        fs('FM', 1) + ',' +
        fs('NM', 1) + ',' +
        fs('FT', 1) + ',' +
        fs('LA', 1) + ',' +
        fs('RNN', 1) + ') не запол. [' + s + ']'#13;
      Next;
    end;
  finally
    frmNach.D_on;
  end;
  Result := s1;
end;

function TfmPlat.CheckNachDubl: string;       //-- Внимание запускать только после CheckNachMand
var
  s: string;
  vTable: THalcyonDataSet;
begin
  Result := '';
  s := '';

  frmNach.D_off;
  with frmNach.hdsGrid do
  try
    First;
    vTable := QR.GetOpen(Self, TableName, false, DataBaseName);
    try
      vTable.Filtered := true;
      while not frmNach.hdsGrid.Eof do
      begin
        vTable.Filter :=  '((LA=''' + FieldByName('LA').AsString + ''')or' +
                          '(RNN=''' + FieldByName('RNN').AsString + '''))and' +
                          '(ID<>' + FieldByName('ID').AsString + ')';
        vTable.Open;
        if not vTable.Eof then s := s +
            FieldByName('FM').AsString + ',' +
            FieldByName('NM').AsString + ',' +
            FieldByName('FT').AsString + ',' +
            FieldByName('LA').AsString + ',' +
            FieldByName('RNN').AsString + #13;
        vTable.Close;
        Next;
      end;
    finally
      vTable.Free;
    end;
  finally
    frmNach.D_on;
  end;
  Result := s;
end;

function TfmPlat.fs(const aFieldName: string; const aTableType: byte = 0): string;
begin
  if aTableType = 0 then
    Result := Trim(frmPlat.hdsGrid.FieldByName(aFieldName).AsString)
  else
    Result := Trim(frmNach.hdsGrid.FieldByName(aFieldName).AsString);
end;

function TfmPlat.ReplDec(const aStr: string; const aCvs: boolean = true): string;
begin
  if aCvs then
    Result := StringReplace(aStr, '.', ',', [rfReplaceAll, rfIgnoreCase])
  else
    Result := StringReplace(aStr, ',', '.', [rfReplaceAll, rfIgnoreCase])
end;

procedure TfmPlat.actMakeMTExecute(Sender: TObject);
const
  cEOLN = #13#10;
var
  f: TextFile;
  vLine, s, s1, s2: string;
  i: integer;

  function RS(const aStr: string): string;
  begin
    Result := StringReplace(aStr, '/', '\', [rfReplaceAll, rfIgnoreCase]);
    Result := StringReplace(Result, '{', '(', [rfReplaceAll, rfIgnoreCase]);
    Result := StringReplace(Result, '}', ')', [rfReplaceAll, rfIgnoreCase]);
  end;

begin
  if QR.Empty(frmNach.hdsGrid) then exit;
  if length(fmTools.edtPredCode.Text) < 9 then
  begin
    MessageDlg('Не заполнен код предприятия ! (в Настройках\Дополнительно)', mtError, [mbOk], 0);
    exit;
  end;

  s := CheckNachMand;
  if s <> '' then
  begin
    IZ.MsgMemo('Заполните обязательные поля:'#13 + s);
    exit;
  end;

{  s := CheckNachDubl;
  if  (s <> '') and
      (MessageDlg( 'Внимание! Существует повторение Счета или РНН :'#13#13 + s + #13 +
                   'Все равно продолжить ?', mtWarning, [mbYes, mbNo], 0) <> mrYes) then
  begin
    exit;
  end;}

  CheckAmount(frmPlat, frmNach);

  s := fmTools.dedZP102.Text + '\zp_' + frmPlat.hdsGrid.FieldByName('DOC_NUM').AsString + '.102';

  AssignFile(f, s);
  {$I-}
  Rewrite(f);
  {$I+}
  if IOResult > 0 then
  begin
    MessageDlg('Файл не создан ! (' + s + ')', mtError, [mbOk], 0);
    exit;
  end;

  vLine :=
  '{1:F01' + 'K' + copy(fs('BIC'), 3, 2) + copy(fs('BIC'), 7, 3) + '00' + '00000000000000}' + cEOLN +
  '{2:I102' + 'SGROSS00' + '0000U3003}' + cEOLN +
  '{4:' + cEOLN +
  ':20:' + fs('DOC_NUM') + cEOLN +
  ':50:/D/' + fs('ACCOUNT') + cEOLN +
  '/NAME/' + StrToOem(RS(fs('NAME'))) + cEOLN +
  '/RNN/' + fs('RNN') + cEOLN +
  '/CHIEF/' + StrToOem(RS(fs('CHIEF'))) + cEOLN +
  '/MAINBK/' + StrToOem(RS(fs('MAINBK'))) + cEOLN +
  '/IRS/' + fs('IRS') + cEOLN +
  '/SECO/' + fs('SECO') + cEOLN +
  ':52B:' + fs('BIC') + cEOLN +
  ':57B:'+ fs('BIC1') + cEOLN +
  ':59:' + fs('ACCOUNT1') + cEOLN +
  '/NAME/' + StrToOem(RS(fs('NAME1'))) + cEOLN +
  '/RNN/' + fs('RNN1') + cEOLN +
  '/IRS/' + fs('IRS1') + cEOLN +
  '/SECO/' + fs('SECO1') + cEOLN +
  ':70:/SEND/07' + cEOLN +
  '/VO/01' + cEOLN +
  '/PSO/01' + cEOLN +
  '/NUM/' + fs('DOC_NUM') + cEOLN +
  '/DATE/' + FormatDateTime('yyMMdd',
                            frmPlat.hdsGrid.FieldByName('DOC_DATE').AsDateTime) + cEOLN +
  '/KNP/' + fs('KNP') + cEOLN;

  s1 := StrToOem(fs('ASSIGN'));
  if fmTools.rgpProject.ItemIndex = 0 then
    s1 := '/ASSIGN/' + fmTools.edtPredCode.Text + s1
  else
    s1 := '/ASSIGN/' + s1;
  i := 1;
  s2 := copy(s1, i, 70);
  while s2 <> '' do
  begin
    vLine := vLine + s2 + cEOLN;
    i := i + 70;
    s2 := copy(s1, i, 70);
  end;

  write(f, vLine);  //-- Освобождаем память

  // список выплат
  i := 0;
  frmNach.D_off;
  frmNach.hdsGrid.First;
  with frmNach.hdsGrid do
  while not frmNach.hdsGrid.Eof do
  if FieldByName('AMOUNT').AsFloat > 0 then
  begin
    inc(i);
    vLine := ':21:' + IntToStr(i) + cEOLN;        //-- Внимание здесь заново пишем!
    vLine := vLine +
      ReplDec(':32B:' + 'KZT' + Trim(Format('%14.2f' , [FieldByName('AMOUNT').AsFloat]))) + cEOLN +
    ':70:' + cEOLN +
    '/FM/' + StrToOem(RS(fs('FM', 1))) + cEOLN +
    '/NM/' + StrToOem(RS(fs('NM', 1))) + cEOLN;
    if fs('FT', 1) <> '' then vLine := vLine + '/FT/' + StrToOem(RS(fs('FT', 1))) + cEOLN;
    vLine := vLine +
    '/RNN/' + StrToOem(fs('RNN', 1)) + cEOLN +
    '/LA/' + StrToOem(fs('LA', 1)) + cEOLN;
    write(f, vLine);
    Next;
  end
  else Next;

  frmNach.actPack.Execute;
//  frmNach.D_on; //--Это в actPack делается

  vLine :=                                         //-- Внимание здесь заново пишем!
  ReplDec(':32A:' + FormatDateTime('YYMMDD',
                                  frmPlat.hdsGrid.FieldByName('CCY_DATE').AsDateTime) +
          'KZT' + Trim(Format('%14.2f' , [frmPlat.hdsGrid.FieldByName('AMOUNT').AsFloat]))) + cEOLN +
  '-}' + cEOLN;

  write(f, vLine);
  CloseFile(f);

  if MessageDlg('Файл "' + ExtractFileName(s) + '" успешно сформирован !'#13#13 +
                'Скопировать на дискету ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    if CopyFileTo(s, 'a:\' + ExtractFileName(s)) then
      ShowMessage('Файл "' + ExtractFileName(s) + '" успешно сохранен на дискету !')
    else
      MessageDlg( 'Файл "' + ExtractFileName(s) + '" не скопирован на дискету !'#13#13 +
                  'Хотя успешно создан в папке: ' + ExtractFileDir(s), mtError, [mbOk], 0);

end;

procedure TfmPlat.actImportE2bExecute(Sender: TObject);
var
  vBadCount,
  i,
  vCount: integer;
  vTable: THalcyonDataSet;
  s, s1: string;
  f: TextFile;

begin
  vTable := frmNach.hdsGrid;
  with frmNach.actFileOpen.Dialog do
  begin
    DefaultExt := 'e2b';
    Filter := 'Файл нач. на карт-счета (*.e2b)|*.e2b';
    FileName:= fmTools.dedClientImp.Text + '\Выберите Файл.e2b';
    if Execute then
    begin
      if FileSizeByName(FileName) = 0 then
      begin
        MessageDlg('В импортируемом файле <' + FileName + '> нет записей !', mtWarning, [mbOk], 0);
        Exit;
      end;
      frmNach.D_off;
      try
        try
          AssignFile(f, FileName);
          Reset(f);
          //---Начинаем импортирование
          vBadCount := 0;
          vCount := 0;
          Readln(f, s);       //---Заголовок ненужен
          while not Eof(f) do
          begin
            Readln(f, s);

            s1 := Trim(copy(s, FieldsVed[1].From, FieldsVed[1].Len));

{            if (QR.CheckRowUniq(vTable.TableName,
                         'LA=''' + s1 + '''', vTable.DatabaseName)) and
               (MessageDlg('Внимание Счет - ' + s1 + ' уже существует!'#13 +
                         'Желаете все равно ввести ?', mtWarning, [mbYes, mbNo], 0) = mrNo) then
            begin
              inc(vBadCount);
            end
            else
}
            with vTable do
            begin
              Append;
              FieldByName('ID').AsInteger := QR.GenID(vTable.TableName, 'ID', vTable.DatabaseName);
              FieldByName('LA').AsString := trim(copy(s, FieldsVed[1].From, FieldsVed[1].Len));
              s1 := trim(copy(s, FieldsVed[2].From, FieldsVed[2].Len));
              FieldByName('FM').AsString := ExtractWord(1, s1, [' ', '.']);
              FieldByName('NM').AsString := ExtractWord(2, s1, [' ', '.']);
              FieldByName('FT').AsString := ExtractWord(3, s1, [' ', '.']);
              FieldByName('AMOUNT').AsFloat := StrToFloat(trim(copy(s, FieldsVed[3].From, FieldsVed[3].Len)));
              FieldByName('TAB_NUM').AsString := trim(copy(s, FieldsVed[5].From, FieldsVed[5].Len));
              FieldByName('RNN').AsString := trim(copy(s, FieldsVed[6].From, FieldsVed[6].Len));
              Post;
              inc(vCount);
            end;
          end;
          CloseFile(f);
          SetPlatAmount(frmPlat, frmNach);
          //-- Конец импорта
          MessageDlg('Импорт файла ' + FileName + ' завершен:' +
             #13#13'Импортировано записей :' + IntToStr(vCount - vBadCount) +
             #13'Не проимпорт. записей :' + IntToStr(vBadCount), mtInformation, [mbOk], 0);
        except
          on E:Exception do IZ.MsgException(E);
        end;
      finally
        frmNach.D_on;
      end;
    end;
  end;
end;

procedure TfmPlat.actSetSumExecute(Sender: TObject);
var
  vAmount: double;
  s: string;
begin
  if QR.Empty(frmNach.hdsGrid) then exit;

  with TfmSetAmount.Create(Self) do
  try
    Caption := 'Установка суммы';
    if ShowModal = mrOk then vAmount := edtAmount.Value
      else exit;
  finally
    Release;
  end;

  s := frmNach.grdGrid.Filter.FilterText;
  frmNach.D_off;
  with frmNach.hdsGrid do
  try
    Close;
    Filter := s;
    Filtered := true;
    Open;
    while not frmNach.hdsGrid.Eof do
    begin
      Edit;
      FieldByName('AMOUNT').AsFloat := vAmount;
      Post;
      Next;
    end;
    Close;
    Filter := '';
    Filtered := false;
    Open;
  finally
    frmNach.D_on;
  end;
  SetPlatAmount(frmPlat, frmNach);
end;

procedure TfmPlat.actDelAmountExecute(Sender: TObject);
var
  s: string;
begin
  if QR.Empty(frmNach.hdsGrid) then exit;

  if MessageDlg('Вы действительно желаете удалить записи выбранные по фильтру ?',
                 mtWarning, [mbYes, mbNo], 0) <> mrYes then exit;

  s := frmNach.grdGrid.Filter.FilterText;
  frmNach.D_off;
  with frmNach.hdsGrid do
  try
    Close;
    Filter := s;//frmNach.grdGrid.Filter.FilterText;
    Filtered := true;
    Open;
    while not frmNach.hdsGrid.Eof do Delete;
    Close;
    Filter := '';
    Filtered := false;
    Open;
  finally
    frmNach.D_on;
  end;
  SetPlatAmount(frmPlat, frmNach)
end;

procedure TfmPlat.actComAmountExecute(Sender: TObject);
var
  s: string;
  vSum,
  vTmp,
  vCom: double;
begin
  if QR.Empty(frmNach.hdsGrid) then exit;

  with TfmSetAmount.Create(Self) do
  try
    Caption := 'Снятие комисии';
    edtAmount.DecimalPlaces := 3;
    edtAmount.DisplayFormat := '0,000';
    lblCom.Visible := true;
    if ShowModal = mrOk then vCom := edtAmount.Value
      else exit;
  finally
    Release;
  end;

  if vCom = 0 then exit;

  s := frmNach.grdGrid.Filter.FilterText;
  vSum := 0;
  frmNach.D_off;
  with frmNach.hdsGrid do
  try
    Close;
    Filter := s;
    Filtered := true;
    Open;
    while not frmNach.hdsGrid.Eof do
    begin
      Edit;
      vTmp := IZ.Round2(FieldByName('AMOUNT').AsFloat * vCom/100);
      FieldByName('AMOUNT').AsFloat := FieldByName('AMOUNT').AsFloat - vTmp;
      vSum := vSum + vTmp;
      Post;
      Next;
    end;
    Close;
    Filter := '';
    Filtered := false;
    Open;
  finally
    frmNach.D_on;
  end;
  SetPlatAmount(frmPlat, frmNach);
  MessageDlg('Комиссии сняты на сумму: ' + FloatToStr(IZ.Round2(vSum)), mtConfirmation, [mbOk], 0);
end;

procedure TfmPlat.actMakeE2bExecute(Sender: TObject);
var
  f: TextFile;
  vLine, s, s1: string;
begin
  if QR.Empty(frmNach.hdsGrid) then exit;

  s := CheckNachMand;
  if s <> '' then
  begin
    IZ.MsgMemo('Заполните обязательные поля:'#13 + s);
    exit;
  end;

  s := CheckNachDubl;
  if  (s <> '') and
      (MessageDlg( 'Внимание! Существует повторение Счета или РНН :'#13#13 + s + #13 +
                   'Все равно продолжить ?', mtWarning, [mbYes, mbNo], 0) <> mrYes) then
  begin
    exit;
  end;

  CheckAmount(frmPlat, frmNach);

  s := fmTools.dedZP102.Text + '\' +
    frmPlat.hdsGrid.FieldByName('DOC_NUM').AsString + '_' + fmTools.edtBin.Text + '.e2b';

  AssignFile(f, s);
  {$I-}
  Rewrite(f);
  {$I+}
  if IOResult > 0 then
  begin
    MessageDlg('Файл не создан ! (' + s + ')', mtError, [mbOk], 0);
    exit;
  end;
  write(f, fmTools.edtBin.Text:3);
  write(f, copy(fs('NAME'),1,31):31);
  write(f, fs('DOC_NUM'):10);
  write(f, frmPlat.hdsGrid.RecordCount:4);
  write(f, frmPlat.hdsGrid.FieldByName('AMOUNT').AsFloat:15:2);
  writeln(f, 0.00:15:2);

  frmNach.D_off;
  with frmNach.hdsGrid do
  begin
    First;
    while not frmNach.hdsGrid.Eof do
    begin
      s1 := fs('FM',1) + ' ' + fs('NM',1)[1] + '.';
      if fs('FT',1) <> '' then s1 := s1 + fs('FT',1)[1] + '.';
      s1 := copy(s1, 1, FieldsVed[2].len);

      write(f, Format('%-' + IntToStr(FieldsVed[1].len) + 's',[fs('LA',1)]));
      write(f, Format('%-' + IntToStr(FieldsVed[2].len) +'s', [s1]));
      write(f, Format('%15.2f',[FieldByName('AMOUNT').AsFloat]));
      write(f, Format('%-' + IntToStr(FieldsVed[4].len) +'s',['KZT']));
      write(f, Format('%-' + IntToStr(FieldsVed[5].len) +'s',[fs('TAB_NUM',1)]));
      writeln(f, Format('%-' + IntToStr(FieldsVed[6].len) +'s',[fs('RNN',1)]));
      Next;
    end;
  end;
  frmNach.D_on;
  CloseFile(f);

  if MessageDlg('Файл "' + ExtractFileName(s) + '" успешно сформирован !'#13#13 +
                'Скопировать на дискету ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    if CopyFileTo(s, 'a:\' + ExtractFileName(s)) then
      ShowMessage('Файл "' + ExtractFileName(s) + '" успешно сохранен на дискету !')
    else
      MessageDlg( 'Файл "' + ExtractFileName(s) + '" не скопирован на дискету !'#13#13 +
                  'Хотя успешно создан в папке: ' + ExtractFileDir(s), mtError, [mbOk], 0);
end;

procedure TfmPlat.actImpNachExecute(Sender: TObject);
var
  vBadCount,
  vCount: integer;
  vTabFrom,
  vTable: THalcyonDataSet;
  s, s1: string;
begin
  vTable := frmNach.hdsGrid;
  with frmNach.actFileOpen.Dialog do
  begin
    DefaultExt := 'dbf';
    Filter := 'Файл начислений (*.dbf)|*.dbf';
    FileName:= QR.qPathDB + '\DOCS\Выберите Файл.dbf';
    if Execute then
    begin
      if FileSizeByName(FileName) = 0 then
      begin
        MessageDlg('В импортируемом файле <' + FileName + '> нет записей !', mtWarning, [mbOk], 0);
        Exit;
      end;
      frmNach.D_off;
      try
        try
          vTabFrom := QR.GetOpen(Self, ExtractFileName(FileName), true, ExtractFileDir(FileName));
          try
            //---Начинаем импортирование
            vBadCount := 0;
            vCount := 0;
            while not vTabFrom.Eof do
            begin
{              if (QR.CheckRowUniq(vTable.TableName,
                           'LA=''' + vTabFrom.FieldByName('LA').AsString + '''', vTable.DatabaseName)) and
                 (MessageDlg('Внимание Счет - ' + vTabFrom.FieldByName('LA').AsString + ' уже существует!'#13 +
                           'Желаете все равно ввести ?', mtWarning, [mbYes, mbNo], 0) = mrNo) then
              begin
                inc(vBadCount);
              end
              else
}
              with vTable do
              begin
                Append;
                FieldByName('ID').AsInteger := QR.GenID(vTable.TableName, 'ID', vTable.DatabaseName);
                FieldByName('FM').AsString := vTabFrom.FieldByName('FM').AsString;
                FieldByName('NM').AsString := vTabFrom.FieldByName('NM').AsString;
                FieldByName('FT').AsString := vTabFrom.FieldByName('FT').AsString;
                FieldByName('LA').AsString := vTabFrom.FieldByName('LA').AsString;
                FieldByName('AMOUNT').AsFloat := vTabFrom.FieldByName('AMOUNT').AsFloat;
                FieldByName('TAB_NUM').AsString := vTabFrom.FieldByName('TAB_NUM').AsString;
                FieldByName('RNN').AsString := vTabFrom.FieldByName('RNN').AsString;
                Post;
                inc(vCount);
              end;
              vTabFrom.Next;
            end;
            vTabFrom.Close;
            SetPlatAmount(frmPlat, frmNach);
            //-- Конец импорта
            MessageDlg('Импорт файла ' + FileName + ' завершен:' +
               #13#13'Импортировано записей :' + IntToStr(vCount - vBadCount) +
               #13'Не проимпорт. записей :' + IntToStr(vBadCount), mtInformation, [mbOk], 0);
          finally
            vTabFrom.Free;
          end;
        except
          on E:Exception do IZ.MsgException(E);
        end;
      finally
        frmNach.D_on;
      end;
    end;
  end;
end;

procedure TfmPlat.actImp102Execute(Sender: TObject);
var
  vBadCount,
  i,
  vCount: integer;
  vTable: THalcyonDataSet;
  s: string;
  f: TextFile;

  function NextNach: boolean;
  begin
    Result := false;
    //---Заголовок не нужен
    while not Eof(f) do
    begin
      Readln(f, s);
      if copy(s, 1, 4)=':21:' then
      begin
        Result := true;
        exit;
      end;
    end;
  end;

begin
  vTable := frmNach.hdsGrid;
  with frmNach.actFileOpen.Dialog do
  begin
    DefaultExt := '102';
    Filter := 'Файл начислений (*.102)|*.102';
    FileName:= fmTools.dedClientImp.Text + '\Выберите Файл.102';
    if Execute then
    begin
      if FileSizeByName(FileName) = 0 then
      begin
        MessageDlg('В импортируемом файле <' + FileName + '> нет записей !', mtWarning, [mbOk], 0);
        Exit;
      end;
      frmNach.D_off;
      try
        try
          AssignFile(f, FileName);
          Reset(f);
          //---Начинаем импортирование
          vBadCount := 0;
          vCount := 0;
          //---Заголовок не нужен
          while not Eof(f) do
          begin
            Readln(f, s);
            if copy(s, 1, 4)=':21:' then
            Break;
          end;
          //---Начинаем читать сотрудников
          while (not Eof(f)) and (copy(s, 1, 4) = ':21:') do
          with vTable do
          begin
            Readln(f, s); //:32B
            Append;
            FieldByName('ID').AsInteger := QR.GenID(vTable.TableName, 'ID', vTable.DatabaseName);
            FieldByName('AMOUNT').AsFloat := StrToFloat(ReplDec(Trim(copy(s, 9, 18)), false));
            Readln(f, s); //:70
            Readln(f, s); //:FM
            FieldByName('FM').AsString := OemToAnsiStr(Trim(copy(s, 5, 30)));
            Readln(f, s); //:NM
            FieldByName('NM').AsString := OemToAnsiStr(Trim(copy(s, 5, 30)));
            Readln(f, s); //:FT ожидается или РНН
            if copy(s, 1, 4) = '/FT/' then
            begin
              FieldByName('FT').AsString := OemToAnsiStr(Trim(copy(s, 5, 30)));
              Readln(f, s); //:RNN
            end;
            FieldByName('RNN').AsString := Trim(copy(s, 6, 12));
            Readln(f, s); //:LA
            FieldByName('LA').AsString := Trim(copy(s, 5, 20));

{            if (QR.CheckRowUniq(vTable.TableName,
                         'LA=''' + FieldByName('LA').AsString + '''', vTable.DatabaseName)) and
               (MessageDlg('Внимание Счет - ' + FieldByName('LA').AsString + ' уже существует!'#13 +
                         'Желаете все равно ввести ?', mtWarning, [mbYes, mbNo], 0) = mrNo) then
            begin
              inc(vBadCount);
              Cancel;
            end
            else
}
//            begin
              inc(vCount);
              Post;
//            end;
            Readln(f, s); //:21:
          end;
          CloseFile(f);
          SetPlatAmount(frmPlat, frmNach);
          //-- Конец импорта
          MessageDlg('Импорт файла ' + FileName + ' завершен:' +
             #13#13'Импортировано записей :' + IntToStr(vCount - vBadCount) +
             #13'Не проимпорт. записей :' + IntToStr(vBadCount), mtInformation, [mbOk], 0);
        except
          on E:Exception do IZ.MsgException(E);
        end;
      finally
        frmNach.D_on;
      end;
    end;
  end;
end;

procedure TfmPlat.actMakeRtfExecute(Sender: TObject);
var
  s: string;
  FileRep: TRtfWriter;
begin
  if QR.Empty(frmNach.hdsGrid) then exit;

  //--Нулевые суммы ненужны
  FileRep := TRtfWriter.Create;
  frmNach.D_off;
  with FileRep do
  try
    //--Нулевые суммы ненужны
    frmNach.hdsGrid.Close;
    frmNach.hdsGrid.Filter := 'AMOUNT>0';
    frmNach.hdsGrid.Filtered := true;
    frmNach.hdsGrid.Open;

    s := fmTools.dedClientExp.Text + '\' + 'rep_' + fs('DOC_NUM') + '.rtf';
    FileName := s;
    RGrid := frmNach.grdGrid;
    RDataSet := frmNach.hdsGrid;
    RFieldCount := fmTools.spdClmCount.Value;
    if RFieldCount > RDataSet.FieldCount then exit;
    if not Pr_InitRtf then
    begin
        MessageDlg(RtfError, mtError, [mbOk], 0);
        exit;
    end;

    //---Начинаю писать заголовок RTF
    TextSize:= 12;
    Pr_WriteText(fs('NAME'),1);
    Pr_WriteText('Индекс ' + fmTools.edtBin.Text, 2);
    TextAlign := 'c';
    TextStyle := ['b'];
    TextSize:= 14;
    Pr_WriteText('Сводная ведомость № ' + fs('DOC_NUM'), 1);
    TextStyle := [];
    TextSize:= 10;
    Pr_WriteText('от ' + fs('DOC_DATE'),2);
    TextSize:= 9;
    TextAlign := 'l';
    //---Начинаю писать таблицу в RTF
    TextAlign := 'r';
    if not Pr_WriteToTable then
    begin
      MessageDlg(RtfError, mtError, [mbOk], 0);
      exit;
    end;

    Pr_WriteText('',1);
    TextAlign := 'l';
    TextSize:= 12;
    Pr_WriteText('Количество сотрудников: ' + IntToStr(frmNach.hdsGrid.RecordCount),1);
    Pr_WriteText('Итого: ' + Format('%14.2f' , [frmPlat.hdsGrid.FieldByName('AMOUNT').AsFloat]) + ' тенге',2);
    TextAlign := 'c';
    Pr_WriteText(fmTools.edtChief.Text +  Format('%50s',[fs('CHIEF')]),2);
    Pr_WriteText(fmTools.edtMainBK.Text + Format('%50s',[fs('MAINBK')]),1);

    frmNach.hdsGrid.Close;
    frmNach.hdsGrid.Filter := '';
    frmNach.hdsGrid.Filtered := false;
    frmNach.hdsGrid.Open;

    //---Все закрываем файл Report
    Pr_CloseRtf;
    ShellExecute(Handle, 'open', PChar(s), nil, nil, SW_RESTORE);

  finally
    frmNach.D_on;
    FileRep.Free;
  end;
end;

procedure TfmPlat.actPodgonExecute(Sender: TObject);
var
  s, s1: string;
begin
  frmNach.D_off;
  try
    s1 := '';
    frmNach.hdsGrid.First;
    with frmNach.hdsGrid do
    while not frmNach.hdsGrid.Eof do
    begin
      if length(fs('RNN', 1))<12 then
      begin
        Edit;
        FieldByName('RNN').AsString := RnnPodgon;
        Post;
        s1 := s1 + 'Для счета ' + fs('LA', 1) + ' - полный подгон ' + RnnPodgon + #13;
      end
      else
      begin
        s := IZ.CheckRNN(fs('RNN', 1));
        if s <> '' then
        begin
          Edit;
          FieldByName('RNN').AsString := s;
          Post;
          s1 := s1 + 'Для счета ' + fs('LA', 1) + ' - корректировка в 12 разряде'#13;
        end;
      end;
      Next;
    end;

    if s1 <> '' then IZ.MsgMemo('Результат подгона РНН-ов:'#13 + s1);
    
  finally
    frmNach.D_on;
  end;
end;

end.
