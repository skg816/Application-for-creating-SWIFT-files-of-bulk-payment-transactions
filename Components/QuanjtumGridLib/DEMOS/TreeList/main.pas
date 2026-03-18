unit main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, dxTL, Menus, dxCntner, dxEditor, dxTLClms, ImgList;

type
  TfmMain = class(TForm)
    odOpen: TOpenDialog;
    sdSave: TSaveDialog;
    PopupMenu: TPopupMenu;
    piNewItem: TMenuItem;
    piNewSubItem: TMenuItem;
    piDelete: TMenuItem;
    N5: TMenuItem;
    piColumns: TMenuItem;
    ImageList3: TImageList;

    dxTreeList: TdxTreeList;
    StatusBar: TStatusBar;
    MainMenu: TMainMenu;
    miFile: TMenuItem;
    miEdit: TMenuItem;
    miView: TMenuItem;
    miHelp: TMenuItem;
    miOpen: TMenuItem;
    miSave: TMenuItem;
    miSaveAs: TMenuItem;
    N2: TMenuItem;
    miExit: TMenuItem;
    miNewItem: TMenuItem;
    miNewSubItem: TMenuItem;
    miDelete: TMenuItem;
    miFlat: TMenuItem;
    N1: TMenuItem;
    miFullexpand: TMenuItem;
    miFullCollapse: TMenuItem;
    miShowButtons: TMenuItem;
    miShowGrid: TMenuItem;
    miShowHeader: TMenuItem;
    miShowLines: TMenuItem;
    miShowRoot: TMenuItem;
    N3: TMenuItem;
    miHideSelection: TMenuItem;
    miHideFocusRect: TMenuItem;
    N4: TMenuItem;
    miColumns: TMenuItem;
    miAbout: TMenuItem;
    dxTreeListColumn1: TdxTreeListColumn;
    dxTreeListColumn2: TdxTreeListSpinColumn;
    dxTreeListColumn5: TdxTreeListColumn;
    miShowBands: TMenuItem;
    dxTreeListColumn4: TdxTreeListPickColumn;
    dxTreeListColumn3: TdxTreeListColumn;
    qqq1: TMenuItem;
    procedure miExitClick(Sender: TObject);
    procedure miShowButtonsClick(Sender: TObject);
    procedure miShowGridClick(Sender: TObject);
    procedure miShowHeaderClick(Sender: TObject);
    procedure miShowLinesClick(Sender: TObject);
    procedure miShowRootClick(Sender: TObject);
    procedure miHideSelectionClick(Sender: TObject);
    procedure miColumnsClick(Sender: TObject);
    procedure miHideFocusRectClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FullExpand1Click(Sender: TObject);
    procedure FullCollapse1Click(Sender: TObject);
    procedure dxTreeListDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure dxTreeListDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure About1Click(Sender: TObject);
    procedure mmNewItemClick(Sender: TObject);
    procedure mmNewSubItemClick(Sender: TObject);
    procedure mmDeleteClick(Sender: TObject);
    procedure dxTreeListSelectedCountChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure miOpenClick(Sender: TObject);
    procedure miSaveAsClick(Sender: TObject);
    procedure miSaveClick(Sender: TObject);
    procedure dxTreeListEdited(Sender: TObject; Node: TdxTreeListNode);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure miFlatClick(Sender: TObject);
    procedure dxTreeListCompare(Sender: TObject; Node1,
      Node2: TdxTreeListNode; var Compare: Integer);
    procedure miShowBandsClick(Sender: TObject);
    procedure dxTreeListGetSelectedIndex(Sender: TObject;
      Node: TdxTreeListNode; var Index: Integer);
    procedure qqq1Click(Sender: TObject);
  private
    procedure UpdateStatusBar(Sender: TObject);
  public
    DataFile : String;
  end;

var
  fmMain: TfmMain;

implementation

{$R *.DFM}

procedure TfmMain.miExitClick(Sender: TObject);
begin
  Close;
end;

//Show/Hide tree list buttons.
procedure TfmMain.miShowButtonsClick(Sender: TObject);
begin
  miShowButtons.Checked := not miShowButtons.Checked;
  dxTreeList.ShowButtons := miShowButtons.Checked;
end;

//Show/hide grid lines
procedure TfmMain.miShowGridClick(Sender: TObject);
begin
  miShowGrid.Checked := not miShowGrid.Checked;
  dxTreeList.ShowGrid := miShowGrid.Checked;
end;

//Show/Hide column header
procedure TfmMain.miShowHeaderClick(Sender: TObject);
begin
  miShowHeader.Checked := not miShowHeader.Checked;
  dxTreeList.ShowHeader := miShowHeader.Checked;
end;

//Show/Hide tree list lines
procedure TfmMain.miShowLinesClick(Sender: TObject);
begin
  miShowLines.Checked := not miShowLines.Checked;
  dxTreeList.ShowLines := miShowLines.Checked;
end;

//Show/hide the root buttons
procedure TfmMain.miShowRootClick(Sender: TObject);
begin
  miShowRoot.Checked := not miShowRoot.Checked;
  dxTreeList.ShowRoot := miShowRoot.Checked;
end;

//Let/not let selected nodes appears selected when the focus shifts to another control.
procedure TfmMain.miHideSelectionClick(Sender: TObject);
begin
  miHideSelection.Checked := not miHideSelection.Checked;
  dxTreeList.HideSelection := miHideSelection.Checked;
end;

//Draw/don't draw the focused rect on the cell.
procedure TfmMain.miHideFocusRectClick(Sender: TObject);
begin
  miHideFocusRect.Checked := not miHideFocusRect.Checked;
  dxTreeList.HideFocusRect := miHideFocusRect.Checked;
end;

//Call column customizing
procedure TfmMain.miColumnsClick(Sender: TObject);
begin
  dxTreeList.ColumnsCustomizing;
end;

procedure TfmMain.FormCreate(Sender: TObject);
begin
  //Get the default file name
  DataFile := ExtractFilePath(Application.ExeName)+'\example.dat';
  //If file exist download the data from the file.
  if FileExists(DataFile) then dxTreeList.LoadFromFile(DataFile);
  //Update status bar of the app
  UpdateStatusBar(nil);
  //Expand all nodes
  dxTreeList.FullExpand;

  miShowButtons.Checked := dxTreeList.ShowButtons;
  miShowGrid.Checked := dxTreeList.ShowGrid;
  miShowHeader.Checked := dxTreeList.ShowHeader;
  miShowLines.Checked := dxTreeList.ShowLines;
  miShowRoot.Checked := dxTreeList.ShowRoot;
  miHideSelection.Checked := dxTreeList.HideSelection;
  miHideFocusRect.Checked := dxTreeList.HideFocusRect;
  miFlat.Checked := dxTreeList.LookAndFeel = lfFlat;
  miShowBands.Checked := dxTreeList.ShowBands;
 end;

//Expand all nodes
procedure TfmMain.FullExpand1Click(Sender: TObject);
begin
  dxTreeList.FullExpand;
end;

//Collapse all nodes
procedure TfmMain.FullCollapse1Click(Sender: TObject);
begin
  dxTreeList.FullCollapse;
end;

//Accept drarg&drop if the user drag the Tree List node only
procedure TfmMain.dxTreeListDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  if Source = dxTreeList then Accept := True
  Else Accept := False;
end;

//On drop move the selected node on the new location
procedure TfmMain.dxTreeListDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  AItem, AnItem: TdxTreeListNode;
  AttachMode: TdxTreeListNodeAttachMode;
  HT: TdxTreeListHitTest;
begin
  //If there is not any Selected Nodes then exit
  if dxTreeList.SelectedCount = 0 then Exit;
  //Get tree list control hit test
  HT := dxTreeList.GetHitTestInfoAt(X, Y);
  //Get tree list node at the dropped point
  AnItem := dxTreeList.GetNodeAt(X, Y);
  //If the point at button or image or state image or label or no where do
  if HT in [htButton, htIcon, htStateIcon, htLabel, htNowhere, htIndent] then
  begin
    //By default make the attach mode a natlInsert
    AttachMode := natlInsert;

    //If the point at button or image or state image or label make Attach mode natlAddChild
    if HT in [htButton, htIcon, htStateIcon, htLabel] then
      AttachMode := natlAddChild
    //If the point at no where mode the selected nodes to the root
    else if HT = htNowhere then
    begin
      AnItem := dxTreeList.Items[0];
      AttachMode := natlAdd;
    end
    else if HT = htIndent then AttachMode := natlInsert;

    //Move the selected nodes
    while dxTreeList.SelectedCount > 0 do
    begin
      AItem := dxTreeList.SelectedNodes[0];
      AItem.Selected := False;
      AItem.MoveTo(AnItem, AttachMode);
      miSave.Enabled := True;
    end;
  end;
  dxTreeList.RefreshSorting;
end;

procedure TfmMain.About1Click(Sender: TObject);
begin
  MessageBox(Self.Handle, 'Developer Express TreeList demo...', 'Hello, developer!', MB_ICONINFORMATION or MB_OK);
end;

//Add new item
procedure TfmMain.mmNewItemClick(Sender: TObject);
var Item : TdxTreeListNode;
begin
  // If there is focused node, then add new node as its child
  //else add the root node.
  if (dxTreeList.FocusedNode <> Nil) and
     (dxTreeList.FocusedNode.Parent <> Nil) then
   Item := dxTreeList.FocusedNode.Parent.AddChild
  else
   Item := dxTreeList.Add;
  //If Item is added successfull then make it visible
  if Item <> nil then Item.MakeVisible;
  miSave.Enabled := True;
end;

//Add new sub item
procedure TfmMain.mmNewSubItemClick(Sender: TObject);
var Item : TdxTreeListNode;
begin
  // If there is focused node, then add new node as its child
  if dxTreeList.FocusedNode <> Nil then
  begin
    Item := dxTreeList.FocusedNode.AddChild;
    if Item <> nil then Item.MakeVisible;
  end;
  miSave.Enabled := True;
end;

procedure TfmMain.mmDeleteClick(Sender: TObject);
var OldNode, Node : TdxTreeListNode;
begin
  //Delete the selected node
  With dxTreeList Do
  //If there are the selected nodes then
  if (SelectedCount > 0) and
     (MessageBox(Self.Handle, 'Delete selected nodes?', 'Warning !', MB_ICONQUESTION or MB_OKCANCEL) <> IDCANCEL) then
  Begin
    //User chooses OK.
    //Save the previous node, to select it after deleting the selected nodes
    OldNode := FocusedNode;
    if OldNode <> Nil then OldNode := OldNode.GetPriorNode;
    //Freez control on delete operation to avoid flickers
    BeginUpdate;
    try
      //Delete all selected nodes
      While SelectedCount > 0 Do
      begin
        Node := SelectedNodes[0];
        if Node = OldNode then OldNode := Nil;
        Node.Free;
      end;
    finally
      //Make the the previous (saved before node) selected
      if (OldNode <> nil) then
      begin
        OldNode.Focused := True;
        OldNode.Selected := True;
      end;
      //Update control
      EndUpdate;
      miSave.Enabled := True;
    end;
  End;
end;

//If the user unselect all nodes make the delete menu item disable
procedure TfmMain.dxTreeListSelectedCountChange(Sender: TObject);
begin
  miDelete.Enabled := dxTreeList.SelectedCount > 0;
  piDelete.Enabled := miDelete.Enabled;
end;

procedure TfmMain.FormActivate(Sender: TObject);
begin
  dxTreeListSelectedCountChange(nil);
end;

//Load the data from the binary file
procedure TfmMain.miOpenClick(Sender: TObject);
begin
  with odOpen do
  begin
    InitialDir := ExtractFilePath(DataFile);
    if Execute then
    begin
      DataFile := FileName;
      dxTreeList.LoadFromFile(DataFile);
      UpdateStatusBar(nil);
    end;
  end;
end;

//Save the data to the binary file
procedure TfmMain.miSaveClick(Sender: TObject);
begin
  dxTreeList.SaveToFile(DataFile);
  UpdateStatusBar(nil);
end;

//Save the data to the binary file
procedure TfmMain.miSaveAsClick(Sender: TObject);
begin
  with sdSave do
  begin
    Title := 'Save '+ExtractFileName(DataFile)+' As';
    InitialDir := ExtractFilePath(DataFile);
    FileName := ExtractFileName(DataFile);
    if Execute then
    begin
      DataFile := FileName;
      dxTreeList.SaveToFile(DataFile);
      UpdateStatusBar(nil);
    end;
  end;
end;

procedure TfmMain.UpdateStatusBar(Sender: TObject);
begin
  StatusBar.Panels[0].Text := ExtractFileName(DataFile);
  miSave.Enabled := False;
end;

//On after edit make the menu item enable
procedure TfmMain.dxTreeListEdited(Sender: TObject; Node: TdxTreeListNode);
begin
  if TdxInplaceTextEdit(dxTreeList.InplaceEditor).Modified then
     miSave.Enabled := True;
end;

//If there is the changes ask the user to save it into the binary file.
procedure TfmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := True;
  if miSave.Enabled then
  case MessageBox(Self.Handle, 'Do you want to save the changes?', 'Warning !', MB_ICONQUESTION or MB_YESNOCANCEL) of
    IDYES : miSaveClick(nil); //SaveChanges
    IDCANCEL : CanClose := False;
  end;
end;

procedure TfmMain.miFlatClick(Sender: TObject);
begin
  // Flat style stting
  with dxTreeList do
  begin
    if LookAndFeel = lfFlat then
      LookAndFeel := lfStandard
    else
      LookAndFeel := lfFlat;
    miFlat.Checked := LookAndFeel = lfFlat;
  end;
end;

procedure TfmMain.dxTreeListCompare(Sender: TObject; Node1,
  Node2: TdxTreeListNode; var Compare: Integer);
var i : integer;
begin
  with TdxTreeList(Sender) do begin
    i := 0;
    while i < ColumnCount do begin
      if Columns[i].Sorted <> csNone then break;
      inc(i);
    end;

    if i < ColumnCount then
      begin
        if Columns[i].Caption = 'Budget' then
          try
            Compare := Round(StrToFloat(Node1.Values[i]) - StrToFloat(Node2.Values[i]));
          except
            Compare := 0;
          end
        else Compare := CompareStr(Node1.Values[i], Node2.Values[i]);
      end
    else
      Compare := 0;
  end;
end;


procedure TfmMain.miShowBandsClick(Sender: TObject);
begin
  miShowBands.Checked := not miShowBands.Checked;
  dxTreeList.ShowBands := miShowBands.Checked;
end;

procedure TfmMain.dxTreeListGetSelectedIndex(Sender: TObject;
  Node: TdxTreeListNode; var Index: Integer);
begin
  Index := Node.ImageIndex;
end;

procedure TfmMain.qqq1Click(Sender: TObject);
begin
  dxTreeList.SaveToIniFile('c:\temp\test.ini');
end;

end.

