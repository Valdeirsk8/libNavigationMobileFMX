unit uMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,

  UFormBase, FMX.Layouts; //Uses do Form Base adicionado Manualmente

type
  TfrmMain = class(TFormBase)
    lytPrincipal: TLayout;
    procedure FormCreate(Sender: TObject);  //Herança do Form Base adicionada manualmente
  private

  public
    function GetLayout():TLayout; override;
    function GetLayoutMenu:TLayout; override;

  end;

var
  frmMain: TfrmMain;

implementation

{$R *.fmx}

uses uFrame1;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  inherited Create(nil); //Deve chamar a herança do form principal para inicializar os objetos necessários.

  //Set the home page
  Self.ListForms.SetHomePage(TFrmFrame1.New(Self));

  //Para mostrar o home page, pode ser chamado de qualquer lugar...
  //todos os form criados serão destruídos e o home page será mantido.
  Self.ListForms.GoHomePage();

end;

function TfrmMain.GetLayout: TLayout;
begin
  result :=  Self.lytPrincipal;
end;

function TfrmMain.GetLayoutMenu: TLayout;
begin
  //Ainda não tem menu
  Result := nil;
end;

end.
