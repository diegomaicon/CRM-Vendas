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
    ExplicitLeft = -2
    object Label1: TLabel
      Left = 64
      Top = 50
      Width = 44
      Height = 16
      Caption = 'C'#243'digo:'
    end
    object Label2: TLabel
      Left = 64
      Top = 97
      Width = 38
      Height = 16
      Caption = 'Nome:'
    end
    object Label3: TLabel
      Left = 64
      Top = 150
      Width = 27
      Height = 16
      Caption = 'Cep:'
    end
    object Label4: TLabel
      Left = 232
      Top = 150
      Width = 44
      Height = 16
      Caption = 'Cidade:'
    end
    object Label5: TLabel
      Left = 475
      Top = 149
      Width = 20
      Height = 17
      Caption = 'UF:'
    end
    object Label6: TLabel
      Left = 65
      Top = 210
      Width = 78
      Height = 16
      Caption = 'Classifica'#231#227'o:'
    end
    object edtNome: TDBEdit
      Left = 64
      Top = 115
      Width = 441
      Height = 24
      DataField = 'CAR_NOME'
      DataSource = dsCartorio
      MaxLength = 100
      TabOrder = 0
    end
    object edtCep: TDBEdit
      Left = 64
      Top = 167
      Width = 121
      Height = 24
      DataField = 'CAR_CEP'
      DataSource = dsCartorio
      MaxLength = 8
      TabOrder = 1
    end
    object estCidade: TDBEdit
      Left = 232
      Top = 167
      Width = 233
      Height = 24
      DataField = 'CAR_CIDADE'
      DataSource = dsCartorio
      MaxLength = 50
      TabOrder = 2
    end
    object edtUF: TDBEdit
      Left = 471
      Top = 167
      Width = 34
      Height = 24
      DataField = 'CAR_UF'
      DataSource = dsCartorio
      MaxLength = 2
      TabOrder = 3
    end
    object DBComboBox1: TDBComboBox
      Left = 64
      Top = 227
      Width = 185
      Height = 24
      DataField = 'CAR_TIPO'
      DataSource = dsCartorio
      TabOrder = 4
    end
    object edtCodigo: TEdit
      Left = 65
      Top = 67
      Width = 121
      Height = 24
      TabOrder = 5
      Text = 'edtCodigo'
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
    ExplicitLeft = 8
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
    DataSet = DM1.ibdCartorio
    Left = 467
    Top = 259
  end
end
