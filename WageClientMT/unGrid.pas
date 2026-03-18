unit unGrid;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, dxCntner, dxTL, dxDBCtrl, dxDBGrid, Menus, ActnList, DB,
  dxTLClms, dxGrClms, dxDBTLCl, ComCtrls, IdGlobal,
  StdActns, ExtActns, unDM, ImgList, DBClient, IniFiles, Buttons, StdCtrls,
  Midas, Halcn6DB;

type
  TfrmGrid = class(TFrame)
    pnlMain: TPanel;
    pnlMainLeft: TPanel;
    actGrid: TActionList;
    stbGrid: TStatusBar;
    actRefresh: TAction;
    popGrid: TPopupMenu;
    N1: TMenuItem;
    N3: TMenuItem;
    actShowGroup: TAction;
    actAutoWidth: TAction;
    actFileRun: TFileRun;
    actSaveFile: TFileSaveAs;
    N4: TMenuItem;
    N6: TMenuItem;
    N8: TMenuItem;
    actFullExpand: TAction;
    actFullCollapse: TAction;
    actSaveToXls: TAction;
    actSaveToHtml: TAction;
    actSaveToTxt: TAction;
    actSaveToXml: TAction;
    N14: TMenuItem;
    Excel1: TMenuItem;
    Html1: TMenuItem;
    ext1: TMenuItem;
    XML1: TMenuItem;
    actShowOwnerName: TAction;
    dsrGrid: TDataSource;
    pnlFilter: TPanel;
    edtFilter: TEdit;
    Label1: TLabel;
    SpeedButton1: TSpeedButton;
    actFilter: TAction;
    N16: TMenuItem;
    N17: TMenuItem;
    N2: TMenuItem;
    SpeedButton2: TSpeedButton;
    actViewFast: TAction;
    N9: TMenuItem;
    actShowFilter: TAction;
    actShowFilter1: TMenuItem;
    actInfo: TAction;
    grdGrid: TdxDBGrid;
    hdsGrid: THalcyonDataSet;
    actSync: TAction;
    actSave: TAction;
    N7: TMenuItem;
    actGridEdit: TAction;
    N10: TMenuItem;
    N11: TMenuItem;
    popAdmin: TMenuItem;
    N5: TMenuItem;
    actSync1: TMenuItem;
    actAdmin: TAction;
    actFileOpen: TFileOpen;
    actClearLocalFilter: TAction;
    actPack: TAction;
    N12: TMenuItem;
    N13: TMenuItem;
    actSaveToDbf: TAction;
    Dbf1: TMenuItem;
    actSaveToDbfFilter: TAction;
    Dbf2: TMenuItem;
    procedure actShowGroupExecute(Sender: TObject);
    procedure actAutoWidthExecute(Sender: TObject);
    procedure actShowFooterExecute(Sender: TObject);
    procedure actShowRowFooterExecute(Sender: TObject);
    procedure actShowLeftBandExecute(Sender: TObject);
    procedure actShowRightBandExecute(Sender: TObject);
    procedure actHideBandsExecute(Sender: TObject);
    procedure actFullExpandExecute(Sender: TObject);
    procedure actFullCollapseExecute(Sender: TObject);
    procedure actSaveToXlsExecute(Sender: TObject);
    procedure actSaveToHtmlExecute(Sender: TObject);
    procedure actSaveToTxtExecute(Sender: TObject);
    procedure actSaveToXmlExecute(Sender: TObject);
    procedure actShowOwnerNameExecute(Sender: TObject);
    procedure actFilterExecute(Sender: TObject);
    procedure actRefreshExecute(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure actViewFastExecute(Sender: TObject);
    procedure actShowFilterExecute(Sender: TObject);
    procedure actInfoExecute(Sender: TObject);
    procedure actSyncExecute(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure actGridEditExecute(Sender: TObject);
    procedure actAdminExecute(Sender: TObject);
    procedure actClearLocalFilterExecute(Sender: TObject);
    procedure actPackExecute(Sender: TObject);
    procedure grdGridCustomDrawCell(Sender: TObject; ACanvas: TCanvas;
      ARect: TRect; ANode: TdxTreeListNode; AColumn: TdxTreeListColumn;
      ASelected, AFocused, ANewItemRow: Boolean; var AText: String;
      var AColor: TColor; AFont: TFont; var AAlignment: TAlignment;
      var ADone: Boolean);
    procedure actSaveToDbfExecute(Sender: TObject);
    procedure actSaveToDbfFilterExecute(Sender: TObject);
  private
    function GetColumnClass(const Field: TField): TdxDBTreeListColumnClass;
    function GetColumnClassByName(const aClassName: string) :TdxDBTreeListColumnClass;
    function CreateColumnByField(const aNum: integer; const aField : TField): TdxDBTreeListColumn;
    function CreateColumnByClass(const aNum: integer; const aClassName, aFieldName: string): TdxDBTreeListColumn;
    function GetBandIndex(const aCaption: string): integer;
    procedure ShowBand(const aCaption: string; const aFix: TdxGridBandFixed; const aShow: boolean = true);
  public
    IsColumnsCreatedIni: boolean;

    procedure FileRun(const aFileName: string);
    procedure CreateGridColumns;
    function SummaryType(const aColumnName: string): string;
    function StrSorted(const aColumn :TdxDBTreeListColumn): string;
    procedure SetSummaryType(const aColumnName: string; const aNum: integer);
    function ExchangeClmClass(aOldClm: TdxDBTreeListColumn; const aDirect: boolean = true): TdxDBTreeListColumn;
    procedure DelSummaryItem(const aColumnName: string);
    function GetSummaryTypeByNum(const aNum: integer): TdxSummaryType;
    procedure D_off;
    procedure D_on;
    procedure ShowColumns(const aColumns: string; const aShow: boolean = true); //-- All = ''
    procedure SetSort(const aColumn: string; aAsc: boolean = true);

    procedure SaveGridMy;
    procedure LoadGridMy;
    procedure ReIndexColumns;

    procedure FrmInit(const aTable: string);
    procedure FrmFree;

    constructor Create(aOwner: TComponent); overload;
    destructor Destroy; overload;
  end;

implementation

uses unInitialize, RxStrUtils, ToolEdit, unTools, unSql, unGridEditTools;
{$R *.dfm}

function TfrmGrid.GetColumnClass(const Field : TField) :TdxDBTreeListColumnClass;
begin
  if Field.FieldKind <> fkLookup then
  case Field.DataType of
    ftBoolean:  Result := TdxDBGridCheckColumn;
    ftDate,
    ftDateTime: Result := TdxDBGridDateColumn;
    ftBlob: Result := TdxDBGridBlobColumn;
    ftFmtMemo,
    ftMemo: Result := TdxDBGridMemoColumn;
    ftTypedBinary,
    ftGraphic: Result := TdxDBGridGraphicColumn;
    ftSmallint,
    ftInteger,
    ftWord,
    ftFloat,
    ftBCD,
    ftCurrency,
    ftBytes,
    ftVarBytes,
    ftAutoInc,
    ftFMTBcd,
    ftLargeint: Result := TdxDBGridMaskColumn;
    else Result := TdxDBGridButtonColumn;
  end
    else Result := TdxDBGridLookupColumn;
end;

function TfrmGrid.GetColumnClassByName(const aClassName: string) :TdxDBTreeListColumnClass;
begin
     if aClassName = 'TdxDBGridCheckColumn' then Result := TdxDBGridCheckColumn
      else if aClassName = 'TdxDBGridDateColumn' then Result := TdxDBGridDateColumn
      else if aClassName = 'TdxDBGridBlobColumn' then Result := TdxDBGridBlobColumn
      else if aClassName = 'TdxDBGridMemoColumn' then Result := TdxDBGridMemoColumn
      else if aClassName = 'TdxDBGridGraphicColumn' then Result := TdxDBGridGraphicColumn
      else if aClassName = 'TdxDBGridMaskColumn' then Result := TdxDBGridMaskColumn
      else if aClassName = 'TdxDBGridButtonColumn' then Result := TdxDBGridButtonColumn
      else if aClassName = 'TdxDBGridImageColumn' then Result := TdxDBGridImageColumn     //---Если были ручные переназначения
      else Result := TdxDBGridButtonColumn;
end;

function TfrmGrid.CreateColumnByField(const aNum: integer; const aField : TField): TdxDBTreeListColumn;
begin
  Result := nil;
  Result := grdGrid.CreateColumn(GetColumnClass(aField));
  Result.Name := Self.Name + '_Clm' + IntToStr(aNum);
  Result.FieldName := aField.FieldName;
//  Result.Tag := aNum;  //---Для быстрого доступа
end;

function TfrmGrid.CreateColumnByClass(const aNum: integer; const aClassName, aFieldName: string): TdxDBTreeListColumn;
begin
  Result := nil;
  Result := grdGrid.CreateColumn(GetColumnClassByName(aClassName));
  Result.Name := Self.Name + '_Clm' + IntToStr(aNum);
  Result.FieldName := aFieldName;
//  Result.Tag := aNum;  //---Для быстрого доступа
  Result.BandIndex := 1;  //---Для center Band
  //---Добавляем целые поля, которые можно использовать в Footer-e групп
  if Result.ClassType = TdxDBGridMaskColumn then
  with grdGrid.SummaryGroups[0].SummaryItems.Add do
  begin
    ColumnName := Result.Name;
    SummaryField := Result.FieldName;
    SummaryType := cstNone;
  end;
end;

procedure TfrmGrid.CreateGridColumns;
var
  i : byte;
  Column :TdxDBTreeListColumn;
begin
  inherited;
  if (not hdsGrid.Active) or (grdGrid.ColumnCount > 0) then exit;
  with hdsGrid do
  for i := 0 to FieldCount - 1 do
    if Fields[i].FullName <> '' then CreateColumnByField(i, Fields[i]);
end;

procedure TfrmGrid.actShowGroupExecute(Sender: TObject);
begin
  grdGrid.ShowGroupPanel := not grdGrid.ShowGroupPanel;
end;

procedure TfrmGrid.actAutoWidthExecute(Sender: TObject);
begin
  if not (edgoAutoWidth in grdGrid.OptionsView) then
     grdGrid.OptionsView := grdGrid.OptionsView + [edgoAutoWidth]
  else
     grdGrid.OptionsView := grdGrid.OptionsView - [edgoAutoWidth];
end;

procedure TfrmGrid.actShowFooterExecute(Sender: TObject);
begin
  grdGrid.ShowSummaryFooter := not grdGrid.ShowSummaryFooter;
end;

procedure TfrmGrid.actShowRowFooterExecute(Sender: TObject);
begin
  grdGrid.ShowRowFooter := not grdGrid.ShowRowFooter;
end;

procedure TfrmGrid.FileRun(const aFileName: string);
begin
  with actFileRun do
  begin
    Directory := ExtractFileDir(aFileName);
    FileName := ExtractFileName(aFileName);
    Parameters := '';
    Execute;
  end;
end;

function TfrmGrid.GetBandIndex(const aCaption: string): integer;
begin
  Result := 0;
  if aCaption = grdGrid.Bands[0].Caption then Result := 0
  else if aCaption = grdGrid.Bands[1].Caption then Result := 1
  else if aCaption = grdGrid.Bands[2].Caption then Result := 2;
end;

procedure TfrmGrid.ShowBand(const aCaption: string; const aFix: TdxGridBandFixed; const aShow: boolean = true);
begin
  inherited;
  with grdGrid.Bands[GetBandIndex(aCaption)] do
  begin
    if aShow then
    begin
      Visible := true;
      Fixed := aFix;
    end
    else
      Visible := false;
  end;
end;

procedure TfrmGrid.actShowLeftBandExecute(Sender: TObject);
begin
  ShowBand('left', bfLeft);
end;

procedure TfrmGrid.actShowRightBandExecute(Sender: TObject);
begin
  ShowBand('right', bfRight);
end;

procedure TfrmGrid.actHideBandsExecute(Sender: TObject);
begin
  ShowBand('left', bfLeft, false);
  ShowBand('right', bfRight, false);
end;

procedure TfrmGrid.actFullExpandExecute(Sender: TObject);
begin
  grdGrid.FullExpand;
end;

procedure TfrmGrid.actFullCollapseExecute(Sender: TObject);
begin
  grdGrid.FullCollapse;
end;

procedure TfrmGrid.actSaveToXlsExecute(Sender: TObject);
begin
  with actSaveFile.Dialog do
  begin
    DefaultExt := 'xls';
    Filter := 'Microsoft Excel 4.0 Worksheet (*.xls)|*.xls';
    InitialDir := fmTools.dedClientExp.Text;
    FileName := 'table' + '.xls';
    if Execute then
    try
      Screen.Cursor := crSQLWait;
      grdGrid.SaveToXLS(FileName, true);
      FileRun(FileName);
    finally
      Screen.Cursor := crDefault;
    end;
  end;
end;

procedure TfrmGrid.actSaveToHtmlExecute(Sender: TObject);
begin
  with actSaveFile.Dialog do
  begin
    DefaultExt := 'htm';
    Filter := 'Web Page (*.htm)|*.htm';
    InitialDir := fmTools.dedClientExp.Text;
    FileName := 'table' + '.htm';
    if Execute then
    try
      Screen.Cursor := crSQLWait;
      grdGrid.SaveToHTML(FileName, true);
      FileRun(FileName);
    finally
      Screen.Cursor := crDefault;
    end;
  end;
end;

procedure TfrmGrid.actSaveToTxtExecute(Sender: TObject);
begin
  with actSaveFile.Dialog do
  begin
    DefaultExt := 'txt';
    Filter := 'Text File (*.txt)|*.txt';
    InitialDir := fmTools.dedClientExp.Text;
    FileName := 'table' + '.txt';
    if Execute then
    try
      Screen.Cursor := crSQLWait;
      grdGrid.SaveToText(FileName, true, ',', '', '');
      FileRun(FileName);
    finally
      Screen.Cursor := crDefault;
    end;
  end;
end;

procedure TfrmGrid.actSaveToXmlExecute(Sender: TObject);
begin
  with actSaveFile.Dialog do
  begin
    DefaultExt := 'xml';
    Filter := 'Web Page (*.xml)|*.xml';
    InitialDir := fmTools.dedClientExp.Text;
    FileName := 'table' + '.xml';
    if Execute then
    try
      Screen.Cursor := crSQLWait;
      grdGrid.SaveToXML(FileName, true);
      FileRun(FileName);
    finally
      Screen.Cursor := crDefault;
    end;
  end;
end;

procedure TfrmGrid.actShowOwnerNameExecute(Sender: TObject);
begin
  IZ.MsgMemo(Self.Owner.Name);
end;

function TfrmGrid.ExchangeClmClass(aOldClm: TdxDBTreeListColumn; const aDirect: boolean = true): TdxDBTreeListColumn;
var
  s: string;
begin
  if aDirect then
  begin
    if aOldClm.ClassName = 'TdxDBGridMaskColumn' then DelSummaryItem(aOldClm.Name);
    Result := grdGrid.CreateColumn(TdxDBGridImageColumn);
  end
  else Result := grdGrid.CreateColumn(GetColumnClass(hdsGrid.FieldByName(aOldClm.FieldName)));

  with Result do
  try
    Caption := aOldClm.Caption;
    FieldName := aOldClm.FieldName;
    BandIndex := aOldClm.BandIndex;
    RowIndex := aOldClm.RowIndex;
    Font.Color := aOldClm.Font.Color;
    ColIndex := aOldClm.ColIndex;
    Index := aOldClm.Index;
    Width := aOldClm.Width;
    Sorted := aOldClm.Sorted;
    TdxDBGridColumn(Result).GroupIndex := TdxDBGridColumn(aOldClm).GroupIndex;
    Visible := aOldClm.Visible;
    SummaryFooterType := aOldClm.SummaryFooterType;
    s := aOldClm.Name;
    aOldClm.Name := aOldClm.Name + 'Deleted';
    Name := s;
    if aDirect then
    begin
      TdxDBGridImageColumn(Result).Images := TImageList(actGrid.Images);
      TdxDBGridImageColumn(Result).ShowDescription := true;
    end;
    //---Добавляем целые поля, которые можно использовать в Footer-e групп
    if (not aDirect) and (ClassName = 'TdxDBGridMaskColumn') then
    with grdGrid.SummaryGroups[0].SummaryItems.Add do
    begin
      ColumnName := Result.Name;
      SummaryField := Result.FieldName;
      SummaryType := cstNone;
    end;
  finally
    aOldClm.Free;
  end;
end;

procedure TfrmGrid.DelSummaryItem(const aColumnName: string);
var
  i: integer;
begin
  //---Ищем в подвальных выражениях текущий Column
  if grdGrid.SummaryGroups[0].SummaryItems.Count > 0 then
  for i:=0 to grdGrid.SummaryGroups[0].SummaryItems.Count - 1 do
  with grdGrid.SummaryGroups[0].SummaryItems[i] do
  if ColumnName = aColumnName then
  begin
     Destroy;
     Break;
  end;
end;

function TfrmGrid.SummaryType(const aColumnName: string): string;
var
  i: integer;
begin
  Result := '0';
  //---Ищем в подвальных выражениях текущий Column
  if grdGrid.SummaryGroups[0].SummaryItems.Count > 0 then
  for i:=0 to grdGrid.SummaryGroups[0].SummaryItems.Count - 1 do
  with grdGrid.SummaryGroups[0].SummaryItems[i] do
  if ColumnName = aColumnName then Result := IntToStr(Ord(SummaryType));           //TdxSummaryType = (cstNone, cstSum, cstMin, cstMax, cstCount, cstAvg);
end;

procedure TfrmGrid.SetSummaryType(const aColumnName: string; const aNum: integer);
var
  i: integer;
begin
  //---Ищем в подвальных выражениях текущий Column
  if grdGrid.SummaryGroups[0].SummaryItems.Count > 0 then
  for i:=0 to grdGrid.SummaryGroups[0].SummaryItems.Count - 1 do
  with grdGrid.SummaryGroups[0].SummaryItems[i] do
  if ColumnName = aColumnName then SummaryType := GetSummaryTypeByNum(aNum);
end;

function TfrmGrid.StrSorted(const aColumn :TdxDBTreeListColumn): string;
begin
  with aColumn do
  if Sorted = csNone then Result := '-1'
    else if Sorted = csUp then Result := '1'
      else Result := '0';
end;

function TfrmGrid.GetSummaryTypeByNum(const aNum: integer): TdxSummaryType;
begin
  case aNum of
    0: Result := cstNone;
    1: Result := cstSum;
    2: Result := cstMin;
    3: Result := cstMax;
    4: Result := cstCount;
    5: Result := cstAvg;
    else Result := cstNone;
  end
end;


procedure TfrmGrid.actFilterExecute(Sender: TObject);
begin
  if Trim(edtFilter.Text) = '' then
  begin
    hdsGrid.Filtered := false;
    hdsGrid.Filter := '';
  end
  else
  begin
    hdsGrid.Filter := Trim(edtFilter.Text);
    hdsGrid.Filtered := true;
  end;
  actRefresh.Execute;
end;

procedure TfrmGrid.actRefreshExecute(Sender: TObject);
var
  vRecID: string;
  vActive: boolean;
begin
  vRecID := '-1';
  vActive := hdsGrid.Active;    //-- При открытии будет нужно
  if (vActive) and (hdsGrid.RecordCount > 0) then vRecID := hdsGrid.FieldByName('ID').AsString;
  hdsGrid.Close;
  hdsGrid.Open;
  if vRecID <> '-1' then hdsGrid.Locate('ID', vRecID, []);
end;

procedure TfrmGrid.SpeedButton2Click(Sender: TObject);
begin
  IZ.MsgMemo(
  'name like ''Констан%'''#13 +
  'name like ''%нстанин%'''#13 +
  '(name like ''Гульн%'') and (family like ''%ковна'')'#13 +
  '(zarplata = 500000) or (rnn = ''600450024445'')'#13 +
  '(zarplata > 8000000) or (nalog = pod_nalog + nds)'#13
  );
end;

procedure TfrmGrid.actViewFastExecute(Sender: TObject);
var
  i, j: integer;
  s: string;
begin
  inherited;
    s := '';
    for i:=0 to grdGrid.ColumnCount - 2 do  //-- 2 - потому что ID__
    with grdGrid.Columns[i] do
    begin
      j := grdGrid.Columns[i].Tag;
      s := s + Field.AsString + #13;
    end;
    IZ.MsgMemo(s, 'Быстрый просмотр');
end;

procedure TfrmGrid.D_off;
begin
  dsrGrid.DataSet := nil;
end;

procedure TfrmGrid.D_on;
begin
  dsrGrid.DataSet := hdsGrid;
end;

procedure TfrmGrid.actShowFilterExecute(Sender: TObject);
begin
  pnlFilter.Visible := not pnlFilter.Visible;
end;

procedure TfrmGrid.actInfoExecute(Sender: TObject);
var
  s: string;
begin
  s := s +
      'Active: ' + IntToStr(ord(hdsGrid.Active)) + #13 +
      'DataBaseName: ' + hdsGrid.DataBaseName + #13 +
      'TableName: ' + hdsGrid.TableName + #13 +
      'Filtered: ' + IntToStr(ord(hdsGrid.Filtered)) + #13 +
      'Filter: ' + hdsGrid.Filter + #13 +
      'IsColumnsCreatedIni: ' + IntToStr(ord(IsColumnsCreatedIni)) + #13;
  IZ.MsgMemo(s);
end;

constructor TfrmGrid.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
end;

destructor TfrmGrid.Destroy;
begin
  inherited Destroy;
end;

procedure TfrmGrid.ShowColumns(const aColumns: string; const aShow: boolean = true);
var
  i: integer;
  vStr: TStringList;
begin
  vStr := TStringList.Create;
  with vStr do
  try
    if aColumns = '' then
    for i:=0 to grdGrid.ColumnCount - 1 do grdGrid.Columns[i].Visible := aShow;
    Delimiter := ';';
    DelimitedText := aColumns;
    for i:=0 to vStr.Count - 1 do
      if vStr[i] <> '' then grdGrid.ColumnByFieldName(vStr[i]).Visible := aShow;
  finally
    vStr.Free;
  end;
end;

procedure TfrmGrid.SetSort(const aColumn: string; aAsc: boolean);
begin
  with grdGrid.ColumnByFieldName(aColumn) do
  if aAsc then Sorted := csUp
    else Sorted := csDown;
end;

procedure TfrmGrid.SaveGridMy;
var
  i: integer;
  GI: TIniFile;
begin
  inherited;
  GI := TIniFile.Create(IZ.AppDir + 'DeskTop\' + Self.Name + '.ini');
  try
    GI.WriteString('Main', 'ShowGrid', IntToStr(Ord(grdGrid.ShowGrid)));
    GI.WriteString('Main', 'ShowPreviewGrid', IntToStr(Ord(grdGrid.ShowPreviewGrid)));
    GI.WriteString('Main', 'ShowNewItemRow', IntToStr(Ord(grdGrid.ShowNewItemRow)));
    GI.WriteString('Main', 'BandRowCount', IntToStr(grdGrid.BandRowCount));
    GI.WriteString('Main', 'HeaderPanelRowCount', IntToStr(grdGrid.HeaderPanelRowCount));
    GI.WriteString('Main', 'edgoAutoWidth', IntToStr(Ord(edgoAutoWidth in grdGrid.OptionsView)));
    GI.WriteString('Main', 'ColumnCount', IntToStr(grdGrid.ColumnCount));

    //---Сохраняем поля
    for i:=0 to grdGrid.ColumnCount - 1 do
    with grdGrid.Columns[i] do
    begin
      //---а это сам
      GI.WriteString(Name, 'Caption', Caption);
      GI.WriteString(Name, 'ClassName', ClassName);
      GI.WriteString(Name, 'FieldName', FieldName);
      //---По идее делает сам Grid
      GI.WriteString(Name, 'BandIndex', IntToStr(BandIndex));
      GI.WriteString(Name, 'RowIndex', IntToStr(RowIndex));
      GI.WriteString(Name, 'ColIndex', IntToStr(ColIndex));
      GI.WriteString(Name, 'Index', IntToStr(Index));
      GI.WriteString(Name, 'Width', IntToStr(Width));
      GI.WriteString(Name, 'Visible', IntToStr(Ord(Visible)));
      GI.WriteString(Name, 'FontColor', FloatToStr(Font.Color));
    end;  //---End For
  finally
    GI.Free;
  end;
end;

procedure TfrmGrid.LoadGridMy;
var
  vClmCnt, i: integer;
  Column :TdxDBTreeListColumn;
  GI: TIniFile;
begin
  inherited;
  GI := TIniFile.Create(IZ.AppDir + 'DeskTop\' + Self.Name + '.ini');
  try
    if GI.ReadString('Main', 'ColumnCount','0') = '0' then
    begin
      CreateGridColumns;
      actSave.Execute;
      exit;
    end;

    IsColumnsCreatedIni := true;

    vClmCnt := 0;

    with grdGrid do
    begin
      //---По идее делает сам Grid
      ShowGrid := GI.ReadString('Main', 'ShowGrid','0') = '1';
      ShowPreviewGrid := GI.ReadString('Main', 'ShowPreviewGrid','0') = '1';
      ShowNewItemRow := GI.ReadString('Main', 'ShowNewItemRow','0') = '1';
      BandRowCount := StrToInt(GI.ReadString('Main', 'BandRowCount','0'));
      HeaderPanelRowCount := StrToInt(GI.ReadString('Main', 'HeaderPanelRowCount','0'));
      if (GI.ReadString('Main', 'edgoAutoWidth','0') = '1') and
        (not(edgoAutoWidth in OptionsView)) then OptionsView := OptionsView + [edgoAutoWidth];
      vClmCnt := StrToInt(GI.ReadString('Main', 'ColumnCount','0'));
    end;

    for i := 0 to vClmCnt - 1 do
    begin
      Column := CreateColumnByClass(i,
                                    GI.ReadString(Self.Name + '_Clm' + IntToStr(i), 'ClassName',''),
                                    GI.ReadString(Self.Name + '_Clm' + IntToStr(i), 'FieldName','')
                                    );
      with Column do
      begin
        BandIndex := StrToInt(GI.ReadString(Name, 'BandIndex','0'));
        RowIndex := StrToInt(GI.ReadString(Name, 'RowIndex','0'));
        ColIndex := StrToInt(GI.ReadString(Name, 'ColIndex','0'));
        Index := StrToInt(GI.ReadString(Name, 'Index','0'));
        Width := StrToInt(GI.ReadString(Name, 'Width','0'));
        Visible := GI.ReadString(Name, 'Visible','0') = '1';
        Caption := GI.ReadString(Name, 'Caption','');
        Font.Color := StrToCard(GI.ReadString(Name, 'FontColor','0'));
        if Caption = '' then
        begin
          Caption := FieldName;
          Width := Width + 1; //---Это для обмана грида, якобы изменилась ширина
        end;
      end;
    end;
  finally
    GI.Free;
  end;
end;

procedure TfrmGrid.ReIndexColumns;
var
  i: integer;
begin
  //---Переиндексируем название компонент колумов
  //---Устанавл временные имена
  for i:=0 to grdGrid.ColumnCount - 1 do
  with grdGrid.Columns[i] do Name := Name + 'T';
  //---Записываем новые имена
  for i:=0 to grdGrid.ColumnCount - 1 do
  with grdGrid.Columns[i] do
  begin
    Name := Self.Name + '_Clm' + IntToStr(i);
    Tag := i; //---Для быстрого доступа
  end;
end;

procedure TfrmGrid.actSyncExecute(Sender: TObject);
var
  i: integer;
  ColumnExists: boolean;
begin
  inherited;
  if not hdsGrid.Active then exit;
  //---Ищем совпадающие столбцы с филдами запроса. Ненайденные фильды помечаем в MaxLength=1000
  for i:=0 to grdGrid.ColumnCount - 1 do
  if not QR.FieldExists(grdGrid.Columns[i].FieldName, hdsGrid) then
    grdGrid.Columns[i].MaxLength := 1000
  else
    hdsGrid.FieldByName(grdGrid.Columns[i].FieldName).Tag := 1;
  //---Удаляем помеченные колумы
  ColumnExists := true;
  while ColumnExists do
  begin
    ColumnExists := false;
    for i:=0 to grdGrid.ColumnCount - 1 do
    if grdGrid.Columns[i].MaxLength = 1000 then
    begin
      grdGrid.Columns[i].Destroy;
      ColumnExists := true;
      Break;
    end;
  end;
  //---Создаем отсутствующие филды в grid-е
  for i:=0 to hdsGrid.Fields.Count - 1 do
    if hdsGrid.Fields[i].Tag <> 1 then CreateColumnByField(1000 + i, hdsGrid.Fields[i]);

  ReIndexColumns;

  ShowMessage('Синхронизация прошла успешно!');
end;

procedure TfrmGrid.actSaveExecute(Sender: TObject);
begin
  ReIndexColumns;
  SaveGridMy;
end;

procedure TfrmGrid.FrmFree;
begin
  hdsGrid.Close;
  grdGrid.DestroyColumns;
end;

procedure TfrmGrid.FrmInit(const aTable: string);
begin
  grdGrid.KeyField := 'ID';
  hdsGrid.DatabaseName := fmTools.dedBase.Text;
  hdsGrid.TableName := aTable;
  IsColumnsCreatedIni := false;
end;

procedure TfrmGrid.actGridEditExecute(Sender: TObject);
var
  fmGridEditTools: TfmGridEditTools;
begin
  if grdGrid.ColumnCount = 0 then exit;

  fmGridEditTools := TfmGridEditTools.Create(Self);
  with fmGridEditTools do
  try
    frmTools := Self;
    ShowModal;
  finally
    frmTools := nil;
    Release;
  end;
end;

procedure TfrmGrid.actAdminExecute(Sender: TObject);
begin
  popAdmin.Visible := not popAdmin.Visible;
end;

procedure TfrmGrid.actClearLocalFilterExecute(Sender: TObject);
begin
  grdGrid.Filter.Clear;
end;

procedure TfrmGrid.actPackExecute(Sender: TObject);
begin
  D_off;
  hdsGrid.Close;
  hdsGrid.Exclusive := true;
  try
    hdsGrid.Open;
    hdsGrid.Pack;
    hdsGrid.Close;
    hdsGrid.Exclusive := false;
    hdsGrid.Open;
  except
    on E:Exception do
    begin
      IZ.MsgException(E);
      hdsGrid.Close;
      hdsGrid.Exclusive := false;
      hdsGrid.Open;
    end;
  end;
  D_on;
end;

procedure TfrmGrid.grdGridCustomDrawCell(Sender: TObject; ACanvas: TCanvas;
  ARect: TRect; ANode: TdxTreeListNode; AColumn: TdxTreeListColumn;
  ASelected, AFocused, ANewItemRow: Boolean; var AText: String;
  var AColor: TColor; AFont: TFont; var AAlignment: TAlignment;
  var ADone: Boolean);
begin
  if (aSelected) and (aFocused) then
  begin
    aColor := clGreen;//Purple;
    aFont.Color := clWhite;
  end;
end;

procedure TfrmGrid.actSaveToDbfExecute(Sender: TObject);
begin
  with actSaveFile.Dialog do
  begin
    DefaultExt := 'dbf';
    Filter := 'dBase IV (*.dbf)|*.dbf';
    InitialDir := fmTools.dedClientExp.Text;
    FileName := 'table' + '.dbf';
    if Execute then
    try
      Screen.Cursor := crSQLWait;
      hdsGrid.CopyTo(FileName, '');
      //FileRun(FileName);
    finally
      Screen.Cursor := crDefault;
    end;
  end;
end;

procedure TfrmGrid.actSaveToDbfFilterExecute(Sender: TObject);
var
  s: string;
begin
  with actSaveFile.Dialog do
  begin
    DefaultExt := 'dbf';
    Filter := 'dBase IV (*.dbf)|*.dbf';
    InitialDir := fmTools.dedClientExp.Text;
    FileName := 'table' + '.dbf';
    if Execute then
    try
      Screen.Cursor := crSQLWait;
      s := grdGrid.Filter.FilterText;
      D_off;
      with hdsGrid do
      try
        Close;
        Filter := s;
        Filtered := true;
        Open;
        hdsGrid.CopyTo(FileName, '');
        Close;
        Filter := '';
        Filtered := false;
        Open;
        //FileRun(FileName);
      except
        on E:Exception do
        begin
          Close;
          Filter := '';
          Filtered := false;
          Open;
          IZ.MsgException(E);
        end;
      end;
    finally
      D_on;
      Screen.Cursor := crDefault;
    end;
  end;
end;

end.
