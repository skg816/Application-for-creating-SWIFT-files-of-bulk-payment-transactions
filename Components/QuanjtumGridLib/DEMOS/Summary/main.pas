unit main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  dxCntner, dxTL, dxDBGrid, ExtCtrls, ComCtrls, DBTables, Db, dxGrClms,
  Menus, StdCtrls, dxDBTLCl, dxDBCtrl, dxGridMenus;

type
  TdxGrid = class(TdxDBGrid) end;

  TMainForm = class(TForm)
    PageControl: TPageControl;
    tsSimple: TTabSheet;
    tsGrouping: TTabSheet;
    tsMultiSum: TTabSheet;
    dxDBGrid1: TdxDBGrid;
    tContacts: TTable;
    dsContacts: TDataSource;
    qrContacts: TQuery;
    col1FirstName: TdxDBGridColumn;
    col1LastName: TdxDBGridColumn;
    col1Company: TdxDBGridColumn;
    col1PaymentAmount: TdxDBGridColumn;
    dxDBGrid3: TdxDBGrid;
    col3FirstName: TdxDBGridColumn;
    col3LastName: TdxDBGridColumn;
    col3Company: TdxDBGridColumn;
    col3PaymentAmount: TdxDBGridColumn;
    tsDisplaySum: TTabSheet;
    dxDBGrid4: TdxDBGrid;
    col4FirstName: TdxDBGridColumn;
    col4LastName: TdxDBGridColumn;
    col4Company: TdxDBGridColumn;
    col4PaymentAmount: TdxDBGridColumn;
    col3Customer: TdxDBGridCheckColumn;
    col3PaymentType: TdxDBGridImageColumn;
    GridImageList: TImageList;
    col4Customer: TdxDBGridCheckColumn;
    col4PaymentType: TdxDBGridImageColumn;
    dxDBGrid5: TdxDBGrid;
    col5FirstName: TdxDBGridColumn;
    col5LastName: TdxDBGridColumn;
    col5Company: TdxDBGridColumn;
    col5Customer: TdxDBGridCheckColumn;
    col5PaymentType: TdxDBGridImageColumn;
    col5PaymentAmount: TdxDBGridColumn;
    tsFooter: TTabSheet;
    dxDBGrid2: TdxDBGrid;
    col2FirstName: TdxDBGridColumn;
    col2LastName: TdxDBGridColumn;
    col2ProductID: TdxDBGridColumn;
    col2PaymentAmount: TdxDBGridColumn;
    col4ID: TdxDBGridMaskColumn;
    col4City: TdxDBGridMaskColumn;
    col4State: TdxDBGridMaskColumn;
    col4PurchaseDate: TdxDBGridDateColumn;
    col4Occupation: TdxDBGridMaskColumn;
    tsCustomSummary: TTabSheet;
    dxDBGrid6: TdxDBGrid;
    col6FirstName: TdxDBGridColumn;
    col6LastName: TdxDBGridColumn;
    col6ProductID: TdxDBGridColumn;
    col6PaymentAmount: TdxDBGridColumn;
    procedure dsContactsDataChange(Sender: TObject; Field: TField);
    procedure FormCreate(Sender: TObject);
    procedure col1FirstNameDrawSummaryFooter(Sender: TObject;
      ACanvas: TCanvas; ARect: TRect; var AText: String;
      var AAlignment: TAlignment; AFont: TFont; var AColor: TColor;
      var ADone: Boolean);
    procedure col1PaymentAmountDrawSummaryFooter(Sender: TObject;
      ACanvas: TCanvas; ARect: TRect; var AText: String;
      var AAlignment: TAlignment; AFont: TFont; var AColor: TColor;
      var ADone: Boolean);
    procedure dxDBGrid2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure col6LastNameSummaryFooter(Sender: TObject; DataSet: TDataSet;
      var Value: Extended);
    procedure dxDBGrid6SummaryGroups0SummaryItems0Summary(Sender: TObject;
      DataSet: TDataSet; var Value: Extended);
  private
    { Private declarations }
  public
  end;

var
  MainForm: TMainForm;

implementation

{$R *.DFM}

procedure TMainForm.dsContactsDataChange(Sender: TObject; Field: TField);
begin
  qrContacts.Close;
  qrContacts.Open;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  tContacts.DatabaseName := '..\Data\';
  qrContacts.DatabaseName := '..\Data\';
  qrContacts.Open;
  tContacts.Open;
end;

procedure TMainForm.col1FirstNameDrawSummaryFooter(Sender: TObject;
  ACanvas: TCanvas; ARect: TRect; var AText: String;
  var AAlignment: TAlignment; AFont: TFont; var AColor: TColor;
  var ADone: Boolean);
begin
    AText := 'Count = '+qrContacts.FieldByName('RecCount').AsString;
end;

procedure TMainForm.col1PaymentAmountDrawSummaryFooter(Sender: TObject;
  ACanvas: TCanvas; ARect: TRect; var AText: String;
  var AAlignment: TAlignment; AFont: TFont; var AColor: TColor;
  var ADone: Boolean);
begin
    AText := 'Sum = '+qrContacts.FieldByName('SumOfPaymentAmount').AsString;
end;

procedure TMainForm.dxDBGrid2MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button <> mbRight then exit;
  // show popup
  TdxDBGridPopupMenuManager.Instance.ShowGridPopupMenu(TdxDBGrid(Sender));
end;

procedure TMainForm.col6LastNameSummaryFooter(Sender: TObject;
  DataSet: TDataSet; var Value: Extended);
begin
  if Value >= 200 then Value := 0
    else Value := 1;
end;

procedure TMainForm.dxDBGrid6SummaryGroups0SummaryItems0Summary(
  Sender: TObject; DataSet: TDataSet; var Value: Extended);
begin
  if Value >= 200 then Value := 0
      else Value := 1;
end;


end.
