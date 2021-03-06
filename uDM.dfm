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
  object ibdContato: TFDTable
    Active = True
    IndexFieldNames = 'CON_ID;CON_NOME'
    Connection = ConexaoFB
    UpdateOptions.AssignedValues = [uvGeneratorName, uvAutoCommitUpdates]
    UpdateOptions.GeneratorName = 'GEN_TBL_CONTATOS_ID'
    UpdateOptions.AutoCommitUpdates = True
    UpdateOptions.UpdateTableName = 'TBL_CONTATOS'
    UpdateOptions.KeyFields = 'CON_ID'
    UpdateOptions.AutoIncFields = 'CON_ID'
    TableName = 'TBL_CONTATOS'
    Left = 104
    Top = 160
  end
  object ibdAgenda: TFDTable
    IndexFieldNames = 'AGE_ID'
    Connection = ConexaoFB
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    UpdateOptions.AutoCommitUpdates = True
    UpdateOptions.UpdateTableName = 'TBL_AGENDA'
    UpdateOptions.KeyFields = 'AGE_ID'
    UpdateOptions.AutoIncFields = 'AGE_ID'
    TableName = 'TBL_AGENDA'
    Left = 176
    Top = 160
  end
  object ibdAtividade: TFDTable
    IndexFieldNames = 'ATI_ID'
    Connection = ConexaoFB
    UpdateOptions.AssignedValues = [uvGeneratorName]
    UpdateOptions.GeneratorName = 'GEN_TBL_ATIVIDADE_ID'
    UpdateOptions.UpdateTableName = 'TBL_ATIVIDADE'
    UpdateOptions.KeyFields = 'ATI_ID'
    UpdateOptions.AutoIncFields = 'ATI_ID'
    TableName = 'TBL_ATIVIDADE'
    Left = 32
    Top = 232
  end
end
