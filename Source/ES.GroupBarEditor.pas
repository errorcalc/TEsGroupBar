{******************************************************************************}
{                            ErrorSoft(c) 2015-2016                            }
{                                                                              }
{             TEsGroupBar - the best skinnable groupbar for vcl                }
{                                  Version 1.6                                 }
{                                                                              }
{                        Free for noncommercial use                            }
{   You can purchase this, write on errorsoft@mail.ru or Enter256@yandex.ru    }
{             This on GitHub: https://github.com/errorcalc/TEsGroupBar         }
{                                                                              }
{           errorsoft@mail.ru | vk.com/errorsoft | github.com/errorcalc        }
{              errorsoft@protonmail.ch | habrahabr.ru/user/error1024           }
{                                                                              }
{     Designed for ООО "Быстрые Информационные Системы", manager@bis3.ru       }
{                                                                              }
{                    Компонент был разработан для                              }
{            ООО "Быстрые Информационные Системы", manager@bis3.ru             }
{   Пишите на errorsoft@mail.ru для разработки компонента (VCL/FMX) на заказ   }
{******************************************************************************}
unit ES.GroupBarEditor;

interface
uses
  DesignEditors, DesignMenus, DesignIntf, Classes, Es.GroupBar, StdCtrls, PicEdit,
  TypInfo, Types, Es.ExGraphics;

type
  TEsGroupBarEditor = class(TComponentEditor)
  public
    constructor Create(AComponent: TComponent; ADesigner: IDesigner); override;
    destructor Destroy; override;
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
    procedure PrepareItem(Index: Integer; const AItem: IMenuItem); override;
    procedure Edit; override;
  end;

  TEsGroupEditor = class(TComponentEditor)
  public
    constructor Create(AComponent: TComponent; ADesigner: IDesigner); override;
    destructor Destroy; override;
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
    procedure PrepareItem(Index: Integer; const AItem: IMenuItem); override;
    procedure Edit; override;
  end;

  TEsPngPropertyFix = class(TGraphicProperty)
    procedure Edit; override;
  end;

implementation

uses
  Dialogs, ColnEdit, Es.Utils, Graphics, PngImage, Es.CfxClasses, Controls,
  SysUtils, DesignConst;

{ TEsGroupBarEditorPopup }

constructor TEsGroupBarEditor.Create(AComponent: TComponent; ADesigner: IDesigner);
begin
  inherited;
  // nop
end;

destructor TEsGroupBarEditor.Destroy;
begin
  // nop
  inherited;
end;

procedure TEsGroupBarEditor.Edit;
begin
  inherited;
  // nop
end;

procedure TEsGroupBarEditor.ExecuteVerb(Index: Integer);
const
  GroupOptionsExt = '.EsGroupStyle';
  GroupOptionsFilter = 'Es Group Style (*' + GroupOptionsExt + ')|*' + GroupOptionsExt + '|All Files (*.*)|*.*';
var
  Group: TEsGroup;
  OpenDialog: TOpenDialog;
  SaveDialog: TSaveDialog;
begin
  case Index of
    0:
    begin
      Group := TEsGroup.Create(Designer.Root);
      Group.Name := Designer.UniqueName('EsGroup');

      TEsGroupBar(Component).AddGroup(Group);
      Designer.SelectComponent(Group);
    end;
    2:
    begin
      OpenDialog := TOpenDialog.Create(nil);
      try
        OpenDialog.DefaultExt := GroupOptionsExt;
        OpenDialog.Title := 'Load style from file...';
        OpenDialog.Filter := GroupOptionsFilter;
        if OpenDialog.Execute then
        begin
          TEsGroupBar(Component).GroupStyle.AssignDefaultStyle;
          try
            DeserializeFromFile(TEsGroupBar(Component).GroupStyle, OpenDialog.FileName, 'GroupBarStyle');
          except
            DeserializeFromFile(TEsGroupBar(Component).GroupStyle, OpenDialog.FileName, 'GroupOptions');
          end;
        end;
      finally
        OpenDialog.Free;
      end;
    end;
    3:
    begin
      SaveDialog := TSaveDialog.Create(nil);
      try
        SaveDialog.DefaultExt := GroupOptionsExt;
        SaveDialog.Title := 'Save style to file...';
        SaveDialog.Filter := GroupOptionsFilter;
        if SaveDialog.Execute then
          SerializeToFile(TEsGroupBar(Component).GroupStyle, SaveDialog.FileName, 'GroupBarStyle');
      finally
        SaveDialog.Free;
      end;
    end;
    4:
    if MessageDlg('Apply standard style?', TMsgDlgType.mtWarning, [mbYes, mbNo], 0, mbNo) = mrYes then
    begin
      TEsGroupBar(Component).GroupStyle.AssignDefaultStyle;
      Designer.Modified;
    end;
  end;
end;

function TEsGroupBarEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := 'Add Item';
    1: Result := '-';
    2: Result := 'Load style from file...';
    3: Result := 'Save style to file...';
    4: Result := 'Assign default style';
  end;
end;

function TEsGroupBarEditor.GetVerbCount: Integer;
begin
  Result := 5;
end;

procedure TEsGroupBarEditor.PrepareItem(Index: Integer; const AItem: IMenuItem);
begin
  inherited;
  // nop
end;

{ TEsGroupEditor }

constructor TEsGroupEditor.Create(AComponent: TComponent; ADesigner: IDesigner);
begin
  inherited;

end;

destructor TEsGroupEditor.Destroy;
begin

  inherited;
end;

procedure TEsGroupEditor.Edit;
begin
  ShowCollectionEditor(Designer, Component, TEsGroup(Component).Items, 'Items');
end;

procedure TEsGroupEditor.ExecuteVerb(Index: Integer);
var
  Group: TEsGroup;
begin
  case Index of
    0:
    begin
      TEsGroup(Component).Items.Add;
    end;
    2:
    begin
      Group := TEsGroup.Create(Designer.Root);
      Group.Name := Designer.UniqueName('EsGroup');

      TEsGroupBar(TEsGroup(Component).Parent).AddGroup(Group);
      Group.GroupIndex := TEsGroup(Component).GroupIndex + 1;
      Designer.SelectComponent(Group);
    end;
  end;
end;

function TEsGroupEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := 'Add Item';
    1: Result := '-';
    2: Result := 'Add Group';
  end;
end;

function TEsGroupEditor.GetVerbCount: Integer;
begin
  Result := 3;
end;

procedure TEsGroupEditor.PrepareItem(Index: Integer; const AItem: IMenuItem);
begin
  inherited;

end;


{TEsPngPropertyFix}

// AlphaControls/alphaskins is bad.
// I has too much head pain, because of them!
// Alpha controls COMPLETLY BREAK DOWN STANDART PNG LOADER.
procedure TEsPngPropertyFix.Edit;
var
  PictureEditor: TPictureEditor;
  Png: TPngImage;

begin
  PictureEditor := TPictureEditor.Create(nil);
  try
    PictureEditor.GraphicClass := TGraphicClass(GetTypeData(GetPropType)^.ClassType);
    PictureEditor.Picture.Graphic := TGraphic(Pointer(GetOrdValue));

    if PictureEditor.Execute then
      if (PictureEditor.Picture.Graphic = nil) or
         (PictureEditor.Picture.Graphic is PictureEditor.GraphicClass) then
        SetOrdValue(LongInt(PictureEditor.Picture.Graphic))
      else
        if (PictureEditor.Picture.Graphic is TBitmap) and
           PictureEditor.Picture.Graphic.ClassNameIs('TPNGGraphic') then
        begin
          Png := TPngImage.Create;
          try
            BitmapAssignToPngImage(Png, TBitmap(PictureEditor.Picture.Graphic), False);
            SetOrdValue(LongInt(Png));
          finally
            Png.Free;
          end;
        end
        else
          raise Exception.CreateRes(@SInvalidFormat);
  finally
    PictureEditor.Free;
  end;
end;

end.
