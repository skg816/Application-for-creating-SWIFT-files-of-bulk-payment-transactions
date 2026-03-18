unit main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Db, DBTables, dxCntner, dxTL, dxDBGrid, dxGrClms, jpeg,
  ExtCtrls, DBCtrls, Grids, DBGrids, ExtDlgs, dxDBEdtr, dxDBTLCl, dxDBCtrl,
  dxEditor, dxEdLib;

type
  TfmMain = class(TForm)
    tJpeg_tst: TTable;
    dsJpeg_tst: TDataSource;
    dxDBGrid: TdxDBGrid;
    colID: TdxDBGridMaskColumn;
    colPicture: TdxDBGridGraphicColumn;
    colGraphicClass: TdxDBGridMaskColumn;
    Panel1: TPanel;
    DBNavigator1: TDBNavigator;
    btLoad: TButton;
    edGraphicType: TdxEdit;
    dlgOpenPicture: TOpenPictureDialog;
    procedure colPictureGetGraphicClass(Sender: TObject;
      Node: TdxTreeListNode; var GraphicClass: TGraphicClass);
    procedure colPictureAssignPicture(Sender: TObject;
      var Picture: TPicture);
    procedure FormCreate(Sender: TObject);
    procedure dxDBGridClick(Sender: TObject);
    procedure btLoadClick(Sender: TObject);
    procedure tJpeg_tstAfterScroll(DataSet: TDataSet);
  end;

var
  fmMain: TfmMain;

implementation

{$R *.DFM}

procedure TfmMain.colPictureGetGraphicClass(Sender: TObject;
  Node: TdxTreeListNode; var GraphicClass: TGraphicClass);
begin
  GraphicClass := TGraphicClass(GetClass(Node.Strings[colGraphicClass.Index]));
end;

procedure TfmMain.colPictureAssignPicture(Sender: TObject;
  var Picture: TPicture);
begin
  colGraphicClass.Field.Text := Picture.Graphic.ClassName;
end;

procedure TfmMain.FormCreate(Sender: TObject);
begin
  tJpeg_tst.DataBaseName := '..\Data\';
  tJpeg_tst.Open;
end;

procedure TfmMain.dxDBGridClick(Sender: TObject);
begin
  if dxDBGrid.FocusedNode <> nil then
    edGraphicType.Text := dxDBGrid.FocusedNode.Values[colGraphicClass.Index];
end;

procedure TfmMain.btLoadClick(Sender: TObject);
var
  Picture: TPicture;
  ImageField: TField;
begin
  with dlgOpenPicture do begin
    InitialDir := ExtractFilePath(Application.ExeName) + '\Images';{Imagedir}
    if Execute then
      with dxDBGrid.DataSource.DataSet do
        try
          Edit;
          ImageField := FindField('Picture');
          if ImageField <> nil then
          begin
            Picture := TPicture.Create;
            try
              Picture.LoadFromFile(FileName);
              colPictureAssignPicture(nil, Picture);
              if Picture.Graphic is TBitmap then
                ImageField.Assign(Picture)
              else SaveGraphicToBlobField(Picture.Graphic, ImageField);
            finally
              Picture.Free;
            end;
          end;
          Post;
        except
        end;
  end;
end;

procedure TfmMain.tJpeg_tstAfterScroll(DataSet: TDataSet);
begin
  dxDBGridClick(dxDBGrid);
end;

initialization
  RegisterClasses([TIcon, TMetafile, TBitmap, TJPEGImage]);

end.
