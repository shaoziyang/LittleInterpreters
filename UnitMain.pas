unit UnitMain;

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
  ComCtrls,
  ToolWin,
  StdCtrls,
  ImgList,
  Menus,
  Buttons,
  Math,
  ExtCtrls,
  XPMan,
  ShellAPI,
  SynEdit,
  SynEditHighlighter,
  SynHighlighterCpp,
  SynHighlighterPas,
  SynHighlighterVB,
  FastIniFile,
  BeRoScript,
  uPSComponent,
  Chip,
  Calculator,
  FastList,
  AppEvnts,
  Grids;

const
{$I app.cfg}

type
  TFormMain = class(TForm)
    SynCppSyn: TSynCppSyn;
    ilMain: TImageList;
    pmLittleC_HisFile: TPopupMenu;
    dlgOpenLittleC: TOpenDialog;
    dlgSaveLittleC: TSaveDialog;
    pcMain: TPageControl;
    tsLittleC: TTabSheet;
    Splitter1: TSplitter;
    mmoOutC: TMemo;
    ToolBar1: TToolBar;
    btnLittleC_clear: TToolButton;
    ToolButton3: TToolButton;
    btnLittleC_new: TToolButton;
    btnLittleC_open: TToolButton;
    btnLittleC_save: TToolButton;
    btnLittleC_saveas: TToolButton;
    ToolButton9: TToolButton;
    btnLittleC_run: TToolButton;
    btnLittleC_stop: TToolButton;
    ToolButton10: TToolButton;
    synEditC: TSynEdit;
    XPManifest1: TXPManifest;
    tsAbout: TTabSheet;
    reReadme: TRichEdit;
    Panel1: TPanel;
    ProgramIcon: TImage;
    ProductName: TLabel;
    Version: TLabel;
    Comments: TLabel;
    Copyright: TLabel;
    Label1: TLabel;
    PSScript: TPSScript;
    tsPascal: TTabSheet;
    ToolBar2: TToolBar;
    btnPas_clear: TToolButton;
    ToolButton2: TToolButton;
    btnPas_new: TToolButton;
    btnPas_open: TToolButton;
    btnPas_save: TToolButton;
    btnPas_saveas: TToolButton;
    ToolButton8: TToolButton;
    btnPas_run: TToolButton;
    btnPas_stop: TToolButton;
    ToolButton13: TToolButton;
    btnPas_CodeSnippet: TToolButton;
    SynEditPas: TSynEdit;
    Splitter2: TSplitter;
    mmoOutPas: TMemo;
    SynPasSyn: TSynPasSyn;
    pmPas_HisFile: TPopupMenu;
    dlgOpenPas: TOpenDialog;
    dlgSavePas: TSaveDialog;
    btnGithub: TSpeedButton;
    btnGitee: TSpeedButton;
    Timer: TTimer;
    TrayIcon: TTrayIcon;
    pmTray: TPopupMenu;
    pmTrayExit: TMenuItem;
    ApplicationEvents: TApplicationEvents;
    tsBasic: TTabSheet;
    ToolBar3: TToolBar;
    btnBas_clear: TToolButton;
    ToolButton4: TToolButton;
    btnBas_new: TToolButton;
    btnBas_open: TToolButton;
    btnBas_save: TToolButton;
    btnBas_saveas: TToolButton;
    ToolButton12: TToolButton;
    btnBas_run: TToolButton;
    ToolButton16: TToolButton;
    btnBas_Help: TToolButton;
    mmoOutBas: TMemo;
    Splitter3: TSplitter;
    SynEditBas: TSynEdit;
    SynVBSyn: TSynVBSyn;
    pmBas_HisFile: TPopupMenu;
    dlgOpenBas: TOpenDialog;
    dlgSaveBas: TSaveDialog;
    ilLogo: TImageList;
    btnBas_stop: TToolButton;
    tsCalc: TTabSheet;
    pcCalc: TPageControl;
    tsCalcExpress: TTabSheet;
    tsCalcGraph: TTabSheet;
    Panel2: TPanel;
    cbbCalcExpress: TComboBox;
    mmoCalcRes: TMemo;
    Bevel1: TBevel;
    Splitter4: TSplitter;
    pnlCalcVar: TPanel;
    Label2: TLabel;
    mmoCalcVar: TMemo;
    dlgFont: TFontDialog;
    grpOption: TGroupBox;
    chkOptTrayIcon: TCheckBox;
    pnlFont: TPanel;
    btnOptFont: TBitBtn;
    btnOptDefaultFont: TBitBtn;
    btnBas_CodeSnippet: TToolButton;
    btnBas_CodeSnippetAdd: TToolButton;
    btnLittleC_CodeSnippet: TToolButton;
    btnPas_CodeSnippetAdd: TToolButton;
    btnLittleC_CodeSnippetAdd: TToolButton;
    mmoOut_Temp: TMemo;
    procedure btnLittleC_clearClick(Sender: TObject);
    procedure mmoOutCChange(Sender: TObject);
    procedure btnLittleC_newClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnLittleC_runClick(Sender: TObject);
    procedure synEditCChange(Sender: TObject);
    procedure btnLittleC_stopClick(Sender: TObject);
    procedure btnLittleC_saveClick(Sender: TObject);
    procedure btnLittleC_saveasClick(Sender: TObject);
    procedure btnLittleC_openClick(Sender: TObject);
    procedure btnPas_clearClick(Sender: TObject);
    procedure btnPas_newClick(Sender: TObject);
    procedure mmoOutPasChange(Sender: TObject);
    procedure btnPas_openClick(Sender: TObject);
    procedure btnPas_saveClick(Sender: TObject);
    procedure btnPas_saveasClick(Sender: TObject);
    procedure SynEditPasChange(Sender: TObject);
    procedure btnPas_runClick(Sender: TObject);
    procedure btnPas_stopClick(Sender: TObject);
    procedure PSScriptCompile(Sender: TPSScript);
    procedure btnGithubClick(Sender: TObject);
    procedure btnGiteeClick(Sender: TObject);
    procedure pcMainChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure pmTrayExitClick(Sender: TObject);
    procedure TrayIconClick(Sender: TObject);
    procedure ApplicationEventsMinimize(Sender: TObject);
    procedure chkOptTrayIconClick(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure btnBas_clearClick(Sender: TObject);
    procedure btnBas_newClick(Sender: TObject);
    procedure mmoOutBasChange(Sender: TObject);
    procedure btnBas_openClick(Sender: TObject);
    procedure btnBas_saveClick(Sender: TObject);
    procedure btnBas_saveasClick(Sender: TObject);
    procedure btnBas_runClick(Sender: TObject);
    procedure SynEditBasChange(Sender: TObject);
    procedure btnBas_stopClick(Sender: TObject);
    procedure btnBas_HelpClick(Sender: TObject);
    procedure cbbCalcExpressDblClick(Sender: TObject);
    procedure cbbCalcExpressKeyPress(Sender: TObject; var Key: Char);
    procedure btnOptFontClick(Sender: TObject);
    procedure btnOptDefaultFontClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnBas_CodeSnippetClick(Sender: TObject);
    procedure SynEditBasPaintTransient(Sender: TObject; Canvas: TCanvas;
      TransientType: TTransientType);
    procedure SynEditPasPaintTransient(Sender: TObject; Canvas: TCanvas;
      TransientType: TTransientType);
    procedure synEditCPaintTransient(Sender: TObject; Canvas: TCanvas;
      TransientType: TTransientType);
    procedure mmoCalcResClick(Sender: TObject);
  private
    { Private declarations }

    ini_writeable: Boolean;
    LittleC_EditorTempFileName: string;
    LittleC_Compiled: Boolean;
    Pas_EditorTempFileName: string;
    Pas_Compiled: Boolean;
    Bas_EditorTempFileName: string;
    Bas_Compiled: Boolean;

    procedure LittleC_Save(filename: string);
    procedure LittleC_Load(filename: string);
    procedure LittleC_addHis(filename: string);
    procedure LittleC_HisClick(Sender: TObject);

    procedure Pas_Save(filename: string);
    procedure Pas_Load(filename: string);
    procedure Pas_addHis(filename: string);
    procedure Pas_HisClick(Sender: TObject);

    procedure Bas_Save(filename: string);
    procedure Bas_Load(filename: string);
    procedure Bas_addHis(filename: string);
    procedure Bas_HisClick(Sender: TObject);

    procedure BasPrint(sender: TObject; msg: string);
  public
    { Public declarations }
    function shortFileName(FileName: string): string;
    procedure mmoOutAdd(var mmo: TMemo; msg: string);
    procedure mmoOutCAdd(s: string);
    procedure mmoOutPasAdd(s: string);
    procedure mmoOutBasAdd(s: string);
    procedure showFont;
  end;

var
  FormMain: TFormMain;
  Script: TBeRoScript;
  ini: TFastIniFile;
  bas: TBasic;
  Calc: TCalculator;

implementation

uses
  UnitBasMan,
  UnitCodeSnippet;

{$R *.dfm}

{$I NewFileTemplate.pas}

{ pascal script addon functions
}

procedure PSprint(v: array of variant);
var
  i: integer;
  s, ss: string;
begin
  s := '';
  for i := low(v) to high(v) do
  begin
    ss := v[i];
    s := s + ss + ' ';
  end;
  FormMain.mmoOutPas.Lines.add(s);
end;

function PSlog(x: extended): extended;
begin
  Result := ln(x);
end;

function PSlog10(x: extended): extended;
begin
  Result := ln(x) * 0.43429448190325182765;
end;

function PSPower(x, y: extended): extended;
begin
  Result := power(x, y);
  random;
end;

function PSExp(x: extended): extended;
begin
  Result := exp(x);
end;

function PSRandom: extended;
begin
  Result := Random;
end;

function PSRandomRange(x, y: integer): integer;
begin
  Result := Randomrange(x, y);
end;

procedure PSWriteln(const s: variant);
begin
  FormMain.mmoOutPas.Lines.Add(s);
end;

procedure PSWrite(const s: variant);
var
  n: integer;
  ss: string;
begin
  n := FormMain.mmoOutPas.Lines.Count;
  if n > 0 then
    n := n - 1;
  ss := s;
  FormMain.mmoOutPas.Lines[n] := FormMain.mmoOutPas.Lines[n] + ss;
end;

function PSReadln(const question: string): string;
begin
  Result := InputBox(question, '', '');
end;

procedure PSclear;
begin
  FormMain.mmoOutPas.Lines.Clear;
end;

procedure PSsleep(x: integer = 1000);
begin
  Sleep(x);
  Application.ProcessMessages;
end;

procedure PSbeep(F, L: word);
begin
  Windows.Beep(F, L);
end;

{ pascal script end }

{Little C script}

procedure RTL_CLEAR; pascal;
begin
  FormMain.mmoOutC.Clear;
  Application.ProcessMessages;
end;

procedure RTL_BEEP(F, L: word); pascal;
begin
  Windows.Beep(F, L);
  Application.ProcessMessages;
end;

procedure RTL_SLEEP(number: Integer); pascal;
begin
  Sleep(number);
  FormMain.mmoOutCAdd(Script.Output);
  Script.Output := '';
  Application.ProcessMessages;
end;

procedure OnOwnNativesPointers(Script: TBeRoScript);
begin
  Script.AddNativeProc('clear', @RTL_CLEAR);
  Script.AddNativeProc('sleep', @RTL_SLEEP);
  Script.AddNativeProc('beep', @RTL_BEEP);
end;

procedure OnOwnNativesDefinitions(Script: TBeRoScript);
begin
  Script.AddString('native void clear();');
  Script.AddString('native void sleep(int number);');
  Script.AddString('native void beep(int F, int L);');
end;
{Little C script end}

procedure TFormMain.ApplicationEventsMinimize(Sender: TObject);
begin
  Hide;
end;

procedure TFormMain.BasPrint(sender: TObject; msg: string);
begin
  mmoOutBasAdd(msg);
  Application.ProcessMessages;
end;

procedure TFormMain.Bas_addHis(filename: string);
var
  mi: TMenuItem;
begin
  if filename <> '' then
  begin
    mi := pmBas_HisFile.Items.Find(filename);
    if mi = nil then
    begin
      if pmBas_HisFile.Items.Count > 8 then
        pmBas_HisFile.Items.Delete(7);

      mi := TMenuItem.Create(pmBas_HisFile);
      mi.Caption := filename;
      mi.OnClick := Bas_HisClick;
      mi.ImageIndex := tsBasic.ImageIndex;
      pmBas_HisFile.Items.Insert(0, mi);
    end
    else
    begin
      // move filename to first
      if mi.MenuIndex = 0 then
        Exit;
      pmBas_HisFile.Items.Remove(mi);
      Bas_addHis(FileName);
    end;
  end;
end;

procedure TFormMain.Bas_HisClick(Sender: TObject);
begin
  Bas_Load(TMenuItem(Sender).Caption);
  Bas_addHis(TMenuItem(Sender).Caption);
end;

procedure TFormMain.Bas_Load(filename: string);
begin
  btnBas_newClick(nil);
  synEditBas.Lines.LoadFromFile(filename);
  tsBasic.Caption := 'Basic - ' + shortFileName(FileName);
  dlgSaveBas.FileName := filename;
end;

procedure TFormMain.Bas_Save(filename: string);
begin
  try
    synEditBas.Lines.SaveToFile(filename);
    synEditBas.Modified := False;
    btnBas_save.Enabled := False;
    btnBas_saveas.Enabled := False;
  except

  end;
end;

procedure TFormMain.btnBas_clearClick(Sender: TObject);
begin
  mmoOutBas.Clear;
end;

procedure TFormMain.btnBas_CodeSnippetClick(Sender: TObject);
begin
  FormCodeSnippet.tcMain.TabIndex := pcMain.ActivePageIndex;
  FormCodeSnippet.Show;
end;

procedure TFormMain.btnBas_HelpClick(Sender: TObject);
begin
  FormBasicManual.Show;
end;

procedure TFormMain.btnBas_newClick(Sender: TObject);
begin
  if Sender <> nil then
    SynEditBas.Text := NewBasFileTemplate;
  SynEditBas.Modified := False;
  btnBas_save.Enabled := False;
  btnBas_saveas.Enabled := False;
  tsBasic.Caption := 'Basic';
  dlgSaveBas.FileName := '';
end;

procedure TFormMain.btnBas_openClick(Sender: TObject);
begin
  if dlgOpenBas.Execute then
  begin
    Bas_Load(dlgOpenBas.FileName);
    Bas_addHis(dlgOpenBas.FileName);
    dlgSaveBas.FileName := dlgOpenBas.FileName;
  end;
end;

procedure TFormMain.btnBas_runClick(Sender: TObject);
begin
  if btnBas_stop.Enabled then
    Exit;
  btnBas_stop.Enabled := True;
  btnBas_run.Enabled := False;
  try
    try
      bas.Run('new');
      bas.Run(SynEditBas.Text + #13#10 + 'run');
    except on E: Exception do
      begin
        mmoOutBas.Lines.add(E.Message);
      end;
    end;
  finally
    btnBas_stop.Enabled := False;
    btnBas_run.Enabled := True;
  end;
end;

procedure TFormMain.btnBas_saveasClick(Sender: TObject);
begin
  if dlgSaveBas.Execute then
  begin
    Bas_Save(dlgSaveBas.FileName);
    tsBasic.Caption := 'Basic - ' + shortFileName(dlgSaveBas.FileName);
  end;
end;

procedure TFormMain.btnBas_saveClick(Sender: TObject);
begin
  if dlgSaveBas.FileName = '' then
  begin
    if not dlgSaveBas.Execute then
      Exit;
    tsBasic.Caption := 'Basic - ' + shortFileName(dlgSaveBas.FileName);
    Bas_addHis(dlgSaveBas.FileName);
  end;
  Bas_Save(dlgSaveBas.FileName);
end;

procedure TFormMain.btnBas_stopClick(Sender: TObject);
begin
  btnBas_stop.Enabled := False;
  btnBas_run.Enabled := True;
  bas.SetBreak
end;

procedure TFormMain.btnGiteeClick(Sender: TObject);
begin
  ShellExecute(Application.Handle, nil, 'https://gitee.com/shaoziyang/LittleInterpretors', nil, nil, SW_SHOWNORMAL);
end;

procedure TFormMain.btnGithubClick(Sender: TObject);
begin
  ShellExecute(Application.Handle, nil, 'https://github.com/shaoziyang/LittleInterpretors', nil, nil, SW_SHOWNORMAL);
end;

procedure TFormMain.btnLittleC_clearClick(Sender: TObject);
begin
  mmoOutC.Clear;
end;

procedure TFormMain.mmoCalcResClick(Sender: TObject);
var
  s: string;
begin
  s := mmoCalcRes.Lines[mmoCalcRes.CaretPos.Y];
  if s[Length(s)] = '=' then
    System.Delete(s, Length(s), 1);
  if s <> '' then
    cbbCalcExpress.Text := s;
end;

procedure TFormMain.mmoOutAdd(var mmo: TMemo; msg: string);
var
  i, n: integer;
begin
  // add msg to last line end
  // process \n
  // reduce flash on update
  mmoOut_Temp.Lines.BeginUpdate;
  mmoOut_Temp.Lines.Text := msg;
  mmoOut_Temp.Lines.EndUpdate;
  n := mmo.Lines.Count;
  if n > 0 then
    n := n - 1;
  mmo.Lines[n] := mmo.Lines[n] + mmoOut_Temp.Lines[0];
  for i := 1 to mmoOut_Temp.Lines.Count - 1 do
    mmo.Lines.Append(mmoOut_Temp.Lines[i]);
  if mmo.Lines.Count > OUTPUT_MAX_LINES then
  begin
    for n := 1 to 256 do
      mmo.Lines.Delete(0);
  end;
end;

procedure TFormMain.mmoOutBasAdd(s: string);
begin
  mmoOutAdd(mmoOutBas, s);
end;

procedure TFormMain.mmoOutBasChange(Sender: TObject);
var
  I: Integer;
begin
  if mmoOutBas.Lines.Count > 10000 then
  begin
    for I := 0 to 1000 do
      mmoOutBas.Lines.Delete(0);
  end;
end;

procedure TFormMain.mmoOutCAdd(s: string);
begin
  mmoOutAdd(mmoOutC, s);
end;

procedure TFormMain.mmoOutCChange(Sender: TObject);
var
  I: Integer;
begin
  if mmoOutC.Lines.Count > 10000 then
  begin
    for I := 0 to 1000 do
      mmoOutC.Lines.Delete(0);
  end;
end;

procedure TFormMain.mmoOutPasAdd(s: string);
begin
  mmoOutAdd(mmoOutPas, s);
end;

procedure TFormMain.mmoOutPasChange(Sender: TObject);
var
  I: Integer;
begin
  if mmoOutPas.Lines.Count > 10000 then
  begin
    for I := 0 to 1000 do
      mmoOutPas.Lines.Delete(0);
  end;
end;

procedure TFormMain.Pas_addHis(filename: string);
var
  mi: TMenuItem;
begin
  if filename <> '' then
  begin
    mi := pmPas_HisFile.Items.Find(filename);
    if mi = nil then
    begin
      if pmPas_HisFile.Items.Count > 8 then
        pmPas_HisFile.Items.Delete(7);

      mi := TMenuItem.Create(pmPas_HisFile);
      mi.Caption := filename;
      mi.OnClick := Pas_HisClick;
      mi.ImageIndex := tsPascal.ImageIndex;
      pmPas_HisFile.Items.Insert(0, mi);
    end
    else
    begin
      // move filename to first
      if mi.MenuIndex = 0 then
        Exit;
      pmPas_HisFile.Items.Remove(mi);
      Pas_addHis(FileName);

    end;
  end;
end;

procedure TFormMain.Pas_HisClick(Sender: TObject);
begin
  Pas_Load(TMenuItem(Sender).Caption);
  Pas_addHis(TMenuItem(Sender).Caption);
end;

procedure TFormMain.Pas_Load(filename: string);
begin
  btnPas_newClick(nil);
  synEditPas.Lines.LoadFromFile(filename);
  tsPascal.Caption := 'Pascal - ' + shortFileName(FileName);
  dlgSavePas.FileName := filename;
end;

procedure TFormMain.Pas_Save(filename: string);
begin
  try
    synEditPas.Lines.SaveToFile(filename);
    synEditPas.Modified := False;
    btnPas_save.Enabled := False;
    btnPas_saveas.Enabled := False;
  except

  end;
end;

procedure TFormMain.pcMainChange(Sender: TObject);
begin
  TrayIcon.IconIndex := pcMain.ActivePage.ImageIndex;
  if Visible and (pcMain.ActivePage = tsCalc) and (pcCalc.ActivePage = tsCalcExpress) then
    cbbCalcExpress.SetFocus;
end;

procedure TFormMain.pmTrayExitClick(Sender: TObject);
begin
  pmTray.Tag := $E;
  Close;
end;

procedure TFormMain.PSScriptCompile(Sender: TPSScript);
begin
  Sender.AddFunction(@PSprint, 'procedure print(v:array of Variant);');
  Sender.AddFunction(@PSwriteln, 'procedure Writeln(s: Variant);');
  Sender.AddFunction(@PSwrite, 'procedure Write(s: Variant);');
  Sender.AddFunction(@PSreadln, 'function Readln(question: string): string;');
  Sender.AddFunction(@PSreadln, 'function Read(question: string): string;');
  Sender.AddFunction(@PSlog, 'function ln(x: extended): extended;');
  Sender.AddFunction(@PSlog10, 'function log10(x: extended): extended;');
  Sender.AddFunction(@PSexp, 'function exp(x: extended): extended;');
  Sender.AddFunction(@PSpower, 'function power(x,y: extended): extended;');
  Sender.AddFunction(@PSRandom, 'function random: extended;');
  Sender.AddFunction(@PSRandomRange, 'function RandomRange(x,y: integer): integer;');
  Sender.AddFunction(@PSclear, 'procedure clear;');
  Sender.AddFunction(@PSbeep, 'procedure beep(F, L:word);');
  Sender.AddFunction(@PSsleep, 'procedure sleep(x:integer);');
end;

function TFormMain.shortFileName(FileName: string): string;
begin
  Result := ExtractFileName(FileName);
  if Length(Result) > 16 then
    Result := copy(Result, 1, 13) + '...';
end;

procedure TFormMain.showFont;
begin
  pnlFont.Caption := Font.Name + ', ' + IntToStr(Font.Size);
end;

procedure TFormMain.SynEditBasChange(Sender: TObject);
begin
  Bas_Compiled := False;
  btnBas_save.Enabled := True;
  btnBas_saveas.Enabled := True;
end;

procedure TFormMain.SynEditBasPaintTransient(Sender: TObject; Canvas: TCanvas;
  TransientType: TTransientType);
begin
  btnBas_CodeSnippetAdd.Enabled := SynEditBas.SelAvail;
end;

procedure TFormMain.synEditCChange(Sender: TObject);
begin
  LittleC_Compiled := False;
  btnLittleC_save.Enabled := True;
  btnLittleC_saveas.Enabled := True;
end;

procedure TFormMain.synEditCPaintTransient(Sender: TObject; Canvas: TCanvas;
  TransientType: TTransientType);
begin
  btnLittleC_CodeSnippetAdd.Enabled := SynEditC.SelAvail;
end;

procedure TFormMain.SynEditPasChange(Sender: TObject);
begin
  Pas_Compiled := False;
  btnPas_save.Enabled := True;
  btnPas_saveas.Enabled := True;
end;

procedure TFormMain.SynEditPasPaintTransient(Sender: TObject; Canvas: TCanvas;
  TransientType: TTransientType);
begin
  btnPas_CodeSnippetAdd.Enabled := SynEditPas.SelAvail;
end;

procedure TFormMain.TimerTimer(Sender: TObject);
begin
  if pcMain.ActivePage = tsAbout then
  begin
    ilLogo.Tag := (ilLogo.Tag + 1) mod ilLogo.Count;
    ProgramIcon.Picture.Bitmap := nil;
    ilLogo.GetBitmap(ilLogo.Tag, ProgramIcon.Picture.Bitmap);
  end;
end;

procedure TFormMain.TrayIconClick(Sender: TObject);
begin
  Show;
  Application.BringToFront;
end;

procedure TFormMain.btnLittleC_newClick(Sender: TObject);
begin
  if Sender <> nil then
    SynEditC.Text := NewCFileTemplate;
  SynEditC.Modified := False;
  btnLittleC_save.Enabled := False;
  btnLittleC_saveas.Enabled := False;
  tsLittleC.Caption := 'LittleC';
  dlgSaveLittleC.FileName := '';
  LittleC_Compiled := False;
end;

procedure TFormMain.btnLittleC_openClick(Sender: TObject);
begin
  if dlgOpenLittleC.Execute then
  begin
    LittleC_Load(dlgOpenLittleC.FileName);
    LittleC_addHis(dlgOpenLittleC.FileName);
    dlgSaveLittleC.FileName := dlgOpenLittleC.FileName;
  end;
end;

procedure TFormMain.btnLittleC_runClick(Sender: TObject);
begin
  if btnLittleC_stop.Enabled then
    Exit;
  btnLittleC_run.Enabled := False;
  btnLittleC_stop.Enabled := True;
  try
    try
      if not LittleC_Compiled then
      begin
        Script.Clear;
        Script.Compile(synEditC.Text);
      end;

      Script.Run;
      if Script.Errors <> '' then
        mmoOutC.Lines.Add(Script.Errors)
      else
        mmoOutCAdd(Script.Output + #13#10);

    except

    end;
  finally
    btnLittleC_run.Enabled := True;
    btnLittleC_stop.Enabled := False;
  end;

end;

procedure TFormMain.btnLittleC_saveasClick(Sender: TObject);
begin
  if dlgSaveLittleC.Execute then
  begin
    LittleC_Save(dlgSaveLittleC.FileName);
    tsLittleC.Caption := 'Little C - ' + shortFileName(dlgSaveLittleC.FileName);
  end;
end;

procedure TFormMain.btnLittleC_saveClick(Sender: TObject);
begin
  if dlgSaveLittleC.FileName = '' then
  begin
    if not dlgSaveLittleC.Execute then
      Exit;
    tsLittleC.Caption := 'Little C - ' + shortFileName(dlgSaveLittleC.FileName);
    LittleC_addHis(dlgSaveLittleC.FileName);
  end;
  LittleC_Save(dlgSaveLittleC.FileName);
end;

procedure TFormMain.btnLittleC_stopClick(Sender: TObject);
begin
  Script.Clear;
  btnLittleC_run.Enabled := True;
  btnLittleC_stop.Enabled := False;
end;

procedure TFormMain.btnOptDefaultFontClick(Sender: TObject);
begin
  Font.Name := 'Courier New';
  Font.Size := 10;
  ini.WriteFont('Option', 'Font', Font);
  dlgFont.Font := Font;
  showFont;
end;

procedure TFormMain.btnOptFontClick(Sender: TObject);
begin
  if dlgFont.Execute then
  begin
    Font.Name := dlgFont.Font.Name;
    Font.Size := dlgFont.Font.Size;
    ini.WriteFont('Option', 'Font', Font);
    showFont;
  end;
end;

procedure TFormMain.btnPas_clearClick(Sender: TObject);
begin
  mmoOutPas.Clear;
end;

procedure TFormMain.btnPas_newClick(Sender: TObject);
begin
  if Sender <> nil then
    SynEditPas.Text := NewPasFileTemplate;
  SynEditPas.Modified := False;
  btnPas_save.Enabled := False;
  btnPas_saveas.Enabled := False;
  tsPascal.Caption := 'Pascal';
  dlgSavePas.FileName := '';
  Pas_Compiled := False;
end;

procedure TFormMain.btnPas_openClick(Sender: TObject);
begin
  if dlgOpenPas.Execute then
  begin
    Pas_Load(dlgOpenPas.FileName);
    Pas_addHis(dlgOpenPas.FileName);
  end;
end;

procedure TFormMain.btnPas_runClick(Sender: TObject);
var
  res: boolean;
  i: integer;
begin
  if btnPas_stop.Enabled then
    Exit;
  btnPas_stop.Enabled := True;
  btnPas_run.Enabled := False;
  try
    try
      if not Pas_Compiled then
      begin
        // compile
        PSScript.Script.Text := SynEditPas.Text;
        Pas_Compiled := PSScript.Compile;
        //for i := 0 to PSScript.CompilerMessageCount - 1 do
        //  mmoPascalScript.Lines.add(PSScript.CompilerMessages[i].MessageToString);

        Application.ProcessMessages;

        if not Pas_Compiled then
        begin
          if PSScript.CompilerMessageCount > 0 then
            for i := 0 to PSScript.CompilerMessageCount - 1 do
              mmoOutPas.Lines.add(PSScript.CompilerErrorToStr(i));
        end
        else
          Pas_Compiled := True;
      end;

      Application.ProcessMessages;
      // run
      res := PSScript.Execute;
      if not res then
        mmoOutPas.Lines.add('Run-time error:' + PSScript.ExecErrorToString);

    except
      on E: Exception do
      begin
        mmoOutPas.Lines.add(E.Message);
      end;
    end;
  finally
    btnPas_stop.Enabled := False;
    btnPas_run.Enabled := True;
  end;
end;

procedure TFormMain.btnPas_saveasClick(Sender: TObject);
begin
  if dlgSavePas.Execute then
  begin
    Pas_Save(dlgSavePas.FileName);
    tsPascal.Caption := 'Pascal - ' + shortFileName(dlgSavePas.FileName);
  end;
end;

procedure TFormMain.btnPas_saveClick(Sender: TObject);
begin
  if dlgSavePas.FileName = '' then
  begin
    if not dlgSavePas.Execute then
      Exit;
    tsPascal.Caption := 'Pascal - ' + shortFileName(dlgSavePas.FileName);
    Pas_addHis(dlgSavePas.FileName);
  end;
  Pas_Save(dlgSavePas.FileName);
end;

procedure TFormMain.btnPas_stopClick(Sender: TObject);
begin
  btnPas_stop.Enabled := False;
  btnPas_run.Enabled := True;
  PSScript.Stop;
end;

procedure TFormMain.cbbCalcExpressDblClick(Sender: TObject);
var
  n: Integer;
  res: string;
begin
  try
    try
      if mmoCalcVar.Modified then
      begin
        Calc.Clear;
        Calc.AddVariableList(mmoCalcVar.Lines);
        mmoCalcVar.Clear;
        for n := 0 to Calc.Count - 1 do
        begin
          mmoCalcVar.Lines.Add(Calc.ItemName[n] + ' = ' + Calc.ItemValueFromIndex[n]);
          if Calc.ItemName[n] = 'x' then
          begin
            MessageDlg('If x is used as the variable name, ''0x'' cannot be used in the expression.',
              mtWarning, [mbOK], 0);
          end;
        end;
        mmoCalcVar.Modified := False;
      end;
      res := Calc.AsString(cbbCalcExpress.Text);
      mmoCalcRes.Lines.Add(Trim(cbbCalcExpress.Text) + ' =');
      mmoCalcRes.Lines.Add(res);
      n := cbbCalcExpress.Items.IndexOf(cbbCalcExpress.Text);
      if n = -1 then
      begin
        cbbCalcExpress.Items.Insert(0, cbbCalcExpress.Text);
        if cbbCalcExpress.Items.Count > 8 then
          cbbCalcExpress.Items.Delete(8);
      end
      else
        cbbCalcExpress.Items.Move(n, 0);

    except
      mmoCalcRes.Lines.Add('Expression < ' + Trim(cbbCalcExpress.Text) + ' > Error!');
      cbbCalcExpress.SelectAll;
    end;
  finally
    mmoCalcRes.Lines.Add('');
    if mmoCalcRes.Lines.Count > 4095 then
    begin
      for n := 1 to 128 * 3 do
        mmoCalcRes.Lines.Delete(0);
    end;
  end;
end;

procedure TFormMain.cbbCalcExpressKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cbbCalcExpressDblClick(Sender);
  end;
end;

procedure TFormMain.chkOptTrayIconClick(Sender: TObject);
begin
  TrayIcon.Visible := chkOptTrayIcon.Checked;
end;

procedure TFormMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := (not TrayIcon.Visible) or (pmTray.Tag = $E);
  if not CanClose then
    Hide;
end;

procedure TFormMain.FormCreate(Sender: TObject);
var
  i: Integer;
  rs: TResourceStream;
begin
  tsCalcGraph.TabVisible := False;

  rs := TResourceStream.Create(HInstance, 'README', 'RC_DATA');
  rs.Position := 0;
  reReadme.Lines.LoadFromStream(rs);

  Version.Caption := VER;
  Caption := 'Little Interpreters ' + VER;

  btnLittleC_newClick(Sender);
  btnLittleC_clearClick(Sender);
  LittleC_Compiled := False;
  try
    Script := TBeRoScript.Create(GetTempDir);
    Script.OnOwnNativesPointers := OnOwnNativesPointers;
    Script.OnOwnNativesDefinitions := OnOwnNativesDefinitions;

  except
    ShowMessage('Create script error!');
    Halt(1);
  end;

  btnPas_newClick(Sender);
  btnPas_clearClick(Sender);
  Pas_Compiled := False;

  bas := TBasic.Create;
  bas.OnPrint := BasPrint;
  btnBas_newClick(Sender);
  btnBas_clearClick(Sender);
  Bas_Compiled := False;

  Calc := TCalculator.Create(nil);
  mmoCalcVar.Modified := True;

  ini := TFastIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
  try
    ini.WriteInteger('Run', 'Count', ini.ReadInteger('Run', 'Count', 0) + 1);
    ini.UpdateFile;
    ini_writeable := True;

    BoundsRect := ini.ReadRect('Last', 'pos', BoundsRect);
    pcMain.ActivePageIndex := ini.ReadInteger('Last', 'page', 0);
    pcMainChange(nil);

    chkOptTrayIcon.Checked := ini.ReadBoolean('Option', 'Tray', True);
    chkOptTrayIconClick(Sender);
    dlgFont.Font := ini.ReadFont('Option', 'Font', Font);
    Font.Name := dlgFont.Font.Name;
    Font.Size := Min(Max(dlgFont.Font.Size, 7), 18);
    pnlFont.Font := Font;
    showFont;

    // C
    mmoOutC.Height := ini.ReadInteger('LittleC', 'Height', mmoOutC.Height);
    LittleC_EditorTempFileName := ChangeFileExt(Application.ExeName, '._c_');
    if FileExists(LittleC_EditorTempFileName) then
      synEditC.Lines.LoadFromFile(LittleC_EditorTempFileName);

    for i := 1 to ini.ReadInteger('LittleCHisFile', 'Count', 0) do
      LittleC_addHis(ini.ReadString('LittleCHisFile', IntToStr(i), ''));

    // Pas
    mmoOutPas.Height := ini.ReadInteger('Pascal', 'Height', mmoOutPas.Height);
    Pas_EditorTempFileName := ChangeFileExt(Application.ExeName, '._p_');
    if FileExists(Pas_EditorTempFileName) then
      synEditPas.Lines.LoadFromFile(Pas_EditorTempFileName);

    for i := 1 to ini.ReadInteger('PasHisFile', 'Count', 0) do
      Pas_addHis(ini.ReadString('PasHisFile', IntToStr(i), ''));

    // Bas
    mmoOutBas.Height := ini.ReadInteger('Basic', 'Height', mmoOutBas.Height);
    Bas_EditorTempFileName := ChangeFileExt(Application.ExeName, '._b_');
    if FileExists(Bas_EditorTempFileName) then
      synEditBas.Lines.LoadFromFile(Bas_EditorTempFileName);

    for i := 1 to ini.ReadInteger('BasHisFile', 'Count', 0) do
      Bas_addHis(ini.ReadString('BasHisFile', IntToStr(i), ''));

    // Calc
    for i := 1 to ini.ReadInteger('CalcExprHis', 'Count', 0) do
      cbbCalcExpress.Items.Add(ini.ReadString('CalcExprHis', IntToStr(i), ''));
    cbbCalcExpress.Text := ini.ReadString('CalcExprHis', 'text', '');
    pnlCalcVar.Width := ini.ReadInteger('CalcExpr', 'Width', mmoCalcRes.Width);
    ini.ReadStrings('CalcExpr', 'vars', mmoCalcVar.Lines);
    if mmoCalcVar.Text = '' then
      mmoCalcVar.Text := 'y=0x12'#13#10'f=y*y+2';
    mmoCalcVar.Modified := True;
  except
    ini_writeable := False;
  end;

end;

procedure TFormMain.FormDestroy(Sender: TObject);
var
  i: integer;
begin
  try
    if ini_writeable then
    begin
      ini.WriteRect('Last', 'pos', BoundsRect);
      ini.WriteInteger('Last', 'page', pcMain.ActivePageIndex);

      ini.WriteBoolean('Option', 'Tray', chkOptTrayIcon.Checked);

      // Little C
      ini.WriteInteger('LittleC', 'Height', mmoOutC.Height);

      synEditC.Lines.SaveToFile(LittleC_EditorTempFileName);

      ini.EraseSection('LittleCHisFile');
      ini.WriteInteger('LittleCHisFile', 'Count', pmLittleC_HisFile.Items.Count);
      for i := 0 to pmLittleC_HisFile.Items.Count - 1 do
        ini.WriteString('LittleCHisFile', IntToStr(i + 1), pmLittleC_HisFile.Items[i].Caption);

      // pas
      ini.WriteInteger('Pascal', 'Height', mmoOutPas.Height);

      synEditPas.Lines.SaveToFile(Pas_EditorTempFileName);

      ini.EraseSection('PasHisFile');
      ini.WriteInteger('PasHisFile', 'Count', pmPas_HisFile.Items.Count);
      for i := 0 to pmPas_HisFile.Items.Count - 1 do
        ini.WriteString('PasHisFile', IntToStr(i + 1), pmPas_HisFile.Items[i].Caption);

      // Bas
      ini.WriteInteger('Basic', 'Height', mmoOutBas.Height);

      synEditBas.Lines.SaveToFile(Bas_EditorTempFileName);

      ini.EraseSection('BasHisFile');
      ini.WriteInteger('BasHisFile', 'Count', pmBas_HisFile.Items.Count);
      for i := 0 to pmBas_HisFile.Items.Count - 1 do
        ini.WriteString('BasHisFile', IntToStr(i + 1), pmBas_HisFile.Items[i].Caption);

      // Calc
      ini.EraseSection('CalcExprHis');
      ini.WriteInteger('CalcExprHis', 'Count', cbbCalcExpress.Items.Count);
      ini.WriteString('CalcExprHis', 'text', cbbCalcExpress.Text);
      for i := 0 to cbbCalcExpress.Items.Count - 1 do
        ini.WriteString('CalcExprHis', IntToStr(i + 1), cbbCalcExpress.Items[i]);
      ini.WriteInteger('CalcExpr', 'Width', pnlCalcVar.Width);
      ini.WriteStrings('CalcExpr', 'vars', mmoCalcVar.Lines);
    end;
  finally
    Script.Free;
    bas.Free;
    ini.Free;
    Calc.Free;
  end;
end;

procedure TFormMain.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_F9:
      begin
        case pcMain.ActivePageIndex of
          0: btnLittleC_runClick(Sender);
          1: btnPas_runClick(Sender);
          2: btnBas_runClick(Sender);
          3: cbbCalcExpressDblClick(Sender);
        end;
      end;
    VK_F10:
      begin
        btnBas_CodeSnippetClick(Sender);
      end;
  end;
end;

procedure TFormMain.LittleC_HisClick(Sender: TObject);
begin
  LittleC_Load(TMenuItem(Sender).Caption);
  LittleC_addHis(TMenuItem(Sender).Caption);
end;

procedure TFormMain.LittleC_Load(filename: string);
begin
  btnLittleC_newClick(nil);
  synEditC.Lines.LoadFromFile(filename);
  tsLittleC.Caption := 'Little C - ' + shortFileName(FileName);
  dlgSaveLittleC.FileName := filename;
end;

procedure TFormMain.LittleC_Save(filename: string);
begin
  try
    synEditC.Lines.SaveToFile(filename);
    synEditC.Modified := False;
    btnLittleC_save.Enabled := False;
    btnLittleC_saveas.Enabled := False;
  except

  end;
end;

procedure TFormMain.LittleC_addHis(filename: string);
var
  mi: TMenuItem;
begin
  if filename <> '' then
  begin
    mi := pmLittleC_HisFile.Items.Find(filename);
    if mi = nil then
    begin
      if pmLittleC_HisFile.Items.Count > 8 then
        pmLittleC_HisFile.Items.Delete(7);

      mi := TMenuItem.Create(pmLittleC_HisFile);
      mi.Caption := filename;
      mi.OnClick := LittleC_HisClick;
      mi.ImageIndex := tsLittleC.ImageIndex;
      pmLittleC_HisFile.Items.Insert(0, mi);

    end
    else
    begin
      // move filename to first
      if mi.MenuIndex = 0 then
        Exit;
      pmLittleC_HisFile.Items.Remove(mi);
      LittleC_addHis(FileName);

    end;
  end;
end;

end.

