object frmCadAgenda: TfrmCadAgenda
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
    object Label1: TLabel
      Left = 65
      Top = 61
      Width = 44
      Height = 16
      Caption = 'C'#243'digo:'
    end
    object Label2: TLabel
      Left = 66
      Top = 214
      Width = 60
      Height = 16
      Caption = 'Descri'#231#227'o:'
    end
    object Label5: TLabel
      Left = 64
      Top = 157
      Width = 107
      Height = 16
      Caption = 'Cod. Contato (F8):'
    end
    object edtCodigo: TEdit
      Left = 65
      Top = 78
      Width = 121
      Height = 24
      Enabled = False
      TabOrder = 0
      Text = 'edtCodigo'
    end
    object edtCodCartorio: TEdit
      Left = 64
      Top = 174
      Width = 81
      Height = 24
      TabOrder = 1
      OnExit = edtCodCartorioExit
      OnKeyDown = edtCodCartorioKeyDown
    end
    object edtNomeContato: TEdit
      Left = 151
      Top = 174
      Width = 346
      Height = 24
      Enabled = False
      TabOrder = 2
    end
    object edtData: TCalendarPicker
      Left = 64
      Top = 119
      Width = 201
      Height = 32
      CalendarHeaderInfo.DaysOfWeekFont.Charset = DEFAULT_CHARSET
      CalendarHeaderInfo.DaysOfWeekFont.Color = clWindowText
      CalendarHeaderInfo.DaysOfWeekFont.Height = -13
      CalendarHeaderInfo.DaysOfWeekFont.Name = 'Segoe UI'
      CalendarHeaderInfo.DaysOfWeekFont.Style = []
      CalendarHeaderInfo.Font.Charset = DEFAULT_CHARSET
      CalendarHeaderInfo.Font.Color = clWindowText
      CalendarHeaderInfo.Font.Height = -20
      CalendarHeaderInfo.Font.Name = 'Segoe UI'
      CalendarHeaderInfo.Font.Style = []
      Color = clWindow
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      TextHint = 'select a date'
    end
    object edtTarefa: TDBEdit
      Left = 66
      Top = 231
      Width = 439
      Height = 24
      DataField = 'AGE_TAREFA'
      DataSource = dsAgenda
      MaxLength = 100
      TabOrder = 4
    end
  end
  object dsAgenda: TDataSource
    DataSet = DM1.ibdAgenda
    Left = 483
    Top = 283
  end
end
