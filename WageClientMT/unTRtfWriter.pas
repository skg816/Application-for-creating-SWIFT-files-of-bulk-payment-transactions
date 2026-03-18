{--- Класс TRtfWriter создания rtf файла ---}
{--- Позволяет писать, как текст так и содержимое таблиц ---}
{---Автор: Дюсембаев Р.Б. (УРБ БТА) 21.06.2001 ---}

unit unTRtfWriter;

interface

uses
  Sysutils, Dialogs, dxDBGrid, DBClient, Halcn6DB;

const

  csHeader: String = '{\rtf1\ansi\ansicpg1251\uc1 \deff0\deflang1033\deflangfe1049';

  csFontTable: String =
    '{\fonttbl'+#13#10+
    '{\f0\froman\fcharset0\fprq2{\*\panose 02020603050405020304}Times New Roman;}'+
    '{\f57\froman\fcharset238\fprq2 Times New Roman CE;}'+
    '{\f58\froman\fcharset204\fprq2 Times New Roman Cyr;}'+
    '{\f60\froman\fcharset161\fprq2 Times New Roman Greek;}'+
    '{\f61\froman\fcharset162\fprq2 Times New Roman Tur;}'+
    '{\f62\froman\fcharset186\fprq2 Times New Roman Baltic;}}'+#13#10;

  csColorTable: String =
    '{\colortbl;'+#13#10+
    '\red0\green0\blue0;'+
    '\red0\green0\blue255;'+
    '\red0\green255\blue255;'+
    '\red0\green255\blue0;'+
    '\red255\green0\blue255;'+
    '\red255\green0\blue0;'+
    '\red255\green255\blue0;'+
    '\red255\green255\blue255;'+
    '\red0\green0\blue128;'+
    '\red0\green128\blue128;'+
    '\red0\green128\blue0;'+
    '\red128\green0\blue128;'+
    '\red128\green0\blue0;'+
    '\red128\green128\blue0;'+
    '\red128\green128\blue128;'+
    '\red192\green192\blue192;}'+#13#10;

  csStylesheet: String =
    '{\stylesheet'+#13#10+
    '{\nowidctlpar\widctlpar\adjustright'+
    '\fs20\lang1049\cgrid \snext0 \''ce\''e1\''fb\''f7\''ed\''fb\''e9;}{\*\cs10'+
    '\additive \''ce\''f1\''ed\''ee\''e2\''ed\''ee\''e9 \''f8\''f0\''e8\''f4\''f2;}}'+#13#10;

  csInfo: String =
    '{\info'+#13#10+
    '{\title DRB}'+
    '{\subject Testirovaniye Report}'+
    '{\author Dyussembayev Rustam}'+
    '{\operator Rustam}'+
    '{\creatim\yr2001\mo3\dy4\min31}'+
    '{\revtim\yr2001\mo3\dy4\min34}'+
    '{\version1}'+
    '{\edmins3}'+
    '{\nofpages1}'+
    '{\nofwords0}'+
    '{\nofchars0}'+
    '{\*\manager Rustam}'+
    '{\*\company BSB}'+
    '{\nofcharsws0}{\vern73}}'+#13#10;

  csPaperWidth = '\paperw';   {+11906 size}
  csPaperHeight = '\paperh';  {+16838 size}
  csMarginLeft = '\margl';    {+1134 size}
  csMarginRight = '\margr';   {+851 size}
  csMarginTop = '\margt';     {+851 size}
  csMarginBottom = '\margb';  {+1134 size}

  csPaperWidthA3 = '23688';
  csPaperHeightA3 = '33501';

  csPaperWidthA4 = '11906';
  csPaperHeightA4 = '16838';

    {1 twip               = 1/20 пункта = 1/1440 дюйма
     1 дюйм               = 2.54 см
     1 см                 = 564  twips
     1 пиксель            = 0.026456 см (2.54см/96пикс)
     1 текстовая позиция  = 10   пикселей             }
  csSmToTwips : real = 564;
  csPicsToTwips : real = 15;
  csInchToTwips : real = 1432.5;

  csAny: String =
    '\widowctrl\ftnbj\aenddoc\formshade\viewkind1\viewscale90\viewzk2\pgbrdrhead\pgbrdrfoot'+
    '\fet0\sectd\linex0\headery709\footery709\colsx709\endnhere\sectdefaultcl'+
    '{\*\pnseclvl1\pnucrm\pnstart1\pnindent720\pnhang{\pntxta .}}'+
    '{\*\pnseclvl2\pnucltr\pnstart1\pnindent720\pnhang{\pntxta .}}'+
    '{\*\pnseclvl3\pndec\pnstart1\pnindent720\pnhang{\pntxta .}}'+
    '{\*\pnseclvl4\pnlcltr\pnstart1\pnindent720\pnhang{\pntxta )}}'+
    '{\*\pnseclvl5\pndec\pnstart1\pnindent720\pnhang{\pntxtb (}{\pntxta )}}'+
    '{\*\pnseclvl6\pnlcltr\pnstart1\pnindent720\pnhang{\pntxtb (}{\pntxta )}}'+
    '{\*\pnseclvl7\pnlcrm\pnstart1\pnindent720\pnhang{\pntxtb (}{\pntxta )}}'+
    '{\*\pnseclvl8\pnlcltr\pnstart1\pnindent720\pnhang{\pntxtb (}{\pntxta )}}'+
    '{\*\pnseclvl9\pnlcrm\pnstart1\pnindent720\pnhang{\pntxtb (}{\pntxta )}}';

  csTableBegin: String =
    #13#10+'\trowd \trgaph108\trleft-108'+
    '\trbrdrt\brdrs\brdrw10'+
    '\trbrdrl\brdrs\brdrw10'+
    '\trbrdrb\brdrs\brdrw10'+
    '\trbrdrr\brdrs\brdrw10'+
    '\trbrdrh\brdrs\brdrw10'+
    '\trbrdrv\brdrs\brdrw10';

  csCellFormat: String =
    '\clvertalt'+
    '\clbrdrt\brdrs\brdrw10'+
    '\clbrdrl\brdrs\brdrw10'+
    '\clbrdrb\brdrs\brdrw10'+
    '\clbrdrr\brdrs\brdrw10'+
    '\cltxlrtb'+
    '\cellx';

  {---Почемуто в RTF все символы русского языка меняются на вот такие знаки---}
  csRusLowCase: array ['а'..'я'] of string = ('e0', 'e1', 'e2', 'e3', 'e4', 'e5', 'e6', 'e7',
          'e8', 'e9', 'ea', 'eb', 'ec', 'ed', 'ee', 'ef','f0', 'f1', 'f2', 'f3', 'f4',
          'f5', 'f6', 'f7', 'f8', 'f9', 'fa', 'fb', 'fc', 'fd', 'fe', 'ff');
  csRusUpCase: array ['А'..'Я'] of string = ('c0', 'c1', 'c2', 'c3', 'c4', 'c5', 'c6', 'c7','c8',
          'c9', 'ca', 'cb', 'cc', 'cd', 'ce', 'cf', 'd0', 'd1', 'd2', 'd3', 'd4', 'd5', 'd6',
          'd7', 'd8', 'd9', 'da', 'db', 'dc', 'dd', 'de','df');

type

  TRtfWriter = class
    RGrid: TdxDBGrid;
    RDataSet: THalcyonDataSet;
    RtfFile: Text;
    TextStyle: Set of char;
  private
    FTextAlign: char;
    FTextColor : byte;
    FTextSize: byte;
    FPaperAlbum: boolean;
    FPaperA3: boolean;
    FPaperMetric: byte;
    FPaperMarginTop: real;
    FPaperMarginRight: real;
    FPaperMarginLeft: real;
    FPaperMarginBottom: real;
    FFileName: String;
    FTextCfg: String;
    FRtfError: String;
    FRFieldCount: integer;
  protected
    procedure Pr_MakeFontCfg(vrInTable: boolean );
    function Fn_DecodePaperFormat(vrParam: real;             {+ .... size Paper}
                              vrFormat: byte): String;   { 0 - Sm, 1-Pics, 2-Inch }
    function Fn_ConvertToRus(vrStr:String):String;
  public
    csMaxWidthCell: Real;

    constructor Create; overload;
    function Pr_InitRtf : boolean;
    procedure Pr_CloseRtf;
    procedure Pr_WriteText(vrTextSource: String;
                              vrTextLnCount: word );
    function Pr_WriteToTable : boolean;
    //---Св-ва вывода текста
    property TextAlign : char read FTextAlign write FTextAlign default 'l';
    property TextColor : byte read FTextColor write FTextColor default 0;
    //    property TextStyle : Set of char read FTextStyle write FTextStyle;
    property TextSize: byte read FTextSize write FTextSize  default 10;
    property TextCfg: String read FTextCfg write FTextCfg;
    //---Св-ва страницы
    property PaperMarginLeft : real read FPaperMarginLeft write FPaperMarginLeft;
    property PaperMarginRight : real read FPaperMarginRight write FPaperMarginRight;
    property PaperMarginTop : real read FPaperMarginTop write FPaperMarginTop;
    property PaperMarginBottom : real read FPaperMarginBottom write FPaperMarginBottom;
    property PaperMetric : byte read FPaperMetric write FPaperMetric; { 0 - Sm, 1-Pics, 2-Inch }
    property PaperAlbum : boolean read FPaperAlbum write FPaperAlbum; { True - Album, False - Landshaft}
    property PaperA3 : boolean read FPaperA3 write FPaperA3; { True - A3, False - A4}
    //---Св-ва файла
    property FileName: String read FFileName write FFileName;
    property RtfError: String  read FRtfError write FRtfError;
    property RFieldCount: integer read FRFieldCount write FRFieldCount;
  published
  end;

implementation

//-----------------------------------------------------

function TRtfWriter.Fn_DecodePaperFormat(vrParam: real;             {+ .... size Paper}
                              vrFormat: byte): String;   { 0 - Sm, 1-Pics, 2-Inch }
begin
  case vrFormat of
    0 : Fn_DecodePaperFormat := IntToStr(Round(vrParam * csSmToTwips));
    1 : Fn_DecodePaperFormat := IntToStr(Round(vrParam * csPicsToTwips));
    2 : Fn_DecodePaperFormat := IntToStr(Round(vrParam * csInchToTwips));
  else
        Fn_DecodePaperFormat := '0';
  end;
end;

//---------------------------------------------------

function TRtfWriter.Pr_InitRtf : boolean;
begin
  Result := true;
  AssignFile(RtfFile, FileName);
  {$I-}
  Rewrite(RtfFile);
  {$I+}
  if IOResult <> 0 then
  begin
    RtfError :='Ошибка открытия файла '+ FileName +' для записи !';
    Result := false;
    Exit;
  end;
  write(RtfFile, csHeader);
  write(RtfFile, csFontTable);
  write(RtfFile, csColorTable);
  write(RtfFile, csStylesheet);
  write(RtfFile, csInfo);
    {---Вносим параметры страницы---}
    if PaperA3 then
    begin
      if PaperAlbum then
      begin
        write(RtfFile, csPaperWidth + csPaperHeightA3);
        write(RtfFile, csPaperHeight + csPaperWidthA3);
      end
      else
      begin
        write(RtfFile, csPaperWidth + csPaperWidthA3);
        write(RtfFile, csPaperHeight + csPaperHeightA3);
      end;
    end
    else
    begin
      if PaperAlbum then
      begin
        write(RtfFile, csPaperWidth + csPaperWidthA4);
        write(RtfFile, csPaperHeight + csPaperHeightA4);
      end
      else
      begin
        write(RtfFile, csPaperWidth + csPaperHeightA4);
        write(RtfFile, csPaperHeight + csPaperWidthA4);
      end;
    end;
    write(RtfFile, csMarginLeft + Fn_DecodePaperFormat (PaperMarginLeft, PaperMetric));
    write(RtfFile, csMarginRight + Fn_DecodePaperFormat (PaperMarginRight, PaperMetric));
    write(RtfFile, csMarginTop + Fn_DecodePaperFormat (PaperMarginTop, PaperMetric));
    write(RtfFile, csMarginBottom + Fn_DecodePaperFormat (PaperMarginBottom, PaperMetric));
    write(RtfFile, csAny);
end;

//-----------------------------------------------------

procedure TRtfWriter.Pr_CloseRtf;
begin
  write(RtfFile, '}}');
  CloseFile(RtfFile);
end;

//--------------------------------------------------

function TRtfWriter.Fn_ConvertToRus(vrStr:String):String;
var
  i: longint;
  vrStrLoc: String;
begin
  vrStrLoc :='';
  For i:=1 to Length(vrStr) do
    if vrStr[i] in ['а'..'я'] then vrStrLoc := vrStrLoc + '\''' + csRusLowCase[vrStr[i]]
    else
      if vrStr[i] in ['А'..'Я'] then vrStrLoc := vrStrLoc + '\''' + csRusUpCase[vrStr[i]]
      else
        vrStrLoc := vrStrLoc + vrStr[i];
  Fn_ConvertToRus := vrStrLoc;
end;

//-------------------------------------------------

procedure TRtfWriter.Pr_MakeFontCfg(vrInTable: boolean );
begin
  TextCfg := '\pard\plain ';
  {---Установка Aligment для текста---}
  if (TextAlign <> '') and (TextAlign in ['c','l','r']) then
     TextCfg := TextCfg+'\q'+TextAlign;
  if vrInTable then
     TextCfg := TextCfg+'\nowidctlpar\widctlpar\intbl\adjustright {'
  else
     TextCfg := TextCfg+'\nowidctlpar\widctlpar\adjustright {';
  {---Установка стиля шрифта для текста---}
  if ('b' in TextStyle) or ('i' in TextStyle) then
  begin
    if 'b' in TextStyle then TextCfg := TextCfg+'\b';
    if 'i' in TextStyle then TextCfg := TextCfg+'\i';
  end;
  TextCfg := TextCfg+'\f58';
  {---Установка цвета шрифта для текста, если =0, то будет исполь. по умолчанию---}
  if TextColor<>0 then
     TextCfg := TextCfg+'\cf'+IntToStr(TextColor);
  {---Установка размера шрифта для текста, елси =0, то по умолчанию =10 ---}
  if TextSize<>0 then
     TextCfg := TextCfg+'\fs'+IntToStr(TextSize*2)
  else
     TextCfg := TextCfg+'\fs'+'20';
  TextCfg := TextCfg+'\lang1033 ';
end;

//-----------------------------------------------------

procedure TRtfWriter.Pr_WriteText(vrTextSource: String;
                              vrTextLnCount: word );
var
  i: word;
  vrLn: String;
begin
  try
    {---Конфигурируем св-ства шрифта---}
    Pr_MakeFontCfg(false);
    write( RtfFile, TextCfg);
    write( RtfFile,  Fn_ConvertToRus(vrTextSource));
    {---Проверка на перевод каретки---}
    vrLn := '';
    if vrTextLnCount<>0 then
       for i:=1 to vrTextLnCount do vrLn := vrLn + '\par';
    {---Установка окончания текста---}
    write( RtfFile, vrLn+'}');
  except
    RtfError := 'Ошибка записи в файл' + FileName; 
  end;
end;

//-----------------------------------------------------

function TRtfWriter.Pr_WriteToTable : boolean;
var
  vrStyle: Set of char;
  i,
  vrLengthCell,
  vrCellCount: word;
begin
    Result := true;
    try
      {---Записываем заголовок таблицы---}
      write(RtfFile, csTableBegin);
      vrCellCount := RFieldCount;
      {---Вычисляем размер ячеек---}
        {---Вносим параметры страницы---}
        if PaperA3 then
        begin
          if PaperAlbum then
            csMaxWidthCell := StrToFloat(csPaperWidthA4) -
                StrToFloat(Fn_DecodePaperFormat (PaperMarginLeft, PaperMetric)) -
                StrToFloat(Fn_DecodePaperFormat (PaperMarginRight, PaperMetric))
          else
            csMaxWidthCell := StrToFloat(csPaperWidthA3) -
                StrToFloat(Fn_DecodePaperFormat (PaperMarginLeft, PaperMetric)) -
                StrToFloat(Fn_DecodePaperFormat (PaperMarginRight, PaperMetric));
        end
        else
        begin
          if PaperAlbum then
            csMaxWidthCell := StrToFloat(csPaperWidthA4) -
                StrToFloat(Fn_DecodePaperFormat (PaperMarginLeft, PaperMetric)) -
                StrToFloat(Fn_DecodePaperFormat (PaperMarginRight, PaperMetric))
          else
            csMaxWidthCell := StrToFloat(csPaperHeightA4) -
                StrToFloat(Fn_DecodePaperFormat (PaperMarginLeft, PaperMetric)) -
                StrToFloat(Fn_DecodePaperFormat (PaperMarginRight, PaperMetric));
        end;
      vrLengthCell := Round(csMaxWidthCell/vrCellCount);
      if vrLengthCell<300 then
      begin
        RtfError :='Текст не помещается в ячейку. Возможно слишком много ячеек !';
        Result := false;
        Exit;
      end;
      {---Выделяем пространство для ячеек---}
      for i:=1 to vrCellCount do
          write(RtfFile, csCellFormat+IntToStr(i * vrLengthCell));
      {---Создаем заголовок таблицы---}
      vrStyle := TextStyle;
      TextStyle := ['b'];
      Pr_MakeFontCfg(true);
      write(RtfFile, TextCfg);
      For i:=0 to vrCellCount-1 do
          write(RtfFile, RGrid.Columns[i].Caption + '\cell ');
      write(RtfFile, '}');
      write(RtfFile, TextCfg);
      write(RtfFile, '\row }'+#13#10);
      TextStyle := vrStyle;     //---Восстанавливаем стиль
      {---Вывод таблицы в RTF---}
      Pr_MakeFontCfg(true);
      with RDataSet do
      begin
        First;
        while not Eof do
        begin
          {---Начало формирования ячейки--------------------------------------------}
          write(RtfFile, TextCfg);
          {---Заполняем ячейки значениями тек. записи---}
          For i:=0 to vrCellCount-1 do
              write(RtfFile,
              Fn_ConvertToRus(FieldByName(RGrid.Columns[i].FieldName).AsString) + '\cell ');
          write(RtfFile, '}');
          write(RtfFile, TextCfg);
          write(RtfFile, '\row }'+#13#10);
          {---Конец формирования ячейки--------------------------------------------}
          Next;
        end;
      end;
    except
      RtfError:= 'Ошибка записи из таблицы!';
      Result := false;
    end;
end;

constructor TRtfWriter.Create;
begin
  csMaxWidthCell := 10000;
  TextStyle := [];
  PaperMarginLeft := 2.5;
  PaperMarginRight := 1.5;
  PaperMarginTop :=  2;
  PaperMarginBottom := 2;
  PaperMetric := 0; { 0 - Sm, 1-Pics, 2-Inch }
  PaperAlbum := true; { True - Album, False - Landshaft}
  PaperA3 := False; { True - A3, False - A4}
  RtfError:= '';
  RFieldCount := 0;
end;

end.
