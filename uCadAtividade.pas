unit uCadAtividade;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.DBCtrls,
  Vcl.Mask, Vcl.ExtCtrls,uFuncoes, REST.Client, Web.HTTPApp,REST.Types,
  IPPeerClient, Data.Bind.Components, Data.Bind.ObjectScope, System.JSON,
  Vcl.WinXCalendars;

type
  TfrmCadAtividade = class(TForm)
    tabinferior: TPanel;
    btnConfirmar: TButton;
    btnCancelar: TButton;
    tabSuperior: TPanel;
    Label5: TLabel;
    dsAgenda: TDataSource;
    GroupBox1: TGroupBox;
    edtCodContato: TEdit;
    edtCodigo: TEdit;
    edtData: TCalendarPicker;
    edtNomeContato: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    rgTipo: TRadioGroup;
    edtDEscircao: TDBMemo;
    procedure btnCancelarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtCodContatoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodContatoExit(Sender: TObject);


  private
    { Private declarations }
     procedure HabilitaComponentes(status:Boolean);
     function  MostraProximoID:Integer;
     function ValidaCartorio(id:integer):string;

  public
    { Public declarations }
    function  CalculaScoring(contato:integer):integer;
   var
    CRUD: TEstado;
    id_CRUD:Integer;

   const
      _LIGACAO = 2;
      _VISITA  = 4;
      _EMAL    = 1;
      _OUTRO   = 1;
  end;

var
  frmCadAtividade: TfrmCadAtividade;

implementation

{$R *.dfm}

uses
   uDM,uLancamentoCartorio, uLancamentoContatos;

procedure TfrmCadAtividade.btnCancelarClick(Sender: TObject);
begin
    DM1.ibdAtividade.Cancel;
    close;
end;

function TfrmCadAtividade.CalculaScoring(contato:integer):integer;
var
   scoring_aux,addScoring:integer;

begin
      addScoring  := 0;
      scoring_aux := 0;
      DM1.ibdContato.Open;
      if DM1.ibdContato.Locate('CON_id',contato,[]) then
      BEGIN
          DM1.ibdContato.Edit;
          scoring_aux := DM1.ibdContato.FieldByName('CON_SCORING').AsInteger;

          //
          case rgTipo.ItemIndex of
              0:addScoring := _LIGACAO;
              1:addScoring := _EMAL;
              2:addScoring := _VISITA;
              3:addScoring := _OUTRO;
          end;

          DM1.ibdContato.FieldByName('CON_SCORING').AsInteger := scoring_aux + (addScoring * (DM1.ibdContato.FieldByName('CON_CARGO').AsInteger * 10));
          DM1.ibdContato.Post;
          DM1.ibdContato.close;
      END;
end;


procedure TfrmCadAtividade.btnConfirmarClick(Sender: TObject);

begin
     case CRUD of
        tInsert : begin
                     try
                          DM1.ibdAtividade.FieldByName('ATI_DATA').AsDateTime  := edtData.Date;
                          DM1.ibdAtividade.FieldByName('ATI_USU_ID').AsInteger := DM1.vgbCodUsuario;
                          DM1.ibdAtividade.FieldByName('ATI_TIPO').AsInteger   := rgTipo.ItemIndex + 1;
                          DM1.ibdAtividade.FieldByName('ATI_CON_ID').AsInteger := StrToInt(trim(edtCodContato.Text));
                          DM1.ibdAtividade.Post;
                     finally
                         CalculaScoring( StrToInt(trim(edtCodContato.Text)));
                     end;
                  end;
       // Implementação Futura...
       { tUpdate : begin
                      DM1.ibdAtividade.FieldByName('ATI_DATA').AsDateTime := edtData.Date;
                      DM1.ibdAtividade.FieldByName('ATI_USU_ID').AsInteger := DM1.vgbCodUsuario;
                      DM1.ibdAtividade.FieldByName('ATI_CON_ID').AsInteger := StrToInt(trim(edtCodContato.Text));
                      DM1.ibdAtividade.Post;
                  end;
        tDelete : DM1.ibdAtividade.Delete; }
     end;
     Close;
end;

procedure TfrmCadAtividade.FormCreate(Sender: TObject);
begin
    DM1.ibdAtividade.Open;
end;

procedure TfrmCadAtividade.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if (Key = 27)  then
       btnCancelar.Click;
end;


procedure TfrmCadAtividade.FormShow(Sender: TObject);
begin
    edtData.SetFocus;

    case CRUD of

        tInsert  : begin
                      HabilitaComponentes(true);

                      DM1.ibdAtividade.Insert;
                      edtCodigo.Text := IntToStr( MostraProximoID);
                   end;

        tBrowser : begin
                      HabilitaComponentes(false);
                      DM1.ibdAtividade.Locate('ATI_ID',id_CRUD,[]);
                      edtCodigo.Text      := IntToStr(DM1.ibdAtividade.FieldByName('AGE_ID').AsInteger);
                   end;

        tUpdate : begin
                       HabilitaComponentes(true);
                       DM1.ibdAtividade.Locate('ATI_ID',id_CRUD,[]);
                       edtCodigo.Text      := IntToStr(DM1.ibdAtividade.FieldByName('AGE_ID').AsInteger);
                  end;

        tDelete : begin
                      HabilitaComponentes(false);
                      DM1.ibdAtividade.Locate('ATI_ID',id_CRUD,[]);
                      edtCodigo.Text      := IntToStr(DM1.ibdAtividade.FieldByName('AGE_ID').AsInteger);

                  end;
    end;
end;



procedure TfrmCadAtividade.HabilitaComponentes(status:Boolean);
var
    i:Word;
begin
    for i := 0 to Self.ComponentCount - 1 do
    begin
        if (Self.Components[i].NAME = 'edtCodigo') OR
            (Self.Components[i].NAME =  'edtNomeContato' )then
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



function TfrmCadAtividade.MostraProximoID:Integer;
begin
      with DM1.ibqAuxiliar do
      begin
          Close;
          SQL.Clear;
          SQL.Add(' SELECT GEN_ID(GEN_TBL_ATIVIDADE_ID, 0) pchave from RDB$DATABASE;');
          Open;

          Result := FieldByName('pchave').AsInteger +1;
          close;
      end;
end;



procedure TfrmCadAtividade.edtCodContatoExit(Sender: TObject);
var
   nome_aux:string;
begin
     if edtCodContato.Enabled then
     if edtCodContato.Text <> '' then
     begin
        nome_aux := ValidaCartorio(StrToInt(Trim(edtCodContato.Text)));
        if nome_aux <> ''  then
           edtNomeContato.Text := nome_aux
        else
        begin
            MessageDlg('Contato não encontrado.',mtInformation,[mbOk],0);
            edtNomeContato.Clear;
            edtCodContato.Clear;
            edtCodContato.SetFocus;
        end;
     end
     else
     begin
          MessageDlg('Informar Contato em que contato trabalha .',mtInformation,[mbOk],0);
          edtNomeContato.Clear;
          edtCodContato.Clear;
          edtCodContato.SetFocus;
     end;
end;

procedure TfrmCadAtividade.edtCodContatoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     if Key = vk_f8 then
     begin
        try
            frmGridContato :=  TfrmGridContato.Create(Self);
            frmGridContato.tabLateral.Visible := False;
            frmGridContato.func_F8 := true;
            frmGridContato.ShowModal;
        finally

            edtCodContato.Text := IntToStr(frmGridContato.id_con_retorno);
            frmGridContato.Free;
        end;
     end;
end;


function TfrmCadAtividade.ValidaCartorio(id:integer):string;
begin
     if id > 0 then
     begin
        with DM1.ibdContato do
        begin
            Open;
            if Locate('CON_ID',id,[]) then
               Result := FieldByName('CON_NOME').AsString
            else
               Result := '';
            Close;
        end;
     end
     else
        Result := '';
end;


end.
