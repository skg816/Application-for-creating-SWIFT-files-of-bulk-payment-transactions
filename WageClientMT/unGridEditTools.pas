unit unGridEditTools;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unxModal, dxTL, dxTLClms, dxCntner, Menus, Placemnt, ActnList,
  ToolWin, ComCtrls, StdCtrls, RxCombos, ExtCtrls, Grids, StdActns, unGrid,
  dxGrClms, dxDBTLCl, dxDBCtrl, dxDBGrid, IdGlobal, Buttons;

type
  TfmGridEditTools = class(TfmxModal)
    ToolButton1: TToolButton;
    actColor: TColorSelect;
    PopupMenu1: TPopupMenu;
    actSaveExpress: TAction;
    actSetImages: TAction;
    actClearImages: TAction;
    Splitter2: TSplitter;
    trlCustom: TdxTreeList;
    trlClmVisible: TdxTreeListCheckColumn;
    trlClmColumn: TdxTreeListColumn;
    trlClmField: TdxTreeListColumn;
    trlClmSumFooter: TdxTreeListColumn;
    trlClmSum: TdxTreeListColumn;
    trlClmColor: TdxTreeListColumn;
    trlClmClass: TdxTreeListColumn;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    edtTitle: TEdit;
    ccbColor: TColorComboBox;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    procedure trlCustomDblClick(Sender: TObject);
    procedure trlCustomDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure trlCustomDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure trlCustomStartDrag(Sender: TObject;
      var DragObject: TDragObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure trlCustomChangeNode(Sender: TObject; OldNode,
      Node: TdxTreeListNode);
    procedure actSetImagesExecute(Sender: TObject);
    procedure actClearImagesExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    frmTools: TfrmGrid;
    DragNode: TdxTreeListNode;
    procedure LoadItem;
  end;

const
  cExpressMain = 'Нет;Количество;Сумма;Мин.значение;Макс.значение;Среднее_значение';
  cExpressGroup = 'Нет;Количество';

implementation

uses unGridClmImg;
{$R *.dfm}

procedure TfmGridEditTools.trlCustomDblClick(Sender: TObject);
begin
  inherited;
  with TdxTreeListColumn(trlCustom.FocusedNode.Data), trlCustom.FocusedNode do
  begin
    Visible := not Visible;
    if Visible then
      Values[trlClmVisible.Index] := trlClmVisible.ValueChecked
    else
      Values[trlClmVisible.Index] := trlClmVisible.ValueUnchecked;
  end;
end;

procedure TfmGridEditTools.trlCustomDragDrop(Sender, Source: TObject; X,
  Y: Integer);
begin
  inherited;
  DragNode.MoveTo(trlCustom.FocusedNode, natlInsert);
  with TdxTreeListColumn(DragNode.Data) do
  if (trlCustom.FocusedNode <> nil) then Index := trlCustom.FocusedNode.AbsoluteIndex
    else Index := 0;
  trlCustom.OnChangeNode := trlCustomChangeNode;
  trlCustomChangeNode(trlCustom, trlCustom.FocusedNode, trlCustom.FocusedNode);
end;

procedure TfmGridEditTools.trlCustomDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  inherited;
  Accept := Source = Sender;
end;

procedure TfmGridEditTools.trlCustomStartDrag(Sender: TObject;
  var DragObject: TDragObject);
begin
  inherited;
  DragNode := TdxTreeList(Sender).FocusedNode;
  trlCustom.OnChangeNode := nil;
end;

procedure TfmGridEditTools.LoadItem;
var
  i: Integer;
begin
  trlCustom.ClearNodes;
  for i := 0 to frmTools.grdGrid.ColumnCount - 1 do
  with trlCustom.Add do
  begin
    if frmTools.grdGrid.Columns[i].Visible then
      Values[trlClmVisible.Index] := trlClmVisible.ValueChecked;
    Values[trlClmColumn.Index] := frmTools.grdGrid.Columns[i].Caption;
    Values[trlClmField.Index] := frmTools.grdGrid.Columns[i].FieldName;
    Values[trlClmClass.Index] := frmTools.grdGrid.Columns[i].ClassName;
    Values[trlClmSumFooter.Index] := IntToStr(Ord(frmTools.grdGrid.Columns[i].SummaryFooterType));
    Values[trlClmSum.Index] := frmTools.SummaryType(frmTools.grdGrid.Columns[i].Name);
    Values[trlClmColor.Index] := FloatToStr(frmTools.grdGrid.Columns[i].Font.Color);
    Data := frmTools.grdGrid.Columns[i];  //---Для ссылки на поле
  end;
end;

procedure TfmGridEditTools.FormShow(Sender: TObject);
begin
  inherited;

  trlCustom.OnChangeNode := nil;
  LoadItem;
  trlCustom.SetFocus;
  trlCustom.GotoFirst;
  with trlCustom.FocusedNode do
  begin
    edtTitle.Text := Values[trlClmColumn.Index];
    ccbColor.ColorValue := StrToCard(Values[trlClmColor.Index]);
  end;
  trlCustom.OnChangeNode := trlCustomChangeNode;
  trlCustomChangeNode(trlCustom, trlCustom.FocusedNode, trlCustom.FocusedNode);
end;

procedure TfmGridEditTools.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  trlCustomChangeNode(trlCustom, trlCustom.FocusedNode, trlCustom.FocusedNode);
  frmTools := nil;
  DragNode := nil;
  inherited;
end;

procedure TfmGridEditTools.trlCustomChangeNode(Sender: TObject; OldNode,
  Node: TdxTreeListNode);
begin
  inherited;
  with OldNode do
  begin
    Values[trlClmColumn.Index] := edtTitle.Text;
    Values[trlClmColor.Index] := FloatToStr(ccbColor.ColorValue);
  end;

  with TdxDBTreeListColumn(OldNode.Data) do
  begin
    Caption := edtTitle.Text;
    Font.Color := ccbColor.ColorValue;
  end;

  with Node do
  begin
    edtTitle.Text := Values[trlClmColumn.Index];
    ccbColor.ColorValue := StrToCard(Values[trlClmColor.Index]);
  end;
end;

procedure TfmGridEditTools.actSetImagesExecute(Sender: TObject);
var
  fmGridClmImg: TfmGridClmImg;
  vClm: TdxDBTreeListImageColumn;
  i: integer;
begin
  inherited;
  if (TdxDBGridColumn(trlCustom.FocusedNode.Data).ClassType <> TdxDBGridImageColumn) and
     (TdxDBGridColumn(trlCustom.FocusedNode.Data).ClassType <> TdxDBGridMaskColumn) then Exit;
     
  vClm := nil;
  //---Если поле не иконочное, то меняем тип поля
  if TdxDBGridColumn(trlCustom.FocusedNode.Data).ClassType <> TdxDBGridImageColumn then
  begin
    if MessageDlg('Вы действительно желаете назначить иконки для данного столбца?',
                    mtConfirmation, [mbYes, mbNo], 0) <> mrYes then Exit;
    vClm := TdxDBTreeListImageColumn(frmTools.ExchangeClmClass(TdxDBTreeListColumn(trlCustom.FocusedNode.Data)));
    trlCustom.FocusedNode.Data := vClm;
  end;
  with trlCustom.FocusedNode do
  begin
    Values[trlClmClass.Index] := 'TdxDBGridImageColumn';
    Values[trlClmSumFooter.Index] := '0';
    Values[trlClmSum.Index] := '0';
  end;
  //---Работаем с иконочным полем
  if vClm = nil then vClm := TdxDBTreeListImageColumn(trlCustom.FocusedNode.Data);
  fmGridClmImg := TfmGridClmImg.Create(Self);
  with fmGridClmImg do
  try
    //---Заполняем множество начальными значениями
    for i:=0 to vClm.ImageIndexes.Count - 1 do
    if vClm.ImageIndexes[i] <> '' then
    with trlClmImg.Add do
    begin
      Values[clmIndex.Index] := IntToStr(i);
      Values[clmValue.Index] := vClm.Values[i];
      Values[clmDescr.Index] := vClm.Descriptions[i];
    end;
    if ShowModal = mrOk then
    begin
      //---Очищаем списки
      vClm.ImageIndexes.Clear;
      vClm.Values.Clear;
      vClm.Descriptions.Clear;
      //---Заполняем множество начальными значениями
      for i:=0 to trlClmImg.Images.Count - 1 do
      begin
        vClm.ImageIndexes.Add('');
        vClm.Values.Add('');
        vClm.Descriptions.Add('');
      end;
      //---Заполняем списки
      for i:=0 to trlClmImg.Count - 1 do
      with trlClmImg.Items[i] do
      begin
        vClm.ImageIndexes[StrToInt(Values[clmIndex.Index])] := Values[clmIndex.Index];
        vClm.Values[StrToInt(Values[clmIndex.Index])] := Values[clmValue.Index];
        vClm.Descriptions[StrToInt(Values[clmIndex.Index])] := Values[clmDescr.Index];
      end;
    end;
  finally
    fmGridClmImg.Release;
  end;
end;

procedure TfmGridEditTools.actClearImagesExecute(Sender: TObject);
var
  vClm: TdxDBTreeListColumn;
begin
  inherited;
  if TdxDBGridColumn(trlCustom.FocusedNode.Data).ClassType<>TdxDBGridImageColumn then exit;

  if MessageDlg('Вы действительно желаете удалить иконки для данного столбца?',
                  mtConfirmation, [mbYes, mbNo], 0) <> mrYes then Exit;
  vClm := frmTools.ExchangeClmClass(TdxDBTreeListColumn(trlCustom.FocusedNode.Data), false);
  trlCustom.FocusedNode.Data := vClm;

  with trlCustom.FocusedNode do
  begin
    Values[trlClmClass.Index] := vClm.ClassName;
    Values[trlClmSumFooter.Index] := '0';
    Values[trlClmSum.Index] := '0';
  end;
end;

end.
