unit main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, dxTL, dxDBGrid, dxCntner, DBTables, Db, dxGrClms, StdCtrls,
  ExtCtrls, dxTLClms, dxDBTLCl, dxDBCtrl;

type
  TMainForm = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    tContacts: TTable;
    dstContacts: TDataSource;
    qrContacts: TQuery;
    dxDBGrid1: TdxDBGrid;
    dsqrContacts: TDataSource;
    col1ID: TdxDBGridColumn;
    col1FirstName: TdxDBGridColumn;
    col1LastName: TdxDBGridColumn;
    col1Company: TdxDBGridColumn;
    col1Customer: TdxDBGridCheckColumn;
    col1PurchaseDate: TdxDBGridDateColumn;
    col1PaymentType: TdxDBGridImageColumn;
    col1PaymentAmount: TdxDBGridCalcColumn;
    GridImageList: TImageList;
    dxDBGrid2: TdxDBGrid;
    dxDBGridColumn1: TdxDBGridColumn;
    dxDBGridColumn2: TdxDBGridColumn;
    dxDBGridColumn3: TdxDBGridColumn;
    dxDBGridColumn4: TdxDBGridColumn;
    dxDBGridCheckColumn1: TdxDBGridCheckColumn;
    dxDBGridDateColumn1: TdxDBGridDateColumn;
    dxDBGridImageColumn1: TdxDBGridImageColumn;
    dxDBGridCalcColumn1: TdxDBGridCalcColumn;
    dxDBGrid3: TdxDBGrid;
    dxDBGridColumn5: TdxDBGridColumn;
    dxDBGridColumn6: TdxDBGridColumn;
    dxDBGridColumn7: TdxDBGridColumn;
    dxDBGridColumn8: TdxDBGridColumn;
    dxDBGridCheckColumn2: TdxDBGridCheckColumn;
    dxDBGridDateColumn2: TdxDBGridDateColumn;
    dxDBGridImageColumn2: TdxDBGridImageColumn;
    dxDBGridCalcColumn2: TdxDBGridCalcColumn;
    dxDBGrid4: TdxDBGrid;
    dxDBGridColumn9: TdxDBGridColumn;
    dxDBGridColumn10: TdxDBGridColumn;
    dxDBGridColumn11: TdxDBGridColumn;
    dxDBGridColumn12: TdxDBGridColumn;
    dxDBGridCheckColumn3: TdxDBGridCheckColumn;
    dxDBGridDateColumn3: TdxDBGridDateColumn;
    dxDBGridImageColumn3: TdxDBGridImageColumn;
    dxDBGridCalcColumn3: TdxDBGridCalcColumn;
    ContactsUpdate: TUpdateSQL;
    Database: TDatabase;
    qrNewID: TQuery;
    qrContactsID: TIntegerField;
    qrContactsProductID: TIntegerField;
    qrContactsFirstName: TStringField;
    qrContactsLastName: TStringField;
    qrContactsCompany: TStringField;
    qrContactsPrefix: TStringField;
    qrContactsTitle: TStringField;
    qrContactsAddress: TStringField;
    qrContactsCity: TStringField;
    qrContactsState: TStringField;
    qrContactsZipCode: TStringField;
    qrContactsSource: TStringField;
    qrContactsCustomer: TStringField;
    qrContactsPurchaseDate: TDateField;
    qrContactsHomePhone: TStringField;
    qrContactsFaxPhone: TStringField;
    qrContactsPaymentType: TStringField;
    qrContactsSpouse: TStringField;
    qrContactsOccupation: TStringField;
    qrContactsPaymentAmount: TBCDField;
    qrContactsCurrency: TCurrencyField;
    qrContactsTime: TTimeField;
    qrContactsHyperLink: TStringField;
    qrContactsCopies: TIntegerField;
    SortingImages: TImageList;
    Panel1: TPanel;
    TreeList: TdxTreeList;
    dxTreeList1Column1: TdxTreeListColumn;
    dxTreeList1Column2: TdxTreeListImageColumn;
    Splitter1: TSplitter;
    procedure FormCreate(Sender: TObject);
    procedure qrContactsAfterDelete(DataSet: TDataSet);
    procedure qrContactsAfterPost(DataSet: TDataSet);
    procedure qrContactsAfterInsert(DataSet: TDataSet);
    procedure TreeListCanNodeSelected(Sender: TObject;
      ANode: TdxTreeListNode; var Allow: Boolean);
    procedure TreeListDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure TreeListDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure dxDBGrid1ColumnClick(Sender: TObject;
      Column: TdxDBTreeListColumn);
    procedure dxTreeList1Column2Change(Sender: TObject);
    procedure dxDBGrid4MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    procedure CreateTreeListNodes;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.DFM}

procedure TMainForm.FormCreate(Sender: TObject);
begin
  tContacts.DatabaseName := '..\Data\';
  qrNewID.DatabaseName := tContacts.DatabaseName;
  DataBase.Directory := tContacts.DatabaseName;
  tContacts.Open;
  qrContacts.Open;
  CreateTreeListNodes;
end;

procedure TMainForm.CreateTreeListNodes;
var
  i : integer;
  Item : TdxTreeListNode;
begin
  TreeList.ClearNodes;
  with dxDBGrid4 do
    for i := 0 to ColumnCount - 1 do
    begin
      Item := TreeList.Add;
      Item.Values[0] := Columns[i].Caption;
      Item.Values[1] := IntToStr(Integer(Columns[i].Sorted));
      Item.Data := Columns[i];
      Columns[i].Tag := Integer(Item);
    end;
end;

procedure TMainForm.qrContactsAfterDelete(DataSet: TDataSet);
begin
  DataBase.ApplyUpdates([qrContacts]);
end;

procedure TMainForm.qrContactsAfterPost(DataSet: TDataSet);
begin
  DataBase.ApplyUpdates([qrContacts]);
end;

procedure TMainForm.qrContactsAfterInsert(DataSet: TDataSet);
begin
  qrNewID.Open;
  DataSet.FieldByName('ID').AsInteger := qrNewID.FieldByName('NewID').AsInteger;
  qrNewID.Close;
end;

procedure TMainForm.TreeListCanNodeSelected(Sender: TObject;
  ANode: TdxTreeListNode; var Allow: Boolean);
begin
  Allow := TdxTreeList(Sender).SelectedCount < 1;
end;

procedure TMainForm.TreeListDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  AItem, AnItem: TdxTreeListNode;
begin
  with TdxTreeList(Sender) do begin
    if SelectedCount = 0 then Exit;
    AnItem := GetNodeAt(X, Y);
    AItem := SelectedNodes[0];
    AItem.Selected := False;
    AItem.MoveTo(AnItem, natlInsert);
  end;
end;

procedure TMainForm.TreeListDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := Source = Sender;
end;

procedure TMainForm.dxDBGrid1ColumnClick(Sender: TObject;
  Column: TdxDBTreeListColumn);

  function GetFieldName(AColumn : TdxDBTreeListColumn) : String;
  begin
    with TdxDBGrid(Sender).DataSource.DataSet.FieldByName(AColumn.FieldName) do
    begin
      Result := FieldName;
      if FieldKind = fkLookup then Result := KeyFields;
    end;
  end;

var
  ID, i: Integer;
  SQLOrderSt: String;
  OldSorted: TdxTreeListColumnSort;
begin
  with TdxDBGrid(Sender) do
  begin
    OldSorted := Column.Sorted;
    if (GetAsyncKeyState(VK_SHIFT) = 0) then
      TdxDBGrid(Sender).ClearColumnsSorted;

    if OldSorted = csUp then
      Column.Sorted := csDown
    else
      Column.Sorted := csUp;

    with TQuery(DataSource.DataSet) do
    begin
      ID := FieldByName('ID').AsInteger;
      DisableControls;
      try
        Close;
        SQLOrderSt := '';
        for i := 0 to SortedColumnCount - 1 do
        begin
          if SQLOrderSt <> '' then
            SQLOrderSt := SQLOrderSt + ', ';
          SQLOrderSt := SQLOrderSt + GetFieldName(SortedColumns[i]);
          if SortedColumns[i].Sorted = csDown then
            SQLOrderSt := SQLOrderSt + ' DESC';
        end;
        if SQLOrderSt <> '' then
          SQLOrderSt := 'ORDER BY ' + SQLOrderSt;
        SQL.Strings[SQL.Count - 1] := SQLOrderSt;
        Open;
        Locate('ID', ID, []);
      finally
        EnableControls;
      end;  
    end;
  end;
end;

procedure TMainForm.dxTreeList1Column2Change(Sender: TObject);
begin
  dxDBGrid4.BeginSorting;
  try
    if TreeList.InplaceEditor <> nil then
       TdxDBTreeListColumn(TreeList.FocusedNode.Data).Sorted :=
         TdxTreeListColumnSort(StrToInt(TdxInplaceTreeListImageEdit(TreeList.InplaceEditor).Text));
  finally
    dxDBGrid4.EndSorting;
  end;
end;

procedure TMainForm.dxDBGrid4MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  i: Integer;
begin
  TreeList.BeginUpdate;
  try
    for i := 0 to dxDBGrid4.ColumnCount - 1 do
      TdxTreeListNode(dxDBGrid4.Columns[i].Tag).Values[1] := IntToStr(Integer(dxDBGrid4.Columns[i].Sorted));
  finally
    TreeList.EndUpdate;
  end;
end;

end.
