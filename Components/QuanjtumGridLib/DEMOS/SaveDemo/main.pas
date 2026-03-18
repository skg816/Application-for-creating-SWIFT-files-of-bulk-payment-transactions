unit main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, ComCtrls, dxCntner, dxTL, dxDBGrid, Db, DBTables, dxGrClms,
  StdCtrls, Menus, dxDBTLCl, dxDBCtrl, dxExEdtr, dxEdLib;

type
  TSaveMethod = procedure (const FileName: String; ASaveAll: Boolean) of object;

  TfmMain = class(TForm)
    Panel1: TPanel;
    dxDBGrid: TdxDBGrid;
    Table1: TTable;
    DataSource1: TDataSource;
    dxDBGridCustNo: TdxDBGridMaskColumn;
    dxDBGridCompany: TdxDBGridMaskColumn;
    dxDBGridAddr1: TdxDBGridMaskColumn;
    dxDBGridAddr2: TdxDBGridMaskColumn;
    dxDBGridCity: TdxDBGridMaskColumn;
    dxDBGridState: TdxDBGridMaskColumn;
    dxDBGridZip: TdxDBGridMaskColumn;
    dxDBGridCountry: TdxDBGridMaskColumn;
    dxDBGridPhone: TdxDBGridMaskColumn;
    dxDBGridFAX: TdxDBGridMaskColumn;
    dxDBGridTaxRate: TdxDBGridCurrencyColumn;
    dxDBGridContact: TdxDBGridMaskColumn;
    dxDBGridLastInvoiceDate: TdxDBGridDateColumn;
    Table1CustNo: TFloatField;
    Table1Company: TStringField;
    Table1Addr1: TStringField;
    Table1Addr2: TStringField;
    Table1City: TStringField;
    Table1State: TStringField;
    Table1Zip: TStringField;
    Table1Country: TStringField;
    Table1Phone: TStringField;
    Table1FAX: TStringField;
    Table1TaxRate: TFloatField;
    Table1Contact: TStringField;
    Table1LastInvoiceDate: TDateTimeField;
    btHTML: TButton;
    btExcel: TButton;
    cbSaveAll: TdxCheckEdit;
    cbLoadAllRecords: TdxCheckEdit;
    cbMultiSelect: TdxCheckEdit;
    cbShowFooter: TdxCheckEdit;
    cbShowHeader: TdxCheckEdit;
    cbShowGrid: TdxCheckEdit;
    SaveDialog: TSaveDialog;
    btnXML: TButton;
    dxCheckEditStyleController: TdxCheckEditStyleController;
    procedure btHTMLClick(Sender: TObject);
    procedure btExcelClick(Sender: TObject);
    procedure cbLoadAllRecordsClick(Sender: TObject);
    procedure cbMultiSelectClick(Sender: TObject);
    procedure cbShowFooterClick(Sender: TObject);
    procedure cbShowGridClick(Sender: TObject);
    procedure cbShowHeaderClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnXMLClick(Sender: TObject);
  private
    procedure Save(ADefaultExt, AFilter, AFileName: String; AMethod: TSaveMethod);
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;

implementation

{$R *.DFM}

procedure TfmMain.FormCreate(Sender: TObject);
begin
  SaveDialog.InitialDir := ExtractFilePath(Application.ExeName);
end;

procedure TfmMain.Save(ADefaultExt, AFilter, AFileName: String; AMethod: TSaveMethod);
begin
  with SaveDialog do
  begin
    DefaultExt := ADefaultExt;
    Filter := AFilter;
    FileName := AFileName;
    if Execute then
      AMethod(FileName, cbSaveAll.Checked);
  end;
end;

procedure TfmMain.btHTMLClick(Sender: TObject);
begin
  Save('htm', 'HTML File (*.htm; *.html)|*.htm', 'ExpGrid.htm', dxDBGrid.SaveToHTML);
end;

procedure TfmMain.btExcelClick(Sender: TObject);
begin
  Save('xls', 'Microsoft Excel 4.0 Worksheet (*.xls)|*.xls', 'ExpGrid.xls', dxDBGrid.SaveToXLS);
end;

procedure TfmMain.btnXMLClick(Sender: TObject);
begin
  Save('xml', 'XML File (*.xml)|*.xml', 'ExpGrid.xml', dxDBGrid.SaveToXML);
end;

procedure TfmMain.cbLoadAllRecordsClick(Sender: TObject);
begin
  with Sender as TdxCheckEdit do
    if Checked then
      dxDBGrid.Options := dxDBGrid.Options + [egoLoadAllRecords]
    else dxDBGrid.Options := dxDBGrid.Options - [egoLoadAllRecords];
end;

procedure TfmMain.cbMultiSelectClick(Sender: TObject);
begin
  with Sender as TdxCheckEdit do
    if Checked then
      dxDBGrid.Options := dxDBGrid.Options + [egoMultiSelect]
    else dxDBGrid.Options := dxDBGrid.Options - [egoMultiSelect];
end;

procedure TfmMain.cbShowFooterClick(Sender: TObject);
begin
  with Sender as TdxCheckEdit do
    dxDBGrid.ShowSummaryFooter := Checked;
end;

procedure TfmMain.cbShowGridClick(Sender: TObject);
begin
  with Sender as TdxCheckEdit do
    dxDBGrid.ShowGrid := Checked;
end;

procedure TfmMain.cbShowHeaderClick(Sender: TObject);
begin
  with Sender as TdxCheckEdit do
    dxDBGrid.ShowHeader := Checked;
end;


end.
