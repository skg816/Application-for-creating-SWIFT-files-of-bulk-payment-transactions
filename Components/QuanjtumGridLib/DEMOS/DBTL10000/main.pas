unit main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, dxCntner, dxTL, dxDBCtrl, dxDBTL, DBTables, Db, Grids, DBGrids,
  StdCtrls, dxExEdtr, dxEdLib;

type
  TfmMain = class(TForm)
    DataSource1: TDataSource;
    Table1: TTable;
    Table1id: TIntegerField;
    Table1parent: TIntegerField;
    Table1name: TStringField;
    Table1buffer: TStringField;
    dxDBTreeList: TdxDBTreeList;
    DBGrid1: TDBGrid;
    dxDBTreeListid: TdxDBTreeListMaskColumn;
    dxDBTreeListparent: TdxDBTreeListMaskColumn;
    dxDBTreeListname: TdxDBTreeListMaskColumn;
    dxDBTreeListbuffer: TdxDBTreeListMaskColumn;
    plBottom: TPanel;
    chbLoadAllRecords: TdxCheckEdit;
    chbCheckHasChildren: TdxCheckEdit;
    chbRowSelect: TdxCheckEdit;
    Button1: TButton;
    Button3: TButton;
    Splitter1: TSplitter;
    dxCheckEditStyleController1: TdxCheckEditStyleController;
    ImageList: TImageList;
    procedure FormCreate(Sender: TObject);
    procedure chbLoadAllRecordsClick(Sender: TObject);
    procedure chbCheckHasChildrenClick(Sender: TObject);
    procedure chbRowSelectClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure dxDBTreeListGetImageIndex(Sender: TObject;
      Node: TdxTreeListNode; var Index: Integer);
  private
    MaxValue : Integer;
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;

implementation

{$R *.DFM}

const RecordCount = 10000;

procedure TfmMain.FormCreate(Sender: TObject);
Var
  i, id, parent : Integer;
begin
  Table1.CreateTable;
  Table1.AddIndex('id', 'id', [ixPrimary, ixUnique]);
  Table1.AddIndex('parent', 'parent', []);
  Table1.Open;

  for i := 0 to RecordCount - 1 do
    with Table1 do
    begin
      Append;
      id := i;
      parent := i div 10 - 1;
      FindField('id').AsInteger := id;
      FindField('parent').AsInteger := parent;
      FindField('Name').AsString := 'TreeNode item No ' + IntToStr(id) + ' parent No ' + IntToStr(Parent);
      FindField('Buffer').AsString := 'No ' + IntToStr(id);
      Post;
    end;
    
  Table1.IndexFieldNames := 'parent';
  Table1.First;
  MaxValue := 10000;
  chbLoadAllRecords.Checked := etoLoadAllRecords in dxDBTreeList.OptionsDB;
  chbCheckHasChildren.Checked := etoCheckHasChildren in dxDBTreeList.OptionsDB;
  chbRowSelect.Checked := etoRowSelect in dxDBTreeList.OptionsView;

end;

procedure TfmMain.chbLoadAllRecordsClick(Sender: TObject);
begin
  with Sender as TdxCheckEdit, dxDBTreeList do
    if Checked then
      OptionsDB := OptionsDB + [etoLoadAllRecords]
    else OptionsDB := OptionsDB - [etoLoadAllRecords];
end;

procedure TfmMain.chbCheckHasChildrenClick(Sender: TObject);
begin
  with Sender as TdxCheckEdit, dxDBTreeList do
    if Checked then
      OptionsDB := OptionsDB + [etoCheckHasChildren]
    else OptionsDB := OptionsDB - [etoCheckHasChildren];
end;

procedure TfmMain.chbRowSelectClick(Sender: TObject);
begin
  with Sender as TdxCheckEdit, dxDBTreeList do
    if Checked then
      OptionsView := OptionsView + [etoRowSelect]
    else OptionsView := OptionsView - [etoRowSelect];
end;

procedure TfmMain.FormDestroy(Sender: TObject);
begin
  Table1.Close;
  Table1.DeleteTable;
end;

procedure TfmMain.Button1Click(Sender: TObject);
begin
  dxDBTreeList.DataSource := DataSource1;
end;

procedure TfmMain.Button3Click(Sender: TObject);
begin
  dxDBTreeList.DataSource := nil;
end;

procedure TfmMain.dxDBTreeListGetImageIndex(Sender: TObject;
  Node: TdxTreeListNode; var Index: Integer);
const
  ImagesIndex: array [Boolean] of Integer = (0, 1);
begin
  if Node.HasChildren then
    Index := ImagesIndex[Node.Expanded]
  else Index := 2;  
end;

end.
