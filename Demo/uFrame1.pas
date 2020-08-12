unit uFrame1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Layouts, FMX.Controls.Presentation,

  uInterfaces, uFormItem ; //Uses Adicionada manualmente

type
  TfrmFrame1 = class(TFormItem)  //Heran�a adicionanda manualmente;
    lytPrincipal: TLayout;
    Rectangle1: TRectangle;
    lbCenter: TLabel;
    procedure lbCenterClick(Sender: TObject);
  private
    function GetLayoutPrincipal():TLayout; override;   //Metodo da Heran�a Obrigat�rio implementar
    function Initialize():IFormItem; override;         //Metodo da Heran�a Obrigat�rio implementar

    procedure afterReturnToTop(); override;            //Metodo opcional, acionado quando o form retorna para o Topo

  public
    class function New(AOwner: TComponent):IFormItem; override;          //Metodo da Heran�a Obrigat�rio implementar

  end;

implementation

{$R *.fmx}

uses uFrame2;

{ TfrmFrame1 }

procedure TfrmFrame1.afterReturnToTop;
begin
  //inherited; //N�o tem problema manter o inherited, pode remove-lo se preferir

  lbCenter.Text := 'Hey, I''m back to the top, click on me te restart';

  //Self.GetFormBase.ListForms.CleanOut(True); //Limpa toda a pilha de form aberta e mantem o Form Setado como HomePage

end;

function TfrmFrame1.GetLayoutPrincipal: TLayout;
begin
  ///*
  ///*Esse Metodo deve devolver o Layout que tem todos os componentes colocados nele, � ele que ser� colado no form Principal
  ///*
  Result := Self.lytPrincipal;
end;

function TfrmFrame1.Initialize: IFormItem;
begin

  ///*
  ///*Esse Metodo Ser� chamado assim que o form estiver colado no Form pricipal
  ///*

  Result := Self;  //Obrigat�rio devolver o Self aqui;

  lbCenter.Text := 'Hey, click on me to start!';
end;

procedure TfrmFrame1.lbCenterClick(Sender: TObject);
begin
  Self.GetFormBase.ListForms.Push(TfrmFrame2.New(Self.Owner));
end;

class function TfrmFrame1.New(AOwner: TComponent): IFormItem;
begin
  Result := TfrmFrame1.Create(AOwner);
end;

end.
