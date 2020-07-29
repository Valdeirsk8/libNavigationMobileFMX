unit uFormItem;

interface

Uses
  System.Classes, System.SysUtils, FMX.Forms, FMX.Layouts;

Type
  TOperacao = (toNenhum, toIncluir, toAlterar, toRepetirProduto);


  IFormItem = interface
    function  GetLayoutPrincipal():TLayout;
    function  GetAownerLayout:Tlayout;
    function  Initialize():IFormItem;
    procedure afterInitialize();
    procedure onHardwareBack();
    procedure afterReturnToTop();
    procedure Pop;
  end;

  TFormItem = class(TFrame, IFormItem)
  Strict Private
    FOwnerLayot:TLayout;
  public
    class function New():IFormItem; virtual; abstract;
    function GetLayoutPrincipal():TLayout; virtual;
    function Initialize():IFormItem; virtual;
    procedure afterInitialize(); virtual;
    procedure onHardwareBack(); virtual;

    function  GetAownerLayout:Tlayout;

    procedure afterReturnToTop(); virtual;
    procedure Pop;
  end;

  TFormItemMenu = class(TForm, IFormItem)
  public
    class function New():IFormItem; virtual; abstract;
    function GetLayoutPrincipal():TLayout; virtual;
    function Initialize():IFormItem; virtual;
    procedure afterInitialize(); virtual;
    procedure onHardwareBack(); virtual;
    procedure afterReturnToTop(); virtual;
    procedure Pop;
    function  GetAownerLayout:Tlayout;

  end;


implementation

{ TFormItem }

uses uFormBase;

procedure TFormItem.Pop;
begin
  if Self.Owner is TFormBase then
    (Self.Owner as TFormBase).ListaForms.Pop();
end;

function TFormItem.GetAownerLayout: Tlayout;
begin
  if Self.Owner is TFormBase then
    Result := TFormBase(Self.Owner).GetLayout();

end;

function TFormItem.GetLayoutPrincipal: TLayout;
begin
  raise eAbstractError.Create('Not implemented');
end;

function TFormItem.Initialize(): IFormItem;
begin
  raise eAbstractError.Create('not Implemented');
end;

procedure TFormItem.afterInitialize();
begin
  //nothing to do
end;

procedure TFormItem.afterReturnToTop();
begin
  //nothing to do
end;

procedure TFormItem.onHardwareBack();
begin
  Self.Pop();
end;


{ TFormItemMenu }

function TFormItemMenu.GetAownerLayout: Tlayout;
begin
  if Self.Owner is TFormBase then
    Result := (Self.Owner as TFormBase).GetLayoutMenu();
end;

function TFormItemMenu.GetLayoutPrincipal: TLayout;
begin
  raise eAbstractError.Create('Not Implemented');
end;

function TFormItemMenu.Initialize: IFormItem;
begin
  raise eAbstractError.Create('Not Implemented');
end;

procedure TFormItemMenu.afterInitialize();
begin
  //nothing to do
end;

procedure TFormItemMenu.afterReturnToTop();
begin
  //nothing to do
end;


procedure TFormItemMenu.onHardwareBack;
begin
  Self.Pop();
end;

procedure TFormItemMenu.Pop;
begin
  if Self.Owner is TFormBase then
    (Self.Owner as TFormBase).ListaFormsMenu.Pop();

end;

end.
