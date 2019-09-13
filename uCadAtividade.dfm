object frmCadAtividade: TfrmCadAtividade
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
    object GroupBox1: TGroupBox
      Left = 23
      Top = 24
      Width = 546
      Height = 289
      Caption = '    +  Adicionar Compromisso      '
      TabOrder = 0
      object Label5: TLabel
        Left = 34
        Top = 145
        Width = 107
        Height = 16
        Caption = 'Cod. Contato (F8):'
      end
      object Label1: TLabel
        Left = 33
        Top = 49
        Width = 44
        Height = 16
        Caption = 'C'#243'digo:'
      end
      object Label2: TLabel
        Left = 34
        Top = 194
        Width = 60
        Height = 16
        Caption = 'Descri'#231#227'o:'
      end
      object edtCodContato: TEdit
        Left = 32
        Top = 162
        Width = 81
        Height = 24
        TabOrder = 2
        OnExit = edtCodContatoExit
        OnKeyDown = edtCodContatoKeyDown
      end
      object edtCodigo: TEdit
        Left = 33
        Top = 66
        Width = 121
        Height = 24
        Enabled = False
        TabOrder = 3
        Text = 'edtCodigo'
      end
      object edtData: TCalendarPicker
        Left = 32
        Top = 107
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
        Date = 43720.000000000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGray
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        IsEmpty = False
        ParentFont = False
        TabOrder = 0
        TextHint = 'Selecione Data'
      end
      object edtNomeContato: TEdit
        Left = 119
        Top = 162
        Width = 394
        Height = 24
        Enabled = False
        TabOrder = 4
      end
      object rgTipo: TRadioGroup
        Left = 256
        Top = 67
        Width = 257
        Height = 72
        Caption = '   Tipo de  Intera'#231#227'o    '
        Columns = 2
        ItemIndex = 0
        Items.Strings = (
          'Telefone'
          'Email'
          'Visita'
          'Outros')
        TabOrder = 1
      end
    end
  end
  object edtDEscircao: TDBMemo
    Left = 59
    Top = 238
    Width = 480
    Height = 62
    DataField = 'ATI_DESCRICAO'
    DataSource = dsAgenda
    TabOrder = 2
  end
  object dsAgenda: TDataSource
    DataSet = DM1.ibdAtividade
    Left = 483
    Top = 283
  end
end
