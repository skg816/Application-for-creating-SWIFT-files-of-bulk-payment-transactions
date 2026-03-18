unit Main;

interface

uses
  Windows, Forms, dxGrClms, dxDBGrid, Db, DBTables, StdCtrls, dxTLClms, dxTL,
  dxCntner, Controls, ExtCtrls, Classes, dxDBTLCl, dxDBCtrl, dxExEdtr;

type
  TMainForm = class(TForm)
    Panel1: TPanel;
    Spliter1: TSplitter;
    Table1: TTable;
    DataSource1: TDataSource;
    dxDBGrid1: TdxDBGrid;
    TLCustomize: TdxTreeList;
    TLCustomizeColumn: TdxTreeListColumn;
    TLCustomizeIsVisible: TdxTreeListCheckColumn;
    dxDBGrid1FirstName: TdxDBGridMaskColumn;
    dxDBGrid1LastName: TdxDBGridMaskColumn;
    dxDBGrid1Company: TdxDBGridMaskColumn;
    dxDBGrid1City: TdxDBGridMaskColumn;
    dxDBGrid1State: TdxDBGridMaskColumn;
    dxDBGrid1PurchaseDate: TdxDBGridDateColumn;
    dxDBGrid1PaymentAmount: TdxDBGridMaskColumn;
    dxDBGrid1Customer: TdxDBGridCheckColumn;
    procedure FormCreate(Sender: TObject);
    procedure TLCustomizeStartDrag(Sender: TObject;
      var DragObject: TDragObject);
    procedure TLCustomizeDragOver(Sender, Source: TObject; X,
      Y: Integer; State: TDragState; var Accept: Boolean);
    procedure TLCustomizeDragDrop(Sender, Source: TObject; X,
      Y: Integer);
    procedure BtnCustomizeClick(Sender: TObject);
    procedure dxDBGrid1HideHeader(Sender: TObject;
      AColumn: TdxTreeListColumn);
    procedure dxDBGrid1ShowHeader(Sender: TObject;
      AColumn: TdxTreeListColumn; BandIndex, RowIndex, ColIndex: Integer);
    procedure dxDBGrid1HeaderMoved(Sender: TObject;
      Column: TdxTreeListColumn);
    procedure TLCustomizeIsVisibleToggleClick(Sender: TObject;
      const Text: String; State: TdxCheckBoxState);
  private
    { Private declarations }
    DragNode: TdxTreeListNode;

    procedure Synchronize;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation
uses
  SysUtils;

{$R *.DFM}

procedure TMainForm.FormCreate(Sender: TObject);
begin
  Table1.DatabaseName := '..\Data\';
  Table1.Open;
  Synchronize;
end;

// Drag&drop columns within the columns list
procedure TMainForm.TLCustomizeStartDrag(Sender: TObject;
  var DragObject: TDragObject);
begin
  DragNode := TdxTreeList(Sender).FocusedNode;
end;

procedure TMainForm.TLCustomizeDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := Source = Sender;
end;

procedure TMainForm.TLCustomizeDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  column : TdxTreeListColumn;
begin
  DragNode.MoveTo(TLCustomize.FocusedNode, natlInsert);
  column := TdxTreeListColumn(DragNode.Data);
  if (TLCustomize.FocusedNode <> nil) then
    column.Index := TLCustomize.FocusedNode.AbsoluteIndex
  else column.Index := 0;
end;

procedure TMainForm.BtnCustomizeClick(Sender: TObject);
begin
  dxDBGrid1.ColumnsCustomizing;
end;

procedure TMainForm.Synchronize;
var
  I: Integer;
  Node: TdxTreeListNode;
begin
  TLCustomize.ClearNodes;
  for I := 0 to dxDBGrid1.ColumnCount - 1 do
  begin
    Node := TLCustomize.Add;
    Node.Values[TLCustomizeColumn.Index] := dxDBGrid1.Columns[I].Caption;
    if dxDBGrid1.Columns[I].Visible then
      Node.Values[TLCustomizeIsVisible.Index] := TLCustomizeIsVisible.ValueChecked;
    Node.Data := dxDBGrid1.Columns[I];
  end;
end;

procedure TMainForm.dxDBGrid1HideHeader(Sender: TObject;
  AColumn: TdxTreeListColumn);
begin
  Synchronize;
end;

procedure TMainForm.dxDBGrid1ShowHeader(Sender: TObject;
  AColumn: TdxTreeListColumn; BandIndex, RowIndex, ColIndex: Integer);
begin
  Synchronize;
end;

procedure TMainForm.dxDBGrid1HeaderMoved(Sender: TObject;
  Column: TdxTreeListColumn);
begin
  Synchronize;
end;

procedure TMainForm.TLCustomizeIsVisibleToggleClick(Sender: TObject;
  const Text: String; State: TdxCheckBoxState);
var
  column : TdxTreeListColumn;
begin
   column := TdxTreeListColumn(TLCustomize.FocusedNode.Data);
   column.Visible := State = cbsChecked;
end;

end.
