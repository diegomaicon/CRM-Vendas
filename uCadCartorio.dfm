object frmCadCartorio: TfrmCadCartorio
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsNone
  Caption = 'Cadatro Cart'#243'rio'
  ClientHeight = 400
  ClientWidth = 600
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object tabSuperior: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 594
    Height = 318
    Align = alClient
    TabOrder = 0
    object Label1: TLabel
      Left = 65
      Top = 35
      Width = 44
      Height = 16
      Caption = 'C'#243'digo:'
    end
    object Label2: TLabel
      Left = 65
      Top = 82
      Width = 38
      Height = 16
      Caption = 'Nome:'
    end
    object Label3: TLabel
      Left = 65
      Top = 135
      Width = 27
      Height = 16
      Caption = 'Cep:'
    end
    object Label4: TLabel
      Left = 281
      Top = 188
      Width = 44
      Height = 16
      Caption = 'Cidade:'
    end
    object Label5: TLabel
      Left = 501
      Top = 188
      Width = 20
      Height = 16
      Caption = 'UF:'
    end
    object Label6: TLabel
      Left = 65
      Top = 243
      Width = 78
      Height = 16
      Caption = 'Classifica'#231#227'o:'
    end
    object Label7: TLabel
      Left = 165
      Top = 135
      Width = 58
      Height = 16
      Caption = 'Endere'#231'o:'
    end
    object Label8: TLabel
      Left = 65
      Top = 188
      Width = 39
      Height = 16
      Caption = 'Bairro:'
    end
    object lblBusca: TLabel
      Left = 65
      Top = 175
      Width = 48
      Height = 11
      Caption = 'Buscando...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object edtNome: TDBEdit
      Left = 64
      Top = 100
      Width = 465
      Height = 24
      DataField = 'CAR_NOME'
      DataSource = dsCartorio
      TabOrder = 1
    end
    object edtCep: TDBEdit
      Left = 65
      Top = 151
      Width = 85
      Height = 24
      DataField = 'CAR_CEP'
      DataSource = dsCartorio
      MaxLength = 8
      TabOrder = 2
      OnExit = edtCepExit
      OnKeyPress = edtCepKeyPress
    end
    object estCidade: TDBEdit
      Left = 281
      Top = 206
      Width = 200
      Height = 24
      DataField = 'CAR_CIDADE'
      DataSource = dsCartorio
      TabOrder = 5
    end
    object edtUF: TDBEdit
      Left = 497
      Top = 206
      Width = 32
      Height = 24
      DataField = 'CAR_UF'
      DataSource = dsCartorio
      TabOrder = 6
    end
    object DBComboBox1: TDBComboBox
      Left = 65
      Top = 260
      Width = 185
      Height = 24
      DataField = 'CAR_TIPO'
      DataSource = dsCartorio
      TabOrder = 7
    end
    object edtCodigo: TEdit
      Left = 65
      Top = 52
      Width = 121
      Height = 24
      Enabled = False
      TabOrder = 0
      Text = 'edtCodigo'
    end
    object edtEndereco: TDBEdit
      Left = 165
      Top = 152
      Width = 364
      Height = 24
      DataField = 'CAR_ENDERECO'
      DataSource = dsCartorio
      TabOrder = 3
    end
    object edtBairro: TDBEdit
      Left = 65
      Top = 206
      Width = 199
      Height = 24
      DataField = 'CAR_BAIRRO'
      DataSource = dsCartorio
      TabOrder = 4
    end
  end
  object tabinferior: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 327
    Width = 594
    Height = 70
    Align = alBottom
    TabOrder = 1
    object btnConfirmar: TButton
      Left = 165
      Top = 14
      Width = 100
      Height = 40
      Caption = 'Confirmar'
      TabOrder = 0
      OnClick = btnConfirmarClick
    end
    object btnCancelar: TButton
      Left = 325
      Top = 14
      Width = 100
      Height = 40
      Caption = 'Cancelar'
      TabOrder = 1
      OnClick = btnCancelarClick
    end
  end
  object dsCartorio: TDataSource
    AutoEdit = False
    DataSet = DM1.ibdCartorio
    Left = 467
    Top = 259
  end
  object RESTClient1: TRESTClient
    Params = <>
    Left = 379
    Top = 19
  end
  object RESTResponse1: TRESTResponse
    Left = 539
    Top = 19
  end
  object RESTRequest1: TRESTRequest
    Client = RESTClient1
    Params = <>
    Response = RESTResponse1
    SynchronizedEvents = False
    Left = 459
    Top = 19
  end
end
