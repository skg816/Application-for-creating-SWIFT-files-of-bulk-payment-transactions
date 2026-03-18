unit main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, dxCntner, dxTL, dxDBCtrl, dxDBTL, ComCtrls, ToolWin,
  ExtCtrls, Menus, dxDBTLCl, Buttons, {ImgList,} StdCtrls, DBCtrls, Grids,
  DBGrids, ShellAPI, dxEditor, dxExEdtr, dxEdLib, dxDBELib;

type
  TfmMain = class(TForm)
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Edit1: TMenuItem;
    View1: TMenuItem;
    Help1: TMenuItem;
    Exit1: TMenuItem;
    Add1: TMenuItem;
    AddChild1: TMenuItem;
    FullCollapse1: TMenuItem;
    FullExpand1: TMenuItem;
    About1: TMenuItem;
    Panel1: TPanel;
    Table: TTable;
    DataSource: TDataSource;
    ToolBar1: TToolBar;
    btnAdd: TToolButton;
    btnAddChild: TToolButton;
    btnDelete: TToolButton;
    Images: TImageList;
    Delete1: TMenuItem;
    ToolButton1: TToolButton;
    btnColumn: TToolButton;
    btnPreview: TToolButton;
    ToolButton4: TToolButton;
    btnFullCollapse: TToolButton;
    btnFullExpand: TToolButton;
    Table_id: TIntegerField;
    Table_parent: TIntegerField;
    Table_name: TStringField;
    Table_bdate: TDateField;
    Table_edate: TDateField;
    Table_info: TMemoField;
    btnCopy: TToolButton;
    CopyToClipboard1: TMenuItem;
    Flat1: TMenuItem;
    Standard1: TMenuItem;
    btnShowGrid: TToolButton;
    DBNavigator1: TDBNavigator;
    chbCustomDraw: TdxCheckEdit;
    ImageList1: TImageList;
    chbAutoDragDropCopy: TdxCheckEdit;
    chbAutoDragDrop: TdxCheckEdit;
    chbDragMode: TdxCheckEdit;
    GroupBox1: TGroupBox;
    chbCanDelete: TdxCheckEdit;
    chbCanNavigation: TdxCheckEdit;
    chbConfirmDelete: TdxCheckEdit;
    chbResetColumnFocus: TdxCheckEdit;
    chbSyncSelection: TdxCheckEdit;
    btnImmediateEdit: TToolButton;
    Panel2: TPanel;
    DBTreeList: TdxDBTreeList;
    DBTreeListPr_id: TdxDBTreeListMaskColumn;
    DBTreeListPr_parent: TdxDBTreeListMaskColumn;
    DBTreeListPr_name: TdxDBTreeListMaskColumn;
    DBTreeListPr_info: TdxDBTreeListMemoColumn;
    Panel3: TPanel;
    DBGrid: TDBGrid;
    DBMemo1: TdxDBMemo;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    EditStyleController: TdxCheckEditStyleController;
    UltraFlat1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure FullCollapse1Click(Sender: TObject);
    procedure FullExpand1Click(Sender: TObject);
    procedure Add1Click(Sender: TObject);
    procedure AddChild1Click(Sender: TObject);
    procedure Delete1Click(Sender: TObject);
    procedure CopyToClipboard1Click(Sender: TObject);
    procedure ColumnSelector1Click(Sender: TObject);
    procedure Flat1Click(Sender: TObject);
    procedure DBTreeListEndColumnsCustomizing(Sender: TObject);
    procedure DBTreeListSelectedCountChange(Sender: TObject);
    procedure btnShowGridClick(Sender: TObject);
    procedure TableNewRecord(DataSet: TDataSet);
    procedure chbCancelOnExitClick(Sender: TObject);
    procedure btnPreviewClick(Sender: TObject);
    procedure DBTreeListCustomDrawCell(Sender: TObject; ACanvas: TCanvas;
      ARect: TRect; ANode: TdxTreeListNode; AColumn: TdxTreeListColumn;
      ASelected, AFocused, ANewItemRow: Boolean; var AText: String;
      var AColor: TColor; AFont: TFont; var AAlignment: TAlignment;
      var ADone: Boolean);
    procedure DBTreeListGetStateIndex(Sender: TObject;
      Node: TdxTreeListNode; var Index: Integer);
    procedure About1Click(Sender: TObject);
    procedure btnImmediateEditClick(Sender: TObject);
    procedure chbDragModeClick(Sender: TObject);
    procedure chbCustomDrawClick(Sender: TObject);
    procedure chbAutoDragDropClick(Sender: TObject);
  private
    FParentValue: Variant;
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;

implementation

{$IFDEF VER140}uses Variants;{$ENDIF}

{$R *.DFM}

procedure TfmMain.FormCreate(Sender: TObject);
begin
  Table.DatabaseName := '..\Data\';
  Table.Active := true;

  chbCanDelete.Checked := etoCanDelete in DBTreeList.OptionsDB;
  chbCanNavigation.Checked := etoCanNavigation in DBTreeList.OptionsDB;
  chbConfirmDelete.Checked := etoConfirmDelete in DBTreeList.OptionsDB;
  chbResetColumnFocus.Checked := etoResetColumnFocus in DBTreeList.OptionsDB;
  chbSyncSelection.Checked := etoSyncSelection in DBTreeList.OptionsDB;
  chbAutoDragDrop.Checked := etoAutoDragDrop in DBTreeList.OptionsBehavior;
  chbAutoDragDropCopy.Checked := etoAutoDragDropCopy in DBTreeList.OptionsBehavior;
  chbDragMode.Checked := DBTreeList.DragMode = dmAutomatic;
  chbAutoDragDrop.Enabled := chbDragMode.Checked;
  chbAutoDragDropCopy.Enabled := chbDragMode.Checked;

  //initialize buttons
  btnDelete.Enabled := DBTreeList.SelectedCount > 0;
  btnPreview.Down := etoPreview in DBTreeList.OptionsView;
  btnShowGrid.Down := DBTreeList.ShowGrid;
  btnImmediateEdit.Down := etoImmediateEditor in DBTreeList.OptionsBehavior;
end;

procedure TfmMain.Exit1Click(Sender: TObject);
begin
  Close;
end;

procedure TfmMain.FullCollapse1Click(Sender: TObject);
begin
  DBTreeList.FullCollapse;
end;

procedure TfmMain.FullExpand1Click(Sender: TObject);
begin
  DBTreeList.FullExpand;
end;

procedure TfmMain.Add1Click(Sender: TObject);
begin
  // add a record
  if Table_parent.IsNull then
    FParentValue := Null
  else FParentValue := Table_parent.Value;
  Table.Insert;
  DBTreeList.ShowEditor;
end;

procedure TfmMain.AddChild1Click(Sender: TObject);
begin
  // add a child record
  FParentValue := TdxDBTreeListNode(DBTreeList.FocusedNode).Id;
  Table.Insert;
  DBTreeList.ShowEditor;
end;

procedure TfmMain.Delete1Click(Sender: TObject);
begin
  if MessageBox(Handle, 'Delete selected nodes?', 'Confirm', MB_YESNO or MB_ICONWARNING) = ID_YES then
  with DBTreeList do
    if SelectedCount > 0 then
      DeleteSelection;
end;

procedure TfmMain.CopyToClipboard1Click(Sender: TObject);
begin
  if DBTreeList.SelectedCount > 0 then
    DBTreeList.CopySelectedToClipboard
  else
    DBTreeList.CopyAllToClipboard;
end;

procedure TfmMain.ColumnSelector1Click(Sender: TObject);
begin
  if btnColumn.Down then
    DBTreeList.ColumnsCustomizing
  else
    DBTreeList.EndColumnsCustomizing;
end;

procedure TfmMain.Flat1Click(Sender: TObject);
const
  ButtonViewStyles : Array[TdxLookAndFeel] of TdxEditButtonViewStyle = (bts3D, btsFlat, btsSimple);
  BorderStyles : Array[TdxLookAndFeel] of TdxEditBorderStyle = (xbs3D, xbsFlat, xbsNone);
begin
  TMenuItem(Sender).Checked := true;
  DBTreeList.LookAndFeel := TdxLookAndFeel(TMenuItem(Sender).Tag);
  EditStyleController.ButtonStyle := ButtonViewStyles[DBTreeList.LookAndFeel];
  DBmemo1.Style.BorderStyle := BorderStyles[DBTreeList.LookAndFeel];
end;

procedure TfmMain.DBTreeListEndColumnsCustomizing(Sender: TObject);
begin
  btnColumn.Down := false;
end;

procedure TfmMain.DBTreeListSelectedCountChange(Sender: TObject);
begin
  btnDelete.Enabled := DBTreeList.SelectedCount > 0;
  Delete1.Enabled := btnDelete.Enabled;
end;

procedure TfmMain.btnShowGridClick(Sender: TObject);
begin
  DBTreeList.ShowGrid := btnShowGrid.Down;
end;

procedure TfmMain.TableNewRecord(DataSet: TDataSet);
begin
  DataSet.FieldByName('Pr_parent').Value := FParentValue;
end;

procedure TfmMain.chbCancelOnExitClick(Sender: TObject);
const
   CheckBoxCount = 5;
   OptionDB : Array [0..CheckBoxCount - 1] of TdxDBTreeListOptionDB =
             (etoCanDelete, etoCanNavigation, etoConfirmDelete, etoResetColumnFocus, etoSyncSelection);
begin
  Assert(((TComponent(Sender).Tag >= 0) and (TComponent(Sender).Tag < CheckBoxCount)), 'Tag is out of range');
  if TdxCheckEdit(Sender).Checked then
    DBTreeList.OptionsDB := DBTreeList.OptionsDB + [OptionDB[TComponent(Sender).Tag]]
  else DBTreeList.OptionsDB := DBTreeList.OptionsDB - [OptionDB[TComponent(Sender).Tag]];
end;

procedure TfmMain.chbAutoDragDropClick(Sender: TObject);
const
   CheckBoxCount = 2;
   OptionBehavior : Array [0..CheckBoxCount - 1] of TdxDBTreeListOptionBehavior =
             (etoAutoDragDrop, etoAutoDragDropCopy);
begin
  Assert(((TComponent(Sender).Tag >= 0) and (TComponent(Sender).Tag < CheckBoxCount)), 'Tag is out of range');
  if TdxCheckEdit(Sender).Checked then
    DBTreeList.OptionsBehavior := DBTreeList.OptionsBehavior + [OptionBehavior[TComponent(Sender).Tag]]
  else DBTreeList.OptionsBehavior := DBTreeList.OptionsBehavior - [OptionBehavior[TComponent(Sender).Tag]];
end;

procedure TfmMain.btnPreviewClick(Sender: TObject);
begin
  if btnPreview.Down then
    DBTreeList.OptionsView := DBTreeList.OptionsView + [etoPreview]
  else DBTreeList.OptionsView := DBTreeList.OptionsView - [etoPreview];
end;

procedure TfmMain.btnImmediateEditClick(Sender: TObject);
begin
  if TToolButton(Sender).Down then
    DBTreeList.OptionsBehavior := DBTreeList.OptionsBehavior + [etoImmediateEditor]
  else
    DBTreeList.OptionsBehavior := DBTreeList.OptionsBehavior - [etoImmediateEditor];
end;

procedure TfmMain.chbDragModeClick(Sender: TObject);
begin
   if TdxCheckEdit(Sender).Checked then
     DBTreeList.DragMode := dmAutomatic
   else DBTreeList.DragMode := dmManual;
   chbAutoDragDrop.Enabled := TdxCheckEdit(Sender).Checked;
   chbAutoDragDropCopy.Enabled := TdxCheckEdit(Sender).Checked;
end;

procedure TfmMain.chbCustomDrawClick(Sender: TObject);
begin
  DBTreeList.Repaint;
end;

procedure TfmMain.DBTreeListCustomDrawCell(Sender: TObject;
  ACanvas: TCanvas; ARect: TRect; ANode: TdxTreeListNode;
  AColumn: TdxTreeListColumn; ASelected, AFocused, ANewItemRow: Boolean;
  var AText: String; var AColor: TColor; AFont: TFont;
  var AAlignment: TAlignment; var ADone: Boolean);
begin
  if not chbCustomDraw.Checked then exit;
   if(ANode.Index mod 2 = 0) then begin
     AFont.Style := [fsBold];
     AFont.Color := clBlue;
   end else begin
     if not ANode.Selected then
       AColor := clYellow;
     AFont.Color := clRed;
   end;
end;

procedure TfmMain.DBTreeListGetStateIndex(Sender: TObject;
  Node: TdxTreeListNode; var Index: Integer);
begin
  if Node.Expanded then
    Index := 1
  else Index := 0;
end;

procedure TfmMain.About1Click(Sender: TObject);
begin
  ShellExecute(Handle, PChar('OPEN'), PChar('http://www.devexpress.com'), Nil, Nil, SW_SHOWMAXIMIZED);
end;

end.
