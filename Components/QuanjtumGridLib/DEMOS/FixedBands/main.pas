unit main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  dxGrClms, dxTL, dxDBGrid, dxCntner, Db, DBTables, dxDBTLCl, dxDBCtrl;

type
  TMainForm = class(TForm)
    tTotal: TTable;
    tTotalID: TAutoIncField;
    tTotalFirstName: TStringField;
    tTotalLastName: TStringField;
    tTotalYears: TIntegerField;
    tTotalRowTotal: TFloatField;
    tTotalRowAVG: TFloatField;
    tTotalJanuary: TFloatField;
    tTotalFebruary: TFloatField;
    tTotalMarch: TFloatField;
    tTotalApril: TFloatField;
    tTotalMay: TFloatField;
    tTotalJune: TFloatField;
    tTotalJuly: TFloatField;
    tTotalAugust: TFloatField;
    tTotalSeptember: TFloatField;
    tTotalOctober: TFloatField;
    tTotalDecember: TFloatField;
    tTotalNovember: TFloatField;
    tTotalPreview: TStringField;
    tTotalCustomName: TStringField;
    dsTotal: TDataSource;
    dxDBGrid: TdxDBGrid;
    col15Year: TdxDBGridColumn;
    colJanuary: TdxDBGridCalcColumn;
    colFebruary: TdxDBGridCalcColumn;
    colMarch: TdxDBGridCalcColumn;
    colApril: TdxDBGridCalcColumn;
    colMay: TdxDBGridCalcColumn;
    colJune: TdxDBGridCalcColumn;
    colJuly: TdxDBGridCalcColumn;
    colAugust: TdxDBGridCalcColumn;
    colSeptember: TdxDBGridCalcColumn;
    colOctober: TdxDBGridCalcColumn;
    colNovember: TdxDBGridCalcColumn;
    colDecember: TdxDBGridCalcColumn;
    colRowTotal: TdxDBGridColumn;
    colRowAVG: TdxDBGridColumn;
    dxDBGridColumn18: TdxDBGridColumn;
    procedure FormCreate(Sender: TObject);
    procedure dxDBGridCustomDrawBand(Sender: TObject;
      ABand: TdxTreeListBand; ACanvas: TCanvas; ARect: TRect;
      var AText: String; var AColor: TColor; AFont: TFont;
      var AAlignment: TAlignment; var ADone: Boolean);
    procedure dxDBGridCustomDrawCell(Sender: TObject; ACanvas: TCanvas;
      ARect: TRect; ANode: TdxTreeListNode; AColumn: TdxTreeListColumn;
      ASelected, AFocused, ANewItemRow: Boolean; var AText: String;
      var AColor: TColor; AFont: TFont; var AAlignment: TAlignment;
      var ADone: Boolean);
    procedure colRowTotalDrawSummaryFooter(Sender: TObject;
      ACanvas: TCanvas; ARect: TRect; var AText: String;
      var AAlignment: TAlignment; AFont: TFont; var AColor: TColor;
      var ADone: Boolean);
    procedure tTotalCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.DFM}

procedure TMainForm.FormCreate(Sender: TObject);
begin
  tTotal.DataBaseName := '..\Data\';
  tTotal.Open;
  dxDBGrid.FullExpand;
end;

procedure TMainForm.dxDBGridCustomDrawBand(Sender: TObject;
  ABand: TdxTreeListBand; ACanvas: TCanvas; ARect: TRect;
  var AText: String; var AColor: TColor; AFont: TFont;
  var AAlignment: TAlignment; var ADone: Boolean);
begin
  AFont.Style := AFont.Style + [fsBold];
end;

procedure TMainForm.dxDBGridCustomDrawCell(Sender: TObject;
  ACanvas: TCanvas; ARect: TRect; ANode: TdxTreeListNode;
  AColumn: TdxTreeListColumn; ASelected, AFocused, ANewItemRow: Boolean;
  var AText: String; var AColor: TColor; AFont: TFont;
  var AAlignment: TAlignment; var ADone: Boolean);
const
  ColorCount = 3;
  Colors: Array[0..ColorCount - 1] of TColor = ($00FEFBD3, clWindow, $00DBFBFD);
begin
  if (ANode.HasChildren) or ASelected then exit;
  Assert(AColumn.BandIndex < ColorCount, 'BandIndex is out of bounds');
  AColor := Colors[AColumn.BandIndex];
end;

procedure TMainForm.colRowTotalDrawSummaryFooter(Sender: TObject;
  ACanvas: TCanvas; ARect: TRect; var AText: String;
  var AAlignment: TAlignment; AFont: TFont; var AColor: TColor;
  var ADone: Boolean);
begin
  AColor := clBlue;
  with AFont do begin
    Style := Style + [fsBold];
    Color := clWhite;
  end;
end;

procedure TMainForm.tTotalCalcFields(DataSet: TDataSet);
var RowTotal : Double;
    i : Integer;
begin
  RowTotal := 0;
  for i := 0 to DataSet.FieldCount - 1 do
    if DataSet.Fields[i].Tag = 1 then
      RowTotal := RowTotal + DataSet.Fields[i].AsFloat;
  tTotalRowTotal.AsFloat := RowTotal;
  tTotalRowAVG.AsFloat := RowTotal / 12;
  tTotalCustomName.AsString := tTotalFirstName.AsString+' '+tTotalLastName.AsString;
  tTotalPreview.AsString := tTotalCustomName.AsString+' ('+tTotalYears.AsString+')';
end;

end.
