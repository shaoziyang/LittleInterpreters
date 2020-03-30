unit UnitLittleDemos;

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
  Grids,
  ValEdit,
  ExtCtrls,
  SynEditHighlighter,
  SynHighlighterCpp,
  SynEdit,
  StdCtrls;

type
  TFormLittleC_Demo = class(TForm)
    SynEdit: TSynEdit;
    SynCppSyn: TSynCppSyn;
    Splitter1: TSplitter;
    vleList: TValueListEditor;
    mmoDemos: TSynEdit;
    procedure FormCreate(Sender: TObject);
    procedure vleListSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure vleListDblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormLittleC_Demo: TFormLittleC_Demo;

implementation

uses UnitMain;

{$R *.dfm}

procedure TFormLittleC_Demo.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  ini.WriteRect('Last', 'pos_LittleDemos',BoundsRect);
  ini.WriteInteger('Last','width_LittleDemos',vleList.Width);
end;

procedure TFormLittleC_Demo.FormCreate(Sender: TObject);
var
  i: Integer;
  rs:   TResourceStream;
begin
  BoundsRect:=ini.ReadRect('Last', 'pos_LittleDemos',BoundsRect);
  vleList.Width:=ini.ReadInteger('Last','width_LittleDemos',vleList.Width);
  rs   :=   TResourceStream.Create(HInstance,   'LittleC_demo',   'RC_DATA');
  rs.Position   :=   0;
  mmoDemos.Lines.LoadFromStream(rs);
  for i := 0 to (mmoDemos.Lines.Count div 2) - 1 do
  begin
    vleList.InsertRow(IntToStr(i + 1), mmoDemos.Lines[i * 2], True);
  end;

end;

procedure TFormLittleC_Demo.vleListDblClick(Sender: TObject);
begin
  formMain.btnLittleC_newClick(nil);
  FormMain.synEditC.Text :=SynEdit.Text;
  self.ModalResult := mrok;
end;

procedure TFormLittleC_Demo.vleListSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
var
s:string;
begin
  CanSelect := True;
  s := mmoDemos.Lines[ARow * 2 - 1];
  SynEdit.Text:=StringReplace(s, '#13#10', #13#10,[rfReplaceAll]);
end;

end.

