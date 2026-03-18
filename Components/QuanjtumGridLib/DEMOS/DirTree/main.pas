unit main;


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ExtCtrls, StdCtrls, dxCntner, dxTL, FileCtrl, dxEditor,
  dxExEdtr, dxEdLib, ImgList;

type
  TfmMain = class(TForm)
    StatusBar: TStatusBar;
    Panel1: TPanel;
    TLDirTree: TdxTreeList;
    Label1: TLabel;
    colName: TdxTreeListColumn;
    colSize: TdxTreeListColumn;
    colType: TdxTreeListColumn;
    ImageList: TImageList;
    Label2: TLabel;
    cbDrives: TdxPickEdit;
    btSearchColor: TButton;
    btFontColor: TButton;
    cdColor: TColorDialog;
    lbSearchResult: TLabel;
    procedure TLDirTreeGetImageIndex(Sender: TObject;
      Node: TdxTreeListNode; var Index: Integer);
    procedure TLDirTreeCompare(Sender: TObject; Node1,
      Node2: TdxTreeListNode; var Compare: Integer);
    procedure TLDirTreeChangeNode(Sender: TObject; OldNode,
      Node: TdxTreeListNode);
    procedure FormCreate(Sender: TObject);
    procedure btSearchColorClick(Sender: TObject);
    procedure btFontColorClick(Sender: TObject);
    procedure cbDrivesChange(Sender: TObject);
    procedure TLDirTreeExpanding(Sender: TObject; Node: TdxTreeListNode;
      var Allow: Boolean);
  private
    function GetNodeFullPath(ANode: TdxTreeListNode): String;
    procedure SortTreeListLevel(ANode: TdxTreeListNode);
    procedure BuildTree(ANode: TdxTreeListNode; const APath: string);
    procedure BuildDriverList;
  public
  end;

var
  fmMain: TfmMain;

implementation

{$R *.DFM}

const
  stFolder = 'Folder';
  stFile   = 'File';

function GetSizeStr(Size: Integer): string;
begin
  Size := Size div 1024;
  if Size < 0 then Size := 0;
  Result := FormatFloat('###,###,##0', Size) + 'KB';
end;

procedure TfmMain.TLDirTreeGetImageIndex(Sender: TObject;
  Node: TdxTreeListNode; var Index: Integer);
begin
  Index := 0;
  if Node.Expanded then
    Index := 1
  else
  if Node.Values[colType.Index] = stFile then
    Index := 2;
end;

procedure TfmMain.TLDirTreeCompare(Sender: TObject; Node1,
  Node2: TdxTreeListNode; var Compare: Integer);
var
  S1, S2: string;
begin
  if Node1.Values[colType.Index] = Node2.Values[colType.Index] then
  begin
    S1 := Node1.Values[colName.Index];
    S2 := Node2.Values[colName.Index];
    if S1 = S2 then
      Compare := 0
    else
    if S1 > S2 then
      Compare := 1
    else Compare := -1;
  end
  else
  if Node1.Values[colType.Index] = stFolder then
    Compare := -1
  else Compare := 1;
end;

procedure TfmMain.TLDirTreeChangeNode(Sender: TObject; OldNode,
  Node: TdxTreeListNode);
begin
  StatusBar.Panels[0].Text := GetNodeFullPath(Node);
end;

procedure TfmMain.BuildDriverList;
var I: Integer;
    Drive: PChar;
begin
  for I := 0 to 31 do
  begin
    if Boolean(GetLogicalDrives and (1 SHL I)) then
    begin
      Drive := PChar(CHR(65 + I) + ':\');
      cbDrives.Items.Add(Drive);
      if I = 2 then cbDrives.ItemIndex := cbDrives.Items.Count - 1;
    end;
  end;  
end;

procedure TfmMain.FormCreate(Sender: TObject);
begin
  BuildDriverList;
  cbDrivesChange(nil);
end;

procedure TfmMain.btSearchColorClick(Sender: TObject);
begin
  if cdColor.Execute then begin
    TLDirTree.AutoSearchColor := cdColor.Color;
    lbSearchResult.Color := TLDirTree.AutoSearchColor;
  end;
end;

procedure TfmMain.btFontColorClick(Sender: TObject);
begin
  if cdColor.Execute then begin
    TLDirTree.AutoSearchTextColor := cdColor.Color;
    lbSearchResult.Font.Color := TLDirTree.AutoSearchTextColor;
  end;
end;

function TfmMain.GetNodeFullPath(ANode: TdxTreeListNode): String;
begin
  Result := '';
  while ANode <> nil do
  begin
    if ANode.HasChildren then
      Result := '\' + Result;
    Result := ANode.Strings[colName.Index] + Result;
    ANode := ANode.Parent;
  end;
  Result := cbDrives.Text + Result;
end;

type
  TDummyTreeList = class(TdxTreeList);

procedure TfmMain.SortTreeListLevel(ANode: TdxTreeListNode);
begin
  TDummyTreeList(TLDirTree).DoSortColumn(-1, colName.Index, False);
end;

procedure TfmMain.BuildTree(ANode: TdxTreeListNode; const APath: string);
var
  SearchRec, Dummy: TSearchRec;
  Found: Integer;
  Node: TdxTreeListNode;
begin
 //find a file or a directory
  Found := FindFirst(APath + '*.*', faAnyFile, SearchRec);
  try
    while Found = 0 do
    begin
      if (SearchRec.Name <> '.') and (SearchRec.Name <> '..') then
      begin
        if ANode <> nil then
          Node := ANode.AddChild
        else Node := TLDirTree.Add;
        Node.Values[colName.Index] := SearchRec.Name;
       //if the directory has been found, build it
        if SearchRec.Attr and faDirectory <> 0 then
        begin
          Node.Values[colType.Index] := stFolder;
          Node.HasChildren := FindFirst(APath + SearchRec.Name + '\*.*', faAnyFile, Dummy) = 0;
        end
        else
        //if the file has been found, get its size
        begin
          Node.Values[colSize.Index] := GetSizeStr(SearchRec.Size);
          Node.Values[colType.Index] := stFile;
        end;
      end;
      Found := FindNext(SearchRec);
    end;
    SortTreeListLevel(ANode);
  finally
   // release memory selected FindFirst(1)
    FindClose(SearchRec);
  end;
end;

procedure TfmMain.cbDrivesChange(Sender: TObject);
begin
  with TLDirTree do
  begin
    Cursor := crHourGlass;
    BeginUpdate;
    try
      //removes all nodes from a tree list
      ClearNodes;
     // build a tree starting with the defined way in DriveCombobox
      BuildTree(nil, GetNodeFullPath(nil));
      //åxpands parent nodes of a top node
      if (TopNode <> nil) then
      begin
        TopNode.Focused := True;
        TopNode.MakeVisible;
      end
      //if none of nodes has been built
      else Application.MessageBox(PChar(cbDrives.Text + ' - test_is not accessible.'),'Error',
       MB_ICONERROR);
    finally
      EndUpdate;
      Cursor := crDefault;
    end;
  end;
  TLDirTree.OnChangeNode(TLDirTree, nil, TLDirTree.TopNode);
end;

procedure TfmMain.TLDirTreeExpanding(Sender: TObject;
  Node: TdxTreeListNode; var Allow: Boolean);
begin
  if Node.HasChildren and (Node.Count = 0) then
    BuildTree(Node, GetNodeFullPath(Node));
end;



end.
