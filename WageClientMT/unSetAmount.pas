unit unSetAmount;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unxModal, dxCntner, dxEditor, dxExEdtr, dxEdLib, ComCtrls,
  StdCtrls, Menus, Placemnt, ActnList, ToolWin;

type
  TfmSetAmount = class(TfmxModal)
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    edtAmount: TdxCurrencyEdit;
    lblCom: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
