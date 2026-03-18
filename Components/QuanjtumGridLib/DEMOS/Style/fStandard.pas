unit fStandard;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  dxCntner, Db, StdCtrls, DBCtrls, dxExEdtr, dxEdLib, dxDBELib, dxEditor,
  ExtCtrls;

type
  TfmStandard = class(TForm)
    pnForm: TPanel;
    PaintBox: TPaintBox;
    Label1: TLabel;
    Label2: TLabel;
    Bevel1: TBevel;
    Label3: TLabel;
    Bevel2: TBevel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Bevel5: TBevel;
    edName: TdxDBEdit;
    edAddress1: TdxDBEdit;
    edCity: TdxDBEdit;
    edState: TdxDBPickEdit;
    edZip: TdxDBMaskEdit;
    edInterests: TdxDBMemo;
    edTelePhone: TdxDBMaskEdit;
    edEmail: TdxDBHyperLinkEdit;
    edImage: TdxDBGraphicEdit;
    edPaymentType: TdxDBImageEdit;
    edPaymentAmount: TdxDBCurrencyEdit;
    edGender: TdxDBImageEdit;
    edOccupation: TdxDBPickEdit;
    edRiskLevel: TdxDBImageEdit;
    edBirthDate: TdxDBDateEdit;
    edDateOpen: TdxDBDateEdit;
    StyleController: TdxEditStyleController;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmStandard: TfmStandard;

implementation

uses main;

{$R *.DFM}

end.
