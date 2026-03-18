unit Main;

interface

uses
  Forms, Controls, Db, DBTables, StdCtrls, ExtCtrls, dxGrClms,
  dxTL, dxDBGrid, dxCntner, Classes, dxDBTLCl, dxDBCtrl;

type
  TMainForm = class(TForm)
    Table1: TTable;
    Table2: TTable;
    DataSource1: TDataSource;
    DataSource2: TDataSource;
    Grid1: TdxDBGrid;
    Grid1FirstName: TdxDBGridColumn;
    Grid1LastName: TdxDBGridColumn;
    Grid1Company: TdxDBGridColumn;
    Grid1PaymentType: TdxDBGridImageColumn;
    Grid1PaymentAmount: TdxDBGridColumn;
    Grid2: TdxDBGrid;
    Grid2FirstName: TdxDBGridColumn;
    Grid2LastName: TdxDBGridColumn;
    Grid2Company: TdxDBGridColumn;
    Grid2PaymentType: TdxDBGridImageColumn;
    Grid2PaymentAmount: TdxDBGridColumn;
    Splitter1: TSplitter;
    GridImageList: TImageList;
    Panel1: TPanel;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure GridDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure GridDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation
uses SysUtils;
{$R *.DFM}

procedure TMainForm.FormCreate(Sender: TObject);
begin
  Table1.DatabaseName := '..\Data\';
  Table2.DatabaseName := Table1.DatabaseName;
  Table1.Open;
  Table2.Open;
  Grid1.FullExpand;
  Grid2.FullExpand;
end;

procedure TMainForm.GridDragDrop(Sender, Source: TObject; X, Y: Integer);
var
  Node: TdxTreeListNode;
  I, J: Integer;
  AFieldName: string;
  AValue: Variant;
  SourceGrid, TargetGrid: TdxDBGrid;
  SourceData, TargetData: TDataSet;
begin
  SourceGrid := Source as TdxDBGrid;
  TargetGrid := Sender as TdxDBGrid;

  Node := TargetGrid.GetNodeAt(X, Y);
  if Node = nil then Exit;
  while Node.HasChildren do
    Node := Node.Items[0];

  SourceData := SourceGrid.DataSource.DataSet;
  TargetData := TargetGrid.DataSource.DataSet;
  SourceData.DisableControls;
  TargetData.DisableControls;
  try
    for I := 0 to SourceGrid.SelectedCount - 1 do
    begin
      SourceData.Bookmark := SourceGrid.SelectedRows[I];
      SourceData.Edit;
      for J := 0 to TargetGrid.GroupColumnCount - 1 do
      begin
        AFieldName := TargetGrid.GroupColumns[J].FieldName;
        AValue := Node.Values[TargetGrid.GroupColumns[J].Index];
        SourceData[AFieldName] := AValue; // change values according to the target group
      end;
      // Y or N according to the TargetGrid
      SourceData['Customer'] := TargetData['Customer'];
      SourceData.Post;
    end;
    SourceGrid.ClearSelection;
  finally
    SourceData.EnableControls;
    TargetData.EnableControls;
  end;  
end;

procedure TMainForm.GridDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  // Both Sender and Source are TdxDBGrid instances
  Accept := (Source is TdxDBGrid) and (Sender is TdxDBGrid);
  // If Sender = Source and it does not have grouping columns,
  // then Accept := False, i.e. reorder of nodes is not implemented
  Accept := Accept and ((Source <> Sender) or (TdxDBGrid(Source).GroupColumnCount > 0));
  // Drag&Drop of entire group is not implemented
  Accept := Accept and not TdxDBGrid(Source).SelectedNodes[0].HasChildren;
end;

end.
