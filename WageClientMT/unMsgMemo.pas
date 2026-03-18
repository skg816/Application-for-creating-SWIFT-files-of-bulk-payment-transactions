unit unMsgMemo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unxModal, StdCtrls, Menus, Placemnt, ActnList, ComCtrls, ToolWin;

type
  TfmMsgMemo = class(TfmxModal)
    memMsg: TMemo;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmMsgMemo: TfmMsgMemo;

implementation

{$R *.dfm}

end.
