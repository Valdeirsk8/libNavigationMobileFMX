unit uFormBase;

interface

uses
  System.Classes, System.SysUtils, FMX.Forms, FMX.Layouts, FMX.Dialogs,

  System.Generics.Collections,

  uFormItem;

type
  TFormBase = Class;

  TListFormItem<IFormItem> = Class(TStack<uFormItem.IFormItem>)
  Private
    FFormHomePage:uFormItem.IFormItem;
    procedure DestroyForm(Form: uFormItem.IFormItem);
  public
    procedure SetHomePage(Base:uFormItem.IFormItem);
    procedure GoHomePage();
    function isHomePage(aForm:uFormItem.IFormItem):Boolean;
    procedure CleanOut(ManterHomePage:Boolean = False);
  End;

  TFormBase = Class(TForm)
  Strict private
    FlistaForms:TListFormItem<uFormItem.IFormItem>;
    FListaFormsMenu: TListFormItem<uFormItem.IFormITem>;
  protected
    procedure OnNotify(Sender:TObject; const Item: uFormItem.IFormItem; Action: TCollectionNotification);
  public
    function GetLayout():TLayout; virtual; abstract;
    function GetLayoutMenu:TLayout; virtual; abstract;

    property ListaForms:TListFormItem<uFormItem.IFormItem> read FlistaForms write FlistaForms;
    property ListaFormsMenu: TListFormItem<uFormItem.IFormITem> read FListaFormsMenu write FListaFormsMenu;

    constructor Create(AOwner: TComponent);virtual;
    destructor Destroy;

  End;

implementation

function TListFormItem<IFormItem>.isHomePage(aForm:uFormItem.IFormItem):Boolean;
begin
  Result := (Self.FFormHomePage = aForm);
end;

procedure TFormBase.OnNotify(Sender:TObject; Const Item: uFormItem.IFormItem; Action: TCollectionNotification);
Var
  List:TListFormItem<uFormItem.IFormItem>;
begin
  List := (Sender as TListFormItem<uFormItem.IFormItem>);

  case Action of
    cnAdded: begin
      if List.Count > 1 then
        Item.GetAownerLayout().RemoveObject(List.ToArray[ List.Count -2 ].GetLayoutPrincipal());
      Item.GetAownerLayout().AddObject(Item.Initialize().GetLayoutPrincipal());

      Item.afterInitialize();
    end;

    cnRemoved: begin
      Item.GetAownerLayout().RemoveObject(Item.GetLayoutPrincipal());
      Item.GetAownerLayout().AddObject(List.ToArray[List.Count -1].GetLayoutPrincipal());
      TForm(Item).DisposeOf();

      list.Peek().afterReturnToTop;
    end;

    cnExtracted: begin
      //don't do nothing for now
    end;
  end;
end;

constructor TFormBase.Create(AOwner: TComponent);
var
  MsgErro: string;
begin
  FlistaForms := TListFormItem<IFormItem>.Create();
  FlistaForms.OnNotify := Self.OnNotify;

  FListaFormsMenu := TListFormItem<IFormItem>.Create();
  FListaFormsMenu.OnNotify := Self.OnNotify;
end;


destructor TFormBase.Destroy;
begin
  FListaForms.CleanOut();
  FreeAndNil(FListaForms);
end;

procedure TListFormItem<IFormItem>.SetHomePage(Base:uFormItem.IFormItem);
begin
  FFormHomePage := Base;
end;

procedure TListFormItem<IFormItem>.GoHomePage();
begin
  Self.CleanOut(True);
  Self.Push(Self.FFormHomePage)
end;

procedure TListFormItem<IFormItem>.CleanOut(ManterHomePage:Boolean);
var
  Form: uFormItem.IFormItem;
  Notify:TCollectionNotifyEvent<uFormItem.IFormItem>;

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

procedure TListFormItem<IFormItem>.DestroyForm(Form: uFormItem.IFormItem);
begin
  Form.GetAownerLayout().RemoveObject(Form.GetLayoutPrincipal());
  TForm(Form).DisposeOf()
end;

end.

