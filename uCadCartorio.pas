unit uCadCartorio;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.DBCtrls,
  Vcl.Mask, Vcl.ExtCtrls,uFuncoes, REST.Client, Web.HTTPApp,REST.Types,
  IPPeerClient, Data.Bind.Components, Data.Bind.ObjectScope, System.JSON;

type
  TfrmCadCartorio = class(TForm)
    tabSuperior: TPanel;
    tabinferior: TPanel;
    btnConfirmar: TButton;
    btnCancelar: TButton;
    edtNome: TDBEdit;
    edtCep: TDBEdit;
    estCidade: TDBEdit;
    edtUF: TDBEdit;
    DBComboBox1: TDBComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    dsCartorio: TDataSource;
    edtCodigo: TEdit;
    RESTClient1: TRESTClient;
    RESTResponse1: TRESTResponse;
    RESTRequest1: TRESTRequest;
    edtEndereco: TDBEdit;
    Label7: TLabel;
    edtBairro: TDBEdit;
    Label8: TLabel;
    lblBusca: TLabel;
    procedure btnCancelarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtCepExit(Sender: TObject);
    procedure edtCepKeyPress(Sender: TObject; var Key: Char);

  private
    { Private declarations }
     procedure HabilitaComponentes(status:Boolean);
     function  MostraProximoID:Integer;
     procedure BuscaCep(cep:string);
  public
    { Public declarations }
   var
    CRUD: TEstado;
  end;

var
  frmCadCartorio: TfrmCadCartorio;

implementation

{$R *.dfm}

uses
   uDM,uLancamentoCartorio;

procedure TfrmCadCartorio.btnCancelarClick(Sender: TObject);
begin
    DM1.ibdCartorio.Cancel;
    close;
end;

procedure TfrmCadCartorio.btnConfirmarClick(Sender: TObject);
begin

     case CRUD of

        tInsert : DM1.ibdCartorio.Post;
        tUpdate : DM1.ibdCartorio.Post;
        tDelete : DM1.ibdCartorio.Delete;
     end;
    Close;
end;

procedure TfrmCadCartorio.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if (Key = 27)  then
       btnCancelar.Click;
end;


procedure TfrmCadCartorio.FormShow(Sender: TObject);
begin
    edtNome.SetFocus;

    DM1.ibdCartorio.Open;
    case CRUD of

        tInsert  : begin
                      HabilitaComponentes(true);

                      DM1.ibdCartorio.Insert;
                      edtCodigo.Text := IntToStr( MostraProximoID);
                   end;
        tBrowser : begin
                      HabilitaComponentes(false);
                      DM1.ibdCartorio.Locate('CAR_ID',dsCartorio.DataSet.FieldByName('CAR_ID').AsInteger,[]);
                      edtCodigo.Text  := IntToStr(DM1.ibdCartorio.FieldByName('CAR_ID').AsInteger);
                   end;
        tUpdate : begin
                       HabilitaComponentes(true);
                       DM1.ibdCartorio.Locate('CAR_ID',dsCartorio.DataSet.FieldByName('CAR_ID').AsInteger,[]);
                       edtCodigo.Text  :=  IntToStr(DM1.ibdCartorio.FieldByName('CAR_ID').AsInteger);
                       DM1.ibdCartorio.Edit;
                  end;

        tDelete : begin
                      HabilitaComponentes(false);
                      DM1.ibdCartorio.Locate('CAR_ID',dsCartorio.DataSet.FieldByName('CAR_ID').AsInteger,[]);
                      edtCodigo.Text  := IntToStr(DM1.ibdCartorio.FieldByName('CAR_ID').AsInteger);
                  end;
    end;
end;



procedure TfrmCadCartorio.HabilitaComponentes(status:Boolean);
var
    i:Word;
begin
    for i := 0 to Self.ComponentCount - 1 do
    begin
        if (Self.Components[i] is TDBEdit )then
        begin
            TDBEdit(Components[i]).Enabled := status;
        end
        else
        if  (Self.Components[i] is TDBComboBox) then
        begin
            TDBComboBox(Components[i]).Enabled := status;
        end;
    end;
end;



function TfrmCadCartorio.MostraProximoID:Integer;
begin
      with DM1.ibqAuxiliar do
      begin
          Close;
          SQL.Clear;
          SQL.Add(' SELECT GEN_ID(GEN_TBL_CARTORIO_ID, 0) pchave from RDB$DATABASE;');
          Open;

          Result := FieldByName('pchave').AsInteger +1;
          close;
      end;
end;

procedure TfrmCadCartorio.BuscaCep(cep:string);
var
    retorno:TJSONObject;
begin
    try
        if Length(cep) < 7 then
        begin
            MessageDlg(' Cep inválido !',mtInformation,[mbOk],0);
            edtCep.SetFocus;
            Exit;
        end
        else
        begin
            try
                RESTClient1.BaseURL := 'https://api.postmon.com.br/v1/cep/'+cep;
                RESTRequest1.Accept := 'application/json';
                RESTRequest1.Execute;
                retorno := RESTRequest1.Response.JSONValue as TJSONObject;

            except on E: Exception do
                MessageDlg(' Problema ao cuscar cep !'+E.ToString,mtInformation,[mbOk],0);
            end;

            if retorno <> nil then
            begin
               DM1.ibdCartorio.FieldByName('CAR_CIDADE').AsString   := retorno.GetValue('cidade').Value;
               DM1.ibdCartorio.FieldByName('CAR_UF').AsString       := retorno.GetValue('estado').Value;
               if retorno.GetValue('logradouro') <> nil then
                    DM1.ibdCartorio.FieldByName('CAR_ENDERECO').AsString := retorno.GetValue('logradouro').Value;
               if retorno.GetValue('bairro') <> nil then
                    DM1.ibdCartorio.FieldByName('CAR_BAIRRO').AsString   :=  retorno.GetValue('bairro').Value ;
            end
            else
            begin
                MessageDlg(' Cep não encontrado !',mtInformation,[mbOk],0);
                edtCep.SetFocus;
                Exit;
            end;

        end;

    except on E: Exception do
        MessageDlg(' Problema ao cuscar cep !'+E.ToString,mtInformation,[mbOk],0);
    end;


end;

procedure TfrmCadCartorio.edtCepExit(Sender: TObject);
begin
    lblBusca.Visible := True;
    BuscaCep(edtCep.Text);
    lblBusca.Visible := False;
end;

procedure TfrmCadCartorio.edtCepKeyPress(Sender: TObject; var Key: Char);
begin
    if (not (Key in ['0'..'9', #8])) then
        Key := #0;
end;

end.
