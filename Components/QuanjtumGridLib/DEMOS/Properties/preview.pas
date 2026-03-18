unit preview;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  jpeg, dxCntner, dxExEdtr, dxEdLib;

type
  TfmPreview = class(TForm)
    GraphicEdit: TdxGraphicEdit;
  end;

var
  fmPreview: TfmPreview;

implementation

{$R *.DFM}

end.
