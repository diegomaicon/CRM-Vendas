object frmCadContato: TfrmCadContato
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
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object tabinferior: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 327
    Width = 594
    Height = 70
    Align = alBottom
    TabOrder = 0
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
  object tabSuperior: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 594
    Height = 318
    Align = alClient
    TabOrder = 1
    ExplicitLeft = 8
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
      Width = 36
      Height = 16
      Caption = 'Email:'
    end
    object Label4: TLabel
      Left = 281
      Top = 236
      Width = 56
      Height = 16
      Caption = 'Celular 2:'
    end
    object Label7: TLabel
      Left = 65
      Top = 185
      Width = 107
      Height = 16
      Caption = 'Telefone Principal:'
    end
    object Label8: TLabel
      Left = 65
      Top = 236
      Width = 56
      Height = 16
      Caption = 'Celular 1:'
    end
    object Label5: TLabel
      Left = 208
      Top = 35
      Width = 109
      Height = 16
      Caption = 'Cod. Cart'#243'rio (F8):'
    end
    object edtNome: TDBEdit
      Left = 65
      Top = 102
      Width = 456
      Height = 24
      DataField = 'CON_NOME'
      DataSource = dscontato
      TabOrder = 2
    end
    object edtEmail: TDBEdit
      Left = 65
      Top = 151
      Width = 456
      Height = 24
      DataField = 'CON_EMAIL'
      DataSource = dscontato
      TabOrder = 3
      OnExit = edtEmailExit
    end
    object edtPhone2: TDBEdit
      Left = 281
      Top = 254
      Width = 200
      Height = 24
      DataField = 'CON_PHONE_2'
      DataSource = dscontato
      MaxLength = 14
      TabOrder = 6
      OnKeyPress = edtTelefone_principalKeyPress
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
    object edtTelefone_principal: TDBEdit
      Left = 65
      Top = 201
      Width = 198
      Height = 24
      DataField = 'CON_PHONE_PRINCIPAL'
      DataSource = dscontato
      MaxLength = 14
      TabOrder = 4
      OnKeyPress = edtTelefone_principalKeyPress
    end
    object edtPhone1: TDBEdit
      Left = 64
      Top = 254
      Width = 199
      Height = 24
      DataField = 'CON_PHONE_1'
      DataSource = dscontato
      MaxLength = 14
      TabOrder = 5
    end
    object edtCodCartorio: TEdit
      Left = 208
      Top = 52
      Width = 81
      Height = 24
      TabOrder = 1
      OnExit = edtCodCartorioExit
      OnKeyDown = edtCodCartorioKeyDown
      OnKeyPress = edtCodCartorioKeyPress
    end
    object edtNomeCatorio: TEdit
      Left = 295
      Top = 52
      Width = 226
      Height = 24
      Enabled = False
      TabOrder = 7
      OnKeyPress = edtCodCartorioKeyPress
    end
  end
  object dscontato: TDataSource
    AutoEdit = False
    DataSet = DM1.ibdContato
    Left = 467
    Top = 259
  end
end
