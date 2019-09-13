unit uDM;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, Data.Win.ADODB, Data.DB,
  FireDAC.Comp.Client,IniFiles,Vcl.Dialogs, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.UI;

type
  TDM1 = class(TDataModule)
    ConexaoFB: TFDConnection;
    ibqAuxiliar: TFDQuery;
    ibdCartorio: TFDTable;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    ibdContato: TFDTable;
    ibdAgenda: TFDTable;
    ibdAtividade: TFDTable;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);

  private
    { Private declarations }
    procedure CarragaINI(nomeArquivo:string);
    procedure GravaIni(nomeArquivo:string);


  public
    { Public declarations }
    var
      vgbPathDB,vgbUserDB,vgbPasswordDB:string;
      vgbUsuario:string;
      vgbCodUsuario:integer;
  end;

var
  DM1: TDM1;

implementation

{$R *.dfm}

procedure TDM1.DataModuleCreate(Sender: TObject);
begin
   ConexaoFB.Close;

   CarragaINI(ExtractFilePath(ParamStr(0))+'\ConfigDB.ini');
   if (vgbPathDB = '') or (vgbUserDB = '') or (vgbPasswordDB = '') then
   begin
      GravaIni(ExtractFilePath(ParamStr(0))+'\ConfigDB.ini')
   end
   else
   begin
      ConexaoFB.Params.Database :=  vgbPathDB;
      ConexaoFB.Params.UserName :=  vgbUserDB;
      ConexaoFB.Params.Password :=  vgbPasswordDB;
      try
         ConexaoFB.Open();
      except on E: Exception do
          MessageDlg('Erro ao conectar. Erro: '+E.ToString,mtInformation,[mbOk],0);
      end;

   end;
end;


procedure TDM1.DataModuleDestroy(Sender: TObject);
begin
    ConexaoFB.Close;
end;

procedure TDM1.CarragaINI(nomeArquivo:string);
var
    ArqIni : TIniFile;
begin
    try
        ArqIni := TIniFile.Create(nomeArquivo);
        vgbPathDB     := ArqIni.ReadString('CONEXAO', 'PATH','');
        vgbUserDB     := ArqIni.ReadString('CONEXAO', 'USER','');
        vgbPasswordDB := ArqIni.ReadString('CONEXAO', 'PASSWORD','');;
    finally
      ArqIni.Free
    end;

end;

procedure TDM1.GravaIni(nomeArquivo:string);
var
    ArqIni : TIniFile;
begin
   try
      ArqIni := TIniFile.Create(nomeArquivo);

      ArqIni.WriteString('CONEXAO', 'PATH', 'C:\CRM\DB\FB_CRM_VENDAS.FDB');
      ArqIni.WriteString('CONEXAO', 'USER','SYSDBA' );
      ArqIni.WriteString('CONEXAO', 'PASSWORD', 'masterkey');

   finally
      ArqIni.Free;
      CarragaINI(ExtractFilePath(ParamStr(0))+'\ConfigDB.ini');
   end;
end;

end.
