program LittleInterpreter;

{$R 'li.res' 'li.rc'}

uses
  Forms,
  UnitMain in 'UnitMain.pas' {FormMain},
  UnitBasMan in 'UnitBasMan.pas' {FormBasicManual},
  UnitCodeSnippet in 'UnitCodeSnippet.pas' {FormCodeSnippet};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TFormBasicManual, FormBasicManual);
  Application.CreateForm(TFormCodeSnippet, FormCodeSnippet);
  Application.Run;
end.
