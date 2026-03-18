
unit popup;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  dxTL, dxCntner, ExtCtrls, dxExEdtr{$IFDEF DELPHI4}, ImgList{$ENDIF};

type
  TfmPopupTree = class(TForm)
    pnPopupControl: TPanel;
    TreeList: TdxTreeList;
    colText: TdxTreeListColumn;
    Image16: TImageList;
    procedure FormCreate(Sender: TObject);
    procedure TreeListGetImageIndex(Sender: TObject; Node: TdxTreeListNode;
      var Index: Integer);
    procedure colTextCustomDrawCell(Sender: TObject; ACanvas: TCanvas;
      ARect: TRect; ANode: TdxTreeListNode; AColumn: TdxTreeListColumn;
      ASelected, AFocused, ANewItemRow: Boolean; var AText: String;
      var AColor: TColor; AFont: TFont; var AAlignment: TAlignment;
      var ADone: Boolean);
    procedure TreeListHotTrackNode(Sender: TObject;
      AHotTrackInfo: TdxTreeListHotTrackInfo; var ACursor: TCursor);
    procedure TreeListKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure TreeListClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmPopupTree: TfmPopupTree;

implementation

uses
  main, dxEditUtils;

{$R *.DFM}

procedure TfmPopupTree.FormCreate(Sender: TObject);
begin
  TreeList.FullExpand;
  TreeList.HighlightColor := TreeList.Color;
  TreeList.HighlightTextColor := TreeList.Font.Color;
end;

procedure TfmPopupTree.TreeListGetImageIndex(Sender: TObject;
  Node: TdxTreeListNode; var Index: Integer);
const
  RootImageIndex = 0;
  ChildImageIndex = 4;
begin
  if Node.Level = 0 then
  begin
    Index := RootImageIndex;
    if Node.Expanded then Inc(Index);
  end
  else
    Index := ChildImageIndex;

  if aoHotTrack in TreeList.OptionsEx then
  begin
    if Node = TreeList.HotTrackInfo.Node then
      if Node.Level = 0 then
        Inc(Index, 2)
      else
        Inc(Index);
  end;
end;

procedure TfmPopupTree.colTextCustomDrawCell(Sender: TObject;
  ACanvas: TCanvas; ARect: TRect; ANode: TdxTreeListNode;
  AColumn: TdxTreeListColumn; ASelected, AFocused, ANewItemRow: Boolean;
  var AText: String; var AColor: TColor; AFont: TFont;
  var AAlignment: TAlignment; var ADone: Boolean);
begin
  if ANode = TreeList.HotTrackInfo.Node then
  begin
    if not ASelected then AFont.Color := clNavy;
    AFont.Style := AFont.Style + [fsUnderline];
    if ANode.Level = 1 then
      AColor := RGB(100, 200, 255);
  end;
end;

procedure TfmPopupTree.TreeListHotTrackNode(Sender: TObject;
  AHotTrackInfo: TdxTreeListHotTrackInfo; var ACursor: TCursor);
begin
  if (AHotTrackInfo.Node <> nil) and (AHotTrackInfo.Node.Level = 1) then
    ACursor := crdxHandPointCursor;
end;

procedure TfmPopupTree.TreeListKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    ClosePopupForm(TreeList, False);
  if Key = VK_RETURN then
    TreeListClick(nil);
end;

procedure TfmPopupTree.TreeListClick(Sender: TObject);
begin
  if (TreeList.FocusedNode <> nil) and (TreeList.FocusedNode.Level = 1) then
    ClosePopupForm(TreeList, True);
end;

end.
