unit uFormItem;

interface

Uses
  System.Classes, System.SysUtils, FMX.Forms, FMX.Layouts,

  uInterfaces;

Type
  TOperacao = (toNenhum, toIncluir, toAlterar, toRepetirProduto);

  TFormItem = class(TForm, IFormItem)
  Strict Private
    FOwnerLayot:TLayout;
  public
    class function New(AOwner: TComponent):IFormItem; virtual; abstract;
    function GetLayoutPrincipal():TLayout; virtual; abstract;
    function Initialize():IFormItem; virtual; abstract;

    procedure afterInitialize(); virtual;
    procedure onHardwareBack(); virtual;

    function  GetAownerLayout:Tlayout;
    function  GetFormBase:IFormBase;

    procedure afterReturnToTop(); virtual;
    procedure Pop;
  end;

//  TFormItemMenu = class(TFrame, IFormItem)
//  public
//    class function New():IFormItem; virtual; abstract;
//    function GetLayoutPrincipal():TLayout; virtual; abstract;
//    function Initialize():IFormItem; virtual; abstract;
//    procedure afterInitialize(); virtual;
//    procedure onHardwareBack(); virtual;
//    procedure afterReturnToTop(); virtual;
//    procedure Pop;
//    function  GetAownerLayout:Tlayout;
//    function  GetFormBase():IFormBase;
//  end;

implementation

procedure TFormItem.Pop;
begin
  if Supports(Self.Owner, IFormBase) then
    (Self.Owner as IFormBase).ListForms.Pop();
end;

function TFormItem.GetAownerLayout: Tlayout;
begin
  Result := Self.GetFormBase.GetLayout();
end;

function TFormItem.GetFormBase: IFormBase;
begin
  if Supports(Self.Owner, IFormBase) then
    Result := (Self.Owner as IFormBase)
  else
    raise Exception.Create('Erro');
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


//{ TFormItemMenu }
//
//function TFormItemMenu.GetAownerLayout: Tlayout;
//begin
//  Result := Self.GetFormBase.GetLayoutMenu();
//end;
//
//
//function TFormItemMenu.GetFormBase: IFormBase;
//begin
//  if Supports(Self.Owner, IFormBase)
//  then Result := (Self.Owner as IFormBase)
//  else raise Exception.Create('Erro');
//
//end;
//
//procedure TFormItemMenu.afterInitialize();
//begin
//  //nothing to do
//end;
//
//procedure TFormItemMenu.afterReturnToTop();
//begin
//  //nothing to do
//end;
//
//
//procedure TFormItemMenu.onHardwareBack;
//begin
//  Self.Pop();
//end;
//
//procedure TFormItemMenu.Pop;
//begin
//  Self.GetFormBase.ListMenuForms.Pop();
//
//end;

end.
