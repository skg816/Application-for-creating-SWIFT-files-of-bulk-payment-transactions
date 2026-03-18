unit fReal;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DBCtrls, dxExEdtr, dxEdLib, dxDBELib, dxEditor, dxCntner,
  ExtCtrls, Db;

type
  TfmRealBlank = class(TForm)
    StyleController: TdxEditStyleController;
    pnForm: TPanel;
    Shape9: TShape;
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
    Shape24: TShape;
    Shape25: TShape;
    Label6: TLabel;
    Shape26: TShape;
    Shape27: TShape;
    Label17: TLabel;
    Shape28: TShape;
    Shape29: TShape;
    Label18: TLabel;
    Shape30: TShape;
    Shape31: TShape;
    Label19: TLabel;
    Shape32: TShape;
    Shape33: TShape;
    Label20: TLabel;
    Shape2: TShape;
    Shape3: TShape;
    Label13: TLabel;
    Shape38: TShape;
    Label23: TLabel;
    Shape6: TShape;
    Shape7: TShape;
    Label4: TLabel;
    Shape8: TShape;
    Shape18: TShape;
    Label5: TLabel;
    Shape19: TShape;
    Label1: TLabel;
    Shape4: TShape;
    Label2: TLabel;
    Shape5: TShape;
    Shape10: TShape;
    Label8: TLabel;
    Shape11: TShape;
    Shape12: TShape;
    Shape13: TShape;
    Label9: TLabel;
    Shape14: TShape;
    Shape15: TShape;
    Shape16: TShape;
    Label3: TLabel;
    Label7: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmRealBlank: TfmRealBlank;

implementation

uses main;

{$R *.DFM}

end.
