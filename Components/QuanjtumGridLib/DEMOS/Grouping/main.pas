unit Main;

interface

uses
  Forms, Db, DBTables, dxTL, StdCtrls, ExtCtrls, dxGrClms, dxDBGrid,
  Controls, dxCntner, Classes, dxDBTLCl, dxDBCtrl;

type
  TMainForm = class(TForm)
    Panel1: TPanel;
    Table1: TTable;
    DataSource1: TDataSource;
    Splitter1: TSplitter;
    dxDBGrid1: TdxDBGrid;
    dxDBGrid1FirstName: TdxDBGridMaskColumn;
    dxDBGrid1LastName: TdxDBGridMaskColumn;
    dxDBGrid1Company: TdxDBGridMaskColumn;
    dxDBGrid1PurchaseDate: TdxDBGridDateColumn;
    dxDBGrid1PaymentAmount: TdxDBGridMaskColumn;
    dxDBGrid1Customer: TdxDBGridCheckColumn;
    dxDBGrid1PaymentType: TdxDBGridImageColumn;
    TLGroup: TdxTreeList;
    TLGroupColumn: TdxTreeListColumn;
    TLAvail: TdxTreeList;
    TLAvailColumn: TdxTreeListColumn;
    procedure FormCreate(Sender: TObject);
    procedure TLStartDrag(Sender: TObject;
      var DragObject: TDragObject);
    procedure TLGroupDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure TLAvailDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure TLDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure dxDBGrid1ReloadGroupList(Sender: TObject);
  private
    { Private declarations }
    NeedSyncro: Boolean;
    DragNode: TdxTreeListNode;
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
  NeedSyncro := True;
  Table1.DatabaseName := '..\Data\';
  Table1.Open;
end;

// Drag&Drop between Column lists
procedure TMainForm.TLStartDrag(Sender: TObject;
  var DragObject: TDragObject);
begin
  if (Sender = TLAvail) and (TLAvail.Count = 1) then
    Abort;
  DragNode := TdxTreeList(Sender).FocusedNode;
end;

procedure TMainForm.TLGroupDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  // Source and Sender are TreeList instances;
  Accept := TdxTreeList(Sender).FocusedNode <> DragNode;
end;

procedure TMainForm.TLAvailDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  Accept := DragNode.Owner = TLGroup;
end;

procedure TMainForm.TLDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  N: TdxTreeListNode;
begin
  if DragNode.Owner = Sender then // reorder
    DragNode.MoveTo(DragNode.Owner.FocusedNode, natlInsert)
  else
  begin
    N := TdxTreeList(Sender).Add;
    N.Values[0] := DragNode.Values[0];
    N.Data := DragNode.Data;
    if Sender = TLGroup then
      N.MoveTo(N.Owner.FocusedNode, natlInsert);
    DragNode.Free;
    DragNode := N;
  end;

  NeedSyncro := False;
  with TdxDBGridColumn(DragNode.Data) do
    if DragNode.Owner = TLGroup then
      GroupIndex := DragNode.Index
    else
      GroupIndex := -1;
  NeedSyncro := True;
end;

// Synchronization of column lists with the grid
// The OnReloadGroupList event is fired each time,
// when group columns have been changed (added, removed or reordered)
procedure TMainForm.dxDBGrid1ReloadGroupList(Sender: TObject);

  procedure AddNode(ATreeList: TdxTreeList; AColumn: TdxDBGridColumn);
  begin
    with ATreeList.Add do
    begin
      Values[0] := AColumn.Caption;
      Data := AColumn;
    end;
  end;

var
  I: Integer;
begin
  if not NeedSyncro then Exit;

  TLGroup.ClearNodes;
  for I := 0 to dxDBGrid1.GroupColumnCount - 1 do
    AddNode(TLGroup, dxDBGrid1.GroupColumns[I]);

  TLAvail.ClearNodes;
  for I := 0 to dxDBGrid1.VisibleColumnCount - 1 do
    if TdxDBGridColumn(dxDBGrid1.VisibleColumns[I]).GroupIndex = -1 then
      AddNode(TLAvail, TdxDBGridColumn(dxDBGrid1.VisibleColumns[I]));
end;

end.
