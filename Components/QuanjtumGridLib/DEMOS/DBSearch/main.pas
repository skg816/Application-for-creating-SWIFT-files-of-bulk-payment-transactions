unit main;


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, Db, DBTables, dxCntner, dxTL, dxDBGrid, dxGrClms, ExtCtrls,
  StdCtrls, Buttons, dxDBTLCl, dxDBCtrl, dxExEdtr, dxEdLib;

type
  TfmMain = class(TForm)
    StatusBar: TStatusBar;
    tCustomer: TTable;
    dsCustomer: TDataSource;
    dxDBGrid: TdxDBGrid;
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
    dxDBGridTaxRate: TdxDBGridMaskColumn;
    dxDBGridContact: TdxDBGridMaskColumn;
    dxDBGridLastInvoiceDate: TdxDBGridDateColumn;
    Panel1: TPanel;
    cbAutoSearch: TdxCheckEdit;
    cbAutoExpandOnSearch: TdxCheckEdit;
    btnSearchColor: TButton;
    btnSearchTextColor: TButton;
    cdSearchColor: TColorDialog;
    procedure cbAutoSearchClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSearchColorClick(Sender: TObject);
    procedure btnSearchTextColorClick(Sender: TObject);
    procedure cbAutoExpandOnSearchClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;

implementation

{$R *.DFM}

procedure TfmMain.FormCreate(Sender: TObject);
begin
  with dxDBGrid do
  begin
    cbAutoSearch.Checked := egoAutoSearch in OptionsEx;
    cbAutoExpandOnSearch.Checked := (egoAutoSearch in OptionsEx) and AutoExpandOnSearch;
  end;
end;

procedure TfmMain.btnSearchColorClick(Sender: TObject);
begin
  if cdSearchColor.Execute then
    dxDBGrid.AutoSearchColor := cdSearchColor.Color;
end;

procedure TfmMain.btnSearchTextColorClick(Sender: TObject);
begin
  if cdSearchColor.Execute then
    dxDBGrid.AutoSearchTextColor := cdSearchColor.Color;
end;

procedure TfmMain.cbAutoExpandOnSearchClick(Sender: TObject);
begin
  dxDBGrid.AutoExpandOnSearch := cbAutoExpandOnSearch.Checked;
end;

procedure TfmMain.cbAutoSearchClick(Sender: TObject);
begin
  with Sender as TdxCheckEdit, dxDBGrid do
  begin
    if Checked then
      OptionsEx := OptionsEx + [egoAutoSearch]
    else OptionsEx := OptionsEx - [egoAutoSearch];
  end;
end;

end.
