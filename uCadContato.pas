unit uCadContato;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.DBCtrls,
  Vcl.Mask, Vcl.ExtCtrls,uFuncoes, REST.Client, Web.HTTPApp,REST.Types,
  IPPeerClient, Data.Bind.Components, Data.Bind.ObjectScope, System.JSON;

type
  TfrmCadContato = class(TForm)
    tabinferior: TPanel;
    btnConfirmar: TButton;
    btnCancelar: TButton;
    dscontato: TDataSource;
    tabSuperior: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    edtNome: TDBEdit;
    edtEmail: TDBEdit;
    edtPhone2: TDBEdit;
    edtCodigo: TEdit;
    edtTelefone_principal: TDBEdit;
    edtPhone1: TDBEdit;
    edtCodCartorio: TEdit;
    Label5: TLabel;
    edtNomeCatorio: TEdit;
    procedure btnCancelarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtCodCartorioKeyPress(Sender: TObject; var Key: Char);
    procedure edtEmailExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtTelefone_principalKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCartorioKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodCartorioExit(Sender: TObject);

  private
    { Private declarations }
     procedure HabilitaComponentes(status:Boolean);
     function  MostraProximoID:Integer;
     function ValidaCartorio(id:integer):string;

  public
    { Public declarations }
   var
    CRUD: TEstado;
    id_CRUD:Integer;
  end;

var
  frmCadContato: TfrmCadContato;

implementation

{$R *.dfm}

uses
   uDM,uLancamentoCartorio;

procedure TfrmCadContato.btnCancelarClick(Sender: TObject);
begin
    DM1.ibdContato.Cancel;
    close;
end;

procedure TfrmCadContato.btnConfirmarClick(Sender: TObject);
begin

     case CRUD of
        tInsert : begin
                      DM1.ibdContato.FieldByName('CON_CAR_ID').AsInteger := StrToInt(trim(edtCodCartorio.Text));
                      DM1.ibdContato.Post;
                  end;
        tUpdate : begin
                      DM1.ibdContato.FieldByName('CON_CAR_ID').AsInteger := StrToInt(trim(edtCodCartorio.Text));
                      DM1.ibdContato.Post;
                  end;
        tDelete : DM1.ibdContato.Delete;
     end;
     Close;
end;

procedure TfrmCadContato.FormCreate(Sender: TObject);
begin
    DM1.ibdContato.Open;
    edtTelefone_principal.Field.EditMask := '(99)9999-9999;1;_'; //Mascara Telefone
    edtPhone1.Field.EditMask             := '(99)99999-9999;1;_'; //Mascara Telefone
    edtPhone2.Field.EditMask             := '(99)99999-9999;1;_'; //Mascara Telefone
end;

procedure TfrmCadContato.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if (Key = 27)  then
       btnCancelar.Click;
end;


procedure TfrmCadContato.FormShow(Sender: TObject);
begin
    edtCodCartorio.SetFocus;

    case CRUD of

        tInsert  : begin
                      HabilitaComponentes(true);

                      DM1.ibdContato.Insert;
                      edtCodigo.Text := IntToStr( MostraProximoID);
                   end;

        tBrowser : begin
                      HabilitaComponentes(false);
                      DM1.ibdContato.Locate('CON_ID',id_CRUD,[]);
                      edtCodigo.Text      := IntToStr(DM1.ibdContato.FieldByName('CON_ID').AsInteger);
                      edtCodCartorio.Text := IntToStr(DM1.ibdContato.FieldByName('CON_CAR_ID').AsInteger);
                      edtNomeCatorio.Text := ValidaCartorio(DM1.ibdContato.FieldByName('CON_CAR_ID').AsInteger);
                   end;

        tUpdate : begin
                       HabilitaComponentes(true);
                       DM1.ibdContato.Locate('CON_ID',id_CRUD,[]);
                       edtCodigo.Text      := IntToStr(DM1.ibdContato.FieldByName('CON_ID').AsInteger);
                       edtCodCartorio.Text := IntToStr(DM1.ibdContato.FieldByName('CON_CAR_ID').AsInteger);
                       edtNomeCatorio.Text := ValidaCartorio(DM1.ibdContato.FieldByName('CON_CAR_ID').AsInteger);
                       DM1.ibdContato.Edit;
                  end;

        tDelete : begin
                      HabilitaComponentes(false);
                      DM1.ibdContato.Locate('CON_ID',id_CRUD,[]);
                      edtCodigo.Text      := IntToStr(DM1.ibdContato.FieldByName('CON_ID').AsInteger);
                      edtCodCartorio.Text := IntToStr(DM1.ibdContato.FieldByName('CON_CAR_ID').AsInteger);
                      edtNomeCatorio.Text := ValidaCartorio(DM1.ibdContato.FieldByName('CON_CAR_ID').AsInteger);
                  end;
    end;
end;



procedure TfrmCadContato.HabilitaComponentes(status:Boolean);
var
    i:Word;
begin
    for i := 0 to Self.ComponentCount - 1 do
    begin
        if Self.Components[i].NAME = 'edtCodigo' then
           Continue
        else
        if (Self.Components[i] is TEdit )then
        begin
            TEdit(Components[i]).Enabled := status;
        end
        else
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



function TfrmCadContato.MostraProximoID:Integer;
begin
      with DM1.ibqAuxiliar do
      begin
          Close;
          SQL.Clear;
          SQL.Add(' SELECT GEN_ID(GEN_TBL_CONTATOS_ID, 0) pchave from RDB$DATABASE;');
          Open;

          Result := FieldByName('pchave').AsInteger +1;
          close;
      end;
end;



procedure TfrmCadContato.edtCodCartorioExit(Sender: TObject);
var
   nome_aux:string;
begin
     if edtCodCartorio.Enabled then
             if edtCodCartorio.Text <> '' then
     begin
        nome_aux := ValidaCartorio(StrToInt(Trim(edtCodCartorio.Text)));
        if nome_aux <> ''  then
           edtNomeCatorio.Text := nome_aux
        else
        begin
            MessageDlg('Cartório não encontrado.',mtInformation,[mbOk],0);
            edtNomeCatorio.Clear;
            edtCodCartorio.Clear;
            edtCodCartorio.SetFocus;
        end;
     end
     else
     begin
          MessageDlg('Informar Cartório em que contato trabalha .',mtInformation,[mbOk],0);
          edtNomeCatorio.Clear;
          edtCodCartorio.Clear;
          edtCodCartorio.SetFocus;
     end;
end;

procedure TfrmCadContato.edtCodCartorioKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     if Key = vk_f8 then
     begin
        try
            frmGridCartorio :=  TfrmGridCartorio.Create(Self);
            frmGridCartorio.tabLateral.Visible := False;
            frmGridCartorio.func_F8 := true;
            frmGridCartorio.ShowModal;
        finally

            edtCodCartorio.Text := IntToStr(frmGridCartorio.id_Car_retorno);
            frmGridCartorio.Free;
        end;
     end;
end;


function TfrmCadContato.ValidaCartorio(id:integer):string;
begin
     if id > 0 then
     begin
        with DM1.ibdCartorio do
        begin
            Open;
            if Locate('CAR_ID',id,[]) then
               Result := FieldByName('CAR_NOME').AsString
            else
               Result := '';
            Close;
        end;
     end
     else
        Result := '';
end;


procedure TfrmCadContato.edtCodCartorioKeyPress(Sender: TObject; var Key: Char);
begin
    if (not (Key in ['0'..'9', #8])) then
            Key := #0;
end;

procedure TfrmCadContato.edtEmailExit(Sender: TObject);
begin
    if not  ValidarEMail(Trim(edtEmail.Text)) then
    begin
        MessageDlg(' Email inválido !',mtInformation,[mbOk],0);
       edtEmail.SetFocus;
       edtEmail.SelectAll;
    end;

end;

procedure TfrmCadContato.edtTelefone_principalKeyPress(Sender: TObject;
  var Key: Char);
begin
    if not(key in['0'..'9',#8,'-','(',')']) then
        key := #0;
end;

end.
