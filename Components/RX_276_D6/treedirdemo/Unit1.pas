unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, FileCtrl, ImgList;

Type
  PDirFile = ^TDirFile;
  TDirFile = Record
    Path: String;
    Name: String;
    Time: Integer;
    Size: Integer;
    Attr: Integer;
    End;

type
  TForm1 = class(TForm)
    TreeView1: TTreeView;
    StatusBar1: TStatusBar;
    ImageList1: TImageList;
    procedure TreeView1Change(Sender: TObject; Node: TTreeNode);
    procedure FormCreate(Sender: TObject);
    procedure TreeView1Expanding(Sender: TObject; Node: TTreeNode;
      var AllowExpansion: Boolean);
    procedure TreeView1Collapsed(Sender: TObject; Node: TTreeNode);
    procedure TreeView1Deletion(Sender: TObject; Node: TTreeNode);
  private
    Procedure AddNode(Const SR: TSearchRec; Const Path: String; Const Node: TTreeNode);
    Procedure ViewStatusBar(DF: TDirFile);
    Procedure GetDiskList(Var Value: String);
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.TreeView1Change(Sender: TObject; Node: TTreeNode);
Var
  DF: TDirFile;
begin
  If TreeView1.Visible And Assigned(TreeView1.Selected) Then Begin
    DF := TDirFile(TreeView1.Selected.Data^);
    ViewStatusBar(DF);
    End
end;

procedure TForm1.ViewStatusBar(DF: TDirFile);
begin
  StatusBar1.Panels[0].Text := Format('%s', [DF.Name]);
  StatusBar1.Panels[1].Text := Format('%d', [DF.Size]);
end;

procedure TForm1.FormCreate(Sender: TObject);
Var
  SR: TSearchRec;
  Disks: String;
  A: Shortint;
begin
  With SR Do Begin
    Size := 0;
    Attr := faDirectory;
    End;
  GetDiskList(Disks); // Список существующих дисков
  For A := 1 To Length(Disks) Do Begin
    SR.Name := Disks[A] + ':\';
    AddNode(SR, '', Nil);
    End;
end;

procedure TForm1.AddNode(Const SR: TSearchRec; Const Path: String; Const Node: TTreeNode);
Var
  CNode: TTreeNode;
  P: PDirFile;
begin
  With SR Do If (Name = '.') Or (Name = '..') Then Exit;
  New(P);
  P^.Path := Path;
  P^.Name := SR.Name;
  P^.Time := SR.Time;
  P^.Size := SR.Size;
  P^.Attr := SR.Attr;
  CNode := TreeView1.Items.AddChildObject(Node, P^.Name, P);
  If (P^.Attr And faDirectory) <> 0 Then Begin
    CNode.HasChildren := True;
    CNode.ImageIndex := 1;
    End;
end;

procedure TForm1.TreeView1Expanding(Sender: TObject; Node: TTreeNode;
  var AllowExpansion: Boolean);
var
  DF: TDirFile;
  SR: TSearchRec;
begin
  If Node.getFirstChild <> Nil Then Exit;
  DF := TDirFile(Node.Data^);
  If (DF.Attr And faDirectory) = 0 Then Exit;
  DF.Path := DF.Path + DF.Name + '\';
  If FindFirst(DF.Path + '*', faAnyFile, SR) = 0 Then Begin
    AddNode(SR, DF.Path, Node);
    While FindNext(SR) = 0 Do
      AddNode(SR, DF.Path, Node);
    FindClose(SR);  // Освобождение ресурсов
    End;
end;

procedure TForm1.TreeView1Collapsed(Sender: TObject; Node: TTreeNode);
begin
  Node.DeleteChildren; // удаление дочерней ветки
  Node.HasChildren := True;
end;

procedure TForm1.TreeView1Deletion(Sender: TObject; Node: TTreeNode);
begin
  Dispose(PDirFile(Node.Data)) // освобождение памяти для каждого из узлов
end;

procedure TForm1.GetDiskList(var Value: String);
Var
  A: Integer;
  A2: Cardinal;
Begin
  Value := '';
  A2 := GetLogicalDrives;
  For A := 2 To 31 Do
    If (A2 And (1 Shl A)) <> 0 Then
      Value := Value + Char(Ord('A')+A);
end;

end.

