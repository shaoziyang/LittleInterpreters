unit UnitCodeSnippet;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  ToolWin,
  ComCtrls,
  SynEdit,
  ExtCtrls,
  ValEdit,
  StdCtrls,
  Buttons,
  Clipbrd,
  SynHighlighterVB,
  SynHighlighterPas,
  SynEditHighlighter,
  SynHighlighterCpp,
  SynMemo,
  Grids;

type
  TFormCodeSnippet = class(TForm)
    tcMain: TTabControl;
    ToolBar1: TToolBar;
    btnAdd: TToolButton;
    btnDel: TToolButton;
    btnSave: TToolButton;
    ToolButton1: TToolButton;
    cbbFind: TComboBox;
    btnFind: TToolButton;
    btnFindNext: TToolButton;
    ToolButton7: TToolButton;
    btnHelp: TToolButton;
    Splitter1: TSplitter;
    SynEditCodeSnippet: TSynEdit;
    btnOpen: TToolButton;
    btnCopy: TToolButton;
    ToolButton10: TToolButton;
    pnlHelp: TPanel;
    Memo1: TMemo;
    Panel1: TPanel;
    Panel2: TPanel;
    btnHelpOk: TBitBtn;
    syncpsyn: TSynCppSyn;
    SynPasSyn: TSynPasSyn;
    SynVBSyn: TSynVBSyn;
    btnLock: TToolButton;
    dlgOpen: TOpenDialog;
    pnlList: TPanel;
    vleCodeSnippetC: TValueListEditor;
    vleCodeSnippetPas: TValueListEditor;
    vleCodeSnippetBas: TValueListEditor;
    vleCodeSnippetOther: TValueListEditor;
    ToolButton2: TToolButton;
    btnDown: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    mmoCodeSnippetC: TSynMemo;
    mmoCodeSnippetPas: TSynMemo;
    mmoCodeSnippetBas: TSynMemo;
    mmoCodeSnippetOther: TSynMemo;
    procedure btnHelpClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnHelpOkClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnDelClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnLockClick(Sender: TObject);
    procedure tcMainChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure vleCodeSnippetBasGetEditText(Sender: TObject; ACol, ARow: Integer;
      var Value: string);
    procedure vleCodeSnippetBasSetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: string);
    procedure btnFindClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnFindNextClick(Sender: TObject);
    procedure cbbFindChange(Sender: TObject);
    procedure cbbFindKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCopyClick(Sender: TObject);
    procedure SynEditCodeSnippetChange(Sender: TObject);
  private
    { Private declarations }
    mmoCodeSnippet: TSynMemo;
    vleCodeSnippet: TValueListEditor;
    PosFind, PosN: Integer;
    procedure LoadCodeSnippet(var mmo: TSynMemo; var vle: TValueListEditor; ext: string; default: string = 'name,CodeSnippet');
    procedure SaveCodeSnippet(mmo: TSynMemo; ext: string);
  public
    { Public declarations }
  end;

var
  FormCodeSnippet: TFormCodeSnippet;

implementation

uses
  UnitMain;

{$R *.dfm}

procedure TFormCodeSnippet.btnSaveClick(Sender: TObject);
begin
  btnSave.Enabled := False;
  if SynEditCodeSnippet.Modified then
  begin
    SynEditCodeSnippet.Modified := False;
    mmoCodeSnippet.Lines[mmoCodeSnippet.Tag * 2 - 1] := SynEditCodeSnippet.Lines.CommaText;
  end;
  SaveCodeSnippet(mmoCodeSnippetC, '.ccs');
  SaveCodeSnippet(mmoCodeSnippetPas, '.pcs');
  SaveCodeSnippet(mmoCodeSnippetBas, '.bcs');
  SaveCodeSnippet(mmoCodeSnippetOther, '.ocs');
end;

procedure TFormCodeSnippet.cbbFindChange(Sender: TObject);
begin
  PosFind := 0;
  PosN := 1;
end;

procedure TFormCodeSnippet.cbbFindKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    btnFindClick(Sender);
  end;
end;

// add a code snippet

procedure TFormCodeSnippet.btnAddClick(Sender: TObject);
var
  i, n: Integer;
begin
  if mmoCodeSnippet.Lines.Count = 0 then
  begin
    vleCodeSnippet.Cells[0, 1] := '1';
    vleCodeSnippet.Cells[1, 1] := mmoCodeSnippet.Hint;
    mmoCodeSnippet.Lines.CommaText := mmoCodeSnippet.Hint + ',' + mmoCodeSnippet.Hint + 'Code';
    Exit;
  end;

  n := vleCodeSnippet.Row;

  if SynEditCodeSnippet.Modified then
  begin
    mmoCodeSnippet.Lines[n * 2 - 2] := vleCodeSnippet.Cells[1, n];
    mmoCodeSnippet.Lines[n * 2 - 1] := SynEditCodeSnippet.Lines.CommaText;
  end;

  vleCodeSnippet.InsertRow(IntToStr(n + 1), mmoCodeSnippet.Hint, True);
  mmoCodeSnippet.Lines.Insert(n * 2, mmoCodeSnippet.Hint);
  mmoCodeSnippet.Lines.Insert(n * 2 + 1, mmoCodeSnippet.Hint + 'Code');
  for i := vleCodeSnippet.RowCount - 1 downto n + 2 do
  begin
    vleCodeSnippet.Cells[1, i] := vleCodeSnippet.Cells[1, i - 1];
  end;
  vleCodeSnippet.Cells[1, n + 1] := mmoCodeSnippet.Hint;
  mmoCodeSnippet.Tag := n + 1;
  vleCodeSnippet.Row := n + 1;
  SynEditCodeSnippet.Lines.CommaText := mmoCodeSnippet.Hint + 'Code';
  vleCodeSnippet.SetFocus;
  btnSave.Enabled := True;
end;

procedure TFormCodeSnippet.btnCopyClick(Sender: TObject);
begin
  Clipboard.AsText := SynEditCodeSnippet.Text;
end;

procedure TFormCodeSnippet.btnDelClick(Sender: TObject);
var
  i: Integer;
begin
  if mmoCodeSnippet.Lines.Count > 0 then
  begin
    vleCodeSnippet.DeleteRow(vleCodeSnippet.Row);
    mmoCodeSnippet.Lines.Delete(vleCodeSnippet.Row * 2 - 2);
    mmoCodeSnippet.Lines.Delete(vleCodeSnippet.Row * 2 - 2);

    for i := 1 to vleCodeSnippet.RowCount - 1 do
      vleCodeSnippet.Cells[0, i] := IntToStr(i);

    mmoCodeSnippet.Tag := vleCodeSnippet.Row;
    SynEditCodeSnippet.Lines.CommaText := mmoCodeSnippet.Lines[mmoCodeSnippet.Tag * 2 - 1];
    btnSave.Enabled := True;
  end;
end;

procedure TFormCodeSnippet.btnFindClick(Sender: TObject);
begin
  PosFind := 0;
  PosN := 1;
  btnFindNextClick(Sender);
end;

procedure TFormCodeSnippet.btnFindNextClick(Sender: TObject);
var
  Y, d: Integer;
  s: string;
begin
  cbbFind.Text := UpperCase(Trim(cbbFind.Text));
  if cbbFind.Text = '' then
    Exit;

  if SynEditCodeSnippet.Modified then
  begin
    SynEditCodeSnippet.Modified := False;
    mmoCodeSnippet.Lines[mmoCodeSnippet.Tag * 2 - 1] := SynEditCodeSnippet.Lines.CommaText;
    PosFind := 0;
  end;

  s := Copy(UpperCase(mmoCodeSnippet.Text), PosFind + 1, Length(mmoCodeSnippet.Text) - PosFind);
  d := Pos(cbbFind.Text, s);
  if d > 0 then
  begin
    mmoCodeSnippet.SelStart := PosFind + d - 1;
    mmoCodeSnippet.SelLength := Length(cbbFind.Text);
    PosFind := PosFind + d;
    Y := mmoCodeSnippet.CaretY;
    d := (Y div 2);
    if d <> vleCodeSnippet.Row then
    begin
      PosN := 1;
      vleCodeSnippet.Row := d + 1;
      mmoCodeSnippet.Tag := d + 1;
    end;
    if (Y mod 2) = 0 then
    begin
      SynEditCodeSnippet.Lines.CommaText := mmoCodeSnippet.Lines[d * 2 - 1];
      s := Copy(UpperCase(SynEditCodeSnippet.Lines.Text), PosN, Length(SynEditCodeSnippet.Lines.Text) - PosN);
      d := Pos(cbbFind.Text, s);
      PosN := PosN + d;
      SynEditCodeSnippet.SelStart := PosN - 2;
      SynEditCodeSnippet.SelLength := Length(cbbFind.Text);
      SynEditCodeSnippet.SetFocus;
    end
    else
    begin
      vleCodeSnippet.SetFocus;
    end;
  end;
end;

procedure TFormCodeSnippet.btnHelpClick(Sender: TObject);
begin
  pnlHelp.Visible := True;
end;

procedure TFormCodeSnippet.btnHelpOkClick(Sender: TObject);
begin
  pnlHelp.Visible := False;
end;

procedure TFormCodeSnippet.btnLockClick(Sender: TObject);
begin
  if btnLock.Down then
    btnLock.ImageIndex := 52
  else
    btnLock.ImageIndex := 53;
end;

procedure TFormCodeSnippet.FormCreate(Sender: TObject);
var
  s: string;
begin
  pnlHelp.Align := alClient;
  pnlHelp.Visible := False;

  BoundsRect := ini.ReadRect('Last', 'pos_CodeSnippet', BoundsRect);
  pnlList.Width := ini.ReadInteger('CodeSnippet', 'List', 120);

  mmoCodeSnippetC.Tag := 1;
  mmoCodeSnippetPas.Tag := 1;
  mmoCodeSnippetBas.Tag := 1;
  mmoCodeSnippetOther.Tag := 1;

  vleCodeSnippetC.Align := alClient;
  vleCodeSnippetPas.Align := alClient;
  vleCodeSnippetBas.Align := alClient;
  vleCodeSnippetOther.Align := alClient;

  mmoCodeSnippet := mmoCodeSnippetC;
  vleCodeSnippet := vleCodeSnippetC;

  LoadCodeSnippet(mmoCodeSnippetC, vleCodeSnippetC, '.ccs', 'C,"""C Code"""');
  LoadCodeSnippet(mmoCodeSnippetPas, vleCodeSnippetPas, '.pcs', 'pascal,"""Pascal Code"""');
  LoadCodeSnippet(mmoCodeSnippetBas, vleCodeSnippetBas, '.bcs', 'basic,"""Basic Code"""');
  LoadCodeSnippet(mmoCodeSnippetOther, vleCodeSnippetOther, '.ocs', 'other,"""Other code"""');

  tcMain.TabIndex := 0;
  PosFind := 0;
end;

procedure TFormCodeSnippet.FormDestroy(Sender: TObject);
begin
  ini.WriteRect('Last', 'pos_CodeSnippet', BoundsRect);
  ini.WriteInteger('CodeSnippet', 'List', pnlList.Width);
end;

procedure TFormCodeSnippet.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F3 then
  begin
    btnFindNextClick(Sender);
  end;
end;

procedure TFormCodeSnippet.FormShow(Sender: TObject);
begin
  tcMainChange(Sender);
end;

procedure TFormCodeSnippet.LoadCodeSnippet(var mmo: TSynMemo; var vle: TValueListEditor; ext: string; default: string);
var
  s: string;
  i: Integer;
begin
  s := ChangeFileExt(Application.ExeName, ext);
  mmo.Clear;
  if FileExists(s) then
    mmo.Lines.LoadFromFile(s);
  if mmo.Lines.Text = '' then
    mmo.Lines.CommaText := default;
  for i := 1 to mmo.Lines.Count div 2 do
  begin
    if i = 1 then
    begin
      vle.Cells[0, 1] := '1';
      vle.Cells[1, 1] := mmo.Lines[0];
    end
    else
    begin
      vle.InsertRow(IntToStr(i), mmo.Lines[i * 2 - 2], True);
    end;
  end;
end;

procedure TFormCodeSnippet.SaveCodeSnippet(mmo: TSynMemo; ext: string);
begin
  mmo.Lines.SaveToFile(ChangeFileExt(Application.ExeName, ext));
end;

procedure TFormCodeSnippet.SynEditCodeSnippetChange(Sender: TObject);
begin
  btnSave.Enabled := True;
end;

procedure TFormCodeSnippet.tcMainChange(Sender: TObject);
begin
  // switch code snippet
  // save editor
  if SynEditCodeSnippet.Modified then
    mmoCodeSnippet.Lines[mmoCodeSnippet.Tag * 2 - 1] := SynEditCodeSnippet.Lines.CommaText;
  case tcMain.TabIndex of
    0:
      begin
        mmoCodeSnippet := mmoCodeSnippetC;
        vleCodeSnippet := vleCodeSnippetC;
        SynEditCodeSnippet.Highlighter := syncpsyn;
      end;
    1:
      begin
        mmoCodeSnippet := mmoCodeSnippetPas;
        vleCodeSnippet := vleCodeSnippetPas;
        SynEditCodeSnippet.Highlighter := SynPasSyn;
      end;
    2:
      begin
        mmoCodeSnippet := mmoCodeSnippetBas;
        vleCodeSnippet := vleCodeSnippetBas;
        SynEditCodeSnippet.Highlighter := SynVBSyn;
      end;
  else
    mmoCodeSnippet := mmoCodeSnippetOther;
    vleCodeSnippet := vleCodeSnippetOther;
    SynEditCodeSnippet.Highlighter := nil;
  end;

  vleCodeSnippet.BringToFront;
  SynEditCodeSnippet.Lines.CommaText := mmoCodeSnippet.Lines[mmoCodeSnippet.Tag * 2 - 1];
end;

procedure TFormCodeSnippet.vleCodeSnippetBasGetEditText(Sender: TObject; ACol,
  ARow: Integer; var Value: string);
begin
  if vleCodeSnippet.TabOrder <> tcMain.TabIndex then
    Exit;

  if mmoCodeSnippet.Tag <> ARow then
  begin
    // save current code snippet
    if SynEditCodeSnippet.Modified then
    begin
      mmoCodeSnippet.Lines[mmoCodeSnippet.Tag * 2 - 1] := SynEditCodeSnippet.Lines.CommaText;
      SynEditCodeSnippet.Modified := False;
      btnSaveClick(Sender);
    end;
    mmoCodeSnippet.Lines[mmoCodeSnippet.Tag * 2 - 2] := vleCodeSnippet.Cells[1, mmoCodeSnippet.Tag];
    mmoCodeSnippet.Tag := ARow;

    // show new code snippet
    SynEditCodeSnippet.Lines.CommaText := mmoCodeSnippet.Lines[ARow * 2 - 1];
  end;
end;

procedure TFormCodeSnippet.vleCodeSnippetBasSetEditText(Sender: TObject; ACol,
  ARow: Integer; const Value: string);
begin
  // save code name
  mmoCodeSnippet.Lines[ARow * 2 - 2] := Value;
end;

end.

