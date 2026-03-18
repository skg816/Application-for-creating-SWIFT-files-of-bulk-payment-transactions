unit gs6_Shel2;
{-----------------------------------------------------------------------------
                            dBase File Interface

       gs6_Shel2 Copyright (c) 2002 Griffin Solutions, Inc.

       Date
          16 Jul 2002

       Programmer:
          Richard F. Griffin                     tel: (478) 953-2680
          Griffin Solutions, Inc.             e-mail: richard@grifsolu.com
          102 Molded Stone Pl
          Warner Robins, GA  31088

       -------------------------------------------------------------
       This unit provides access to Griffin Solutions dBase Objects
       using high-level procedures and functions that make Object
       Oriented Programming transparent to the user.  It provides a
       selection of commands similar to the dBase format.

   Changes:

------------------------------------------------------------------------------}
{$I gs6_FLAG.PAS}
{$IFDEF WINAPI}
   {$IFNDEF CONSOLE}
      {$DEFINE ISGUI}
   {$ENDIF}
{$ENDIF}
interface
uses
   Windows,
   SysUtils,
   gs6_dbf,
   gs6_DBSy,
   gs6_indx,
   gs6_Glbl;

type
   gsDateTypes = (American,ANSI,British,French,German,Italian,Japan,
                  USA, MDY, DMY, YMD);

   gsSortStatus = (Ascending, Descending, SortUp, SortDown,
                   SortDictUp, SortDictDown, NoSort,
                   AscendingGeneral, DescendingGeneral);
   gsIndexUnique = (Unique, Duplicates);

   gsLokProtocol = (Default, DB4Lock, ClipLock, FoxLock);

   gsFlushAction = (NeverFlush,WriteFlush,AppendFlush,UnLockFlush);

{private}

   FilterCheck   = Function: boolean;
   StatusProc    = CaptureStatus;

{   pDBFObject = ^DBFObject;}
   DBFObject = class(GSO_dBHandler)
      DBFAlias    : string;
      DBFFilter   : FilterCheck;
      DBFStatus   : StatusProc;
      constructor Create(const FName, APassword: gsUTFString; ReadWrite, Shared: boolean);
      Procedure   gsStatusUpdate(stat1,stat2,stat3 : longint); virtual;
      Function    gsTestFilter : boolean; virtual;
   end;


var
   DBFActive  : DBFObject;
   DBFUsed    : integer;
   DBFAreas   : array[0..AreaLimit] of DBFObject;

{public}

   Function   Alias : string;
   Function   ALock : boolean;
   Procedure  Append;
   procedure  AssignUserID(id: longint);
   Procedure  ClearRecord;
   Procedure  CloseDataBases;
   Procedure  CopyRecordTo(area: integer; filname: string);
   Procedure  CopyStructure(filname : string);
   Procedure  CopyTo(filname : string);
   Function   CurrentArea : byte;
   Function   DBF : string;
   Function   dBOF : boolean;
   Function   Deleted : boolean;
   Procedure  DeleteRec;
   Function   dEOF : boolean;
   Function   ExternalChange: integer;
   Function   Field(n : integer) : string;
   Function   FieldCount : integer;
   Function   FieldDec(n : integer) : integer;
   Function   FieldLen(n : integer) : integer;
   Function   FieldNo(fn : string) : integer;
   Function   FieldType(n : integer) : char;
   Procedure  Find(ss : string);
   Function   FLock : boolean;
   Procedure  FlushDBF;
   Function   Found : boolean;
   Procedure  Go(n : longint);
   Procedure  GoBottom;
   Procedure  GoTop;
   Function   HuntDuplicate(const st, ky: String) : longint;
   Function   Index(INames,Tag : string): integer;            {!!RFG 091297}
   Function   IndexCount: integer;
   Function   IndexCurrent: string;
   Function   IndexCurrentOrder: integer;
   Function   IndexExpression(Value: integer): string;
   Function   IndexKeyLength(Value: integer): integer;
   Function   IndexKeyType(Value: integer): char;
   Function   IndexFilter(Value: integer): string;
   Function   IndexUnique(Value: integer): boolean;
   Function   IndexAscending(Value: integer): boolean;
   Function   IndexFileName(Value: integer): string;
   Procedure  IndexIsProduction(tf: boolean);
   Function   IndexMaintained: boolean;
   Procedure  IndexFileInclude(const IName: string);
   Procedure  IndexFileRemove(const IName: string);
   Procedure  IndexTagRemove(const IName, Tag: string);
   Procedure  IndexOn(const IName, tag, keyexp, forexp: String;
                      uniq: gsIndexUnique; ascnd: gsSortStatus);
   Function   IndexTagName(Value: integer): string;
   Function   LUpdate: string;
   Function   MemoryIndexAdd(const tag, keyexpr, forexpr: String;
                 uniq: gsIndexUnique; ascnd: gsSortStatus): boolean;
   Procedure  Pack;
   Procedure  RecallRec;
   Function   RecCount : longint;
   Function   RecNo : longint;
   Function   RecSize : word;
   Procedure  Reindex;
   Procedure  Replace;
   Function   RLock : boolean;
   procedure  ReturnDateTimeUser(var dt, tm, us: longint);
   Function   SearchDBF(const s: String; var FNum : word;
                        var fromrec: longint; torec: longint): word;
   Function   Select(Obj : byte): boolean;
   Function   SelectAsDBF(pDBF: DBFObject): boolean;
   Function   SelectedDBF: DBFObject;
   Procedure  SetDBFCache(tf: boolean);
   Procedure  SetDBFCacheAllowed(tf: boolean);
   Procedure  SetExact(tf: boolean);
   Procedure  SetFilterThru(UserRoutine : FilterCheck);
   Procedure  SetFlush(fs: gsFlushAction);
   Procedure  SetLockProtocol(LokProtocol: gsLokProtocol);
   Procedure  SetNear(tf: boolean);
   Procedure  SetOrderTo(order : integer);
   Procedure  SetRange(RLo, RHi: string);
   Procedure  SetStatusCapture(UserRoutine : StatusProc);
   Procedure  SetTagTo(TName: string);
   Procedure  SetUseDeleted(tf: boolean);
   Procedure  Skip(n : longint);
   Procedure  Unlock;
   Procedure  UnlockAll;
   Function   Use(FName : string): boolean;
   Function   UseEx(FName : string; ReadWrite, Shared: boolean): boolean;
   Procedure  Zap;

     {dBase field handling routines}

   Function   MemoSize(fnam: string): longint;
   Function   MemoSizeN(fnum: integer): longint;
   Procedure  MemoLoad(fnam: string;buf: PChar; var cb: longint);
   Function   MemoSave(fnam: string;buf: PChar; var cb: longint): longint;
   Procedure  MemoLoadN(fnum: integer;buf: PChar; var cb: longint);
   Function   MemoSaveN(fnum: integer;buf: PChar; var cb: longint): longint;
   Function   DateGet(st : string) : longint;
   Function   DateGetN(n : integer) : longint;
   Procedure  DatePut(st : string; jdte : longint);
   Procedure  DatePutN(n : integer; jdte : longint);
   Function   FieldGet(fnam : string) : string;
   Function   FieldGetN(fnum : integer) : string;
   Procedure  FieldPut(fnam, st : string);
   Procedure  FieldPutN(fnum : integer; st : string);
   Function   FloatGet(st : string) : FloatNum;
   Function   FloatGetN(n : integer) : FloatNum;
   Procedure  FloatPut(st : string; r : FloatNum);
   Procedure  FloatPutN(n : integer; r : FloatNum);
   Function   LogicGet(st : string) : boolean;
   Function   LogicGetN(n : integer) : boolean;
   Procedure  LogicPut(st : string; b : boolean);
   Procedure  LogicPutN(n : integer; b : boolean);
   Function   IntegerGet(st : string) : LongInt;
   Function   IntegerGetN(n : integer) : LongInt;
   Procedure  IntegerPut(st : string; i : LongInt);
   Procedure  IntegerPutN(n : integer; i : LongInt);
   Function   NumberGet(st : string) : FloatNum;
   Function   NumberGetN(n : integer) : FloatNum;
   Procedure  NumberPut(st : string; r : FloatNum);
   Procedure  NumberPutN(n : integer; r : FloatNum);
   Function   StringGet(fnam : string) : string;
   Function   StringGetN(fnum : integer) : string;
   Procedure  StringPut(fnam, st : string);
   Procedure  StringPutN(fnum : integer; st : string);

{private}


{public}

     {Default capture procedures}

Function  DefFilterCk: boolean;
Function  DefFormulaBuild(who,st,rsl: PChar;var Typ: char;
                                            var Chg: boolean):integer;
Procedure DefCapStatus(stat1,stat2,stat3 : longint);

implementation


{-----------------------------------------------------------------------------
                            Data Capture Procedures
------------------------------------------------------------------------------}

constructor DBFObject.Create(const FName, APassword: gsUTFString; ReadWrite, Shared: boolean);
begin
   inherited Create(FName,APassword,ReadWrite,Shared);
   DBFFilter := DefFilterCk;
   DBFStatus := DefCapStatus;
end;

Procedure DBFObject.gsStatusUpdate(stat1,stat2,stat3 : longint);
begin
   DBFStatus(stat1,stat2,stat3);
end;

Function DBFObject.gsTestFilter : boolean;
begin
   if dState = dbIndex then
      gsTestFilter := true
   else
   begin
      if DBFFilter then
         gsTestFilter := inherited gsTestFilter
      else
         gsTestFilter := false;
   end;
end;


                    {Default capture routines}
{$F+}
Function DefFilterCk: boolean;
begin
   DefFilterCk := true;
end;

Function DefFormulaBuild(who, st, rsl : PChar;
                         var Typ: char; var Chg: boolean): integer;
begin
   DefFormulaBuild := -1;
end;

Procedure DefCapStatus(stat1,stat2,stat3 : longint);
begin
end;
{$F-}
{-----------------------------------------------------------------------------
                        High-Level Procedures/Functions
------------------------------------------------------------------------------}

function CheckUsedArea: boolean;
begin
   CheckUsedArea := false;
   if DBFActive = nil then
   begin
      raise EHalcyonError.Create('Area is not active');
   end
   else
      CheckUsedArea := true;
end;

Function Alias : string;
begin
   if DBFActive <> nil then
      Alias := DBFActive.DBFAlias
   else
      Alias := '';
end;

Function ALock : boolean;
begin
   if CheckUsedArea then
      ALock := DBFActive.gsLockAppend
   else
      ALock := false;
end;

Procedure Append;
begin
   if CheckUsedArea then
      DBFActive.gsAppend;
end;

Procedure AssignUserID(id: longint);
begin
   if CheckUsedArea then
      DBFActive.gsAssignUserID(id);
end;

Procedure ClearRecord;
begin
   if CheckUsedArea then
      DBFActive.gsBlank;
end;

Procedure CloseDatabases;
var i : integer;
begin
   for i := 1 to AreaLimit do
      if (DBFAreas[i] <> nil) then
      begin
         DBFAreas[i].Free;
         DBFAreas[i] := nil;
      end;
   DBFActive := nil;
   DBFUsed := 1;
end;

Procedure  CopyRecordTo(area: integer; filname: string);
var
   curarea : integer;
begin
   if filname <> '' then
   begin
      CopyStructure(filname);
      curarea := DBFUsed;
      Select(area);
      Use(filname);
      Select(curarea);
   end
   else
      if not CheckUsedArea then exit;
   DBFActive.gsCopyRecord(GSO_dBHandler(DBFAreas[area]));
end;

Procedure  CopyStructure(filname : string);
begin
   if CheckUsedArea then
      DBFActive.gsCopyStructure(filname);
end;

Procedure  CopyTo(filname : string);
begin
   if CheckUsedArea then
      DBFActive.gsCopyFile(filname,'');
end;

function CreateDBF(const fname: string; ftype: char;
                                        fproc: dbInsertFieldProc): boolean;
begin
   CreateDBF := gsCreateDBF(fname,ftype,fproc);
end;

Function CurrentArea : byte;
begin
   CurrentArea := DBFUsed;
end;

Function DBF : string;
begin
   if DBFActive = nil then
      DBF := ''
   else
      DBF := DBFActive.FileName;
end;

Function dBOF : boolean;
begin
   if CheckUsedArea then
      dBOF := DBFActive.File_TOF
   else
      dBOF := false;
end;

Function Deleted : boolean;
begin
   if CheckUsedArea then
      Deleted := DBFActive.gsDelFlag
   else
      Deleted := false;
end;

Procedure DeleteRec;
begin
   if CheckUsedArea then
      DBFActive.gsDeleteRec;
end;

Function dEOF : boolean;
begin
   if CheckUsedArea then
      dEOF := DBFActive.File_EOF
   else
      dEOF := false;
end;

Function ExternalChange: integer;
begin
   if CheckUsedArea then
      ExternalChange := DBFActive.gsExternalChange
   else
      ExternalChange := 0;
end;

Function Field(n : integer) : string;
var
   st : string;
begin
   if CheckUsedArea then
   begin
      st := DBFActive.gsFieldName(n);
      if st = '' then
      Field := st;
   end
   else
      Field := '';
end;

Function FieldCount : integer;
begin
   if CheckUsedArea then
      FieldCount := DBFActive.NumFields
   else
      FieldCount := 0;
end;

Function FieldDec(n : integer) : integer;
begin
   if CheckUsedArea then
      FieldDec := DBFActive.gsFieldDecimals(n)
   else
      FieldDec := 0;
end;

Function FieldLen(n : integer) : integer;
begin
   if CheckUsedArea then
      FieldLen := DBFActive.gsFieldLength(n)
   else
      FieldLen := 0;
end;

Function FieldNo(fn : string) : integer;
var
   mtch : boolean;
   i,
   ix   : integer;
   za   : string[16];
begin
   if CheckUsedArea then
   begin
      fn := TrimRight(AnsiUpperCase(fn));
      ix := DBFActive.NumFields;
      i := 1;
      mtch := false;
      while (i <= ix) and not mtch do
      begin
         za := StrPas(DBFActive.Fields^[i].dbFieldName);
         if za = fn then
            mtch := true
         else
            inc(i);
      end;
      if mtch then
         FieldNo := i
      else
         FieldNo := 0;
   end
   else
      FieldNo := 0;
end;


Function FieldType(n : integer) : char;
begin
   if CheckUsedArea then
      FieldType := DBFActive.gsFieldType(n)
   else
      FieldType := '?';
end;

Procedure Find(ss : string);
begin
   if CheckUsedArea then
      DBFActive.gsFind(ss)
   else
      DBFActive.gsvFound := false;
end;

Function FLock : boolean;
begin
   if CheckUsedArea then
      FLock := DBFActive.gsLockFile
   else
      FLock := false;
end;

Procedure FlushDBF;
begin
   if not CheckUsedArea then exit;
   DBFActive.dStatus := Updated;
   DBFActive.gsFlush;
end;

Function Found : boolean;
begin
   if CheckUsedArea then
      Found := DBFActive.gsvFound
   else
      Found := false;
end;

Procedure Go(n : longint);
var
   feof: boolean;
   fbof: boolean;
begin
   feof := false;
   fbof := false;
   if CheckUsedArea then
   begin
      if n = Same_Record then              {!!RFG 081897}
      begin                                {!!RFG 081897}
         feof := DBFActive.File_EOF;      {!!RFG 081897}
         fbof := DBFActive.File_TOF;      {!!RFG 081897}
      end;                                 {!!RFG 081897}
      DBFActive.gsGetRec(n);
      if n = Same_Record then              {!!RFG 081897}
      begin                                {!!RFG 081897}
         DBFActive.File_EOF := feof;      {!!RFG 081897}
         DBFActive.File_TOF := fbof;      {!!RFG 081897}
      end;
   end;
end;

Procedure GoBottom;
begin
   if CheckUsedArea then
      DBFActive.gsGetRec(Bttm_Record);
end;

Procedure GoTop;
begin
   if CheckUsedArea then
      DBFActive.gsGetRec(Top_Record);
end;

Function HuntDuplicate(const st, ky: String): longint;
begin                                                 {!!RFG 082097}
   HuntDuplicate := -1;
   if CheckUsedArea then
      HuntDuplicate := DBFActive.gsHuntDuplicate(st, ky);
end;

Function Index(INames, Tag : string): integer;        {!!RFG 091297}
begin
   if CheckUsedArea then
      Index := DBFActive.gsIndex(INames,Tag)
   else
      Index := 0;
end;

Procedure  IndexFileInclude(const IName: string);
begin
   if CheckUsedArea then
      DBFActive.gsIndexRoute(IName);
end;

Procedure  IndexFileRemove(const IName: string);
begin
   if CheckUsedArea then
      DBFActive.gsIndexFileRemove(IName);
end;

Procedure IndexTagRemove(const IName, Tag: string);
begin
   if CheckUsedArea then
      DBFActive.gsIndexTagRemove(IName, Tag);
end;

Procedure IndexOn(const IName, tag, keyexp, forexp: String;
                  uniq: gsIndexUnique; ascnd: gsSortStatus);
begin
   if CheckUsedArea then
   DBFActive.gsIndexTo(IName, tag, keyexp, forexp,
                      GSsetIndexUnique(uniq), GSsetSortStatus(ascnd));
end;

function IndexExpression(Value: integer): string;
var
   p: GSobjIndexTag;
begin
   if CheckUsedArea then
   begin
      p := DBFActive.gsIndexPointer(Value);
      if p <> nil then
         IndexExpression := p.KeyExpr
      else
         IndexExpression := '';
   end
   else
      IndexExpression := '';
end;

function IndexKeyLength(Value: integer): integer;
var
   p: GSobjIndexTag;
begin
   if CheckUsedArea then
   begin
      p := DBFActive.gsIndexPointer(Value);
      if p <> nil then
         IndexKeyLength := p.KeyLength
      else
         IndexKeyLength := 0;
   end
   else
      IndexKeyLength := 0;
end;

function IndexKeyType(Value: integer): char;
var
   p: GSobjIndexTag;
begin
   if CheckUsedArea then
   begin
      p := DBFActive.gsIndexPointer(Value);
      if p <> nil then
         IndexKeyType := p.KeyType
      else
         IndexKeyType := 'C';
   end
   else
      IndexKeyType := '?';
end;

function IndexFilter(Value: integer): string;
var
   p: GSobjIndexTag;
begin
   if CheckUsedArea then
   begin
      p := DBFActive.gsIndexPointer(Value);
      if (p <> nil) and (p.ForExpr <> '') then
         IndexFilter := p.ForExpr
      else
         IndexFilter := '';
   end
   else
      IndexFilter := '';
end;

function IndexUnique(Value: integer): boolean;
var
   p: GSobjIndexTag;
begin
   if CheckUsedArea then
   begin
      p := DBFActive.gsIndexPointer(Value);
      if p <> nil then
         IndexUnique := p.KeyIsUnique
      else
         IndexUnique := false;
   end
   else
      IndexUnique := false;
end;

function IndexAscending(Value: integer): boolean;
var
   p: GSobjIndexTag;
begin
   if CheckUsedArea then
   begin
      p := DBFActive.gsIndexPointer(Value);
      if p <> nil then
         IndexAscending := p.KeyIsAscending
      else
         IndexAscending := false;
   end
   else
      IndexAscending := false;
end;

function IndexFileName(Value: integer): string;
var
   p: GSobjIndexTag;
begin
   if CheckUsedArea then
   begin
      p := DBFActive.gsIndexPointer(Value);
      if p <> nil then
         IndexFileName := p.Owner.IndexName
      else
         IndexFileName := '';
   end
   else
      IndexFileName := '';
end;

function IndexTagName(Value: integer): string;
var
   p: GSobjIndexTag;
begin
   if CheckUsedArea then
   begin
      p := DBFActive.gsIndexPointer(Value);
      if p <> nil then
         IndexTagName := p.TagName
      else
         IndexTagName := '';
   end
   else
      IndexTagName := '';
end;

function IndexCount: integer;
var
   i: integer;
   n: integer;
begin
   n := 0;
   if CheckUsedArea then
   begin
      i := 1;
      while (i <= IndexesAvail) do
      begin
         if DBFActive.IndexStack[i] <> nil then
            n := n + DBFActive.IndexStack[i].TagCount;
         inc(i);
      end;
   end;
   IndexCount := n;
end;

function IndexCurrent: string;
begin
   if CheckUsedArea then
   begin
      if DBFActive.IndexMaster <> nil then
         IndexCurrent := DBFActive.IndexMaster.TagName
      else
         IndexCurrent := '';
   end
   else
      IndexCurrent := '';
end;

function IndexCurrentOrder: integer;
var
   p: GSobjIndexTag;
   i: integer;
   n: integer;
   ni: integer;
begin
   IndexCurrentOrder := 0;
   if CheckUsedArea then
   begin
      with DBFActive do
      begin
         if IndexMaster <> nil then
         begin
            p := nil;
            n := 0;
            ni := 0;
            i := 1;
            while (p = nil) and (i <= IndexesAvail) do
            begin
               if IndexStack[i] <> nil then
               begin
                  p := IndexStack[i].TagByNumber(ni);
                  inc(ni);
                  if p <> nil then
                  begin
                     inc(n);
                     if p.TagName <> PrimaryTagName then
                        p := nil;
                  end
                  else
                  begin
                     inc(i);
                     ni := 0;
                  end;
               end;
            end;
            if p <> nil then
               IndexCurrentOrder := n;
         end;
      end;
   end;
end;

procedure IndexIsProduction(tf: boolean);
begin
   if CheckUsedArea then
   begin
      if tf then
         DBFActive.IndexFlag := $01
      else
         DBFActive.IndexFlag := $00;
      DBFActive.WithIndex := tf;
      DBFActive.dStatus := Updated;
      DBFActive.gsHdrWrite;
   end;
end;

Function IndexMaintained: boolean;
begin
   IndexMaintained := false;
   if CheckUsedArea then
      IndexMaintained := DBFActive.IndexFlag > 0;
end;

Function LUpdate: string;
var
   fd: longint;
   td: TDateTime;
begin
   if DBFActive = nil then
      LUpdate := ''
   else
   begin
      fd := FileGetDate(DBFActive.FileHandle);
      td := FileDateToDateTime(fd);
      LUpdate := DateToStr(td);
   end;
end;

Function MemoryIndexAdd(const tag, keyexpr, forexpr: String;
            uniq: gsIndexUnique; ascnd: gsSortStatus): boolean;
begin
   MemoryIndexAdd := false;
   if CheckUsedArea then
   MemoryIndexAdd := DBFActive.gsMemoryIndexAdd(Tag, keyexpr, forexpr,
                      GSsetIndexUnique(uniq), GSsetSortStatus(ascnd));
end;


Procedure Pack;
begin
   if CheckUsedArea then
      DBFActive.gsPack;
end;

Procedure RecallRec;
begin
   if CheckUsedArea then
      DBFActive.gsUndelete;
end;

Function RecCount : longint;
begin
   if CheckUsedArea then
      RecCount := DBFActive.NumRecs
   else
      RecCount := 0;
end;

Function RecNo : longint;
begin
   if CheckUsedArea then
      RecNo := DBFActive.RecNumber
   else
      RecNo := 0;
end;

Function RecSize : word;
begin
   if CheckUsedArea then
      RecSize := DBFActive.RecLen
   else
      RecSize := 0;
end;

Procedure Reindex;
begin
   if CheckUsedArea then
      DBFActive.gsReindex;
end;

Procedure Replace;
begin
   if CheckUsedArea then
      DBFActive.gsPutRec(DBFActive.RecNumber);
end;

Function RLock : boolean;
begin
   if CheckUsedArea then
      RLock := DBFActive.gsRLock
   else
      RLock := false;
end;

procedure ReturnDateTimeUser(var dt, tm, us: longint);
begin
   dt := 0;
   tm := 0;
   us := 0;
   if CheckUsedArea then
      DBFActive.gsReturnDateTimeUser(dt, tm, us);
end;

Function SearchDBF(const s: String; var FNum : word;
                   var fromrec: longint; torec: longint): word;
begin
   if CheckUsedArea then
      SearchDBF := DBFActive.gsSearchDBF(s,FNum,fromrec,torec)
   else
      SearchDBF := 0;
end;

Function Select(Obj : byte): boolean;
begin
   Select := false;
   if (Obj < 1) or (Obj > AreaLimit) then exit;
   DBFUsed := Obj;
   DBFActive := DBFAreas[Obj];
   Select := true;
end;

Function SelectAsDBF(pDBF: DBFObject): boolean;
begin
   DBFActive := pDBF;
   SelectAsDBF := pDBF <> nil;
end;

Function SelectedDBF: DBFObject;
begin
   SelectedDBF := DBFActive;
end;


Procedure SetDBFCacheAllowed(tf: boolean);
begin
   if CheckUsedArea then
      DBFActive.gsSetDBFCacheAllowed(tf);
end;

Procedure SetDBFCache(tf: boolean);
begin
   if not CheckUsedArea then exit;
   if tf and (DBFActive.IndexMaster <> nil) then exit;
   DBFActive.gsSetDBFCache(tf);
end;

Procedure SetExact(tf: boolean);
begin
   if DBFActive <> nil then
      DBFActive.gsvExactMatch := tf;
end;

Procedure SetFilterThru(UserRoutine : FilterCheck);
begin
   if not CheckUsedArea then exit;
   DBFActive.DBFFilter := UserRoutine;
end;

Procedure SetFlush(fs: gsFlushAction);
begin
   if CheckUsedArea then
      DBFActive.gsvAutoFlush := fs <> NeverFlush;
end;

Procedure SetLockProtocol(LokProtocol: gsLokProtocol);
begin
   if DBFActive <> nil then
      DBFActive.gsSetLockProtocol(GSsetLokProtocol(LokProtocol));
end;

Procedure SetNear(tf: boolean);
begin
   if DBFActive <> nil then
      DBFActive.gsvFindNear := tf;
end;

Procedure SetOrderTo(order : integer);
begin
   if CheckUsedArea then
      DBFActive.gsIndexOrder(order);
end;

Procedure SetRange(RLo, RHi: string);
begin
   if CheckUsedArea then
      DBFActive.gsSetRange(RLo,RHi,true,true,false);
end;

Procedure SetStatusCapture(UserRoutine : CaptureStatus);
begin
   if CheckUsedArea then
      DBFActive.DBFStatus := UserRoutine;
end;

Procedure SetTagTo(TName: string);
begin
   if CheckUsedArea then
      DBFActive.gsSetTagTo(TName,true);
end;

Procedure SetUseDeleted(tf: boolean);
begin
   if CheckUsedArea then
      DBFActive.UseDeletedRec := tf;
end;

Procedure Skip(n : longint);
begin
   if CheckUsedArea then
      DBFActive.gsSkip(n);
end;

Procedure Unlock;
begin
   if CheckUsedArea then
     DBFActive.gsLockOff;
end;

Procedure UnlockAll;
var i : integer;
begin
   for i := 1 to AreaLimit do
      if DBFAreas[i] <> nil then
         while DBFAreas[i].LockCount > 0 do DBFAreas[i].gsLockOff;
end;

Function Use(FName : string): boolean;
begin
   Use := UseEx(FName,true,true);
end;

Function UseEx(FName : string; ReadWrite, Shared: boolean): boolean;
var
  FMode: byte;
begin
   UseEx := true;
   if DBFActive <> nil then
      DBFActive.Free;
   DBFActive := nil;
   DBFAreas[DBFUsed] := DBFActive;
   if FName = '' then exit;
   if ReadWrite then
      FMode := fmOpenReadWrite
   else
      FMode := fmOpenRead;
   if Shared then
      FMode := FMode + fmShareDenyNone;
   DBFActive := DBFObject.Create(FName,'',ReadWrite,Shared);
   if (DBFActive <> nil) then
   begin
      DBFAreas[DBFUsed] := DBFActive;
      DBFActive.DBFAlias := ExtractFileName(DBFActive.FileName);
      DBFActive.DBFAlias := ChangeFileExt(DBFActive.DBFAlias,'');
   end;
   UseEx := DBFActive <> nil;
end;

Procedure Zap;
begin
   if CheckUsedArea then
      DBFActive.gsZap;
end;

{------------------------------------------------------------------------------
                           Field Access Routines
------------------------------------------------------------------------------}

Function MemoSize(fnam: string): longint;
begin
   MemoSize := DBFActive.gsMemoSize(fnam);
end;

Function MemoSizeN(fnum: integer): longint;
begin
   MemoSizeN := DBFActive.gsMemoSizeN(fnum);
end;

Procedure MemoLoad(fnam: string;buf: PChar; var cb: longint);
begin
   DBFActive.gsMemoLoad(fnam,buf,cb);
end;

Function MemoSave(fnam: string;buf: PChar; var cb: longint): longint;
begin
   MemoSave := DBFActive.gsMemoSave(fnam,buf,cb);
end;

Procedure  MemoLoadN(fnum: integer;buf: PChar; var cb: longint);
begin
   DBFActive.gsMemoLoadN(fnum,buf,cb);
end;

Function   MemoSaveN(fnum: integer;buf: PChar; var cb: longint): longint;
begin
   MemoSaveN := DBFActive.gsMemoSaveN(fnum,buf,cb);
end;


Function DateGet(st : string) : longint;
begin
   DateGet := DBFActive.gsDateGet(st);
end;

Function DateGetN(n : integer) : longint;
begin
   DateGetN := DBFActive.gsDateGetN(n);
end;

Procedure DatePut(st : string; jdte : longint);
begin
   DBFActive.gsDatePut(st, jdte);
end;

Procedure DatePutN(n : integer; jdte : longint);
begin
   DBFActive.gsDatePutN(n, jdte);
end;

Function FieldGet(fnam : string) : string;
begin
   FieldGet := DBFActive.gsFieldGet(fnam);
end;

Function FieldGetN(fnum : integer) : string;
begin
   FieldGetN := DBFActive.gsFieldGetN(fnum);
end;

Procedure FieldPut(fnam, st : string);
begin
   DBFActive.gsFieldPut(fnam, st);
end;

Procedure FieldPutN(fnum : integer; st : string);
begin
   DBFActive.gsFieldPutN(fnum, st);
end;

Function FloatGet(st : string) : FloatNum;
begin
   FloatGet := DBFActive.gsNumberGet(st);
end;

Function FloatGetN(n : integer) : FloatNum;
begin
   FloatGetN := DBFActive.gsNumberGetN(n);
end;

Procedure FloatPut(st : string; r : FloatNum);
begin
   DBFActive.gsNumberPut(st, r);
end;

Procedure FloatPutN(n : integer; r : FloatNum);
begin
   DBFActive.gsNumberPutN(n, r);
end;

Function LogicGet(st : string) : boolean;
begin
   LogicGet := DBFActive.gsLogicGet(st);
end;

Function LogicGetN(n : integer) : boolean;
begin
   LogicGetN := DBFActive.gsLogicGetN(n);
end;

Procedure LogicPut(st : string; b : boolean);
begin
   DBFActive.gsLogicPut(st, b);
end;

Procedure LogicPutN(n : integer; b : boolean);
begin
   DBFActive.gsLogicPutN(n, b);
end;

Function IntegerGet(st : string) : LongInt;
var
   r : FloatNum;
begin
   r := DBFActive.gsNumberGet(st);
   IntegerGet := Trunc(r);
end;

Function IntegerGetN(n : integer) : LongInt;
var
   r : FloatNum;
begin
   r := DBFActive.gsNumberGetN(n);
   IntegerGetN := Trunc(r);
end;

Procedure IntegerPut(st : string; i : LongInt);
var
   r : FloatNum;
begin
   r := i;
   DBFActive.gsNumberPut(st, r);
end;

Procedure IntegerPutN(n : integer; i : LongInt);
var
   r : FloatNum;
begin
   r := i;
   DBFActive.gsNumberPutN(n, r);
end;

Function NumberGet(st : string) : FloatNum;
begin
   NumberGet := DBFActive.gsNumberGet(st);
end;

Function NumberGetN(n : integer) : FloatNum;
begin
   NumberGetN := DBFActive.gsNumberGetN(n);
end;

Procedure NumberPut(st : string; r : FloatNum);
begin
   DBFActive.gsNumberPut(st, r);
end;

Procedure NumberPutN(n : integer; r : FloatNum);
begin
   DBFActive.gsNumberPutN(n, r);
end;

Function StringGet(fnam : string) : string;
begin
   StringGet := DBFActive.gsStringGet(fnam);
end;

Function StringGetN(fnum : integer) : string;
begin
   StringGetN := DBFActive.gsStringGetN(fnum);
end;

Procedure StringPut(fnam, st : string);
begin
   DBFActive.gsStringPut(fnam, st);
end;

Procedure StringPutN(fnum : integer; st : string);
begin
   DBFActive.gsStringPutN(fnum, st);
end;


{------------------------------------------------------------------------------
                           Setup and Exit Routines
------------------------------------------------------------------------------}

var
   ExitSave      : pointer;

{$F+}
procedure ExitHandler;
begin
   ExitProc := ExitSave;
end;
{$F-}

initialization
   ExitSave := ExitProc;
   ExitProc := @ExitHandler;
   DBFActive := nil;
   for DBFUsed := 0 to AreaLimit do
   begin
      DBFAreas[DBFUsed] := nil;
   end;
   DBFUsed := 1;

finalization
   CloseDatabases;

end.

