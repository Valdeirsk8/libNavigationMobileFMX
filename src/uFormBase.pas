unit uFormBase;

interface

uses
  System.Classes, System.SysUtils, FMX.Forms, FMX.Layouts, FMX.Dialogs,

  System.Generics.Collections,

  uFormItem, uInterfaces;

type
  //TFormBase = Class;

  TFormBase = Class(TForm, IFormBase)
  Strict private
    FListForms: TListFormItem;
    FListMenuForms: TListFormItem;
  protected
    procedure OnNotify(Sender:TObject; const Item: IFormItem; Action: TCollectionNotification);

  private
    function  GetListForms():TListFormItem;
    procedure SetListForms(aValue:TListFormItem);

    function  GetListMenuForms(): TListFormItem;
    procedure SetListMenuForms(aValue:TListFormItem);

  public
    function GetLayout():TLayout; virtual; abstract;
    function GetLayoutMenu:TLayout; virtual; abstract;

    constructor Create(AOwner: TComponent);virtual;
    destructor Destroy;

    property ListForms     : TListFormItem read GetListForms     write SetListForms;
    property ListMenuForms : TListFormItem read GetListMenuForms write SetListMenuForms;
  End;

implementation


function TFormBase.GetListForms(): TListFormItem;
begin
  Result := FListForms;
end;

function TFormBase.GetListMenuForms(): TListFormItem;
begin
  Result := FListMenuForms;
end;

procedure TFormBase.SetListForms(aValue:TListFormItem);
begin
  Self.FListForms := aValue;
end;

procedure TFormBase.SetListMenuForms(aValue:TListFormItem);
begin
  Self.FListMenuForms := aValue;
end;

procedure TFormBase.OnNotify(Sender:TObject; const Item: IFormItem; Action: TCollectionNotification);
Var
  List:TListFormItem;
begin
  List := (Sender as TListFormItem);

  case Action of
    cnAdded: begin
      if List.Count > 1 then
        Item.GetAownerLayout().RemoveObject(List.ToArray[ List.Count -2 ].GetLayoutPrincipal());
      Item.GetAownerLayout().AddObject(Item.Initialize().GetLayoutPrincipal());

      Item.afterInitialize();
    end;

    cnRemoved: begin
      Item.GetAownerLayout().RemoveObject(Item.GetLayoutPrincipal());
      Item.GetAownerLayout().AddObject(List.Peek().GetLayoutPrincipal());

      TFrame(Item).Free();

      list.Peek().afterReturnToTop;
    end;

    cnExtracted: begin
      //don't do nothing for now
    end;
  end;
end;

constructor TFormBase.Create(AOwner: TComponent);
begin
  FlistForms          := TListFormItem.Create();
  FlistForms.OnNotify := Self.OnNotify;

  FListMenuForms          := TListFormItem.Create();
  FListMenuForms.OnNotify := Self.OnNotify;
end;


destructor TFormBase.Destroy;
begin
  FListForms.CleanOut();
  FreeAndNil(FListForms);
end;


end.

