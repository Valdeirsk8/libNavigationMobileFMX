program prjDemo;

uses
  System.StartUpCopy,
  FMX.Forms,
  uMain in 'uMain.pas' {frmMain},
  uFrame2 in 'uFrame2.pas' {frmFrame2: TFrame},
  uFrame3 in 'uFrame3.pas' {frmFrame3: TFrame},
  uFormBase in '..\src\uFormBase.pas',
  uInterfaces in '..\src\Interface\uInterfaces.pas',
  uFrame1 in 'uFrame1.pas' {frmFrame1},
  uFormItem in '..\src\uFormItem.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
