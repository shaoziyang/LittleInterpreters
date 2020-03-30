unit UnitBasMan;

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
  SynEditHighlighter,
  SynHighlighterVB,
  SynEdit;

type
  TFormBasicManual = class(TForm)
    SynEditBasicManual: TSynEdit;
    SynVBSyn: TSynVBSyn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormBasicManual: TFormBasicManual;

implementation

uses UnitMain;

{$R *.dfm}

procedure TFormBasicManual.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ini.WriteRect('Last', 'pos_BasicMan', BoundsRect);
end;

procedure TFormBasicManual.FormCreate(Sender: TObject);
begin
  BoundsRect := ini.ReadRect('Last', 'pos_BasicMan', BoundsRect);
end;

end.

