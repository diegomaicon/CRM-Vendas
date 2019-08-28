object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  Caption = 'CRM Vendas'
  ClientHeight = 720
  ClientWidth = 1024
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 16
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 1018
    Height = 714
    Align = alClient
    TabOrder = 0
    ExplicitLeft = -2
    ExplicitTop = -2
    object tabSuperior: TPanel
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 157
      Height = 706
      Align = alLeft
      TabOrder = 0
      object btnInserir: TBitBtn
        Left = 1
        Top = 70
        Width = 155
        Height = 40
        Align = alTop
        Caption = '&Cart'#243'rios'
        TabOrder = 0
        OnClick = btnInserirClick
        ExplicitTop = 36
        ExplicitWidth = 100
      end
      object btnAlterar: TBitBtn
        Left = 1
        Top = 130
        Width = 155
        Height = 40
        Margins.Top = 10
        Margins.Bottom = 10
        Align = alTop
        TabOrder = 1
        ExplicitTop = 96
        ExplicitWidth = 100
      end
      object btnConsultar: TBitBtn
        Left = 1
        Top = 190
        Width = 155
        Height = 40
        Margins.Top = 10
        Margins.Bottom = 10
        Align = alTop
        TabOrder = 2
        ExplicitLeft = 0
      end
      object btnExcluir: TBitBtn
        Left = 1
        Top = 250
        Width = 155
        Height = 40
        Margins.Top = 10
        Margins.Bottom = 10
        Align = alTop
        TabOrder = 3
        ExplicitTop = 216
        ExplicitWidth = 100
      end
      object Panel2: TPanel
        Left = 1
        Top = 110
        Width = 155
        Height = 20
        Align = alTop
        Enabled = False
        TabOrder = 4
        ExplicitTop = 76
        ExplicitWidth = 100
      end
      object Panel3: TPanel
        Left = 1
        Top = 1
        Width = 155
        Height = 69
        Align = alTop
        Enabled = False
        TabOrder = 5
        ExplicitWidth = 100
      end
      object Panel4: TPanel
        Left = 1
        Top = 170
        Width = 155
        Height = 20
        Align = alTop
        Enabled = False
        TabOrder = 6
        ExplicitTop = 136
        ExplicitWidth = 100
      end
      object Panel6: TPanel
        Left = 1
        Top = 230
        Width = 155
        Height = 20
        Align = alTop
        Enabled = False
        TabOrder = 7
        ExplicitTop = 196
        ExplicitWidth = 100
      end
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 247
    Top = 215
  end
end
