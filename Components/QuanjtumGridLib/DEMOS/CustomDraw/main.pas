unit Main;

interface

uses
  Windows, Forms, dxDBGrid, Controls, Db, DBTables, dxGrClms, Graphics,
  ExtCtrls, dxTL, dxCntner, ComCtrls, Classes, dxDBCtrl, dxDBTLCl;

type
  TdxGrid = class(TdxDBGrid) end;
  TMainForm = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    dxDBGrid1: TdxDBGrid;
    dxDBGrid1Name: TdxDBGridColumn;
    dxDBGrid1Company: TdxDBGridColumn;
    dxDBGrid1Address: TdxDBGridColumn;
    dxDBGrid1City: TdxDBGridColumn;
    dxDBGrid1State: TdxDBGridColumn;
    dxDBGrid1Fax: TdxDBGridColumn;
    dxDBGrid1Country: TdxDBGridColumn;
    dxDBGrid1Phone: TdxDBGridColumn;
    dxDBGrid1Zip: TdxDBGridColumn;
    DSCustomer: TDataSource;
    TableCustomer: TTable;
    dxDBGrid2: TdxDBGrid;
    dxDBGrid2FirstName: TdxDBGridColumn;
    dxDBGrid2LastName: TdxDBGridColumn;
    dxDBGrid2Customer: TdxDBGridCheckColumn;
    dxDBGrid2PurchaseDate: TdxDBGridDateColumn;
    dxDBGrid2PaymentType: TdxDBGridImageColumn;
    dxDBGrid2PaymentAmount: TdxDBGridCalcColumn;
    TableContacts: TTable;
    DSContacts: TDataSource;
    dxDBGrid3: TdxDBGrid;
    dxDBGrid3FirstName: TdxDBGridColumn;
    dxDBGrid3LastName: TdxDBGridColumn;
    dxDBGrid3Company: TdxDBGridColumn;
    dxDBGrid3Customer: TdxDBGridCheckColumn;
    dxDBGrid3PurchaseDate: TdxDBGridDateColumn;
    dxDBGrid3PaymentType: TdxDBGridImageColumn;
    dxDBGrid3PaymentAmount: TdxDBGridCalcColumn;
    Images: TImageList;
    dxDBGrid4: TdxDBGrid;
    dxDBGrid4FirstName: TdxDBGridColumn;
    dxDBGrid4LastName: TdxDBGridColumn;
    dxDBGrid4Company: TdxDBGridColumn;
    dxDBGrid4Customer: TdxDBGridCheckColumn;
    dxDBGrid4PurchaseDate: TdxDBGridDateColumn;
    dxDBGrid4PaymentAmount: TdxDBGridMaskColumn;
    Panel1: TPanel;
    Image1: TImage;
    Image2: TImage;
    procedure FormCreate(Sender: TObject);
    procedure dxDBGrid1BackgroundDrawEvent(Sender: TObject; ACanvas: TCanvas;
      ARect: TRect);
    procedure dxDBGrid1CustomDrawBand(Sender: TObject; ABand: TdxTreeListBand;
      ACanvas: TCanvas; ARect: TRect; var AText: String;
      var AColor: TColor; AFont: TFont; var AAlignment: TAlignment;
      var ADone: Boolean);
    procedure dxDBGrid1CustomDrawColumnHeader(Sender: TObject;
      AColumn: TdxTreeListColumn; ACanvas: TCanvas; ARect: TRect;
      var AText: String; var AColor: TColor; AFont: TFont;
      var AAlignment: TAlignment; var ASorted: TdxTreeListColumnSort;
      var ADone: Boolean);
    procedure dxDBGrid2CustomDrawCell(Sender: TObject; ACanvas: TCanvas;
      ARect: TRect; ANode: TdxTreeListNode; AColumn: TdxTreeListColumn;
      ASelected, AFocused, ANewItemRow: Boolean; var AText: String;
      var AColor: TColor; AFont: TFont; var AAlignment: TAlignment;
      var ADone: Boolean);
    procedure dxDBGrid2GetLevelColor(Sender: TObject; ALevel: Integer;
      var AColor: TColor);
    procedure dxDBGrid3CustomDrawFooterNode(Sender: TObject; ACanvas: TCanvas;
      ARect: TRect; ANode: TdxTreeListNode; AColumn: TdxTreeListColumn;
      AFooterIndex: Integer; var AText: String; var AColor: TColor;
      AFont: TFont; var AAlignment: TAlignment; var ADone: Boolean);
    procedure dxDBGrid3PaymentAmountDrawSummaryFooter(Sender: TObject;
      ACanvas: TCanvas; ARect: TRect; var AText: String;
      var AAlignment: TAlignment; AFont: TFont; var AColor: TColor;
      var ADone: Boolean);
    procedure dxDBGrid3CustomerDrawSummaryFooter(Sender: TObject;
      ACanvas: TCanvas; ARect: TRect; var AText: String;
      var AAlignment: TAlignment; AFont: TFont; var AColor: TColor;
      var ADone: Boolean);
    procedure dxDBGrid4CustomDrawPreviewCell(Sender: TObject;
      ACanvas: TCanvas; ARect: TRect; ANode: TdxTreeListNode;
      ASelected: Boolean; var AText: String; var AColor,
      ATextColor: TColor; AFont: TFont; var ADone: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

uses SysUtils, dxDemoUtils{$IFDEF VER140}, Variants{$ENDIF};
{$R *.DFM}

// Draw GroupPanel, Bands, Headers
procedure PaintImageTiled(ACanvas: TCanvas; ARect: TRect; ABitmap: TBitmap);
var
  X, Y: Integer;
begin
  X := ARect.Left;
  repeat
    Y := ARect.Top;
    repeat
      ACanvas.Draw(X, Y, ABitmap);
      Inc(Y, ABitmap.Height);
    until Y >= ARect.Bottom;
    Inc(X, ABitmap.Width);
  until X >= ARect.Right
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  TableContacts.DatabaseName := '..\Data\';
  TableContacts.Open;
  TableCustomer.Open;
  dxDBGrid2.FullExpand;
  dxDBGrid3.FullExpand;
end;

procedure TMainForm.dxDBGrid1BackgroundDrawEvent(Sender: TObject;
  ACanvas: TCanvas; ARect: TRect);
var
  CustomDrawRgn: TdxCustomDrawRegion;
begin
  CustomDrawRgn := TdxCustomDrawRegion.Create(ACanvas.Handle, ARect);
  try
    PaintImageTiled(ACanvas, ARect, Image1.Picture.Bitmap);
    if TdxDBGrid(Sender).GroupColumnCount = 0 then
      with ACanvas do
      begin
        Font.Color := clBlack;
        Brush.Style := bsClear;
        TextOut(10,(ARect.Bottom - ARect.Top + ACanvas.Font.Height) div 2, 'Drag a column header here to group that column');
      end;
  finally
    CustomDrawRgn.Free;
  end;
end;

procedure TMainForm.dxDBGrid1CustomDrawBand(Sender: TObject;
  ABand: TdxTreeListBand; ACanvas: TCanvas; ARect: TRect;
  var AText: String; var AColor: TColor; AFont: TFont;
  var AAlignment: TAlignment; var ADone: Boolean);
const
  BandFontColor : Array[Boolean] of TColor = (clBtnShadow, clWhite);
var
  X, Y: Integer;
  CustomDrawRgn: TdxCustomDrawRegion;
  IsBandDown: Boolean;
begin
  CustomDrawRgn := TdxCustomDrawRegion.Create(ACanvas.Handle, ARect);
  try
    PaintImageTiled(ACanvas, ARect, Image2.Picture.Bitmap);

    ACanvas.Font.Size := 11;
    X := ARect.Left + 5;
    Y := ARect.Top + (ARect.Bottom - ARect.Top - ACanvas.TextHeight(AText)) div 2;
    ACanvas.Font.Style := ACanvas.Font.Style + [fsBold];

    IsBandDown := (Sender as TdxDBGrid).DownBandIndex = ABand.VisibleIndex;
    if IsBandDown then
      ACanvas.Brush.Color := clBtnFace;
    ACanvas.Brush.Style := bsClear;
    ACanvas.Font.Color := BandFontColor[IsBandDown];
    ACanvas.TextRect(ARect, X + 3, Y + 3, AText);
    if not IsBandDown then
    begin
      ACanvas.Font.Color := clWhite;
      ACanvas.TextRect(ARect, X, Y, AText );
    end;

    DrawEdge(ACanvas.Handle, ARect, BDR_RAISEDINNER, BF_TOPLEFT);
    DrawEdge(ACanvas.Handle, ARect, BDR_RAISEDOUTER, BF_BOTTOMRIGHT);

  finally
    CustomDrawRgn.Free;
  end;

  ADone := True;
end;

procedure TMainForm.dxDBGrid1CustomDrawColumnHeader(Sender: TObject;
  AColumn: TdxTreeListColumn; ACanvas: TCanvas; ARect: TRect;
  var AText: String; var AColor: TColor; AFont: TFont;
  var AAlignment: TAlignment; var ASorted: TdxTreeListColumnSort;
  var ADone: Boolean);
begin
  // change painting font
  if (AColumn.Caption = 'City') or (AColumn.Caption = 'State') or
     (AColumn.Caption = 'Country') or (AColumn.Caption = 'Zip') then
  begin
    AFont.Style := AFont.Style + [fsBold];
    AFont.Color := clGray;
  end;

  // change background color
  if AColumn.Caption = 'CustNo' then
    AColor := clGreen;
end;

// Draw Cells and Levels Color

procedure TMainForm.dxDBGrid2CustomDrawCell(Sender: TObject; ACanvas: TCanvas;
  ARect: TRect; ANode: TdxTreeListNode; AColumn: TdxTreeListColumn;
  ASelected, AFocused, ANewItemRow: Boolean; var AText: String;
  var AColor: TColor; AFont: TFont; var AAlignment: TAlignment;
  var ADone: Boolean);
var
  Value: Variant;
begin
  if ANode.HasChildren then
    Exit;
  if not ASelected and (AColumn = dxDBGrid2PaymentAmount) then
  begin
    Value := ANode.Values[AColumn.Index];
    if not VarIsNull(Value) then
    begin
      if Value < 200 then
        AColor := clLime
      else
        if Value < 300 then
          AColor := clYellow
        else
        begin // > 300
          AColor := clRed;
          AFont.Color := clWhite;
        end;
     end;   
  end;

  // customers are in bold color
  if ANode.Values[dxDBGrid2Customer.Index] = dxDBGrid2Customer.ValueChecked then
  begin
    AFont.Style := AFont.Style + [fsBold];
    if ASelected then
      AFont.Color := clWhite
    else
      AFont.Color := clNavy;
  end;
end;

function GetColor(BColor, EColor: TColor; N, H: Integer): TColor;
begin
  Result := RGB(Trunc(GetRValue(BColor) + (GetRValue(EColor)-GetRValue(BColor)) * N / H),
    Trunc(GetGValue(BColor) + (GetGValue(EColor)-GetGValue(BColor)) * N / H),
    Trunc(GetBValue(BColor) + (GetBValue(EColor)-GetBValue(BColor)) * N / H));
end;

procedure TMainForm.dxDBGrid2GetLevelColor(Sender: TObject; ALevel: Integer;
  var AColor: TColor);
begin
  AColor := GetColor(TdxDBGrid(Sender).GroupNodeColor, clWhite, ALevel, 3);
end;

// Draw Footers
procedure TMainForm.dxDBGrid3CustomDrawFooterNode(Sender: TObject;
  ACanvas: TCanvas; ARect: TRect; ANode: TdxTreeListNode;
  AColumn: TdxTreeListColumn; AFooterIndex: Integer; var AText: String;
  var AColor: TColor; AFont: TFont; var AAlignment: TAlignment;
  var ADone: Boolean);
begin
  if AColumn = dxDBGrid3PaymentAmount then
  begin
    AColor := clWhite;
    AFont.Style := AFont.Style + [fsBold];
  end;

  if AColumn = dxDBGrid3FirstName then
  begin
    InflateRect(ARect, 1, 1);
    ACanvas.Brush.Color := cl3DLight;
    ACanvas.FillRect(ARect);
    Images.Draw(ACanvas, ARect.Left + 3, ARect.Top, 1);
    ADone := True;
  end;
end;

procedure TMainForm.dxDBGrid3PaymentAmountDrawSummaryFooter(Sender: TObject;
  ACanvas: TCanvas; ARect: TRect; var AText: String;
  var AAlignment: TAlignment; AFont: TFont; var AColor: TColor;
  var ADone: Boolean);
begin
  AColor := clWhite;
  AFont.Style := AFont.Style + [fsBold];
end;

procedure TMainForm.dxDBGrid3CustomerDrawSummaryFooter(Sender: TObject;
  ACanvas: TCanvas; ARect: TRect; var AText: String;
  var AAlignment: TAlignment; AFont: TFont; var AColor: TColor;
  var ADone: Boolean);
begin
  ACanvas.Brush.Color := clBtnFace;
  ACanvas.FillRect(ARect);
  Images.Draw(ACanvas, (ARect.Right + ARect.Left) div 2 - 8, ARect.Top, 0);
  ADone := True;
end;

// Draw Preview
procedure TMainForm.dxDBGrid4CustomDrawPreviewCell(Sender: TObject;
  ACanvas: TCanvas; ARect: TRect; ANode: TdxTreeListNode;
  ASelected: Boolean; var AText: String; var AColor, ATextColor: TColor;
  AFont: TFont; var ADone: Boolean);
var
  Value: Variant;
begin
  // The "Green bar" feature for the preview
  if ANode.Index mod 2 = 0 then
    AColor := clInfoBk
  else
    AColor := clAqua;

  // Bold preview text if a customer paid more than $300
  Value := ANode.Values[dxDBGrid4PaymentAmount.Index];
  try
    if Value > 300 then
      AFont.Style := AFont.Style + [fsBold];
  except
    on EVariantError do; // the Value can be Null
  end;
end;

end.
