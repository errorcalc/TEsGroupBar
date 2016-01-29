{******************************************************************************}
{                            ErrorSoft(c) 2015-2016                            }
{                                                                              }
{             TEsGroupBar - the best skinnable groupbar for vcl                }
{                                  Version 1.0                                 }
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
unit EsGroupBarRegister;

interface

{$I 'EsGroupBar.inc'}

uses
  Es.Vcl.GroupBar, Classes, DesignIntf, Es.Vcl.GroupBarEditor, Es.Vcl.CfxClasses, PngImage;

procedure Register;

implementation

{$R 'Icons/EsGroupBarIcons.res'}

procedure Register;
begin
  RegisterComponents('ErrorSoft Panels', [TEsGroupBar]);
  RegisterComponentEditor(TEsGroupBar, TEsGroupBarEditor);
  RegisterComponentEditor(TEsGroup, TEsGroupEditor);
  {$ifdef FixLoadPng}
  RegisterPropertyEditor(TypeInfo(TPngImage), TStyleNinePath, '', TEsPngPropertyFix);
  {$endif}
  UnlistPublishedProperty(TEsGroupBar, 'GroupOptions');
  UnlistPublishedProperty(TEsGroupStyle, 'GroupStyle');
  UnlistPublishedProperty(TEsGroupButtonStyle, 'IsDefaultStyle');
  UnlistPublishedProperty(TEsGroupSelectStyle, 'IsDefaultStyle');
  UnlistPublishedProperty(TEsGroupItemSeparatorStyle, 'IsDefaultStyle');
  UnlistPublishedProperty(TEsGroupBackgroundStyle, 'IsDefaultStyle');
end;

end.
