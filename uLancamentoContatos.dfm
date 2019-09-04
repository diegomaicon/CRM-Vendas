object frmGridContato: TfrmGridContato
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Contatos'
  ClientHeight = 720
  ClientWidth = 1024
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnKeyDown = i
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object tabLateral: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 102
    Height = 628
    Align = alLeft
    TabOrder = 0
    object btnInserir: TBitBtn
      Left = 1
      Top = 36
      Width = 100
      Height = 40
      Align = alTop
      Caption = '&Inserir'
      TabOrder = 0
      OnClick = btnInserirClick
      OnKeyDown = btnInserirKeyDown
    end
    object btnAlterar: TBitBtn
      Left = 1
      Top = 96
      Width = 100
      Height = 40
      Margins.Top = 10
      Margins.Bottom = 10
      Align = alTop
      Caption = '&Alterar'
      TabOrder = 1
      OnClick = btnAlterarClick
    end
    object btnConsultar: TBitBtn
      Left = 1
      Top = 156
      Width = 100
      Height = 40
      Margins.Top = 10
      Margins.Bottom = 10
      Align = alTop
      Caption = '&Consultar'
      TabOrder = 2
      OnClick = btnConsultarClick
    end
    object btnExcluir: TBitBtn
      Left = 1
      Top = 216
      Width = 100
      Height = 40
      Margins.Top = 10
      Margins.Bottom = 10
      Align = alTop
      Caption = '&Excluir'
      TabOrder = 3
      OnClick = btnExcluirClick
    end
    object Panel2: TPanel
      Left = 1
      Top = 76
      Width = 100
      Height = 20
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      ParentCustomHint = False
      Align = alTop
      Anchors = []
      BevelEdges = []
      BiDiMode = bdLeftToRight
      Ctl3D = True
      UseDockManager = False
      DoubleBuffered = False
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentBiDiMode = False
      ParentBackground = False
      ParentCtl3D = False
      ParentDoubleBuffered = False
      ParentFont = False
      ParentShowHint = False
      ShowCaption = False
      ShowHint = False
      TabOrder = 4
    end
    object Panel3: TPanel
      Left = 1
      Top = 1
      Width = 100
      Height = 35
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      ParentCustomHint = False
      Align = alTop
      Anchors = []
      BevelEdges = []
      BiDiMode = bdLeftToRight
      Ctl3D = True
      UseDockManager = False
      DoubleBuffered = False
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentBiDiMode = False
      ParentBackground = False
      ParentCtl3D = False
      ParentDoubleBuffered = False
      ParentFont = False
      ParentShowHint = False
      ShowCaption = False
      ShowHint = False
      TabOrder = 5
    end
    object Panel4: TPanel
      Left = 1
      Top = 136
      Width = 100
      Height = 20
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      ParentCustomHint = False
      Align = alTop
      Anchors = []
      BevelEdges = []
      BiDiMode = bdLeftToRight
      Ctl3D = True
      UseDockManager = False
      DoubleBuffered = False
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentBiDiMode = False
      ParentBackground = False
      ParentCtl3D = False
      ParentDoubleBuffered = False
      ParentFont = False
      ParentShowHint = False
      ShowCaption = False
      ShowHint = False
      TabOrder = 6
    end
    object Panel6: TPanel
      Left = 1
      Top = 196
      Width = 100
      Height = 20
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      ParentCustomHint = False
      Align = alTop
      Anchors = []
      BevelEdges = []
      BiDiMode = bdLeftToRight
      Ctl3D = True
      UseDockManager = False
      DoubleBuffered = False
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentBiDiMode = False
      ParentBackground = False
      ParentCtl3D = False
      ParentDoubleBuffered = False
      ParentFont = False
      ParentShowHint = False
      ShowCaption = False
      ShowHint = False
      TabOrder = 7
    end
  end
  object tabMeio: TPanel
    AlignWithMargins = True
    Left = 111
    Top = 3
    Width = 910
    Height = 628
    Align = alClient
    TabOrder = 1
    object gridContato: TDBGrid
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 902
      Height = 620
      Align = alClient
      DataSource = dsConsulta
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -13
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnDblClick = gridContatoDblClick
      Columns = <
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'CON_ID'
          Title.Caption = 'ID'
          Width = 50
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CARTORIO'
          Title.Caption = 'Cart'#243'rio'
          Width = 131
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CON_NOME'
          Title.Caption = 'Nome'
          Width = 200
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CON_EMAIL'
          Title.Caption = 'Email'
          Width = 200
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CON_PHONE_PRINCIPAL'
          Title.Caption = 'Telefone'
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CON_PHONE_1'
          Title.Caption = 'Celular 1'
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CON_PHONE_2'
          Title.Caption = 'Celular 2'
          Width = 250
          Visible = True
        end>
    end
  end
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 637
    Width = 1018
    Height = 80
    Align = alBottom
    TabOrder = 2
    object edtBusca: TEdit
      Left = 112
      Top = 32
      Width = 396
      Height = 24
      TabOrder = 0
    end
    object Button1: TButton
      Left = 528
      Top = 32
      Width = 89
      Height = 25
      Caption = '&Buscar'
      TabOrder = 1
      OnClick = Button1Click
    end
  end
  object ibqConsulta: TFDQuery
    Connection = DM1.ConexaoFB
    SQL.Strings = (
      'Select * from TBL_USUARIO'
      ' Where USU_LOGIN = '#39'DIEGO'#39'   and USU_SENHA = '#39#39)
    Left = 136
    Top = 80
  end
  object dsConsulta: TDataSource
    DataSet = ibqConsulta
    OnDataChange = dsConsultaDataChange
    Left = 136
    Top = 152
  end
end
