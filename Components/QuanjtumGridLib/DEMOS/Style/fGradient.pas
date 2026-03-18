unit fGradient;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, dxExEdtr, dxEdLib, dxEditor, dxCntner, StdCtrls, Db, dxDBELib,
  DBCtrls;

type
  TfmGradient = class(TForm)
    pnForm: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Bevel1: TBevel;
    edName: TdxDBEdit;
    StyleController: TdxEditStyleController;
    Label3: TLabel;
    Bevel2: TBevel;
    Label4: TLabel;
    edAddress1: TdxDBEdit;
    Label5: TLabel;
    edCity: TdxDBEdit;
    edState: TdxDBPickEdit;
    edZip: TdxDBMaskEdit;
    Label6: TLabel;
    Bevel3: TBevel;
    edInterests: TdxDBMemo;
    Bevel4: TBevel;
    Label7: TLabel;
    Label8: TLabel;
    edTelePhone: TdxDBMaskEdit;
    edEmail: TdxDBHyperLinkEdit;
    Label9: TLabel;
    Label10: TLabel;
    edImage: TdxDBGraphicEdit;
    Label11: TLabel;
    Label15: TLabel;
    PaintBox: TPaintBox;
    edPaymentType: TdxDBImageEdit;
    edPaymentAmount: TdxDBCurrencyEdit;
    Label16: TLabel;
    edGender: TdxDBImageEdit;
    edOccupation: TdxDBPickEdit;
    edRiskLevel: TdxDBImageEdit;
    edBirthDate: TdxDBDateEdit;
    edDateOpen: TdxDBDateEdit;
    Bevel5: TBevel;
    procedure PaintBoxPaint(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmGradient: TfmGradient;

implementation

uses
  main, dxDemoUtils;

{$R *.DFM}

procedure TfmGradient.PaintBoxPaint(Sender: TObject);
begin 
  with Sender as TPaintBox do
    FillGrayGradientRect(PaintBox.Canvas, PaintBox.ClientRect, PaintBox.Color);
end;

end.
