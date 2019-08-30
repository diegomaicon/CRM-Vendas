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
    LoginPrompt = False
    Left = 32
    Top = 24
  end
  object ibqAuxiliar: TFDQuery
    Connection = ConexaoFB
    Left = 32
    Top = 96
  end
  object ibdCartorio: TFDTable
    IndexFieldNames = 'CAR_ID'
    Connection = ConexaoFB
    UpdateOptions.AssignedValues = [uvGeneratorName, uvAutoCommitUpdates]
    UpdateOptions.GeneratorName = 'GEN_TBL_CARTORIO_ID'
    UpdateOptions.AutoCommitUpdates = True
    UpdateOptions.UpdateTableName = 'TBL_CARTORIO'
    UpdateOptions.AutoIncFields = 'CAR_ID'
    TableName = 'TBL_CARTORIO'
    Left = 32
    Top = 160
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 168
    Top = 32
  end
end
