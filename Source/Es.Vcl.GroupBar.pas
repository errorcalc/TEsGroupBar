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
unit Es.Vcl.GroupBar;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Generics.Collections,
   Es.Vcl.BaseControls, Es.Vcl.CfxClasses, Es.Vcl.ExGraphics, PngImage, Dialogs, ImgList, ActnList
   {$if CompilerVersion >= 23}, UITypes{$ifend};

type
  // Button style
  TEsGroupButtonState = (bsNormalOpen, bsNormalOpenHot, bsNormalClose, bsNormalCloseHot,
    bsSelectedOpen, bsSelectedOpenHot, bsSelectedClose, bsSelectedCloseHot);
  TEsGroupButtonStyle = class(TStyleNinePath)
  private
    FWidth: Integer;
    FHeight: Integer;
    FOffsetLeft: Cardinal;
    procedure SetHeight(const Value: Integer);
    procedure SetWidth(const Value: Integer);
    function GetOverlay(const Index: Integer): TPngImage;
    procedure SetOverlay(const Index: Integer; const Value: TPngImage);
    procedure SetOffsetLeft(const Value: Cardinal);
    function IsStyleStored: Boolean;
  protected
    function GetStateCount: Integer; override;
    procedure AssignDefaultValues; override;
    function GetStylePrefix: string; override;
  public
    procedure Draw(Canvas: TCanvas; Rect: TRect; State: TEsGroupButtonState; Alpha: Byte = 255); reintroduce;
    property OnChange;
  published
    property ImageNormalOpen: TPngImage index bsNormalOpen read GetOverlay write SetOverlay;
    property ImageNormalOpenHot: TPngImage index bsNormalOpenHot read GetOverlay write SetOverlay;
    property ImageNormalClose: TPngImage index bsNormalClose read GetOverlay write SetOverlay;
    property ImageNormalCloseHot: TPngImage index bsNormalCloseHot read GetOverlay write SetOverlay;
    property ImageSelectedOpen: TPngImage index bsSelectedOpen read GetOverlay write SetOverlay;
    property ImageSelectedOpenHot: TPngImage index bsSelectedOpenHot read GetOverlay write SetOverlay;
    property ImageSelectedClose: TPngImage index bsSelectedClose read GetOverlay write SetOverlay;
    property ImageSelectedCloseHot: TPngImage index bsSelectedCloseHot read GetOverlay write SetOverlay;
    property IsDefaultStyle;
    property Width: Integer read FWidth write SetWidth stored IsStyleStored default 16;
    property Height: Integer read FHeight write SetHeight stored IsStyleStored default 16;
    property OffsetLeft: Cardinal read FOffsetLeft write SetOffsetLeft stored IsStyleStored default 1;
  end;

  // GroupSelectStyle
  TEsGroupSelectState = (gssNormal, gssHot, gssDown);//, gssSelected);
  TEsGroupSelectStyle = class(TStyleNinePath)
  private
    FHeight: Cardinal;
    FShowHotSelector: Boolean;
    function GetImage(const Index: Integer): TPngImage;
    procedure SetImage(const Index: Integer; const Value: TPngImage);
    function IsStyleStored: Boolean;
    procedure SetHeight(const Value: Cardinal);
    procedure SetShowHotSelector(const Value: Boolean);
  protected
    function GetStateCount: Integer; override;
    procedure AssignDefaultValues; override;
    function GetStylePrefix: string; override;
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure Draw(Canvas: TCanvas; Rect: TRect; State: TEsGroupSelectState; Alpha: Byte = 255); reintroduce;
    property OnChange;
  published
    property ImageSelector: TPngImage index gssNormal read GetImage write SetImage;
    property ImageHotSelector: TPngImage index gssHot read GetImage write SetImage;
    property ImageDownSelector: TPngImage index gssDown read GetImage write SetImage;
    property ImageMargins;
    property ImageMode;
    property IsDefaultStyle;
    property Height: Cardinal read FHeight write SetHeight stored IsStyleStored default 18;
    property ShowHotSelector: Boolean read FShowHotSelector write SetShowHotSelector default False;
  end;

  // ItemSeparatorStyle
  TEsItemSeparatorState = (issNormal, issSelected);
  TEsGroupItemSeparatorStyle = class(TStyleNinePath)
  private
    FHeight: Cardinal;
    function GetImage(const Index: Integer): TPngImage;
    procedure SetImage(const Index: Integer; const Value: TPngImage);
    procedure SetHeight(const Value: Cardinal);
    function IsStyleStored: Boolean;
  protected
    function GetStateCount: Integer; override;
    procedure AssignDefaultValues; override;
    function GetStylePrefix: string; override;
  public
    procedure Draw(Canvas: TCanvas; Rect: TRect; State: TEsItemSeparatorState; Alpha: Byte = 255); reintroduce;
    property OnChange;
  published
    property ImageNormal: TPngImage index issNormal read GetImage write SetImage;
    property ImageSelected: TPngImage index issSelected read GetImage write SetImage;
    property ImageMargins;
    property IsDefaultStyle;
    property ImageMode default TStretchMode.smTile;
    property Height: Cardinal read FHeight write SetHeight stored IsStyleStored default 1;
  end;

  // GroupBackgroundStyle
  TEsGroupBackgroundState = (gbsNormal, gbsSelected);
  TEsGroupBackgroundStyle = class(TStyleNinePath)
  private
    function GetImage(const Index: Integer): TPngImage;
    function GetOverlay(const Index: Integer): TPngImage;
    procedure SetImage(const Index: Integer; const Value: TPngImage);
    procedure SetOverlay(const Index: Integer; const Value: TPngImage);
  protected
    function GetStateCount: Integer; override;
    procedure AssignDefaultValues; override;
    function GetStylePrefix: string; override;
  public
    procedure Draw(Canvas: TCanvas; Rect: TRect; State: TEsGroupBackgroundState; Alpha: Byte = 255); reintroduce;
    property OnChange;
  published
    property ImageNormal: TPngImage index gbsNormal read GetImage write SetImage;
    property ImageSelected: TPngImage index gbsSelected read GetImage write SetImage;
    property OverlayNormal: TPngImage index gbsNormal read GetOverlay write SetOverlay;
    property OverlaySelected: TPngImage index gbsSelected read GetOverlay write SetOverlay;
    property ImageMargins;
    property OverlayMargins;
    property IsDefaultStyle;
  end;

  TChangeOptionsEvent = procedure (Sender: TObject; Rebuld: Boolean) of object;

  // TEsGroupStyle
  TEsGroupStyle = class(TPersistent)
  private
    FControl: TControl;
    FOnChange: TChangeOptionsEvent;
    //
    FButtonStyle: TEsGroupButtonStyle;
    FItemHotColor: TColor;
    FParentHeaderFont: Boolean;
    FHeaderHeight: Cardinal;
    FPadding: TStylePadding;
    FItemHeight: Cardinal;
    FItemSeparatorStyle: TEsGroupItemSeparatorStyle;
    FItemImageOffset: Cardinal;
    FSelectStyle: TEsGroupSelectStyle;
    FBackgroundStyle: TEsGroupBackgroundStyle;
    FHeaderPadding: TStylePadding;
    FHeaderFont: TFont;
    FShowSeparator: Boolean;
    FItemColor: TColor;
    FHeaderTextAlignment: TAlignment;
    FHeaderTextSelectedColor: TColor;
    FHeaderTextColor: TColor;
    FItemDisabledColor: TColor;
    FSelectedItemColor: TColor;
    FSelectedItemHotColor: TColor;
    FSelectedItemSelectedColor: TColor;
    FAccuracyItemHitTest: Boolean;
    FUnderlineHotItem: Boolean;
    FItemSelectedColor: TColor;
    FItemOffset: Cardinal;
    FDisableInactiveGroup: Boolean;
    FTextGlow: Boolean;
    procedure SetButtonStyle(const Value: TEsGroupButtonStyle);
    procedure SetBackgroundStyle(const Value: TEsGroupBackgroundStyle);
    procedure SetHeaderFont(const Value: TFont);
    procedure SetHeaderHeight(const Value: Cardinal);
    procedure SetHeaderPadding(const Value: TStylePadding);
    procedure SetItemColor(const Value: TColor);
    procedure SetItemHeight(const Value: Cardinal);
    procedure SetItemHotColor(const Value: TColor);
    procedure SetItemImageOffset(const Value: Cardinal);
    procedure SetItemSeparatorStyle(const Value: TEsGroupItemSeparatorStyle);
    procedure SetPadding(const Value: TStylePadding);
    procedure SetParentHeaderFont(const Value: Boolean);
    procedure SetSelectStyle(const Value: TEsGroupSelectStyle);
    procedure SetShowSeparator(const Value: Boolean);
    procedure SetControl(const Value: TControl);
    procedure SetHeaderTextAlignment(const Value: TAlignment);
    function IsPaddingStored: Boolean;
    function IsHeaderPaddingStored: Boolean;
    //
    procedure HeaderFontChange(Sender: TObject);
    function IsHeaderFontStored: Boolean;
    procedure SetHeaderTextColor(const Value: TColor);
    procedure SetHeaderTextSelectedColor(const Value: TColor);
    procedure SetItemDisabledColor(const Value: TColor);
    procedure SetSelectedItemColor(const Value: TColor);
    procedure SetSelectedItemHotColor(const Value: TColor);
    procedure SetSelectedItemSelectedColor(const Value: TColor);
    procedure SetAccuracyItemHitTest(const Value: Boolean);
    procedure SetUnderlineHotItem(const Value: Boolean);
    procedure SetItemSelectedColor(const Value: TColor);
    procedure SetItemOffset(const Value: Cardinal);
    procedure SetDisableInactiveGroup(const Value: Boolean);
    procedure SetTextGlow(const Value: Boolean);
    //
  protected
    procedure Change(Rebild: Boolean);
    procedure SimpleChange(Sender: TObject);
    procedure RebildChange(Sender: TObject);
    //
    procedure AssignDefaultProperties;
  public
    constructor Create(Control: TWinControl = nil);
    destructor Destroy; override;
    procedure AssignDefaultImages;
    procedure AssignHeaderFont(Font: TFont);
    // Styles
    procedure LoadStyleFormStream(Stream: TStream);
    procedure LoadStyleFormFile(FileName: string);
    procedure LoadStyleFromResource(Instance: HINST; const ResourceName: string; ResourceType: PChar);
    procedure AssignDefaultStyle;
    //
    property Control: TControl read FControl write SetControl;
    property OnChange: TChangeOptionsEvent read FOnChange write FOnChange;
  published
    // Header
    property HeaderHeight: Cardinal read FHeaderHeight write SetHeaderHeight default 21;
    property HeaderPadding: TStylePadding read FHeaderPadding write SetHeaderPadding stored IsHeaderPaddingStored;
    //property HeaderTextLayout: TTextLayout read FHeaderTextLayout write SetHeaderTextLayout;
    property HeaderTextAlignment: TAlignment read FHeaderTextAlignment write SetHeaderTextAlignment default TAlignment.taLeftJustify;
    //property HeaderTextHorzLayout: THorzLayot
    property HeaderFont: TFont read FHeaderFont write SetHeaderFont stored IsHeaderFontStored;
    property ParentHeaderFont: Boolean read FParentHeaderFont write SetParentHeaderFont default True;
    property HeaderTextColor: TColor read FHeaderTextColor write SetHeaderTextColor default clBlack;
    property HeaderTextSelectedColor: TColor read FHeaderTextSelectedColor write SetHeaderTextSelectedColor default $00BB3300;
    // Item
    property ItemHeight: Cardinal read FItemHeight write SetItemHeight default 20;
    property ItemColor: TColor read FItemColor write SetItemColor default clBlack;
    property SelectedItemColor: TColor read FSelectedItemColor write SetSelectedItemColor default clBlack;
    property ItemHotColor: TColor read FItemHotColor write SetItemHotColor default $00F26E00;
    property SelectedItemHotColor: TColor read FSelectedItemHotColor write SetSelectedItemHotColor default $00F26E00;
    property ItemSelectedColor: TColor read FItemSelectedColor write SetItemSelectedColor default $00FFFFFF;
    property SelectedItemSelectedColor: TColor read FSelectedItemSelectedColor write SetSelectedItemSelectedColor default $00FFFFFF;
    property ItemDisabledColor: TColor read FItemDisabledColor write SetItemDisabledColor default $008D8D8D;
    property ItemImageOffset: Cardinal read FItemImageOffset write SetItemImageOffset default 6;
    property ItemOffset: Cardinal read FItemOffset write SetItemOffset default 6;
    //
    property TextGlow: Boolean read FTextGlow write SetTextGlow default False;
    //
    property AccuracyItemHitTest: Boolean read FAccuracyItemHitTest write SetAccuracyItemHitTest default True;
    property UnderlineHotItem: Boolean read FUnderlineHotItem write SetUnderlineHotItem default False;
    // Internal
    property Padding: TStylePadding read FPadding write SetPadding stored IsPaddingStored;
    property ShowSeparator: Boolean read FShowSeparator write SetShowSeparator default False;
    property DisableInactiveGroup: Boolean read FDisableInactiveGroup write SetDisableInactiveGroup default False;
    // Styles
    property BackgroundStyle: TEsGroupBackgroundStyle read FBackgroundStyle write SetBackgroundStyle;
    /// <summary>  This property is deprecated please use BackgroundStyle </summary>
    property GroupStyle: TEsGroupBackgroundStyle read FBackgroundStyle write SetBackgroundStyle stored False;// deprecated
    property ItemSeparatorStyle: TEsGroupItemSeparatorStyle read FItemSeparatorStyle write SetItemSeparatorStyle;
    property SelectStyle: TEsGroupSelectStyle read FSelectStyle write SetSelectStyle;
    property ButtonStyle: TEsGroupButtonStyle read FButtonStyle write SetButtonStyle;
  end;

  EEsGroupBarError = class(Exception);
  TEsGroupSpace = 0..100;
  TEsGroupBar = class;
  TEsGroup = class;
  TEsGroupItem = class;

  // TEsGroupItemActionLink
  TEsGroupItemActionLink = class(TActionLink)
  protected
    FClient: TEsGroupItem;
    procedure AssignClient(AClient: TObject); override;
    //
    function IsCaptionLinked: Boolean; override;
    function IsCheckedLinked: Boolean; override;
    function IsEnabledLinked: Boolean; override;
    function IsVisibleLinked: Boolean; override;
    function IsHintLinked: Boolean; override;
    function IsImageIndexLinked: Boolean; override;
    function IsOnExecuteLinked: Boolean; override;
    //
    procedure SetCaption(const Value: string); override;
    procedure SetChecked(Value: Boolean); override;
    procedure SetEnabled(Value: Boolean); override;
    procedure SetVisible(Value: Boolean); override;
    procedure SetHint(const Value: string); override;
    procedure SetImageIndex(Value: Integer); override;
    procedure SetOnExecute(Value: TNotifyEvent); override;
  end;

  // TEsGroupItem
  TEsGroupItem = class(TCollectionItem)
  private
    FCaption: string;
    FImageIndex: TImageIndex;
    FHint: string;
    FOnClick: TNotifyEvent;
    FEnabled: Boolean;
    FTag: LongInt;
    FSelected: Boolean;
    FActionLink: TEsGroupItemActionLink;
    FVisible: Boolean;

    procedure SetCaption(const Value: string);
    procedure SetEnabled(const Value: Boolean);
    procedure SetHint(const Value: string);
    procedure SetImageIndex(const Value: TImageIndex);
    function GetAction: TBasicAction;
    procedure SetAction(const Value: TBasicAction);
    procedure SetSelected(const Value: Boolean);
    procedure SetVisible(const Value: Boolean);
    procedure ActionChange(Sender: TObject; CheckDefaults: Boolean);
    procedure ActionHandler(Sender: TObject);
    //
    function IsOnClickStored: Boolean;
    function IsEnabledStored: Boolean;
    function IsImageIndexStored: Boolean;
    function IsHintStored: Boolean;
    function IsCaptionStored: Boolean;
    function GetGroup: TEsGroup;
    function IsVisibleStored: Boolean;
    function GetIsActive: Boolean;
    //
  protected
    function GetDisplayName: string; override;
    procedure SetIndex(Value: Integer); override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Click;
    procedure InitiateAction;
    procedure ResetSelection;
    procedure AssignTo(Dest: TPersistent); override;
    property ActionLink: TEsGroupItemActionLink read FActionLink write FActionLink;
    property Group: TEsGroup read GetGroup;
    property IsActive: Boolean read GetIsActive;
  published
    property Action: TBasicAction read GetAction write SetAction;
    property Caption: string read FCaption write SetCaption stored IsCaptionStored;
    property Hint: string read FHint write SetHint stored IsHintStored;
    property Visible: Boolean read FVisible write SetVisible stored IsVisibleStored default True;
    property ImageIndex: TImageIndex read FImageIndex write SetImageIndex stored IsImageIndexStored default -1;
    property Tag: LongInt read FTag write FTag default 0;
    property OnClick: TNotifyEvent read FOnClick write FOnClick stored IsOnClickStored;
    property Enabled: Boolean read FEnabled write SetEnabled stored IsEnabledStored default True;
    property Selected: Boolean read FSelected write SetSelected default False;
  end;

  // TEsGroupItems
  TEsGroupItems = class(TCollection)
  private
    FGroup: TEsGroup;
    function GetItem(Index: Integer): TEsGroupItem;
    procedure SetItem(Index: Integer; const Value: TEsGroupItem);
  protected
    procedure Update(Item: TCollectionItem); override;
    function GetOwner: TPersistent; override;
  public
    constructor Create(Group: TEsGroup);
    function Add: TEsGroupItem;
    property Items[Index: Integer]: TEsGroupItem read GetItem write SetItem; default;
    property Group: TEsGroup read FGroup;
  end;

  TEsGroup = class(TEsCustomControl)
  type
    TButtonState = (bsNormal, bsDown, bsHot);
  private
    // Internal
    ButtonState: TButtonState;
    IsClicked: Boolean;
    OverItem: TEsGroupItem;
    FGroupBar: TEsGroupBar;
    ImagesChangeLink: TChangeLink;
    IsChanging: Boolean;
    //
    FItemIndex: Integer;
    // To published
    FItems: TEsGroupItems;
    FExpanded: Boolean;
    FImages: TCustomImageList;
    FShowSelection: Boolean;
    //
    class constructor Create;
    // Handle messages
    procedure WMWindowPosChanged(var Message: TWMWindowPosChanged); message WM_WINDOWPOSCHANGED;
    procedure CMDesignHitTest(var Message: TCMDesignHitTest); message CM_DESIGNHITTEST;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CMVisibleChanged(var Message: TMessage); message CM_VISIBLECHANGED;
    // Setters/Getters (Internal)
    function GetContentRect: TRect;// Options!
    function GetButtonRect: TRect;// Options!
    function GetHeaderRect: TRect;// Options!
    //---
    procedure SetGroupBar(const Value: TEsGroupBar);
    function GetOptions: TEsGroupStyle;
    function GetImageList: TCustomImageList;
    // Internal
    procedure ImagesChange(Sender: TObject);
    function CanCloseByUser: Boolean;
    // Setters/Getters (Published)
    procedure SetGroupIndex(const Value: Integer);
    function GetGroupIndex: Integer;
    procedure SetExpanded(const Value: Boolean);
    procedure SetItems(const Value: TEsGroupItems);
    procedure SetImages(const Value: TCustomImageList);
    procedure SetShowItemSelection(const Value: Boolean);
    function IsShowItemSelection: Boolean;
    procedure SetItemIndex(const Value: Integer);
    function GetShowItemSelection: Boolean;
  protected
    // Internal Properties
    property Options: TEsGroupStyle read GetOptions; // Options!
    property ContentRect: TRect read GetContentRect;// Options!
    property ButtonRect: TRect read GetButtonRect;// Options!
    property HeaderRect: TRect read GetHeaderRect;// Options!
    property ImageList: TCustomImageList read GetImageList;
    // Internal f/p
    function ItemRect(Index: Integer; Accuracy: Boolean = False): TRect;// Options!
    function ItemAtPos(X, Y: Integer): TEsGroupItem;// Options!
    function IsActiveGroup: Boolean;
    procedure CalcHeight;// Options-test
    procedure UpdateBounds;
    // Handle control f/p
    procedure UpdateText; override;
    procedure Loaded; override;
    procedure ReadState(Reader: TReader); override;
    procedure CreateWnd; override;
    procedure Resize; override;
    procedure SetParent(AParent: TWinControl); override;
    procedure Paint; override;// Options-test
    // mouse events
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    // Handle control f/p
    procedure InitiateAction; override;
    //
    function IsEmptyGroup: Boolean;
    //
    function IsSelected: Boolean;
    procedure Open;
    procedure Close;
    procedure View;
    //
    property GroupBar: TEsGroupBar read FGroupBar write SetGroupBar;
  published
    property GroupIndex: Integer read GetGroupIndex write SetGroupIndex stored False;
    //
    property Width stored False;
    property Height stored False;
    property Left stored False;
    property Top stored False;
    //
    property ShowItemSelection: Boolean read GetShowItemSelection write SetShowItemSelection stored IsShowItemSelection default False;
    //
    property Visible;
    property Caption;
    //
    property Items: TEsGroupItems read FItems write SetItems;
    property Expanded: Boolean read FExpanded write SetExpanded default True;
    property Images: TCustomImageList read FImages write SetImages;
    //
    property ItemIndex: Integer read FItemIndex write SetItemIndex stored False;
    // inherited
    property BiDiMode;
    property DragCursor;
    property DragMode;
    property ParentBiDiMode;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Touch;

    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGesture;
    property OnMouseActivate;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnStartDrag;
  end;

  // TEsGroupBar
  TEsGroupBar = class(TScrollingWinControl)
  private
    IsChangingActiveBar: Boolean;
    IsUpdatingBounds: Boolean;
    Pos: Integer;
    GroupList: TList<TEsGroup>;
    FGroupVerticalSpace: TEsGroupSpace;
    FGroupHorizontalSpace: TEsGroupSpace;
    FGroupStyle: TEsGroupStyle;
    FImages: TCustomImageList;
    ImagesChangeLink: TChangeLink;
    FUniqueItemSelection: Boolean;
    FHighlightSelectedGroup: Boolean;
    FAutoHideEmptyGroup: Boolean;
    FCanCloseGroup: Boolean;
    //
    {$if CompilerVersion >= 23}
    class constructor Create;
    class destructor Destroy;
    {$endif}
    //
    procedure WMVScroll(var Message: TWMVScroll); message WM_VSCROLL;
    procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
    procedure WMMouseWheel(var Message: TWMMouseWheel); message WM_MOUSEWHEEL;
    procedure WMEraseBkgnd(var Message: TWmEraseBkgnd); message WM_ERASEBKGND;
    procedure CMControlListChanging(var Message: TCMControlListChanging); message CM_CONTROLLISTCHANGING;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure WMPaint(var Message: TWmPaint); message WM_PAINT;
    procedure SetGroupHorizontalSpace(const Value: TEsGroupSpace);
    procedure SetGroupVerticalSpace(const Value: TEsGroupSpace);
    procedure SetGroupStyle(const Value: TEsGroupStyle);
    procedure SetImages(const Value: TCustomImageList);
    procedure ImagesChange(Sender: TObject);
    procedure SetUniqueItemSelection(const Value: Boolean);
    procedure SetHighlightSelectedGroup(const Value: Boolean);
    //
    procedure InternalSelect(Index: Integer);
    function GetGroup(Index: Integer): TEsGroup;
    function GetGroupCount: Integer;
    procedure SetAutoHideEmptyGroup(const Value: Boolean);
    procedure SetCanCloseGroup(const Value: Boolean);
  protected
    procedure Loaded; override;
    procedure PaintWindow(DC: HDC); override;
    //
    procedure SetChildOrder(Child: TComponent; Order: Integer); override;
    //
    procedure CreateWnd; override;
    procedure Resize; override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure UpdateBounds;
    //
    procedure ChangeOptons(Sender: TObject; Rebild: Boolean);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    //
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
    //
    procedure AddGroup(Group: TEsGroup);
    procedure InsertGroup(Index: Integer; Group: TEsGroup);
    procedure RemoveGroup(Group: TEsGroup);
    //
    procedure ScrollToGroup(Group: TEsGroup);
    procedure ResetScrollPos;
    //
    procedure CloseAllGroups;
    procedure OpenAllGroups;
    //
    property Groups[Index: Integer]: TEsGroup read GetGroup;
    property GroupCount: Integer read GetGroupCount;
    //
    property DockManager;
  published
    // new
    property GroupStyle: TEsGroupStyle read FGroupStyle write SetGroupStyle;
    /// <summary>  This property is deprecated please use BackgroundStyle </summary>
    property GroupOptions: TEsGroupStyle read FGroupStyle write SetGroupStyle stored False;// depracated
    //
    property UniqueItemSelection: Boolean read FUniqueItemSelection write SetUniqueItemSelection default False;
    //
    property AutoHideEmptyGroup: Boolean read FAutoHideEmptyGroup write SetAutoHideEmptyGroup default False;
    //
    property CanCloseGroup: Boolean read FCanCloseGroup write SetCanCloseGroup default True;
    //
    property Images: TCustomImageList read FImages write SetImages;
    property HighlightSelectedGroup: Boolean read FHighlightSelectedGroup write SetHighlightSelectedGroup default False;

    property GroupVerticalSpace: TEsGroupSpace read FGroupVerticalSpace write SetGroupVerticalSpace default 2;
    property GroupHorizontalSpace: TEsGroupSpace read FGroupHorizontalSpace write SetGroupHorizontalSpace default 2;
    // inherited
    property Align;
    property Anchors;
    property Height;
    property Width;
    property Color;
    property Visible;
    property HorzScrollBar stored False;
    property VertScrollBar stored False;
    property OnMouseWheelDown;
    property AutoSize;
    property BiDiMode;
    property BorderWidth;
    property Caption;
    property Constraints;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property ParentBiDiMode;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Touch;
    {$if CompilerVersion >= 24}
    property StyleElements;
    {$endif}
    //
    property OnMouseActivate;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnEnter;
    property OnExit;
    property OnCanResize;
    property OnClick;
    property OnConstrainedResize;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnStartDrag;
    property OnEndDrag;
    property OnGesture;
    property OnResize;
  end;

implementation

{$R 'DefaultStyle/EsGroupBarCfx.res'}


uses
  Es.Vcl.Utils,
{$if CompilerVersion >= 23}
  Themes
{$endif}
;
{ TEsGroupBar }

constructor TEsGroupBar.Create(AOwner: TComponent);
begin
  inherited;
  GroupList := TList<TEsGroup>.Create;
  Pos := 0;

  ControlStyle := ControlStyle + [csAcceptsControls];
  AutoScroll := False;
  VertScrollBar.Tracking := True;
  VertScrollBar.Smooth := True;
  DisableAutoRange;

  FGroupVerticalSpace := 2;
  FGroupHorizontalSpace := 2;

  FGroupStyle := TEsGroupStyle.Create(Self);
  FGroupStyle.OnChange := ChangeOptons;
  FGroupStyle.AssignHeaderFont(Font);
  //
  ImagesChangeLink := TChangeLink.Create;
  ImagesChangeLink.OnChange := ImagesChange;
  //
  FCanCloseGroup := True;

  GroupStyle.AssignDefaultImages;
end;

procedure TEsGroupBar.AddGroup(Group: TEsGroup);
begin
  Group.Parent := Self;
  Group.FGroupBar := Self;
  GroupList.Add(Group);
  Group.CalcHeight;
end;

procedure TEsGroupBar.RemoveGroup(Group: TEsGroup);
begin
  Group.FGroupBar := nil;
  GroupList.Remove(Group);
  UpdateBounds;
end;

{$if CompilerVersion >= 23}
class constructor TEsGroupBar.Create;
begin
  TCustomStyleEngine.RegisterStyleHook(TEsGroupBar, TScrollBoxStyleHook);
end;
{$endif}

procedure TEsGroupBar.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);

  Params.Style := Params.Style or WS_CLIPCHILDREN;
end;

procedure TEsGroupBar.CreateWnd;
begin
  inherited;
  UpdateBounds;
end;

{$if CompilerVersion >= 23}
class destructor TEsGroupBar.Destroy;
begin
  TCustomStyleEngine.UnRegisterStyleHook(TEsGroupBar, TScrollBoxStyleHook);
end;
{$endif}

destructor TEsGroupBar.Destroy;
var
  I: Integer;
begin
  for I := 0 to GroupList.Count - 1 do
    GroupList[I].FGroupBar := nil;
  GroupList.Free;

  FGroupStyle.Free;

  ImagesChangeLink.free;
  inherited;
end;

procedure TEsGroupBar.GetChildren(Proc: TGetChildProc; Root: TComponent);
var
  I: Integer;
begin
  for I := 0 to GroupList.Count - 1 do
    Proc(GroupList[I]);
end;

function TEsGroupBar.GetGroup(Index: Integer): TEsGroup;
begin
  Result := GroupList[Index];
end;

function TEsGroupBar.GetGroupCount: Integer;
begin
  Result := GroupList.Count;
end;

procedure TEsGroupBar.ImagesChange(Sender: TObject);
var
  I: Integer;
begin
  for I := 0 to GroupList.Count - 1 do
    GroupList[I].Invalidate;
end;

procedure TEsGroupBar.InsertGroup(Index: Integer; Group: TEsGroup);
begin
  Group.Parent := Self;
  Group.FGroupBar := Self;
  GroupList.Insert(Index, Group);
  UpdateBounds;
end;

procedure TEsGroupBar.InternalSelect(Index: Integer);
var
  I: Integer;
begin
  if UniqueItemSelection and not IsChangingActiveBar then
  begin
    IsChangingActiveBar := True;
    try
      for I := 0 to GroupList.Count - 1 do
        if Index <> I then
          GroupList[I].ItemIndex := -1;
    finally
      IsChangingActiveBar := False;
    end;
  end;
end;

procedure TEsGroupBar.Loaded;
begin
  inherited;
  UpdateBounds;
end;

procedure TEsGroupBar.OpenAllGroups;
var
  I: Integer;
begin
  for I := 0 to GroupList.Count - 1 do
    GroupList[I].Open;
end;

procedure TEsGroupBar.PaintWindow(DC: HDC);
begin
  Inherited;
  //FillRect(DC, ClientRect, Brush.Handle);
end;

procedure TEsGroupBar.ResetScrollPos;
begin
  VertScrollBar.Position := 0;
end;

procedure TEsGroupBar.Resize;
begin
  inherited;
  UpdateBounds;
end;

procedure TEsGroupBar.ScrollToGroup(Group: TEsGroup);
begin
  ScrollInView(Group);
end;

procedure TEsGroupBar.SetAutoHideEmptyGroup(const Value: Boolean);
begin
  if FAutoHideEmptyGroup <> Value then
  begin
    FAutoHideEmptyGroup := Value;
    UpdateBounds;
  end;
end;

procedure TEsGroupBar.SetCanCloseGroup(const Value: Boolean);
var
  I: Integer;
begin
  if FCanCloseGroup <> Value then
  begin
    FCanCloseGroup := Value;
    for I := 0 to GroupList.Count - 1 do
      GroupList[I].Invalidate;
  end;
end;

procedure TEsGroupBar.SetChildOrder(Child: TComponent; Order: Integer);
begin
  inherited;
  TEsGroup(Child).GroupIndex := Order;
end;

procedure TEsGroupBar.SetGroupHorizontalSpace(const Value: TEsGroupSpace);
begin
  if FGroupHorizontalSpace <> Value then
  begin
    FGroupHorizontalSpace := Value;
    UpdateBounds;
  end;
end;

procedure TEsGroupBar.SetGroupStyle(const Value: TEsGroupStyle);
begin
  FGroupStyle.Assign(Value);
end;

procedure TEsGroupBar.SetGroupVerticalSpace(const Value: TEsGroupSpace);
begin
  if FGroupVerticalSpace <> Value then
  begin
    FGroupVerticalSpace := Value;
    UpdateBounds;
  end;
end;

procedure TEsGroupBar.SetHighlightSelectedGroup(const Value: Boolean);
var
  I: Integer;
begin
  if FHighlightSelectedGroup <> Value then
  begin
    FHighlightSelectedGroup := Value;
    for I := 0 to GroupList.Count - 1 do
      GroupList[I].Invalidate;
  end;
end;

procedure TEsGroupBar.SetImages(const Value: TCustomImageList);
var
  I: Integer;
begin
  if FImages <> nil then
    FImages.UnRegisterChanges(ImagesChangeLink);

  FImages := Value;

  if FImages <> nil then
  begin
    FImages.UnRegisterChanges(ImagesChangeLink);
    FImages.FreeNotification(Self);
  end;

  for I := 0 to GroupList.Count - 1 do
    GroupList[I].Invalidate;
end;

procedure TEsGroupBar.SetUniqueItemSelection(const Value: Boolean);
begin
  if FUniqueItemSelection <> Value then
  begin
    FUniqueItemSelection := Value;
    InternalSelect(-1);
  end;
end;

procedure TEsGroupBar.UpdateBounds;
var
  I, Y, H: Integer;
  TotalHeight: Integer;
begin
  IsUpdatingBounds := True;

  try
    TotalHeight := GroupVerticalSpace;
    for I := 0 to GroupList.Count - 1 do
      if (csDesigning in GroupList[I].ComponentState) or GroupList[I].Visible then
        TotalHeight := TotalHeight + GroupList[I].Height + GroupVerticalSpace;

    Y := GroupVerticalSpace - VertScrollBar.ScrollPos;

    I := 0;
    while I < GroupList.Count do
    begin
      if (csDesigning in GroupList[I].ComponentState) or GroupList[I].Visible then
      begin
        if (not AutoHideEmptyGroup) or (not GroupList[I].IsEmptyGroup) or (csDesigning in GroupList[I].ComponentState) then
        begin
          H := GroupList[I].Height;
          GroupList[I].SetBounds(GroupHorizontalSpace, Y, ClientWidth - GroupHorizontalSpace * 2, H);
          Y := Y + H + GroupVerticalSpace;
        end else
        begin
          GroupList[I].SetBounds(GroupHorizontalSpace, Y, ClientWidth - GroupHorizontalSpace * 2, 0);
        end;
      end;
      Inc(I);
    end;

    VertScrollBar.Range := TotalHeight;
  finally
    IsUpdatingBounds := False;
  end;

end;

procedure TEsGroupBar.ChangeOptons(Sender: TObject; Rebild: Boolean);
var
  I: Integer;
begin
  if not (csLoading in ComponentState) then
  begin
    if Rebild then
    begin
      for I := 0 to GroupList.Count - 1 do
      begin
        GroupList[I].CalcHeight;
        GroupList[I].Invalidate;
      end;
      //UpdateBounds;
    end else
      for I := 0 to GroupList.Count - 1 do
        GroupList[I].Invalidate;
  end;
end;

procedure TEsGroupBar.CloseAllGroups;
var
  I: Integer;
begin
  for I := 0 to GroupList.Count - 1 do
    GroupList[I].Close;
end;

procedure TEsGroupBar.CMControlListChanging(var Message: TCMControlListChanging);
begin
  if (csDesigning in ComponentState) and Message.Inserting and (Message.ControlListItem^.Parent = Self) and
     not (Message.ControlListItem^.Control is TEsGroup) then
      raise EEsGroupBarError.Create('Only TEsGroup is child in TEsGroupBar');
end;

procedure TEsGroupBar.CMFontChanged(var Message: TMessage);
begin
  Inherited;

  if GroupStyle.ParentHeaderFont then
  begin
    GroupStyle.AssignHeaderFont(Font);
  end;
end;

procedure TEsGroupBar.WMEraseBkgnd(var Message: TWmEraseBkgnd);
begin
  Inherited;
end;

procedure TEsGroupBar.WMMouseWheel(var Message: TWMMouseWheel);
begin
  VertScrollBar.Position := VertScrollBar.Position - Message.WheelDelta;
  Message.Result := 1;
end;

procedure TEsGroupBar.WMNCHitTest(var Message: TWMNCHitTest);
begin
  DefaultHandler(Message);
end;

procedure TEsGroupBar.WMPaint(var Message: TWmPaint);
begin
  Inherited;
end;

procedure TEsGroupBar.WMVScroll(var Message: TWMVScroll);
begin
  Inherited;
  if csDesigning in ComponentState then
    if GetParentForm(Self).Designer <> nil then
      GetParentForm(Self).Designer.Modified;

  Repaint;
end;

{ TEsGroup }

constructor TEsGroup.Create(AOwner: TComponent);
begin
  inherited;
  ControlStyle := ControlStyle + [csSetCaption, csActionClient];
  ParentBackground := False;
  Height := 100;
  FExpanded := True;
  FItems := TEsGroupItems.Create(Self);
  ImagesChangeLink := TChangeLink.Create;
  ImagesChangeLink.OnChange := ImagesChange;
  FItemIndex := -1;
end;

procedure TEsGroup.CalcHeight;
var
  NewHeight: Integer;
  I: Integer;
begin
  if Options <> nil then
  begin
    // for auto hide
    if GroupBar.AutoHideEmptyGroup and IsEmptyGroup then
    begin
      Height := 0;
      Exit;
    end;

    NewHeight := Options.HeaderHeight;

    if Expanded then
    begin
      NewHeight := NewHeight + Options.Padding.Top + Options.Padding.Bottom;
      for I := 0 to Items.Count - 1 do
      begin
        if not Items[I].Visible then
          continue;
        NewHeight := NewHeight + Integer(Options.ItemHeight);
        if Options.ShowSeparator and (I <> 0) then
          NewHeight := NewHeight + Integer(Options.ItemSeparatorStyle.Height);
      end;
    end;

    if NewHeight <> Height then
      Height := NewHeight;
  end;
end;

class constructor TEsGroup.Create;
begin
  Classes.RegisterClasses([TEsGroup]);
end;

procedure TEsGroup.CreateWnd;
begin
  inherited;
end;

destructor TEsGroup.Destroy;
begin
  if FGroupBar <> nil then
    FGroupBar.RemoveGroup(Self);
  FItems.Free;
  ImagesChangeLink.Free;
  inherited;
end;

procedure TEsGroup.Loaded;
begin
  inherited;
end;

function TEsGroup.CanCloseByUser: Boolean;
begin
  Result := True;
  if (FGroupBar <> nil) then
    Result := FGroupBar.CanCloseGroup;
end;

procedure TEsGroup.Close;
begin
  Expanded := False;
end;

procedure TEsGroup.CMDesignHitTest(var Message: TCMDesignHitTest);
begin
  if PtInRect(ButtonRect, Point(Message.Pos.x, Message.Pos.y)) then
    Message.Result := 1;
end;

procedure TEsGroup.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if (Button = TMouseButton.mbLeft) and PtInRect(ButtonRect, Point(X, Y)) and CanCloseByUser then
    ButtonState := bsDown;

  if Button = TMouseButton.mbLeft then
  begin
    OverItem := ItemAtPos(X, Y);
    IsClicked := True;
  end;

  Invalidate;
end;

procedure TEsGroup.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if ButtonState = bsDown then
    Exit;

  if PtInRect(ButtonRect, Point(X, Y)) and CanCloseByUser then
    ButtonState := bsHot
  else
    ButtonState := bsNormal;

  if not IsClicked then
    OverItem := ItemAtPos(X, Y);

  Invalidate;
end;

procedure TEsGroup.CMMouseLeave(var Message: TMessage);
begin
  if ButtonState <> bsNormal then
    ButtonState := bsNormal;

  OverItem := nil;

  Invalidate;
end;

procedure TEsGroup.CMVisibleChanged(var Message: TMessage);
begin
  Inherited;
  UpdateBounds;
end;

procedure TEsGroup.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;

  if (ButtonState <> bsNormal) and (Button = TMouseButton.mbLeft) then
  begin
    if PtInRect(ButtonRect, Point(X, Y)) then
    begin
      ButtonState := bsHot;
      Expanded := not Expanded;
    end else
      ButtonState := bsNormal;
  end;

  if (Button = TMouseButton.mbLeft) then
  begin
    IsClicked := False;
    if (OverItem = ItemAtPos(X, Y)) and (OverItem <> nil) and (OverItem.IsActive) then
      OverItem.Click;
  end;

  Invalidate;
end;

procedure TEsGroup.Open;
begin
  Expanded := True;
end;

procedure TEsGroup.Paint;

  function Light(Color: TColor; Value: Integer): TColor;
  var
    R, G, B: Byte;
  begin
     Color := ColorToRGB(Color);
     R := GetRValue(Color);
     G := GetGValue(Color);
     B := GetBValue(Color);
     if Value < 0 then
     begin
       R := R - muldiv(R, ABS(Value), 100);
       G := G - muldiv(G, ABS(Value), 100);
       B := B - muldiv(B, ABS(Value), 100);
     end else
     begin
       R := R + muldiv(255 - R, Value, 100);
       G := G + muldiv(255 - G, Value, 100);
       B := B + muldiv(255 - B, Value, 100);
     end;
     Result := RGB(R, G, B);
  end;
const
  HotSelectorOpacity = 110;
  DownSelectorOpacity = 170;
  DisabledOpacity = 90;
  DarkValue = -25;
  GlowValue = 68;
  ButtonStates: array [Boolean, Boolean, TButtonState] of TEsGroupButtonState =
    (((TEsGroupButtonState.bsNormalOpen, TEsGroupButtonState.bsNormalOpenHot, TEsGroupButtonState.bsNormalOpenHot),
    (TEsGroupButtonState.bsNormalClose, TEsGroupButtonState.bsNormalCloseHot, TEsGroupButtonState.bsNormalCloseHot)),
    ((TEsGroupButtonState.bsSelectedOpen, TEsGroupButtonState.bsSelectedOpenHot, TEsGroupButtonState.bsSelectedOpenHot),
    (TEsGroupButtonState.bsSelectedClose, TEsGroupButtonState.bsSelectedCloseHot, TEsGroupButtonState.bsSelectedCloseHot)));

  SeparatorStates: array [Boolean] of TEsItemSeparatorState = (TEsItemSeparatorState.issNormal, TEsItemSeparatorState.issSelected);

  TextFormats: array [TAlignment] of TTextFormats =
    (TTextFormats.tfLeft, TTextFormats.tfRight, TTextFormats.tfCenter);
var
  Opacity: Byte;
  I, V: Integer;
  R, T: TRect;
  S: string;
  DrawingStyle: TDrawingStyle;
  C: TColor;
  Item: TEsGroupItem;
begin
  inherited;
  if FGroupBar <> nil then
  begin
    // CALC OPACITY
    Opacity := 255;
    if Options.DisableInactiveGroup then
      if not IsActiveGroup then
        Opacity := DisabledOpacity;

    // DRAW BACKGROUND
    if IsSelected then
      GroupBar.GroupStyle.BackgroundStyle.Draw(Canvas, ClientRect, gbsSelected, Opacity)
    else
      GroupBar.GroupStyle.BackgroundStyle.Draw(Canvas, ClientRect, gbsNormal, Opacity);

    // DRAW BUTTON
    if CanCloseByUser then
      Options.ButtonStyle.Draw(Canvas, ButtonRect, ButtonStates[IsSelected, Expanded, ButtonState], Opacity);

    // DRAW SEPARATORS (if need)
    if Options.ShowSeparator then
      for I := 0 to Items.count - 2 do
      begin
        Item := Items[I];

        if not Item.Visible then
          continue;

        R := ItemRect(I);
        R.Top := R.Bottom;
        R.Bottom := R.Top + Integer(Options.ItemSeparatorStyle.Height);
        if ImageList <> nil then
        begin
          R.Left := R.Left + Integer(Options.ItemImageOffset);
          R.Right := R.Right - Integer(Options.ItemImageOffset);
        end
        else
        begin
          R.Left := R.Left + Integer(Options.ItemOffset);
          R.Right := R.Right - Integer(Options.ItemOffset);
        end;

        if (R.Left < R.Right) and not ((I = Items.count - 2) and not Items[Items.count - 1].Visible) then
          Options.ItemSeparatorStyle.Draw(Canvas, R, SeparatorStates[IsSelected]);
      end;

    // DRAW ITEM SELECTOR (if need)
    // selected item
    if FItemIndex <> -1 then
    begin
      if Items[FItemIndex].Enabled then
        Opacity := 255
      else
        Opacity := 100;

      if ShowItemSelection then
      begin
        if Items[FItemIndex].Visible then
          Options.SelectStyle.Draw(Canvas, ItemRect(FItemIndex), TEsGroupSelectState.gssNormal, Opacity);
      end;
    end;
    // over item
    if Options.SelectStyle.ShowHotSelector and (OverItem <> nil) and
      ((FItemIndex <> OverItem.Index) or not ShowItemSelection) and OverItem.IsActive then
    begin
      if IsClicked and OverItem.IsActive then
        if Options.SelectStyle.IsPresented(Integer(TEsGroupSelectState.gssDown)) then
          Options.SelectStyle.Draw(Canvas, ItemRect(OverItem.Index), TEsGroupSelectState.gssDown)
        else
          Options.SelectStyle.Draw(Canvas, ItemRect(OverItem.Index), TEsGroupSelectState.gssNormal, DownSelectorOpacity)
      else
        if Options.SelectStyle.IsPresented(Integer(TEsGroupSelectState.gssHot)) then
          Options.SelectStyle.Draw(Canvas, ItemRect(OverItem.Index), TEsGroupSelectState.gssHot)
        else
          Options.SelectStyle.Draw(Canvas, ItemRect(OverItem.Index), TEsGroupSelectState.gssNormal, HotSelectorOpacity);
    end;

    // DRAW ITEMS
    Canvas.Font.Assign(Font);
    Canvas.Brush.Style := bsClear;
    for I := 0 to Items.count - 1 do
    begin
      Item := Items[I];

      if not Item.Visible then
        continue;

      R := ItemRect(I);
      S := Item.Caption;

      // DRAW ICON (if need)
      if (GetImageList <> nil) then
      begin
        if Item.ImageIndex <> -1 then
        begin
          if Item <> OverItem then
            DrawingStyle := TDrawingStyle.dsNormal
          else
            DrawingStyle := TDrawingStyle.dsNormal;

          ImageList.Draw(Canvas, R.Left + Integer(Options.ItemImageOffset), (R.Top + R.Bottom) div 2 - ImageList.Height div 2,
            Item.ImageIndex, DrawingStyle, TImageType.itImage, Item.IsActive);
        end;

        R.Left := R.Left + ImageList.Width + Integer(Options.ItemImageOffset);
        if R.Left > R.Right then R.Left := R.Right;

        SetTextColor(Canvas.Handle, Canvas.Font.Color);// what ImageList broke color?
      end;

      // DRAW TEXT
      Canvas.Brush.Style := bsClear;

      // get colors
      // TODO: refactor me
      if IsSelected then
      begin
        if Item.IsActive then
          if Item = OverItem then
          begin
            if (OverItem.Index = ItemIndex) and ShowItemSelection then
              C := Options.SelectedItemSelectedColor
            else
              C := Options.SelectedItemHotColor
          end else
            if (Item.Index = ItemIndex) and ShowItemSelection then
              C := Options.SelectedItemSelectedColor
            else
              C := Options.SelectedItemColor
        else
          C := Options.ItemDisabledColor;
      end else
      begin
        if Item.IsActive then
          if Item = OverItem then
          begin
            if (OverItem.Index = ItemIndex) and ShowItemSelection then
              C := Options.ItemSelectedColor
            else
              C := Options.ItemHotColor
          end else
            if (Item.Index = ItemIndex) and ShowItemSelection then
              C := Options.ItemSelectedColor
            else
              C := Options.ItemColor
        else
          C := Options.ItemDisabledColor;
      end;

      if Item.IsActive and (Item = OverItem) and IsClicked then
        C := Light(C, DarkValue);

      // fsUnderline
      if Options.UnderlineHotItem then
      begin
        if (Item = OverItem) and Item.IsActive then
          Canvas.Font.Style := Canvas.Font.Style + [fsUnderline]
        else
          Canvas.Font.Style := Canvas.Font.Style - [fsUnderline];
      end;

      // calc text rect
      T := Rect(R.Left + Integer(Options.ItemOffset), R.Top, R.Right - Integer(Options.ItemOffset), R.Bottom);
      if T.Left > R.Right then T.Left := R.Right;
      if T.Right < R.Left then T.Right := R.Left;

      {$region 'GLOW'}
      // DRAW GLOW (if need)
      if Options.TextGlow then
      begin
        if GetRValue(C) + GetGValue(C) + GetBValue(C) < 127 * 3 then
          V := GlowValue
        else
          V := -GlowValue;
        OffsetRect(T, 0, 1);
        Canvas.Font.Color := Light(C, V);
        Canvas.TextRect(T, S, [tfSingleLine, tfVerticalCenter, tfEndEllipsis]);
        OffsetRect(T, 1, -1);
        Canvas.Font.Color := Light(C, V);
        Canvas.TextRect(T, S, [tfSingleLine, tfVerticalCenter, tfEndEllipsis]);
        OffsetRect(T, -1, 0);
      end;
      {$endregion 'GLOW'}

      Canvas.Font.Color := C;
      Canvas.TextRect(T, S, [tfSingleLine, tfVerticalCenter, tfEndEllipsis]);
    end;

    // DRAW HEADER
    R := HeaderRect;
    if CanCloseByUser then
      R.Right := ButtonRect.Left - Integer(Options.ButtonStyle.OffsetLeft);// skip button
    S := Caption;
    Canvas.Font.Assign(Options.HeaderFont);
    // color for state
    if IsSelected then
      C := Options.HeaderTextSelectedColor
    else
      C := Options.HeaderTextColor;

    {$region 'HEADER GLOW'}
    // DRAW GLOW (if need)
    if Options.TextGlow then
    begin
      if GetRValue(C) + GetGValue(C) + GetBValue(C) < 127 * 3 then
        V := GlowValue
      else
        V := -GlowValue;
      OffsetRect(T, 0, 1);
      Canvas.Font.Color := Light(C, V);
      Canvas.TextRect(R, S, [tfSingleLine, tfVerticalCenter, TextFormats[Options.HeaderTextAlignment]]);
      OffsetRect(T, 1, -1);
      Canvas.Font.Color := Light(C, V);
      Canvas.TextRect(R, S, [tfSingleLine, tfVerticalCenter, TextFormats[Options.HeaderTextAlignment]]);
      OffsetRect(T, -1, 0);
    end;
    {$endregion}

    Canvas.Font.Color := C;
    Canvas.TextRect(R, S, [tfSingleLine, tfVerticalCenter, TextFormats[Options.HeaderTextAlignment]]);
  end;
end;

procedure TEsGroup.ReadState(Reader: TReader);
begin
  inherited;

  if Reader.Parent is TEsGroupBar then
    GroupBar := TEsGroupBar(Reader.Parent);
end;

procedure TEsGroup.Resize;
begin
  inherited;
  CalcHeight;
end;

procedure TEsGroup.SetExpanded(const Value: Boolean);
begin
  if FExpanded <> Value then
  begin
    FExpanded := Value;
    CalcHeight;
  end;
end;

procedure TEsGroup.SetGroupBar(const Value: TEsGroupBar);
begin
  if FGroupBar <> Value then
  begin
    if FGroupBar <> nil then
      FGroupBar.RemoveGroup(Self);
    Parent := Value;
    FGroupBar := Value;
    if Value <> nil then
      FGroupBar.AddGroup(Self);
  end;
end;

function TEsGroup.GetButtonRect: TRect;
var
  Y: Integer;
begin
  Y := (HeaderRect.Top + HeaderRect.Bottom) div 2 - Options.ButtonStyle.Height div 2;

  Result := Rect(HeaderRect.Right - Options.ButtonStyle.Width, Y,
    HeaderRect.Right, Y + Options.ButtonStyle.Height);
end;

function TEsGroup.GetContentRect: TRect;
begin
  Result := Rect(Options.Padding.Left, Options.HeaderHeight + Options.Padding.Top,
    Width - Options.Padding.Right, Height - Options.Padding.Bottom);
end;

function TEsGroup.GetGroupIndex: Integer;
begin
  if FGroupBar <> nil then
    Result := FGroupBar.GroupList.IndexOf(Self)
  else
    Result := -1;
end;

function TEsGroup.GetHeaderRect: TRect;
begin
  Result := Rect(Options.HeaderPadding.Left, Options.HeaderPadding.Top,
    Width - Options.HeaderPadding.Right, Options.HeaderHeight - Options.HeaderPadding.Bottom);
end;

function TEsGroup.GetImageList: TCustomImageList;
begin
  if Images <> nil then
    Result := Images
  else if GroupBar <> nil then
    Result := GroupBar.Images
  else
    Result := nil;
end;

procedure TEsGroup.ImagesChange(Sender: TObject);
begin
  Invalidate;
end;

function TEsGroup.ItemRect(Index: Integer; Accuracy: Boolean = False): TRect;
var
  H: Integer;
  SkipItems: Integer;
  I: Integer;
begin
  // Get real item index
  SkipItems := 0;
  for I := 0 to Index - 1 do
    if Items[I].Visible = False then
      Inc(SkipItems);
  Index := Index - SkipItems;

  // Get item full height
  if Options.ShowSeparator then
    H := Integer(Options.ItemHeight + Options.ItemSeparatorStyle.Height)
  else
    H := Options.ItemHeight;

  // calculate
  Result.Left := ContentRect.Left;
  // We can get real item width if we has control canvas,
  // also if we havent canvas then no need calculating accuracy width
  if Accuracy and HandleAllocated then
  begin
    Canvas.Font.Assign(Font);

    Result.Right := Result.Left;
    if ImageList <> nil then
      Result.Right := Result.Right + ImageList.Width + Integer(Options.ItemImageOffset);
    Result.Right := Result.Right + Integer(Options.ItemOffset) + Canvas.TextWidth(Items[Index].Caption + ' ');
    if Result.Right > ContentRect.Right then
      Result.Right := ContentRect.Right;
  end else
    Result.Right := ContentRect.Right;
  Result.Top := ContentRect.Top + Index * H;
  Result.Bottom := Result.Top + Integer(Options.ItemHeight);
end;

function TEsGroup.GetOptions: TEsGroupStyle;
begin
  if GroupBar <> nil then
    Result := GroupBar.GroupStyle
  else
    Result := nil;
end;

function TEsGroup.GetShowItemSelection: Boolean;
begin
  if GroupBar <> nil then
    if GroupBar.UniqueItemSelection then
      Result := True
    else
      Result := FShowSelection
  else
    Result := FShowSelection;
end;

procedure TEsGroup.InitiateAction;
var
  I: Integer;
begin
  inherited;
  for I := 0 to Items.Count - 1 do
    Items[I].InitiateAction;
end;

function TEsGroup.IsActiveGroup: Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to Items.Count - 1 do
    if Items[I].IsActive and Items[I].Visible then
    begin
      Result := True;
      Exit;
    end;
end;

function TEsGroup.IsEmptyGroup: Boolean;
var
  I: Integer;
begin
  Result := True;
  for I := 0 to Items.Count - 1 do
    if Items[I].Visible then
    begin
      Result := False;
      Exit;
    end;
end;

function TEsGroup.IsSelected: Boolean;
begin
  Result := False;
  if GroupBar <> nil then
  begin
    Result := GroupBar.UniqueItemSelection and GroupBar.HighlightSelectedGroup and (ItemIndex <> -1);
  end;
end;

function TEsGroup.IsShowItemSelection: Boolean;
begin
  Result := (GroupBar = nil) or not GroupBar.UniqueItemSelection;
end;

function TEsGroup.ItemAtPos(X, Y: Integer): TEsGroupItem;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to Items.Count - 1 do
    if Items[I].Visible then
      if PtInRect(ItemRect(I), Point(X, Y)) then // not accuracy test
      begin
        if not Options.AccuracyItemHitTest or PtInRect(ItemRect(I, True), Point(X, Y)) then // accuracy test
          Result := Items[I];
        exit;
      end;
end;

procedure TEsGroup.SetGroupIndex(const Value: Integer);
begin
  if FGroupBar <> nil then
  begin
    if Value < FGroupBar.GroupList.Count then
      FGroupBar.GroupList.Move(GroupIndex, Value)
    else
      raise EEsGroupBarError.Create('GroupIndex: Index of bounds');

    UpdateBounds;
  end;
end;

procedure TEsGroup.SetImages(const Value: TCustomImageList);
begin
  if FImages <> nil then
    FImages.UnRegisterChanges(ImagesChangeLink);

  FImages := Value;

  if FImages <> nil then
  begin
    FImages.UnRegisterChanges(ImagesChangeLink);
    FImages.FreeNotification(Self);
  end;

  Invalidate;
end;

procedure TEsGroup.SetItemIndex(const Value: Integer);
var
  I, NewIndex: Integer;
begin
  // IsChanging - protection of recursion
  if (FItemIndex <> Value) and not IsChanging then
  begin
    IsChanging := True;
    try
      NewIndex := Value;
      if NewIndex < -1 then NewIndex := -1 else
      if NewIndex >= Items.Count then NewIndex := Items.Count - 1;

      for I := 0 to Items.Count - 1 do
        if I <> NewIndex then Items[I].Selected := False;

      if NewIndex <> -1 then
        Items[NewIndex].Selected := True
      else
        Items[FItemIndex].Selected := False;

      if GroupBar <> nil then
        if FItemIndex = -1 then
          GroupBar.InternalSelect(-1)
        else
          if FItemIndex = -1 then
            GroupBar.InternalSelect(GroupIndex);

      FItemIndex := NewIndex;

      View;
    finally
      IsChanging := False;
    end;
  end;
end;

procedure TEsGroup.SetItems(const Value: TEsGroupItems);
begin
  FItems.Assign(Value);
end;

procedure TEsGroup.SetParent(AParent: TWinControl);
begin
  if (AParent <> nil) and not (AParent is TEsGroupBar) then
    raise EEsGroupBarError.Create('Parent need TEsGroupBar class');
  inherited;
end;

procedure TEsGroup.SetShowItemSelection(const Value: Boolean);
begin
  if ((GroupBar = nil) or (not GroupBar.UniqueItemSelection)) and (FShowSelection <> Value) then
  begin
    FShowSelection := Value;
    Invalidate;
  end;
end;

procedure TEsGroup.UpdateBounds;
begin
  if FGroupBar <> nil then
    FGroupBar.UpdateBounds;
end;

procedure TEsGroup.UpdateText;
begin
  inherited;
  Invalidate;
end;

procedure TEsGroup.View;
begin
  if (FItemIndex <> -1) and (GroupBar <> nil) and (GroupBar.UniqueItemSelection) and not(csDesigning in ComponentState) then
  begin
    Open;
    if (Top < 0) or (Top + Height > GroupBar.Height) then
      if Height <= GroupBar.Height then
        GroupBar.ScrollToGroup(Self)
      else
      begin
        GroupBar.ScrollToGroup(Self);
        GroupBar.VertScrollBar.Position := GroupBar.VertScrollBar.Position -
          GroupBar.Height div 2 + ItemRect(FItemIndex).Top + (ItemRect(FItemIndex).Bottom - ItemRect(FItemIndex).Top) div 2;
      end;
  end;
end;

procedure TEsGroup.WMWindowPosChanged(var Message: TWMWindowPosChanged);
begin
  Inherited;
  if (FGroupBar <> nil) and not FGroupBar.IsUpdatingBounds then
    UpdateBounds;
end;

{ TEsGroupBackgroundStyle }

procedure TEsGroupBackgroundStyle.AssignDefaultValues;
begin
  inherited;
  ImageMargins.SetBounds(4, 21, 4, 1);
  OverlayMargins.SetBounds(0, 0, 0, 0);
  OverlayAlign := TImageAlign.iaTop;
end;

procedure TEsGroupBackgroundStyle.Draw(Canvas: TCanvas; Rect: TRect; State: TEsGroupBackgroundState; Alpha: Byte);
begin
  Inherited Draw(Canvas, Rect, Integer(State), Alpha);
end;

function TEsGroupBackgroundStyle.GetImage(const Index: Integer): TPngImage;
begin
  result := inherited GetImage(Index);
end;

function TEsGroupBackgroundStyle.GetOverlay(const Index: Integer): TPngImage;
begin
  result := inherited GetOverlay(Index);
end;

function TEsGroupBackgroundStyle.GetStateCount: Integer;
begin
  Result := 2;
end;

function TEsGroupBackgroundStyle.GetStylePrefix: string;
begin
  Result := 'TEsGroup';
end;

procedure TEsGroupBackgroundStyle.SetImage(const Index: Integer; const Value: TPngImage);
begin
  inherited;
end;

procedure TEsGroupBackgroundStyle.SetOverlay(const Index: Integer; const Value: TPngImage);
begin
  inherited;
end;

{ TEsGroupButtonStyle }

procedure TEsGroupButtonStyle.AssignDefaultValues;
begin
  inherited;
  OverlayAlign := TImageAlign.iaCenter;
  FWidth := 16;
  FHeight := 16;
  FOffsetLeft := 1;
end;

procedure TEsGroupButtonStyle.Draw(Canvas: TCanvas; Rect: TRect; State: TEsGroupButtonState;
  Alpha: Byte);
begin
  Inherited Draw(Canvas, Rect, Integer(State), Alpha);
end;

function TEsGroupButtonStyle.GetOverlay(const Index: Integer): TPngImage;
begin
  Result := inherited GetOverlay(Index);
end;

function TEsGroupButtonStyle.GetStateCount: Integer;
begin
  Result := 8;
end;

function TEsGroupButtonStyle.GetStylePrefix: string;
begin
  Result := 'TEsGroupButton';
end;

function TEsGroupButtonStyle.IsStyleStored: Boolean;
begin
  Result := Inherited IsStyleStored;
end;

procedure TEsGroupButtonStyle.SetHeight(const Value: Integer);
begin
  if FHeight <> Value then
  begin
    FHeight := Value;
    Change;
  end;
end;

procedure TEsGroupButtonStyle.SetOffsetLeft(const Value: Cardinal);
begin
  if FOffsetLeft <> Value then
  begin
    FOffsetLeft := Value;
    Change;
  end;
end;

procedure TEsGroupButtonStyle.SetOverlay(const Index: Integer; const Value: TPngImage);
begin
  inherited;
end;

procedure TEsGroupButtonStyle.SetWidth(const Value: Integer);
begin
  if FWidth <> Value then
  begin
    FWidth := Value;
    Change;
  end;
end;

{ TEsGroupSelectStyle }

procedure TEsGroupSelectStyle.AssignDefaultValues;
begin
  inherited;
  ImageMargins.SetBounds(2, 2, 2, 2);
  FHeight := 18;
  FShowHotSelector := False;
  ImageMode := smNormal;
end;

constructor TEsGroupSelectStyle.Create;
begin
  inherited;
end;

destructor TEsGroupSelectStyle.Destroy;
begin
  inherited;
end;

procedure TEsGroupSelectStyle.Draw(Canvas: TCanvas; Rect: TRect; State: TEsGroupSelectState;
  Alpha: Byte);
begin
  Inherited Draw(Canvas, Rect, Integer(State), Alpha);
end;

function TEsGroupSelectStyle.GetImage(const Index: Integer): TPngImage;
begin
  result := inherited GetImage(Index);
end;

function TEsGroupSelectStyle.GetStateCount: Integer;
begin
  Result := 3;
end;

function TEsGroupSelectStyle.GetStylePrefix: string;
begin
  Result := 'TEsGroup_Selector';
end;

function TEsGroupSelectStyle.IsStyleStored: Boolean;
begin
  Result := Inherited IsStyleStored;
end;

procedure TEsGroupSelectStyle.SetHeight(const Value: Cardinal);
begin
  if Value <> FHeight then
  begin
    FHeight := Value;
    Change;
  end;
end;

procedure TEsGroupSelectStyle.SetImage(const Index: Integer; const Value: TPngImage);
begin
  inherited;
end;

procedure TEsGroupSelectStyle.SetShowHotSelector(const Value: Boolean);
begin
  if Value <> FShowHotSelector then
  begin
    FShowHotSelector := Value;
    Change;
  end;
end;

{ TEsGroupItemSeparatorStyle }

procedure TEsGroupItemSeparatorStyle.AssignDefaultValues;
begin
  inherited;
  ImageMargins.SetBounds(0, 0, 0, 0);
  ImageMode := TStretchMode.smTile;// drawing style or strech mode
  FHeight := 1;
end;

procedure TEsGroupItemSeparatorStyle.Draw(Canvas: TCanvas; Rect: TRect;
  State: TEsItemSeparatorState; Alpha: Byte);
begin
  Inherited Draw(Canvas, Rect, Integer(State), Alpha);
end;

function TEsGroupItemSeparatorStyle.GetImage(const Index: Integer): TPngImage;
begin
  result := inherited GetImage(Index);
end;

function TEsGroupItemSeparatorStyle.GetStateCount: Integer;
begin
  Result := 2;
end;

function TEsGroupItemSeparatorStyle.GetStylePrefix: string;
begin
  Result := 'TEsGroup_ItemSeparator';
end;

function TEsGroupItemSeparatorStyle.IsStyleStored: Boolean;
begin
  Result := Inherited IsStyleStored;
end;

procedure TEsGroupItemSeparatorStyle.SetHeight(const Value: Cardinal);
begin
  if Value <> FHeight then
  begin
    FHeight := Value;
    Change;
  end;
end;

procedure TEsGroupItemSeparatorStyle.SetImage(const Index: Integer; const Value: TPngImage);
begin
  inherited;
end;

{ TEsGroupStyle }

constructor TEsGroupStyle.Create(Control: TWinControl = nil);
begin
  inherited Create;
  FBackgroundStyle := TEsGroupBackgroundStyle.Create;
  FItemSeparatorStyle := TEsGroupItemSeparatorStyle.Create;
  FSelectStyle:= TEsGroupSelectStyle.Create;
  FButtonStyle := TEsGroupButtonStyle.Create;
  //
  FBackgroundStyle.OnChange := SimpleChange;
  FItemSeparatorStyle.OnChange := RebildChange;
  FSelectStyle.OnChange := SimpleChange;
  FButtonStyle.OnChange := SimpleChange;
  //
  FHeaderPadding := TStylePadding.Create(nil);
  FHeaderPadding.OnChange := SimpleChange;
  //
  FPadding := TStylePadding.Create(nil);
  FPadding.OnChange := RebildChange;

  FHeaderFont := TFont.Create;
  FHeaderFont.OnChange := HeaderFontChange;

  AssignDefaultProperties;

  if Control <> nil then
    Self.Control := Control;
end;

destructor TEsGroupStyle.Destroy;
begin
  FreeAndNil(FBackgroundStyle);
  FreeAndNil(FItemSeparatorStyle);
  FreeAndNil(FSelectStyle);
  FreeAndNil(FButtonStyle);
  FreeAndNil(FPadding);
  FreeAndNil(FHeaderPadding);
  FreeAndNil(FHeaderFont);
  inherited;
end;

procedure TEsGroupStyle.SimpleChange(Sender: TObject);
begin
  Change(False);
end;

procedure TEsGroupStyle.HeaderFontChange(Sender: TObject);
begin
  Change(False);
end;

function TEsGroupStyle.IsHeaderFontStored: Boolean;
begin
  Result := not FParentHeaderFont;
end;

function TEsGroupStyle.IsHeaderPaddingStored: Boolean;
begin
  Result := (FHeaderPadding.Left <> 3) or (FHeaderPadding.Top <> 0) or
   (FHeaderPadding.Right <> 3) or (FHeaderPadding.Bottom <> 0);
end;

function TEsGroupStyle.IsPaddingStored: Boolean;
begin
  Result := (FPadding.Left <> 3) or (FPadding.Top <> 3) or
   (FPadding.Right <> 3) or (FPadding.Bottom <> 3);
end;

procedure TEsGroupStyle.AssignDefaultImages;
begin
  FBackgroundStyle.AssignDefaultImages;
  FItemSeparatorStyle.AssignDefaultImages;
  FSelectStyle.AssignDefaultImages;
  FButtonStyle.AssignDefaultImages;
  // TryChange !!!
end;

procedure TEsGroupStyle.AssignDefaultStyle;
begin
  FBackgroundStyle.AssignDefaultStyle;
  FItemSeparatorStyle.AssignDefaultStyle;
  FSelectStyle.AssignDefaultStyle;
  FButtonStyle.AssignDefaultStyle;
  AssignDefaultProperties;
end;

procedure TEsGroupStyle.LoadStyleFormFile(FileName: string);
begin
  AssignDefaultStyle;
  DeserializeFromFile(Self, FileName, 'GroupBarStyle');
end;

procedure TEsGroupStyle.LoadStyleFormStream(Stream: TStream);
begin
  AssignDefaultStyle;
  DeserializeFromStream(Self, Stream, 'GroupBarStyle');
end;

procedure TEsGroupStyle.LoadStyleFromResource(Instance: HINST; const ResourceName: string; ResourceType: PChar);
begin
  AssignDefaultStyle;
  DeserializeFromResource(Self, Instance, ResourceName, ResourceType, 'GroupBarStyle');
end;

procedure TEsGroupStyle.RebildChange(Sender: TObject);
begin
  Change(True);
end;

procedure TEsGroupStyle.AssignDefaultProperties;
begin
  FHeaderPadding.SetBounds(3, 0, 3, 0);
  FPadding.SetBounds(3, 3, 3, 3);
  FHeaderHeight := 21;
  FHeaderTextAlignment := TAlignment.taLeftJustify;
  ParentHeaderFont := True;
  FHeaderTextColor := clBlack;
  FHeaderTextSelectedColor := $00BB3300;
  FItemHeight := 20;
  FItemColor := clBlack;
  FSelectedItemColor := clBlack;
  FItemHotColor := $00F26E00;
  FSelectedItemHotColor := $00F26E00;
  FItemDisabledColor := $008D8D8D;
  FItemSelectedColor := $00FFFFFF;
  FSelectedItemSelectedColor := $00FFFFFF;
  FItemImageOffset := 6;
  FItemOffset := 6;
  FAccuracyItemHitTest := True;
  FTextGlow := False;
  FUnderlineHotItem := False;
  FShowSeparator := False;
  FDisableInactiveGroup := False;
end;

procedure TEsGroupStyle.SetAccuracyItemHitTest(const Value: Boolean);
begin
  if FAccuracyItemHitTest <> Value then
  begin
    FAccuracyItemHitTest := Value;
    Change(False);
  end;
end;

procedure TEsGroupStyle.SetButtonStyle(const Value: TEsGroupButtonStyle);
begin
  FButtonStyle.Assign(Value);
  Change(True);
end;

procedure TEsGroupStyle.SetBackgroundStyle(const Value: TEsGroupBackgroundStyle);
begin
  FBackgroundStyle.Assign(Value);
  Change(True);
end;

procedure TEsGroupStyle.SetHeaderFont(const Value: TFont);
begin
  FHeaderFont.Assign(Value);
  Change(True);
end;

procedure TEsGroupStyle.SetHeaderHeight(const Value: Cardinal);
begin
  if FHeaderHeight <> Value then
  begin
    FHeaderHeight := Value;
    Change(True);
  end;
end;

procedure TEsGroupStyle.SetHeaderPadding(const Value: TStylePadding);
begin
  FHeaderPadding.Assign(Value);
end;

procedure TEsGroupStyle.SetHeaderTextAlignment(const Value: TAlignment);
begin
  if FHeaderTextAlignment <> Value then
  begin
    FHeaderTextAlignment := Value;
    Change(False);
  end;
end;

procedure TEsGroupStyle.SetHeaderTextColor(const Value: TColor);
begin
  if FHeaderTextColor <> Value then
  begin
    FHeaderTextColor := Value;
    Change(False);
  end;
end;

procedure TEsGroupStyle.SetHeaderTextSelectedColor(const Value: TColor);
begin
  if FHeaderTextSelectedColor <> Value then
  begin
    FHeaderTextSelectedColor := Value;
    Change(False);
  end;
end;

procedure TEsGroupStyle.SetItemColor(const Value: TColor);
begin
  if FItemColor <> Value then
  begin
    FItemColor := Value;
    Change(False);
  end;
end;

procedure TEsGroupStyle.SetItemDisabledColor(const Value: TColor);
begin
  if FItemDisabledColor <> Value then
  begin
    FItemDisabledColor := Value;
    Change(False);
  end;
end;

procedure TEsGroupStyle.SetItemHeight(const Value: Cardinal);
begin
  if FItemHeight <> Value then
  begin
    FItemHeight := Value;
    Change(True);
  end;
end;

procedure TEsGroupStyle.SetItemHotColor(const Value: TColor);
begin
  if FItemHotColor <> Value then
  begin
    FItemHotColor := Value;
    Change(False);
  end;
end;

procedure TEsGroupStyle.SetItemImageOffset(const Value: Cardinal);
begin
  if FItemImageOffset <> Value then
  begin
    FItemImageOffset := Value;
    Change(False);
  end;
end;

procedure TEsGroupStyle.SetItemOffset(const Value: Cardinal);
begin
  if FItemOffset <> Value then
  begin
    FItemOffset := Value;
    Change(False);
  end;
end;

procedure TEsGroupStyle.SetItemSelectedColor(const Value: TColor);
begin
  if FItemSelectedColor <> Value then
  begin
    FItemSelectedColor := Value;
    Change(False);
  end;
end;

procedure TEsGroupStyle.SetItemSeparatorStyle(const Value: TEsGroupItemSeparatorStyle);
begin
  FItemSeparatorStyle.Assign(Value);
end;

procedure TEsGroupStyle.SetSelectedItemColor(const Value: TColor);
begin
  if FSelectedItemColor <> Value then
  begin
    FSelectedItemColor := Value;
    Change(False);
  end;
end;

procedure TEsGroupStyle.SetSelectedItemHotColor(const Value: TColor);
begin
  if FSelectedItemHotColor <> Value then
  begin
    FSelectedItemHotColor := Value;
    Change(False);
  end;
end;

procedure TEsGroupStyle.SetSelectedItemSelectedColor(const Value: TColor);
begin
  if FSelectedItemSelectedColor <> Value then
  begin
    FSelectedItemSelectedColor := Value;
    Change(False);
  end;
end;

procedure TEsGroupStyle.SetPadding(const Value: TStylePadding);
begin
  FPadding.Assign(Value);
end;

procedure TEsGroupStyle.SetControl(const Value: TControl);
begin
  FControl := Value;
  FBackgroundStyle.Control := Value;
  FItemSeparatorStyle.Control := Value;
  FSelectStyle.Control := Value;
  FButtonStyle.Control := Value;
end;

procedure TEsGroupStyle.SetDisableInactiveGroup(const Value: Boolean);
begin
  if FDisableInactiveGroup <> Value then
  begin
    FDisableInactiveGroup := Value;
    Change(False);
  end;
end;

procedure TEsGroupStyle.SetParentHeaderFont(const Value: Boolean);
var
  ChangeProc: TNotifyEvent;
begin
  if FParentHeaderFont <> Value then
  begin
    FParentHeaderFont := Value;

    if FParentHeaderFont and (FControl <> nil) then
    begin
      ChangeProc := HeaderFont.OnChange;
      HeaderFont.OnChange := nil;
      try
        AssignHeaderFont(TEsGroupBar(FControl).Font);
      finally
        HeaderFont.OnChange := ChangeProc;
      end;
      Change(False);
      //HeaderFont.Assign();
    end;
    //Change(True);
  end;
end;

procedure TEsGroupStyle.SetSelectStyle(const Value: TEsGroupSelectStyle);
begin
  FSelectStyle.Assign(Value);
  Change(True);
end;

procedure TEsGroupStyle.SetShowSeparator(const Value: Boolean);
begin
  if FShowSeparator <> Value then
  begin
    FShowSeparator := Value;
    Change(True);
  end;
end;

procedure TEsGroupStyle.SetTextGlow(const Value: Boolean);
begin
  if FTextGlow <> Value then
  begin
    FTextGlow := Value;
    Change(False);
  end;
end;

procedure TEsGroupStyle.SetUnderlineHotItem(const Value: Boolean);
begin
  if FUnderlineHotItem <> Value then
  begin
    FUnderlineHotItem := Value;
    Change(False);
  end;
end;

procedure TEsGroupStyle.AssignHeaderFont(Font: TFont);
var
  Temp: TFont;
begin
    Temp := TFont.Create;
    try
      Temp.Assign(Font);
      Temp.Style := Temp.Style + [fsBold];
      HeaderFont.Assign(Temp);
    finally
      Temp.Free;
    end;
end;

procedure TEsGroupStyle.Change(Rebild: Boolean);
begin
  if Assigned(FOnChange) then
    FOnChange(Self, Rebild);
end;

{ TEsGroupItem }

procedure TEsGroupItem.ActionChange(Sender: TObject; CheckDefaults: Boolean);
var
  Action: TCustomAction;
begin
  if Sender is TCustomAction then
  begin
    Action := TCustomAction(Sender);

    if not CheckDefaults or (Self.Caption = '') then
      Self.Caption := Action.Caption;

    if not CheckDefaults or (Self.Hint = '') then
      Self.Hint := Action.Hint;

    if not CheckDefaults or (Self.ImageIndex = -1) then
      Self.ImageIndex := Action.ImageIndex;

    if not CheckDefaults or (@Self.OnClick = nil) then
      Self.OnClick := Action.OnExecute;

    if not CheckDefaults or (Self.Enabled = True) then
      Self.Enabled := Action.Enabled;
    end;
end;

procedure TEsGroupItem.ActionHandler(Sender: TObject);
begin
  if Sender = Action then
    ActionChange(Sender, False);
end;

procedure TEsGroupItem.AssignTo(Dest: TPersistent);
begin
  if Dest is TEsGroupItem then
  begin
    TEsGroupItem(Dest).Action := Action;
    TEsGroupItem(Dest).Enabled := Enabled;
    TEsGroupItem(Dest).Hint := Hint;
    TEsGroupItem(Dest).Caption := Caption;
    TEsGroupItem(Dest).OnClick := OnClick;
    TEsGroupItem(Dest).Tag := Tag;
    TEsGroupItem(Dest).ImageIndex := ImageIndex;
    TEsGroupItem(Dest).Visible := Visible;
  end else
    Inherited;
end;

procedure TEsGroupItem.Click;
begin
  Selected := True;
  if ((Action <> nil) and (@FOnClick <> @Action.OnExecute) and Assigned(FOnClick)) then
    FOnClick(Self)
  else
  if not (csDesigning in Group.ComponentState) and (ActionLink <> nil) then
    ActionLink.Execute(Group)
  else
    if Assigned(FOnClick) then
      FOnClick(Self);
end;

constructor TEsGroupItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);

  if (csDesigning in Group.ComponentState) and not (csLoading in Group.ComponentState) then
    FCaption := 'Item' + IntToStr(Index + 1);

  FEnabled := True;
  FImageIndex := -1;
  Visible := True;// Use Setter for request calculating size
end;

destructor TEsGroupItem.Destroy;
begin
  if Group <> nil then
  begin
    if Index < Group.FItemIndex then
      Dec(Group.FItemIndex)
    else if Index = Group.FItemIndex then
      Group.FItemIndex := -1;
  end;

  FreeAndNil(FActionLink);
  inherited;
end;

function TEsGroupItem.GetAction: TBasicAction;
begin
  if ActionLink <> nil then
    Result := ActionLink.Action
  else
    Result := nil;
end;

function TEsGroupItem.GetDisplayName: string;
begin
  if Caption <> '' then
    Result := Caption
  else
    Result := Inherited GetDisplayName;
end;

function TEsGroupItem.GetGroup: TEsGroup;
begin
  Result := TEsGroupItems(Collection).Group;
end;

function TEsGroupItem.GetIsActive: Boolean;
begin
  Result := Enabled and (not((Action <> nil) and (not Assigned(Action.OnExecute)))
   or ((Group <> nil) and (csDesigning in Group.ComponentState)));
end;

procedure TEsGroupItem.InitiateAction;
begin
  if ActionLink <> nil then
    ActionLink.Update;
end;

function TEsGroupItem.IsCaptionStored: Boolean;
begin
  Result := (ActionLink = nil) or not ActionLink.IsCaptionLinked;
end;

function TEsGroupItem.IsEnabledStored: Boolean;
begin
  Result := (ActionLink = nil) or not ActionLink.IsEnabledLinked;
end;

function TEsGroupItem.IsHintStored: Boolean;
begin
  Result := (ActionLink = nil) or not ActionLink.IsHintLinked;
end;

function TEsGroupItem.IsImageIndexStored: Boolean;
begin
  Result := (ActionLink = nil) or not ActionLink.IsImageIndexLinked;
end;

function TEsGroupItem.IsOnClickStored: Boolean;
begin
  Result := (ActionLink = nil) or not ActionLink.IsOnExecuteLinked;
end;

function TEsGroupItem.IsVisibleStored: Boolean;
begin
  Result := (ActionLink = nil) or not ActionLink.IsVisibleLinked;
end;

procedure TEsGroupItem.ResetSelection;
begin
  if FSelected <> False then
  begin
    FSelected := False;

    Changed(False);
  end;
end;

procedure TEsGroupItem.SetAction(const Value: TBasicAction);
begin
  if Value = nil then
  begin
    ActionLink.Free;
    ActionLink := nil;
  end
  else
  begin
    if ActionLink = nil then
      ActionLink := TEsGroupItemActionLink.Create(Self);
    ActionLink.Action := Value;
    ActionLink.OnChange := ActionHandler;
    ActionChange(Value, csLoading in Value.ComponentState);
    Value.FreeNotification(Group);
  end;
  Changed(False);
end;

procedure TEsGroupItem.SetCaption(const Value: string);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    Changed(False);
  end;
end;

procedure TEsGroupItem.SetEnabled(const Value: Boolean);
begin
  if FEnabled <> Value then
  begin
    FEnabled := Value;
    Changed(False);
  end;
end;

procedure TEsGroupItem.SetHint(const Value: string);
begin
  FHint := Value;
end;

procedure TEsGroupItem.SetImageIndex(const Value: TImageIndex);
begin
  if FImageIndex <> Value then
  begin
    FImageIndex := Value;
    Changed(False);
  end;
end;

procedure TEsGroupItem.SetIndex(Value: Integer);
begin
  if (Index >= 0) and (Index < Collection.Count) and (Group <> nil) then
  begin
    if Index = Group.FItemIndex then
      Group.FItemIndex := Value else
    if Value = Group.FItemIndex then
      Group.FItemIndex := Index else
    if (Index < Group.FItemIndex) and (Value > Group.FItemIndex) then
      Dec(Group.FItemIndex) else
    if (Index > Group.FItemIndex) and (Value < Group.FItemIndex) then
      Inc(Group.FItemIndex);
  end;

  inherited SetIndex(Value);
end;

procedure TEsGroupItem.SetSelected(const Value: Boolean);
begin
  if FSelected <> Value then
  begin
    FSelected := Value;

    if (Group <> nil) and not Group.IsChanging then
    begin
      if FSelected then
        Group.ItemIndex := Index
      else
        Group.ItemIndex := -1;
    end;

    Changed(False);// is we need call this?
  end;
end;

procedure TEsGroupItem.SetVisible(const Value: Boolean);
begin
  if FVisible <> Value then
  begin
    FVisible := Value;
    Changed(True);
  end;
end;

{ TEsGroupItemActionLink }

procedure TEsGroupItemActionLink.AssignClient(AClient: TObject);
begin
  FClient := AClient as TEsGroupItem;
end;

function TEsGroupItemActionLink.IsCaptionLinked: Boolean;
begin
  Result := inherited IsCaptionLinked
    and (FClient.Caption = TCustomAction(Action).Caption);
end;

function TEsGroupItemActionLink.IsCheckedLinked: Boolean;
begin
  Result := inherited IsCheckedLinked
    and (FClient.Selected = TCustomAction(Action).Checked);
end;

function TEsGroupItemActionLink.IsEnabledLinked: Boolean;
begin
  Result := inherited IsEnabledLinked
    and (FClient.Enabled = TCustomAction(Action).Enabled);
end;

function TEsGroupItemActionLink.IsHintLinked: Boolean;
begin
  Result := inherited IsHintLinked
    and (FClient.Hint = TCustomAction(Action).Hint);
end;

function TEsGroupItemActionLink.IsImageIndexLinked: Boolean;
begin
  Result := inherited IsImageIndexLinked
    and (FClient.ImageIndex = TCustomAction(Action).ImageIndex);
end;

function TEsGroupItemActionLink.IsOnExecuteLinked: Boolean;
begin
  Result := inherited IsOnExecuteLinked
    and (@FClient.OnClick = @TCustomAction(Action).OnExecute);
end;

function TEsGroupItemActionLink.IsVisibleLinked: Boolean;
begin
  Result := inherited IsVisibleLinked
    and (FClient.Visible = TCustomAction(Action).Visible);
end;

procedure TEsGroupItemActionLink.SetCaption(const Value: string);
begin
  if IsCaptionLinked then
    FClient.Caption := Value;
end;

procedure TEsGroupItemActionLink.SetChecked(Value: Boolean);
begin
  if IsCheckedLinked then
    FClient.Selected := Value;
end;

procedure TEsGroupItemActionLink.SetEnabled(Value: Boolean);
begin
  if IsEnabledLinked then
    FClient.Enabled := Value;
end;

procedure TEsGroupItemActionLink.SetHint(const Value: string);
begin
  if IsHintLinked then
    FClient.Hint := Value;
end;

procedure TEsGroupItemActionLink.SetImageIndex(Value: Integer);
begin
  if IsImageIndexLinked then
    FClient.ImageIndex := Value;
end;

procedure TEsGroupItemActionLink.SetOnExecute(Value: TNotifyEvent);
begin
  if IsOnExecuteLinked then
    FClient.OnClick := Value;
end;

procedure TEsGroupItemActionLink.SetVisible(Value: Boolean);
begin
  if IsVisibleLinked then
    FClient.Visible := Value;
end;

{ TEsGroupItems }

function TEsGroupItems.Add: TEsGroupItem;
begin
  Result := TEsGroupItem(Inherited Add);
end;

constructor TEsGroupItems.Create(Group: TEsGroup);
begin
  Inherited Create(TEsGroupItem);
  FGroup := Group;
end;

function TEsGroupItems.GetItem(Index: Integer): TEsGroupItem;
begin
  Result := TEsGroupItem(inherited GetItem(Index));
end;

function TEsGroupItems.GetOwner: TPersistent;
begin
  Result := FGroup;
end;

procedure TEsGroupItems.SetItem(Index: Integer; const Value: TEsGroupItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TEsGroupItems.Update(Item: TCollectionItem);
begin
  if Item = nil then
    FGroup.CalcHeight;
  FGroup.Invalidate;
end;

end.
