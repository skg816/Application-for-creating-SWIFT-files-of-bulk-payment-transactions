unit main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, dxGrClms, dxTL, dxDBGrid, dxCntner, Menus, StdCtrls, dxExEdtr,
  dxDBTLCl, dxDBCtrl;
                               
type
  TfmMain = class(TForm)
    dxDBGrid: TdxDBGrid;
    colSpeciesNo: TdxDBGridColumn;
    colNotes: TdxDBGridMemoColumn;
    colCategory: TdxDBGridColumn;
    colGraphic: TdxDBGridGraphicColumn;
    colCommon_Name: TdxDBGridColumn;
    colSpeciesName: TdxDBGridColumn;
    colLength: TdxDBGridColumn;
    colLength_In: TdxDBGridColumn;
    Table1: TTable;
    DataSource1: TDataSource;
    MainMenu: TMainMenu;
    miFile: TMenuItem;
    Exit1: TMenuItem;
    GraphicColumn1: TMenuItem;
    miStretch: TMenuItem;
    miShadowSelection: TMenuItem;
    N1: TMenuItem;
    PopupToolBarAlignment1: TMenuItem;
    ptaLeft1: TMenuItem;
    ptaRight1: TMenuItem;
    ptaTop1: TMenuItem;
    ptaBottom1: TMenuItem;
    PopupToolBarButtons1: TMenuItem;
    ptbCut1: TMenuItem;
    ptbCopy1: TMenuItem;
    ptbPaste1: TMenuItem;
    ptbDelete1: TMenuItem;
    ptbLoad1: TMenuItem;
    ptbSave1: TMenuItem;
    ptbCustom1: TMenuItem;
    ShowCaptions1: TMenuItem;
    PopupToolBarVisible1: TMenuItem;
    N2: TMenuItem;
    DisableEditor1: TMenuItem;
    MemoColumn1: TMenuItem;
    DisableEditor2: TMenuItem;
    N3: TMenuItem;
    ScrollBars1: TMenuItem;
    ssNone1: TMenuItem;
    ssHorizontal1: TMenuItem;
    ssVertical1: TMenuItem;
    ssBoth1: TMenuItem;
    WordWrap1: TMenuItem;
    QuickDraw1: TMenuItem;
    procedure dxDBGridColumnSorting(Sender: TObject;
      Column: TdxDBTreeListColumn; var Allow: Boolean);
    procedure dxDBGridCanHeaderDragging(Sender: TObject;
      AColumn: TdxTreeListColumn; var Allow: Boolean);
    procedure colGraphicCustomClick(Sender: TObject);
    procedure miStretchClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure miShadowSelectionClick(Sender: TObject);
    procedure ptaLeft1Click(Sender: TObject);
    procedure ptbCut1Click(Sender: TObject);
    procedure ShowCaptions1Click(Sender: TObject);
    procedure PopupToolBarVisible1Click(Sender: TObject);
    procedure DisableEditor1Click(Sender: TObject);
    procedure DisableEditor2Click(Sender: TObject);
    procedure ssNone1Click(Sender: TObject);
    procedure WordWrap1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure QuickDraw1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;

implementation

uses preview;

{$R *.DFM}

procedure TfmMain.dxDBGridColumnSorting(Sender: TObject;
  Column: TdxDBTreeListColumn; var Allow: Boolean);
begin
  if (Column = colGraphic) or (Column = colNotes) then Allow := False;
end;

procedure TfmMain.dxDBGridCanHeaderDragging(Sender: TObject;
  AColumn: TdxTreeListColumn; var Allow: Boolean);
begin
  if (AColumn = colGraphic) or (AColumn = colNotes) then Allow := False;
end;

procedure TfmMain.colGraphicCustomClick(Sender: TObject);
begin
   if fmPreview = nil then
     fmPreview := TfmPreview.Create(Self);
   fmPreview.Show;
end;

procedure TfmMain.FormCreate(Sender: TObject);
begin
  Table1.DataBaseName := 'DBDEMOS';
  Table1.Open;

  // load settings
  QuickDraw1.Checked := colGraphic.QuickDraw;
  miStretch.Checked := colGraphic.Stretch;
  miShadowSelection.Checked := colGraphic.ShadowSelection;
  // sub alignment
  ptaLeft1.Parent.Items[Integer(colGraphic.PopupToolBar.Alignment)].Checked := True;
  with colGraphic.PopupToolBar do
  begin
    ptbCut1.Checked := ptbCut in Buttons;
    ptbCopy1.Checked := ptbCopy in Buttons;
    ptbPaste1.Checked := ptbPaste in Buttons;
    ptbDelete1.Checked := ptbDelete in Buttons;
    ptbSave1.Checked := ptbSave in Buttons;
    ptbLoad1.Checked := ptbLoad in Buttons;
    ptbCustom1.Checked := ptbCustom in Buttons;
  end;
  ShowCaptions1.Checked := colGraphic.PopupToolBar.ShowCaptions;
  PopupToolBarVisible1.Checked := colGraphic.PopupToolBar.Visible;
  DisableEditor1.Checked := colGraphic.DisableEditor;
  // memo
  DisableEditor2.Checked := colNotes.DisableEditor;
  ssNone1.Parent.Items[Integer(colNotes.ScrollBars)].Checked := True;
  WordWrap1.Checked := colNotes.WordWrap;
end;

procedure TfmMain.miStretchClick(Sender: TObject);
begin
  TMenuItem(Sender).Checked := not TMenuItem(Sender).Checked;
  colGraphic.Stretch := TMenuItem(Sender).Checked;
end;

procedure TfmMain.miShadowSelectionClick(Sender: TObject);
begin
  TMenuItem(Sender).Checked := not TMenuItem(Sender).Checked;
  colGraphic.ShadowSelection := TMenuItem(Sender).Checked;
end;

procedure TfmMain.ptaLeft1Click(Sender: TObject);
begin
  dxDBGrid.HideEditor;
  with Sender as TMenuItem do
  begin
    Checked := True;
    colGraphic.PopupToolBar.Alignment :=
      TdxPopupToolBarAlignment(Parent.IndexOf(Sender as TMenuItem));
  end;
end;

procedure TfmMain.ptbCut1Click(Sender: TObject);
var
  ToolBarButton: TdxPopupToolBarButton;
begin
  dxDBGrid.HideEditor;
  with Sender as TMenuItem do
  begin
    Checked := not Checked;
    ToolBarButton := TdxPopupToolBarButton(Parent.IndexOf(Sender as TMenuItem));
    if Checked then
      colGraphic.PopupToolBar.Buttons := colGraphic.PopupToolBar.Buttons  + [ToolBarButton]
    else colGraphic.PopupToolBar.Buttons := colGraphic.PopupToolBar.Buttons  - [ToolBarButton];
  end;
end;

procedure TfmMain.ShowCaptions1Click(Sender: TObject);
begin
  dxDBGrid.HideEditor;
  TMenuItem(Sender).Checked := not TMenuItem(Sender).Checked;
  colGraphic.PopupToolBar.ShowCaptions := TMenuItem(Sender).Checked;
end;

procedure TfmMain.PopupToolBarVisible1Click(Sender: TObject);
begin
  dxDBGrid.HideEditor;
  TMenuItem(Sender).Checked := not TMenuItem(Sender).Checked;
  colGraphic.PopupToolBar.Visible := TMenuItem(Sender).Checked;
end;

procedure TfmMain.DisableEditor1Click(Sender: TObject);
begin
  dxDBGrid.HideEditor;
  TMenuItem(Sender).Checked := not TMenuItem(Sender).Checked;
  colGraphic.DisableEditor := TMenuItem(Sender).Checked;
end;

procedure TfmMain.DisableEditor2Click(Sender: TObject);
begin
  dxDBGrid.HideEditor;
  TMenuItem(Sender).Checked := not TMenuItem(Sender).Checked;
  colNotes.DisableEditor := TMenuItem(Sender).Checked;
end;

procedure TfmMain.ssNone1Click(Sender: TObject);
begin
  dxDBGrid.HideEditor;
  with Sender as TMenuItem do
  begin
    Checked := True;
    colNotes.ScrollBars :=
      TScrollStyle(Parent.IndexOf(Sender as TMenuItem));
  end;
end;

procedure TfmMain.WordWrap1Click(Sender: TObject);
begin
  dxDBGrid.HideEditor;
  TMenuItem(Sender).Checked := not TMenuItem(Sender).Checked;
  colNotes.WordWrap := TMenuItem(Sender).Checked;
end;

procedure TfmMain.Exit1Click(Sender: TObject);
begin
  Close;
end;

procedure TfmMain.QuickDraw1Click(Sender: TObject);
begin
  TMenuItem(Sender).Checked := not TMenuItem(Sender).Checked;
  colGraphic.QuickDraw := TMenuItem(Sender).Checked;
end;

end.
