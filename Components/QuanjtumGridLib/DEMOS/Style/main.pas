unit main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Buttons, StdCtrls, dxExEdtr, dxEdLib, dxEditor, dxCntner, Db,
  DBTables{$IFDEF DELPHI4}, ImgList{$ENDIF}, DBCtrls;
                                                                    
type
  TMainForm = class(TForm)
    pnTop: TPanel;
    pnSeparator: TPanel;
    Bevel1: TBevel;
    Panel1: TPanel;
    Panel2: TPanel;
    BSample: TSpeedButton;
    BWeb: TSpeedButton;
    BRealBlank: TSpeedButton;
    BFlat: TSpeedButton;
    BStandard: TSpeedButton;
    BCustomize: TSpeedButton;
    Bevel2: TBevel;
    pnParent1: TPanel;
    pnCustomize: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    pnParent: TPanel;
    Panel6: TPanel;
    taClient: TTable;
    ImageList: TImageList;
    Bevel3: TBevel;
    Panel7: TPanel;
    Label1: TLabel;
    Label114: TLabel;
    edBorderColor: TdxButtonEdit;
    Label115: TLabel;
    edBorderStyle: TdxPickEdit;
    edButtonTransparence: TLabel;
    edButtonViewStyle: TdxPickEdit;
    Label117: TLabel;
    ButtonTransparence: TdxPickEdit;
    cbLeft: TdxCheckEdit;
    cbRight: TdxCheckEdit;
    cbTop: TdxCheckEdit;
    cbBottom: TdxCheckEdit;
    cbHotTrack: TdxCheckEdit;
    cbShadow: TdxCheckEdit;
    Label2: TLabel;
    Bevel4: TBevel;
    Bevel5: TBevel;
    Label3: TLabel;
    Label4: TLabel;
    Bevel6: TBevel;
    Label5: TLabel;
    Bevel7: TBevel;
    ColorDialog: TColorDialog;
    Bevel8: TBevel;
    dsClient: TDataSource;
    DBNavigator: TDBNavigator;
    BNew: TButton;
    BSave: TButton;
    BCancel: TButton;
    procedure BCustomizeClick(Sender: TObject);
    procedure BSampleClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edBorderColorButtonClick(Sender: TObject;
      AbsoluteIndex: Integer);
    procedure edBorderStyleChange(Sender: TObject);
    procedure edButtonViewStyleChange(Sender: TObject);
    procedure ButtonTransparenceChange(Sender: TObject);
    procedure cbLeftClick(Sender: TObject);
    procedure cbTopChange(Sender: TObject);
    procedure cbRightChange(Sender: TObject);
    procedure cbBottomChange(Sender: TObject);
    procedure cbHotTrackClick(Sender: TObject);
    procedure cbShadowClick(Sender: TObject);
    procedure edBorderColorDblClick(Sender: TObject);
    procedure BWebClick(Sender: TObject);
    procedure BRealBlankClick(Sender: TObject);
    procedure BFlatClick(Sender: TObject);
    procedure BStandardClick(Sender: TObject);
    procedure BNewClick(Sender: TObject);
    procedure BSaveClick(Sender: TObject);
    procedure BCancelClick(Sender: TObject);
    procedure dsClientStateChange(Sender: TObject);
  private
    FActiveStyleController: TdxEditStyleController;
    procedure SetActiveStyleController(Value: TdxEditStyleController);
  protected
    procedure InitCustomizePanel;
    procedure ShowPanel(APanel: TPanel);
  public
    property ActiveStyleController: TdxEditStyleController read FActiveStyleController
      write SetActiveStyleController;
  end;

var
  MainForm: TMainForm;

implementation

uses
  dxDemoUtils, fGradient, fWeb, fReal, fFlat, fStandard;

{$R *.DFM}

procedure TMainForm.ShowPanel(APanel: TPanel);

  procedure SetButtonsParent;
  begin
    DBNavigator.Parent := APanel;
    DBNavigator.Visible := True;
    BNew.Parent := APanel;
    BNew.Visible := True;
    BSave.Parent := APanel;
    BSave.Visible := True;
    BCancel.Parent := APanel;
    BCancel.Visible := True;
  end;

var
  I: Integer;
  AControl: TControl;
begin
  APanel.Parent := pnParent;
  APanel.Left := 0;
  APanel.Top := 0;
  SetButtonsParent;
  APanel.Visible := True;
  for I := 0 to pnParent.ControlCount - 1 do
  begin
    AControl := pnParent.Controls[I];
    if (AControl is TPanel) and (AControl <> APanel) then
      AControl.Visible := False;
  end;
end;

procedure TMainForm.InitCustomizePanel;
begin
  edBorderColor.Color := ActiveStyleController.BorderColor;
  edBorderStyle.ItemIndex := Integer(ActiveStyleController.BorderStyle);
  edButtonViewStyle.ItemIndex := Integer(ActiveStyleController.ButtonStyle);
  ButtonTransparence.ItemIndex := Integer(ActiveStyleController.ButtonTransparence);
  cbHotTrack.Checked := ActiveStyleController.HotTrack;
  cbShadow.Checked := ActiveStyleController.Shadow;
  cbLeft.Checked := edgLeft in ActiveStyleController.Edges;
  cbRight.Checked := edgRight in ActiveStyleController.Edges;
  cbTop.Checked := edgTop in ActiveStyleController.Edges;
  cbBottom.Checked := edgBottom in ActiveStyleController.Edges;
end;

procedure TMainForm.SetActiveStyleController(Value: TdxEditStyleController);
begin
  FActiveStyleController := Value;
  InitCustomizePanel;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  taClient.Active := False;
  taClient.DatabaseName := ExtractFilePath(Application.ExeName) + 'DATA';
  taClient.Active := True;
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  if Screen.Fonts.IndexOf('Tahoma') = -1 then
  begin
    ResetDefaultFontName(Self);
    ResetDefaultFontName(fmGradient.pnForm);
    ResetDefaultFontName(fmWebStyle.pnForm);
    ResetDefaultFontName(fmRealBlank.pnForm);
    ResetDefaultFontName(fmFlat.pnForm);
    ResetDefaultFontName(fmStandard.pnForm);
  end;
  BSampleClick(nil);
end;

procedure TMainForm.edBorderColorButtonClick(Sender: TObject;
  AbsoluteIndex: Integer);
begin
  ColorDialog.Color := edBorderColor.Color;
  if ColorDialog.Execute then
  begin
    edBorderColor.Color := ColorDialog.Color;
    edBorderColor.Font.Color := ColorToRGB(edBorderColor.Color) xor $FFFFFF;
    ActiveStyleController.BorderColor := edBorderColor.Color;
  end;
end;

procedure TMainForm.edBorderColorDblClick(Sender: TObject);
begin
  edBorderColorButtonClick(nil, 0);
end;

procedure TMainForm.edBorderStyleChange(Sender: TObject);
begin
  ActiveStyleController.BorderStyle := TdxEditBorderStyle(edBorderStyle.ItemIndex);
end;

procedure TMainForm.edButtonViewStyleChange(Sender: TObject);
begin
  ActiveStyleController.ButtonStyle := TdxEditButtonViewStyle(edButtonViewStyle.ItemIndex);
end;

procedure TMainForm.ButtonTransparenceChange(Sender: TObject);
begin
  ActiveStyleController.ButtonTransparence := TdxEditButtonTransparence(ButtonTransparence.ItemIndex);
end;

procedure TMainForm.cbLeftClick(Sender: TObject);
begin
  with ActiveStyleController do
  begin
    if cbLeft.Checked then
      Edges := Edges + [edgLeft]
    else
      Edges := Edges - [edgLeft];
  end;
end;

procedure TMainForm.cbTopChange(Sender: TObject);
begin
  with ActiveStyleController do
  begin
    if cbTop.Checked then
      Edges := Edges + [edgTop]
    else
      Edges := Edges - [edgTop];
  end;
end;

procedure TMainForm.cbRightChange(Sender: TObject);
begin
  with ActiveStyleController do
  begin
    if cbRight.Checked then
      Edges := Edges + [edgRight]
    else
      Edges := Edges - [edgRight];
  end;
end;

procedure TMainForm.cbBottomChange(Sender: TObject);
begin
  with ActiveStyleController do
  begin
    if cbBottom.Checked then
      Edges := Edges + [edgBottom]
    else
      Edges := Edges - [edgBottom];
  end;
end;

procedure TMainForm.cbHotTrackClick(Sender: TObject);
begin
  ActiveStyleController.HotTrack := cbHotTrack.Checked;
end;

procedure TMainForm.cbShadowClick(Sender: TObject);
begin
  ActiveStyleController.Shadow := cbShadow.Checked;
end;

procedure TMainForm.BCustomizeClick(Sender: TObject);
begin
  pnCustomize.Visible := not pnCustomize.Visible;
end;

procedure TMainForm.BSampleClick(Sender: TObject);
begin
  ShowPanel(fmGradient.pnForm);
  ActiveStyleController := fmGradient.StyleController;
end;

procedure TMainForm.BWebClick(Sender: TObject);
begin
  ShowPanel(fmWebStyle.pnForm);
  ActiveStyleController := fmWebStyle.StyleController;
end;

procedure TMainForm.BRealBlankClick(Sender: TObject);
begin
  ShowPanel(fmRealBlank.pnForm);
  ActiveStyleController := fmRealBlank.StyleController;
end;

procedure TMainForm.BFlatClick(Sender: TObject);
begin
  ShowPanel(fmFlat.pnForm);
  ActiveStyleController := fmFlat.StyleController;
end;

procedure TMainForm.BStandardClick(Sender: TObject);
begin
  ShowPanel(fmStandard.pnForm);
  ActiveStyleController := fmStandard.StyleController;
end;

procedure TMainForm.BNewClick(Sender: TObject);
var
  ANewID: Integer;
begin
  taClient.DisableControls;
  try
    taClient.Last;
    ANewID := taClient.FieldByName('CLIENT_ID').AsInteger + 1;
  finally
    taClient.EnableControls;
  end;
  taClient.Append;
  taClient.FieldByName('CLIENT_ID').AsInteger := ANewID;
end;

procedure TMainForm.BSaveClick(Sender: TObject);
begin
  taClient.Post;
end;

procedure TMainForm.BCancelClick(Sender: TObject);
begin
  taClient.Cancel;
end;

procedure TMainForm.dsClientStateChange(Sender: TObject);
begin
  BNew.Enabled := taClient.State = dsBrowse;
  BSave.Enabled := taClient.State in dsEditModes;
  BCancel.Enabled := BSave.Enabled;
end;

end.
