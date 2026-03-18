unit preview;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBCtrls;

type
  TfmPreview = class(TForm)
    DBImage1: TDBImage;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmPreview: TfmPreview;

implementation

uses main;

{$R *.DFM}

end.
