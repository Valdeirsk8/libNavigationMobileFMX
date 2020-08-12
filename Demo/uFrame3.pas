unit uFrame3;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.Objects, FMX.Controls.Presentation, FMX.DialogService.Async,


  uInterfaces, uFormItem; //Uses Adicionada manualmente;;

type
  TfrmFrame3 = class(TFormItem)  //Herança adicionanda manualmente;
    lytPrincipal: TLayout;
    Rectangle1: TRectangle;
    lbCenter: TLabel;
    procedure Rectangle1Tap(Sender: TObject; const Point: TPointF);
   private
    function GetLayoutPrincipal():TLayout; override;   //Metodo da Herança Obrigatório implementar
    function Initialize():IFormItem; override;         //Metodo da Herança Obrigatório implementar

    procedure afterReturnToTop(); override;
  public
    class function New(AOwner: TComponent):IFormItem; override;          //Metodo da Herança Obrigatório implementar

  end;
implementation

{$R *.fmx}

{ TfrmFrame3 }

procedure TfrmFrame3.afterReturnToTop;
begin
  //
end;

function TfrmFrame3.GetLayoutPrincipal: TLayout;
begin
  Result := Self.lytPrincipal;
end;

function TfrmFrame3.Initialize: IFormItem;
begin
  Result := Self;
  Self.lbCenter.Text := 'I''m the last form, click on me to return!';
end;

class function TfrmFrame3.New(AOwner: TComponent): IFormItem;
begin
  Result := TfrmFrame3.Create(AOwner);
end;

procedure TfrmFrame3.Rectangle1Tap(Sender: TObject; const Point: TPointF);
begin
  inherited;
  Self.Pop();
end;

end.
