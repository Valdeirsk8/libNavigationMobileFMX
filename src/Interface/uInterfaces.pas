unit uInterfaces;

interface

uses System.Generics.Collections,



     FMX.Layouts, FMX.Forms;


type
  IFormItem = interface;

  TListFormItem = Class(TStack<IFormItem>)
  Private
    FFormHomePage:IFormItem;
    procedure DestroyForm(Form: IFormItem);
  public
    procedure SetHomePage(Base:IFormItem);
    procedure GoHomePage();
    function isHomePage(aForm:IFormItem):Boolean;
    procedure CleanOut(ManterHomePage:Boolean = False);
  End;

  IFormBase = interface
    ['{1E6B3C91-E5AB-4900-B1F9-34EC6F156F17}']
    function GetLayout():TLayout;
    function GetLayoutMenu:TLayout;

    function  GetListForms():TListFormItem;
    procedure SetListForms(aValue:TListFormItem);

    function  GetListMenuForms(): TListFormItem;
    procedure SetListMenuForms(aValue:TListFormItem);

    property ListForms     : TListFormItem read GetListForms     write SetListForms;
    property ListMenuForms : TListFormItem read GetListMenuForms write SetListMenuForms;
  end;

  IFormItem = interface
    ['{0D2996A3-2EBD-4D6E-A4CD-18E4F633BA5C}']
    function  GetLayoutPrincipal():TLayout;
    function  GetAownerLayout:Tlayout;
    function  Initialize():IFormItem;
    function  GetFormBase():IFormBase;

    procedure afterInitialize();
    procedure onHardwareBack();
    procedure afterReturnToTop();
    procedure Pop;
  end;





implementation


procedure TListFormItem.SetHomePage(Base:IFormItem);
begin
  FFormHomePage := Base;
end;

procedure TListFormItem.GoHomePage();
begin
  Self.CleanOut(True);
  Self.Push(Self.FFormHomePage)
end;

procedure TListFormItem.CleanOut(ManterHomePage:Boolean);
var
  Form: IFormItem;
  Notify:TCollectionNotifyEvent<IFormItem>;

begin
  Notify := Self.OnNotify;
  Self.OnNotify := nil;

  while Self.Count > 0 do begin
    Form := Self.Pop;

    if not (ManterHomePage) then
      DestroyForm(Form)
    else if Form <> Self.FFormHomePage then
      DestroyForm(Form);
  end;

  Self.OnNotify := Notify;
end;

procedure TListFormItem.DestroyForm(Form: IFormItem);
begin
  Form.GetAownerLayout().RemoveObject(Form.GetLayoutPrincipal());
  TFrame(Form).Free();
end;


function TListFormItem.isHomePage(aForm:IFormItem):Boolean;
begin
  Result := (Self.FFormHomePage = aForm);
end;

end.
