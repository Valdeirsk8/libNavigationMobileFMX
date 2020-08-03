unit uFrame2;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.Objects, FMX.Controls.Presentation,

  uInterfaces, uFormItem ; //Uses Adicionada manualmente;

type
  TfrmFrame2 = class(TFormItem)  //Herança adicionanda manualmente;
    lytLayout: TLayout;
    Rectangle1: TRectangle;
    lbCenter: TLabel;
   private
    function GetLayoutPrincipal():TLayout; override;   //Metodo da Herança Obrigatório implementar
    function Initialize():IFormItem; override;         //Metodo da Herança Obrigatório implementar

    procedure afterReturnToTop(); override;           //Metodo opcional, acionado quando o form retorna para o Topo

    procedure ClickOnInitialize(Sender: TObject);
    procedure ClickOnReturnToTop(Sender: TObject);

  public
    class function New(AOwner: TComponent):IFormItem; override;          //Metodo da Herança Obrigatório implementar

  end;

implementation

{$R *.fmx}

uses uFrame3;

{ TfrmFrame2 }

procedure TfrmFrame2.afterReturnToTop;
begin
  //inherited;
  Self.lbCenter.Text := 'Hey, I return to top, click on me to pop me';
  Self.Rectangle1.OnClick := ClickOnReturnToTop;
end;

function TfrmFrame2.GetLayoutPrincipal: TLayout;
begin
  Result := Self.lytLayout;
end;

function TfrmFrame2.Initialize: IFormItem;
begin
  Result := Self;
  Self.lbCenter.Text := 'I''m the second Form, click on me to open another form';
  Self.Rectangle1.OnClick := ClickOnInitialize;
end;

class function TfrmFrame2.New(AOwner: TComponent): IFormItem;
begin
  Result := TfrmFrame2.Create(AOwner);
end;

procedure TfrmFrame2.ClickOnInitialize(Sender: TObject);
begin
  Self.GetFormBase.ListForms.Push(TfrmFrame3.New(Self.Owner));
end;

procedure TfrmFrame2.ClickOnReturnToTop(Sender: TObject);
begin
  Self.Pop();
end;

end.
