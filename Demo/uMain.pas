{******************************************************************************}
{                            ErrorSoft(c) 2015-2016                            }
{                                                                              }
{             TEsGroupBar - the best skinnable groupbar for vcl                }
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
unit uMain;

interface

{$ifndef VER210}
  {$ifndef VER220}
    {$ifndef VER230}
      {$define VER_XE3_UP}
    {$endif}
  {$endif}
{$endif}

{$ifdef VER_XE3_UP}
  {$ifndef VER240}
    {$ifndef VER250}
      {$ifndef VER260}
        {$ifndef VER270}
          {$ifndef VER280}
            {$define VER_XE8_UP}
          {$endif}
        {$endif}
      {$endif}
    {$endif}
  {$endif}
{$endif}

{$if CompilerVersion >= 30}
{$define Win10Styles}
{$ifend}
{$if CompilerVersion >= 23}
{$define SupportStyles}
{$ifend}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, StdCtrls, ActnList, ES.Vcl.BaseControls, Es.Vcl.GroupBar
  {$ifdef VER_XE8_UP},System.ImageList{$endif} {$ifdef VER_XE3_UP},System.Actions{$endif}
  , ExtCtrls, ToolWin, ComCtrls;

type
  TMainForm = class(TForm)
    EsGroupBar1: TEsGroupBar;
    EsGroup1: TEsGroup;
    EsGroup2: TEsGroup;
    ActionList1: TActionList;
    ImageList1: TImageList;
    Action1: TAction;
    Action2: TAction;
    Action3: TAction;
    Action4: TAction;
    Action5: TAction;
    grSelectStyle: TEsGroup;
    Memo1: TMemo;
    StaticText1: TStaticText;
    Panel1: TPanel;
    btnAddGroup: TButton;
    btnOpenAll: TButton;
    btnCloseAll: TButton;
    chEsGroup1Visible: TCheckBox;
    chEsGroup1Expanded: TCheckBox;
    chAction3Enabled: TCheckBox;
    chAction3Visible: TCheckBox;
    grAutoHide: TEsGroup;
    chAutoHideGroupItem: TCheckBox;
    StaticText2: TStaticText;
    chUniqueItemSelection: TCheckBox;
    btnView: TButton;
    chCanCloseGroup: TCheckBox;
    chShowSeparator: TCheckBox;
    chAccuracyItemHitTest: TCheckBox;
    chTextGlow: TCheckBox;
    chUnderlineHotItem: TCheckBox;
    procedure Action1Execute(Sender: TObject);
    procedure btnAddGroupClick(Sender: TObject);
    procedure btnOpenAllClick(Sender: TObject);
    procedure btnCloseAllClick(Sender: TObject);
    procedure EsGroup3Items0Click(Sender: TObject);
    procedure EsGroup3Items1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EsGroup3Items2Click(Sender: TObject);
    procedure EsGroup3Items3Click(Sender: TObject);
    procedure EsGroup3Items4Click(Sender: TObject);
    procedure chEsGroup1VisibleClick(Sender: TObject);
    procedure chEsGroup1ExpandedClick(Sender: TObject);
    procedure chAction3EnabledClick(Sender: TObject);
    procedure chAction3VisibleClick(Sender: TObject);
    procedure chAutoHideGroupItemClick(Sender: TObject);
    procedure grAutoHideItems0Click(Sender: TObject);
    procedure chUniqueItemSelectionClick(Sender: TObject);
    procedure btnViewClick(Sender: TObject);
    procedure chCanCloseGroupClick(Sender: TObject);
    procedure chShowSeparatorClick(Sender: TObject);
    procedure chAccuracyItemHitTestClick(Sender: TObject);
    procedure chTextGlowClick(Sender: TObject);
    procedure chUnderlineHotItemClick(Sender: TObject);
  private
    { Private declarations }
    procedure SetStyle(Index: Integer);
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

{$ifdef SupportStyles}
uses
  Vcl.Themes,
  Vcl.Styles;
{$endif}

procedure TMainForm.Action1Execute(Sender: TObject);
begin
 Memo1.Lines.Add(TAction(Sender).Caption + ' Clicked');
end;

procedure TMainForm.btnAddGroupClick(Sender: TObject);
var
  G: TEsGroup;
  i: Integer;
begin
  G := TEsGroup.Create(nil);
  G.Caption := 'TestGroup';
  for i := 0 to 10 do
  begin
    G.Items.Add.Caption := 'Test ' + IntToStr(i);
    G.Items[i].OnClick := grAutoHideItems0Click;
  end;
  EsGroupBar1.AddGroup(G);
end;

procedure TMainForm.btnOpenAllClick(Sender: TObject);
begin
  EsGroupBar1.OpenAllGroups;
end;

procedure TMainForm.btnViewClick(Sender: TObject);
begin
  EsGroup1.View;
end;

procedure TMainForm.btnCloseAllClick(Sender: TObject);
begin
  EsGroupBar1.CloseAllGroups;
end;

procedure TMainForm.chEsGroup1VisibleClick(Sender: TObject);
begin
  EsGroup1.Visible := TCheckBox(Sender).Checked;
end;

procedure TMainForm.chShowSeparatorClick(Sender: TObject);
begin
  EsGroupBar1.GroupStyle.ShowSeparator := TCheckBox(Sender).Checked;
end;

procedure TMainForm.chTextGlowClick(Sender: TObject);
begin
  EsGroupBar1.GroupStyle.TextGlow := TCheckBox(Sender).Checked;
end;

procedure TMainForm.chUnderlineHotItemClick(Sender: TObject);
begin
  EsGroupBar1.GroupStyle.UnderlineHotItem := TCheckBox(Sender).Checked;
end;

procedure TMainForm.chUniqueItemSelectionClick(Sender: TObject);
begin
  EsGroupBar1.UniqueItemSelection := TCheckBox(Sender).Checked;
end;

procedure TMainForm.chEsGroup1ExpandedClick(Sender: TObject);
begin
  EsGroup1.Expanded := TCheckBox(Sender).Checked;
end;

procedure TMainForm.chAccuracyItemHitTestClick(Sender: TObject);
begin
  EsGroupBar1.GroupStyle.AccuracyItemHitTest := TCheckBox(Sender).Checked;
end;

procedure TMainForm.chAction3EnabledClick(Sender: TObject);
begin
  Action3.Enabled := TCheckBox(Sender).Checked;
end;

procedure TMainForm.chAction3VisibleClick(Sender: TObject);
begin
  Action2.Visible := TCheckBox(Sender).Checked;
end;

procedure TMainForm.chAutoHideGroupItemClick(Sender: TObject);
begin
  grAutoHide.Items[0].Visible := TCheckBox(Sender).Checked;
end;

procedure TMainForm.chCanCloseGroupClick(Sender: TObject);
begin
  EsGroupBar1.CanCloseGroup := TCheckBox(Sender).Checked;
end;

procedure TMainForm.EsGroup3Items0Click(Sender: TObject);
begin
  SetStyle(0);
end;

procedure TMainForm.EsGroup3Items1Click(Sender: TObject);
begin
  SetStyle(1);
end;

procedure TMainForm.EsGroup3Items2Click(Sender: TObject);
begin
  SetStyle(2);
end;

procedure TMainForm.EsGroup3Items3Click(Sender: TObject);
begin
  SetStyle(3);
end;

procedure TMainForm.EsGroup3Items4Click(Sender: TObject);
begin
  SetStyle(4);
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  {$if CompilerVersion >= 29}
  ImageList1.GrayscaleFactor := 255;
  {$ifend}
  {$ifndef Win10Styles}
  grSelectStyle.Items[2].Caption := 'Light*';
  grSelectStyle.Items[3].Caption := 'Metropolis UI Dark*';
  grSelectStyle.Items[4].Caption := 'Metropolis UI Blue*';
  StaticText1.Visible := True;
  {$endif}

  chEsGroup1Visible.Checked := EsGroup1.Visible;
  chEsGroup1Expanded.Checked := EsGroup1.Expanded;
  chAction3Enabled.Checked := Action3.Enabled;
  chAction3Visible.Checked := Action3.Visible;
  chAutoHideGroupItem.Checked := grAutoHide.Items[0].Visible;
  chUniqueItemSelection.Checked := EsGroupBar1.UniqueItemSelection;
  chCanCloseGroup.Checked := EsGroupBar1.CanCloseGroup;

  SetStyle(0);
end;

procedure TMainForm.grAutoHideItems0Click(Sender: TObject);
begin
 Memo1.Lines.Add(TEsGroupItem(Sender).Caption + ' Clicked');
end;

procedure TMainForm.SetStyle(Index: Integer);
begin
  case Index of
    0:
    begin
      {$ifdef SupportStyles}TStyleManager.SetStyle('Windows');{$endif}
      EsGroupBar1.GroupStyle.AssignDefaultStyle;
    end;
    1:
    begin
      {$ifdef SupportStyles}TStyleManager.TrySetStyle('Ruby Graphite');{$endif}
      EsGroupBar1.GroupStyle.LoadStyleFromResource(hInstance, 'RubyGraphiteStyle', RT_RCDATA);
    end;
    2:
    begin
      {$ifdef SupportStyles}TStyleManager.TrySetStyle({$ifdef Win10Styles}'Windows10'{$else}'Light'{$endif});{$endif}
      EsGroupBar1.GroupStyle.LoadStyleFromResource(hInstance, 'Modern', RT_RCDATA);
    end;
    3:
    begin
      {$ifdef SupportStyles}TStyleManager.TrySetStyle({$ifdef Win10Styles}'Windows10 Dark'{$else}'Metropolis UI Dark'{$endif});{$endif}
      EsGroupBar1.GroupStyle.LoadStyleFromResource(hInstance, 'ModernDark', RT_RCDATA);
    end;
    4:
    begin
      {$ifdef SupportStyles}TStyleManager.TrySetStyle({$ifdef Win10Styles}'Windows10 Blue'{$else}'Metropolis UI Blue'{$endif});{$endif}
      EsGroupBar1.GroupStyle.LoadStyleFromResource(hInstance, 'ModernBlue', RT_RCDATA);
    end;
  end;

  chShowSeparator.Checked := EsGroupBar1.GroupStyle.ShowSeparator;
  chUnderlineHotItem.Checked := EsGroupBar1.GroupStyle.UnderlineHotItem;
  chTextGlow.Checked := EsGroupBar1.GroupStyle.TextGlow;
  chAccuracyItemHitTest.Checked := EsGroupBar1.GroupStyle.AccuracyItemHitTest;
end;

end.
