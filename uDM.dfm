object DM1: TDM1
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 355
  Width = 651
  object ConexaoFB: TFDConnection
    Params.Strings = (
      'Database=C:\CRM\DB\FB_CRM_VENDAS.FDB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'Protocol=TCPIP'
      'Server=127.0.0.1'
      'DriverID=FB')
    Connected = True
    LoginPrompt = False
    Left = 32
    Top = 24
  end
  object ibqAuxiliar: TFDQuery
    Connection = ConexaoFB
    Left = 56
    Top = 96
  end
  object ibdCartorio: TFDTable
    IndexFieldNames = 'CAR_ID'
    Connection = ConexaoFB
    UpdateOptions.UpdateTableName = 'TBL_CARTORIO'
    TableName = 'TBL_CARTORIO'
    Left = 184
    Top = 168
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 168
    Top = 32
  end
end