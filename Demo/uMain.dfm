object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'TEsGroupBar demo project'
  ClientHeight = 520
  ClientWidth = 698
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object EsGroupBar1: TEsGroupBar
    Left = 0
    Top = 20
    Width = 209
    Height = 500
    AutoHideEmptyGroup = True
    HighlightSelectedGroup = True
    Align = alLeft
    Caption = 'EsGroupBar1'
    TabOrder = 0
    object grSelectStyle: TEsGroup
      ShowItemSelection = True
      Caption = 'Select Style'
      Items = <
        item
          Caption = 'Default'
          OnClick = EsGroup3Items0Click
          Selected = True
        end
        item
          Caption = 'RubyGraphite'
          OnClick = EsGroup3Items1Click
        end
        item
          Caption = 'Modern'
          OnClick = EsGroup3Items2Click
        end
        item
          Caption = 'ModernDark'
          OnClick = EsGroup3Items3Click
        end
        item
          Caption = 'ModernBlue'
          OnClick = EsGroup3Items4Click
        end>
    end
    object EsGroup1: TEsGroup
      Caption = 'EsGroup1'
      Items = <
        item
          Action = Action1
        end
        item
          Action = Action2
        end
        item
          Action = Action3
        end
        item
          Action = Action4
        end
        item
          Action = Action5
        end>
      Images = ImageList1
    end
    object grAutoHide: TEsGroup
      Caption = 'I am autohide group'
      Items = <
        item
          Caption = 'AutoHideGroupItem'
          OnClick = grAutoHideItems0Click
        end>
    end
    object EsGroup2: TEsGroup
      ShowItemSelection = True
      Caption = 'EsGroup2 - Show Item Selection'
      Items = <
        item
          Caption = 'Item1'
        end
        item
          Caption = 'Item2'
        end
        item
          Caption = 'Item3'
        end
        item
          Caption = 'Item4'
        end
        item
          Caption = 'Item5'
        end>
    end
  end
  object Memo1: TMemo
    AlignWithMargins = True
    Left = 510
    Top = 23
    Width = 185
    Height = 494
    Align = alRight
    Lines.Strings = (
      'Events:')
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object StaticText1: TStaticText
    Left = 0
    Top = 0
    Width = 698
    Height = 20
    Align = alTop
    BevelInner = bvNone
    BevelKind = bkFlat
    Caption = 
      '* - Modern styles are included in Delphi only since DX10, styles' +
      ' was replaced at similar styles.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    Visible = False
  end
  object Panel1: TPanel
    Left = 209
    Top = 20
    Width = 240
    Height = 500
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 3
    object btnAddGroup: TButton
      Left = 6
      Top = 6
      Width = 115
      Height = 25
      Caption = 'Add Group'
      TabOrder = 0
      OnClick = btnAddGroupClick
    end
    object btnOpenAll: TButton
      Left = 6
      Top = 37
      Width = 115
      Height = 25
      Caption = 'OpenAll'
      TabOrder = 1
      OnClick = btnOpenAllClick
    end
    object btnCloseAll: TButton
      Left = 6
      Top = 68
      Width = 115
      Height = 25
      Caption = 'CloseAll'
      TabOrder = 2
      OnClick = btnCloseAllClick
    end
    object chEsGroup1Visible: TCheckBox
      Left = 6
      Top = 131
      Width = 115
      Height = 17
      Caption = 'EsGroup1 Visible'
      TabOrder = 3
      OnClick = chEsGroup1VisibleClick
    end
    object chEsGroup1Expanded: TCheckBox
      Left = 6
      Top = 154
      Width = 115
      Height = 17
      Caption = 'EsGroup1 Expanded'
      TabOrder = 4
      OnClick = chEsGroup1ExpandedClick
    end
    object chAction3Enabled: TCheckBox
      Left = 6
      Top = 177
      Width = 97
      Height = 17
      Caption = 'Action3 Enabled'
      TabOrder = 5
      OnClick = chAction3EnabledClick
    end
    object chAction3Visible: TCheckBox
      Left = 6
      Top = 200
      Width = 97
      Height = 17
      Caption = 'Action2 Visible'
      TabOrder = 6
      OnClick = chAction3VisibleClick
    end
    object chAutoHideGroupItem: TCheckBox
      Left = 6
      Top = 241
      Width = 163
      Height = 17
      Caption = 'AutoHideGroupItem.Visible'
      TabOrder = 7
      OnClick = chAutoHideGroupItemClick
    end
    object StaticText2: TStaticText
      Left = 16
      Top = 264
      Width = 217
      Height = 18
      AutoSize = False
      Caption = 'TEsGroupBar.AutoHideEmptyGroup := True'
      Color = clInfoBk
      ParentColor = False
      TabOrder = 8
      Transparent = False
    end
    object chUniqueItemSelection: TCheckBox
      Left = 6
      Top = 309
      Width = 229
      Height = 17
      Caption = 'TEsGroupBar.UnquineSelection'
      TabOrder = 9
      OnClick = chUniqueItemSelectionClick
    end
    object btnView: TButton
      Left = 6
      Top = 463
      Width = 115
      Height = 25
      Caption = 'View EsGroup1'
      TabOrder = 10
      OnClick = btnViewClick
    end
    object chCanCloseGroup: TCheckBox
      Left = 6
      Top = 332
      Width = 227
      Height = 17
      Caption = 'TEsGroupBar.CanCloseGroup'
      TabOrder = 11
      OnClick = chCanCloseGroupClick
    end
    object chShowSeparator: TCheckBox
      Left = 6
      Top = 371
      Width = 227
      Height = 17
      Caption = 'TEsGroupStyle.ShowSeparator'
      TabOrder = 12
      OnClick = chShowSeparatorClick
    end
    object chAccuracyItemHitTest: TCheckBox
      Left = 6
      Top = 394
      Width = 227
      Height = 17
      Caption = 'TEsGroupStyle.AccuracyItemHitTest'
      TabOrder = 13
      OnClick = chAccuracyItemHitTestClick
    end
    object chTextGlow: TCheckBox
      Left = 6
      Top = 417
      Width = 227
      Height = 17
      Caption = 'TEsGroupStyle.TextGlow'
      TabOrder = 14
      OnClick = chTextGlowClick
    end
    object chUnderlineHotItem: TCheckBox
      Left = 6
      Top = 440
      Width = 227
      Height = 17
      Caption = 'TEsGroupStyle.UnderlineHotItem'
      TabOrder = 15
      OnClick = chUnderlineHotItemClick
    end
  end
  object ActionList1: TActionList
    Images = ImageList1
    Left = 464
    Top = 56
    object Action1: TAction
      Caption = 'Action1'
      ImageIndex = 0
      OnExecute = Action1Execute
    end
    object Action2: TAction
      Caption = 'Action2'
      ImageIndex = 3
      OnExecute = Action1Execute
    end
    object Action3: TAction
      Caption = 'Action3'
      Enabled = False
      ImageIndex = 4
      OnExecute = Action1Execute
    end
    object Action4: TAction
      Caption = 'Action4'
      ImageIndex = 2
      OnExecute = Action1Execute
    end
    object Action5: TAction
      Caption = 'Action5'
      ImageIndex = 1
      OnExecute = Action1Execute
    end
  end
  object ImageList1: TImageList
    ColorDepth = cd32Bit
    Left = 464
    Top = 104
    Bitmap = {
      494C010105000800340110001000FFFFFFFF2110FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000002000000001002000000000000020
      000000000000000000000000000000000000183948C02B6581FF2B6581FF2B65
      81FF2B6581FF2B6581FF2B6581FF2B6581FF2B6581FF2B6581FF2B6581FF1021
      2BFF1F2D36FF152D3CEF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000003B7C99FF4FA2C5FF4FA2C5FF4FA2
      C5FF4FA2C5FF4FA2C5FF4FA2C5FF4FA2C5FF4FA2C5FF4FA2C5FF3B7C99FF1E2E
      35FFE99464FF284050FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000003F819EFF52A6CAFF52A6CAFF52A6
      CAFF52A6CAFF52A6CAFF52A6CAFF52A6CAFF52A6CAFF52A6CAFF3F819EFF2138
      43FFE99464FF2C4D63FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004486A2FF55ABCEFF55ABCEFF55AB
      CEFF55ABCEFF55ABCEFF55ABCEFF55ABCEFF55ABCEFF55ABCEFF4486A2FF243D
      49FFDCDCDCFF32566DFF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000498AA5FF58B0D1FF58B0D1FF58B0
      D1FF58B0D1FF58B0D1FF58B0D1FF58B0D1FF58B0D1FF58B0D1FF498AA5FF263F
      4BFFDCDCDCFF365D73FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004E90A9FF5BB5D5FF5BB5D5FF5BB5
      D5FF5BB5D5FF5BB5D5FF5BB5D5FF5BB5D5FF5BB5D5FF5BB5D5FF4E90A9FF2941
      4CFFDCDCDCFF3C6478FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000005395AEFF5EBAD9FF5EBAD9FF5EBA
      D9FF5EBAD9FF5EBAD9FF5EBAD9FF5EBAD9FF5EBAD9FF5EBAD9FF5395AEFF2B43
      4EFFDCDCDCFF426A7EFF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000589BB1FF62C0DDFF62C0DDFF62C0
      DDFF62C0DDFF62C0DDFF62C0DDFF62C0DDFF62C0DDFF62C0DDFF599EB6FF3F61
      70FF355564FF3F5E6EEF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000005D9FB5FF65C5E1FF65C5E1FF65C5
      E1FF65C5E1FF65C5E1FF65C5E1FF65C5E1FF65C5E1FF65C5E1FF65C5E1FF60AC
      C5FF52798AFF0001012000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000063A4B9FF68CBE5FF68CBE5FF68CB
      E5FF68CBE5FF68CBE5FF68CBE5FF68CBE5FF68CBE5FF68CBE5FF68CBE5FF68CB
      E5FF63A4B9FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000068AABEFF6BD0E9FF6BD0E9FF6BD0
      E9FF6BD0E9FF6BD0E9FF6BD0E9FF6BD0E9FF6BD0E9FF6BD0E9FF6BD0E9FF6BD0
      E9FF68AABEFF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000006CAFC1FF6ED5EDFF6ED5EDFF6ED5
      EDFF6ED5EDFF6ED5EDFF6ED5EDFF6ED5EDFF6ED5EDFF6ED5EDFF6ED5EDFF6ED5
      EDFF6CAFC1FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000072B4C5FF72DAF0FF72DAF0FF72DA
      F0FF72DAF0FF72DAF0FF72DAF0FF72DAF0FF72DAF0FF72DAF0FF72DAF0FF72DA
      F0FF72B4C5FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000077B9CBFF75E0F6FF75E0F6FF75E0
      F6FF75E0F6FF75E0F6FF75E0F6FF75E0F6FF75E0F6FF75E0F6FF75E0F6FF75E0
      F6FF77B9CBFF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007DBFCFFF78E5FAFF78E5FAFF78E5
      FAFF78E5FAFF78E5FAFF78E5FAFF78E5FAFF78E5FAFF78E5FAFF78E5FAFF78E5
      FAFF7DBFCFFF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004A6F78C083C4D3FF83C4D3FF83C4
      D3FF83C4D3FF83C4D3FF83C4D3FF83C4D3FF83C4D3FF83C4D3FF83C4D3FF83C4
      D3FF4A6F78C00000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000031724600C6C
      A8CF13A4FFFF13A4FFFF13A4FFFF13A4FFFF13A4FFFF13A4FFFF008305FF0081
      00FF007F04FC0317246000000000000000000000000000000000031724600C6C
      A8CF13A4FFFF13A4FFFF13A4FFFFA9A5A0FFA9A5A0FFA9A5A0FFA9A5A0FFA9A5
      A0FFA9A5A0FFA9A5A0FFA9A5A0FFA9A5A0FF0000000000000000051924601878
      A8CF24B6FFFF24B6FFFF24B6FFFF24B6FFFF24B6FFFF24B6FFFF24B6FFFF24B6
      FFFF1878A8CF0519246000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000001190E0EF109A
      F7FB1EABFFFF48C7FFFF5BD1FFFF52D1FFFF45D3FFFF4BD8FFFF008100FF129E
      15FF008100FF1190E0EF000000000000000000000000000000001190E0EF109A
      F7FB1EABFFFF48C7FFFF5BD1FFFFA9A5A0FFFEFCFBFFFCFAF6FFE7CCBCFFB065
      40FFF2E2D7FFF8EFE6FFF8EEE2FFA9A5A0FF000000000000000020A0E0EF1FAD
      F7FB32BCFFFF62D4FFFF75DCFFFF6CDCFFFF5FDDFFFF65E1FFFF62DFFFFF42CF
      FFFF2CBAF7FB20A0E0EF000000000000000000000000000D155D2776E1FF082A
      499F000102200000000000000000000000000000000000000000000000000001
      0220082A499F2273E1FF000D155D00000000000000000000000013A4FFFF34B8
      FFFF48C7FFFF87E1FFFFA5EBFFFF8FE9FFFF72E6FFFF76E9FFFF008100FF2BAF
      2CFF008100FF13A4FFFF0000000000000000000000000000000013A4FFFF34B8
      FFFF48C7FFFF87E1FFFFA5EBFFFFA9A5A0FFFCFAF6FFFCF7F2FFB66A40FFB55D
      28FFC0815EFFF8EEE2FFF7EBDEFFA9A5A0FF000000000000000024B6FFFF4CC8
      FFFF62D4FFFF9DE8FFFFB7F0FFFFA4EEFFFF8BECFFFF8FEEFFFF8CEDFFFF6EE1
      FFFF31C1FFFF24B6FFFF000000000000000000000000000305302A7BEDFF3B9A
      FFFF3076C4EF061D2E8000000010000000000000000000000010061C2E802D6F
      C4EF3795FFFF2577EDFF0003053000000000000000000000000013A4FFFF57CA
      FFFF45C6FFFF82DEFFFFA1EAFFFF028705FF008100FF008100FF008100FF45C0
      46FF008100FF008100FF008100FF007000EF000000000000000013A4FFFF57CA
      FFFF45C6FFFF82DEFFFFA1EAFFFFA9A5A0FFFCF7F2FFE2C5B4FFC6753AFFC572
      34FFAC4F1BFFEFDCCCFFF6E9D9FFA9A5A0FF000000000000000024B6FFFF71D6
      FFFF5FD3FFFF99E6FFFFB4EFFFFF9DEBFFFF1E32AAFF010192FF010192FF0101
      92FF010192FF010192FF010192FF010160CF0000000000000000104E87CF37AC
      FFFF3BB9FFFF49B0F9FF2871A3DF02101860020F18602A71B9EF4194F9FF31A1
      FFFF2D94FFFF0D4787CF0000000000000000000000000000000013A4FFFF72D4
      FFFF42C6FFFF7DDDFFFF9CE7FFFF008100FF95E696FF98E998FF89E788FF65DD
      64FF45C244FF20A320FF0A900AFF008100FF000000000000000013A4FFFF72D4
      FFFF42C6FFFF7DDDFFFF9CE7FFFFA9A5A0FFFBF4EEFFD5A78BFFC47D4FFFBF7D
      59FFC26929FFBF7E59FFF4E6D5FFA9A5A0FF000000000000000024B6FFFF8BDE
      FFFF5CD3FFFF95E5FFFFAFEDFFFF96E8FFFF090997FF7070F3FF7373F4FF6A6A
      F4FF3C3CE3FF1414C4FF0202A9FF010192FF0000000000000000010F18603FBC
      F9FF41CBFFFF43CCFFFF48CAFFFF4BBCF9FF47B5F9FF3EB6FFFF33AFFFFF2EA6
      FFFF257EF9FF010E18600000000000000000000000000000000013A4FFFF8FDD
      FFFF3EC5FFFF77DCFFFF96E3FFFF028705FF008100FF008100FF008100FF87E5
      88FF008100FF008100FF008100FF007000EF000000000000000013A4FFFF8FDD
      FFFF3EC5FFFF77DCFFFF96E3FFFFA9A5A0FFFAF2EAFFF8EFE6FFF8EEE2FFF7EB
      DEFFC17644FFA34415FFEBD5C0FFA9A5A0FF000000000000000024B6FFFFA4E5
      FFFF57D2FFFF90E4FFFFAAEAFFFF8DE4FFFF1A30AAFF090997FF090997FF0909
      97FF090997FF090997FF090997FF010160CF0000000000000000000000103293
      BEEF57D3FFFF57D3FFFF55D3FFFF4FD1FFFF47CEFFFF3FCAFFFF38BEFFFF30A7
      FFFF105FBEEF000000100000000000000000000000000000000013A4FFFFACE6
      FFFF42C7FFFF72DAFFFF90E3FFFF6AD8FFFF3ECBFFFF3DCAFFFF008100FF90E5
      90FF008100FF13A4FFFF0000000000000000000000000000000013A4FFFFACE6
      FFFF42C7FFFF72DAFFFF90E3FFFFA9A5A0FFF8EFE6FFF8EEE2FFF7EBDEFFF6E9
      D9FFCB9776FFA34618FFB87451FFA9A5A0FF000000000000000024B6FFFFBDEC
      FFFF5CD4FFFF8BE3FFFFA5EAFFFF84E1FFFF57D7FFFF56D6FFFF54D6FFFF44CD
      FFFF4AC8FFFF24B6FFFF00000000000000000000000000000000000000000A30
      459F84E1FFFF6EDBFFFF6DDBFFFF65D8FFFF5AD5FFFF4BD0FFFF3FCAFFFF239F
      FFFF0228459F00000000000000000000000000000000000000001298EBF57ACF
      F9FCB1E7FFFFC5F0FFFFC9F2FFFFC7F2FFFFC5F0FFFFC5F0FFFF008100FF84E0
      87FF008100FF1296E9F4000000000000000000000000000000001298EBF57ACF
      F9FCB1E7FFFFC5F0FFFFC9F2FFFFA9A5A0FFF8EEE2FFF7EBDEFFF6E9D9FFF4E6
      D5FFF3E3D1FFAC5E3AFFB26A45FFA9A5A0FF000000000000000022A8EBF590D8
      F9FCC1EDFFFFD2F4FFFFD5F5FFFFD4F5FFFFD2F4FFFFD2F4FFFFD2F4FFFFCEF1
      FFFF8ED9FBFD21A6E9F40000000000000000000000000000000000060A4081AF
      C4EFA8EBFFFF83E3FFFF82E2FFFF79DFFFFF6CDAFFFF5AD4FFFF48CEFFFF2AB3
      FFFF0B6AC4EF00060A40000000000000000000000000000000001296E9F40F9D
      FBFD1AABFFFF30BCFFFF3DC6FFFF3BC9FFFF36CCFFFF3CD1FFFF008605FF0081
      00FF008305FF1298EBF5000000000000000000000000000000001296E9F40F9D
      FBFD1AABFFFF30BCFFFF3DC6FFFFA9A5A0FFA9A5A0FFA9A5A0FFA9A5A0FFA9A5
      A0FFA9A5A0FFA9A5A0FFA9A5A0FFA9A5A0FF000000000000000021A6E9F41EAF
      FBFD2DBCFFFF48CBFFFF56D3FFFF54D5FFFF4FD8FFFF55DCFFFF52DAFFFF40CE
      FFFF29BBFBFD22A8EBF500000000000000000000000006111860A9D4E7FFC2F4
      FFFFB5F3FFFFB0F2FFFF97ECFFFF87E5FFFF7ADFFFFF67D8FFFF51D1FFFF41CB
      FFFF29A7FFFF0D70E7FF000E186000000000000000000000000013A4FFFF2DB4
      FFFF46C6FFFF86E1FFFFA6EBFFFF90E9FFFF74E6FFFF78EAFFFF75E7FFFF55D9
      FFFF1DB2FFFF14A9FFFF0000000000000000000000000000000013A4FFFF2DB4
      FFFF46C6FFFF86E1FFFFA6EBFFFF90E9FFFF74E6FFFF78EAFFFF75E7FFFF55D9
      FFFF1DB2FFFF14A9FFFF0000000000000000000000000000000024B6FFFF45C3
      FFFF60D3FFFF9CE8FFFFB8F0FFFFA5EEFFFF8DECFFFF91EFFFFF8EEDFFFF6FE2
      FFFF31C2FFFF25BAFFFF00000000000000000F232E7FB5DCEDFFB7F0FFFFB8F2
      FFFFC2F5FFFFC5F9FFFFBFF8FFFFB2F3FFFF9BEAFFFF7CDEFFFF58D3FFFF45CC
      FFFF3ABFFFFF2BA1FFFF0D68EDFF0226499F000000000000000013A4FFFF54C9
      FFFF44C6FFFF82DEFFFFA3EAFFFF89E6FFFF68E0FFFF6AE2FFFF67E1FFFF4CD4
      FFFF1CB0FFFF14A9FFFF0000000000000000000000000000000013A4FFFF54C9
      FFFF44C6FFFF82DEFFFFA3EAFFFF89E6FFFF68E0FFFF6AE2FFFF67E1FFFF4CD4
      FFFF1CB0FFFF14A9FFFF0000000000000000000000000000000024B6FFFF6ED5
      FFFF5ED3FFFF99E6FFFFB5EFFFFF9FECFFFF82E7FFFF84E9FFFF81E8FFFF66DE
      FFFF30C0FFFF25BAFFFF0000000000000000517588CCA0D1E7FFA3D1E7FFA8D3
      E7FFA9D4E7FFC8E9F3FFCBF8FFFFB4F4FFFF9FF0FFFF94E9FFFF6FCFF3FF38B3
      E7FF27A8E7FF1B8CE7FF177EE7FF177EE7FF000000000000000013A4FFFF6DD1
      FFFF41C5FFFF7DDDFFFF9DE7FFFF81E2FFFF5BD9FFFF5ADAFFFF58D9FFFF42CE
      FFFF19ACFFFF14A9FFFF0000000000000000000000000000000013A4FFFF6DD1
      FFFF41C5FFFF7DDDFFFF9DE7FFFF81E2FFFF5BD9FFFF5ADAFFFF58D9FFFF42CE
      FFFF19ACFFFF14A9FFFF0000000000000000000000000000000024B6FFFF87DC
      FFFF5BD2FFFF95E5FFFFB0EDFFFF98E9FFFF75E2FFFF74E3FFFF72E2FFFF5CD9
      FFFF2CBDFFFF25BAFFFF00000000000000000000000000000000000000000000
      0000000000000D202D80DEF9FFFFB5F2FFFF9BEFFFFF8DE8FFFF1032469F0000
      000000000000000000000000000000000000000000000000000013A4FFFF8ADC
      FFFF3EC5FFFF77DAFFFF97E5FFFF76DDFFFF4DD3FFFF4CD3FFFF4BD3FFFF38C6
      FFFF15A7FFFF14A9FFFF0000000000000000000000000000000013A4FFFF8ADC
      FFFF3EC5FFFF77DAFFFF97E5FFFF76DDFFFF4DD3FFFF4CD3FFFF4BD3FFFF38C6
      FFFF15A7FFFF14A9FFFF0000000000000000000000000000000024B6FFFFA0E4
      FFFF57D2FFFF90E3FFFFABEBFFFF8FE5FFFF67DDFFFF66DDFFFF65DDFFFF51D3
      FFFF27B9FFFF25BAFFFF00000000000000000000000000000000000000000000
      00000000000000010220B0D4E7FFB2F0FFFF94EDFFFF70C7E7FF000102200000
      000000000000000000000000000000000000000000000000000013A4FFFFA7E5
      FFFF39C5FFFF72DAFFFF91E2FFFF6DD9FFFF40CBFFFF3FCBFFFF3DCBFFFF2EC0
      FFFF22AFFFFF14A9FFFF0000000000000000000000000000000013A4FFFFA7E5
      FFFF39C5FFFF72DAFFFF91E2FFFF6DD9FFFF40CBFFFF3FCBFFFF3DCBFFFF2EC0
      FFFF22AFFFFF14A9FFFF0000000000000000000000000000000024B6FFFFB9EB
      FFFF52D2FFFF8BE3FFFFA6E9FFFF87E2FFFF5AD7FFFF58D7FFFF56D7FFFF46CE
      FFFF37BFFFFF25BAFFFF00000000000000000000000000000000000000000000
      00000000000000000000416275BFB3EFFFFF90EAFFFF2B5C75BF000000000000
      00000000000000000000000000000000000000000000000000001190E0EF91D6
      F7FBB6EBFFFFB0EBFFFFBCEFFFFFB0EBFFFF9FE6FFFF9EE6FFFF9DE6FFFFABE9
      FFFF84D6F9FC1594E1F0000000000000000000000000000000001190E0EF91D6
      F7FBB6EBFFFFB0EBFFFFBCEFFFFFB0EBFFFF9FE6FFFF9EE6FFFF9DE6FFFFABE9
      FFFF84D6F9FC1594E1F00000000000000000000000000000000020A0E0EFA3DD
      F7FBC5F0FFFFC0F0FFFFCBF3FFFFC0F0FFFFB2ECFFFFB1ECFFFFB0ECFFFFBCEE
      FFFF9ADEF9FC25A4E1F000000000000000000000000000000000000000000000
      00000000000000000000000E16609ADCF3FF85D9F6FF000E1660000000000000
      0000000000000000000000000000000000000000000000000000031724600C6C
      A8CF13A4FFFF13A4FFFF13A4FFFF13A4FFFF13A4FFFF13A4FFFF13A4FFFF13A4
      FFFF0E7DC3DF0317246000000000000000000000000000000000031724600C6C
      A8CF13A4FFFF13A4FFFF13A4FFFF13A4FFFF13A4FFFF13A4FFFF13A4FFFF13A4
      FFFF0E7DC3DF0317246000000000000000000000000000000000051924601878
      A8CF24B6FFFF24B6FFFF24B6FFFF24B6FFFF24B6FFFF24B6FFFF24B6FFFF24B6
      FFFF1B8BC3DF0519246000000000000000000000000000000000000000000000
      0000000000000000000000000000264F65B21B4256A600000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000200000000100010000000000000100000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000}
  end
end
