unit fWeb;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DBCtrls, dxExEdtr, dxEdLib, dxDBELib, dxEditor, dxCntner,
  ExtCtrls, Db;

type
  TfmWebStyle = class(TForm)
    StyleController: TdxEditStyleController;
    pnForm: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label15: TLabel;
    Label16: TLabel;
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
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    Shape4: TShape;
    Shape5: TShape;
    Shape6: TShape;
    Shape7: TShape;
    Shape8: TShape;
    Shape9: TShape;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmWebStyle: TfmWebStyle;

implementation

uses main;

{$R *.DFM}

end.
