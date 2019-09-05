unit uCadAgenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.DBCtrls,
  Vcl.Mask, Vcl.ExtCtrls,uFuncoes, REST.Client, Web.HTTPApp,REST.Types,
  IPPeerClient, Data.Bind.Components, Data.Bind.ObjectScope, System.JSON,
  Vcl.WinXCalendars;

type
  TfrmCadAgenda = class(TForm)
    tabinferior: TPanel;
    btnConfirmar: TButton;
    btnCancelar: TButton;
    tabSuperior: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    edtCodigo: TEdit;
    edtCodCartorio: TEdit;
    edtNomeContato: TEdit;
    edtData: TCalendarPicker;
    Label5: TLabel;
    edtTarefa: TDBEdit;
    dsAgenda: TDataSource;
    procedure btnCancelarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
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
  frmCadAgenda: TfrmCadAgenda;

implementation

{$R *.dfm}

uses
   uDM,uLancamentoCartorio, uLancamentoContatos;

procedure TfrmCadAgenda.btnCancelarClick(Sender: TObject);
begin
    DM1.ibdAgenda.Cancel;
    close;
end;

procedure TfrmCadAgenda.btnConfirmarClick(Sender: TObject);
begin

     case CRUD of
        tInsert : begin
                      DM1.ibdAgenda.FieldByName('AGE_DATA').AsDateTime := edtData.Date;
                      DM1.ibdAgenda.FieldByName('AGE_USU_ID').AsInteger := DM1.vgbCodUsuario;
                      DM1.ibdAgenda.FieldByName('AGE_CON_ID').AsInteger := StrToInt(trim(edtCodCartorio.Text));
                      DM1.ibdAgenda.Post;
                  end;
        tUpdate : begin
                      DM1.ibdAgenda.FieldByName('AGE_DATA').AsDateTime := edtData.Date;
                      DM1.ibdAgenda.FieldByName('AGE_USU_ID').AsInteger := DM1.vgbCodUsuario;
                      DM1.ibdAgenda.FieldByName('AGE_CON_ID').AsInteger := StrToInt(trim(edtCodCartorio.Text));
                      DM1.ibdAgenda.Post;
                  end;
        tDelete : DM1.ibdAgenda.Delete;
     end;
     Close;
end;

procedure TfrmCadAgenda.FormCreate(Sender: TObject);
begin
    DM1.ibdAgenda.Open;
end;

procedure TfrmCadAgenda.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if (Key = 27)  then
       btnCancelar.Click;
end;


procedure TfrmCadAgenda.FormShow(Sender: TObject);
begin
    edtData.SetFocus;

    case CRUD of

        tInsert  : begin
                      HabilitaComponentes(true);

                      DM1.ibdAgenda.Insert;
                      edtCodigo.Text := IntToStr( MostraProximoID);
                   end;

        tBrowser : begin
                      HabilitaComponentes(false);
                      DM1.ibdAgenda.Locate('AGE_ID',id_CRUD,[]);
                      edtCodigo.Text      := IntToStr(DM1.ibdAgenda.FieldByName('AGE_ID').AsInteger);
                   end;

        tUpdate : begin
                       HabilitaComponentes(true);
                       DM1.ibdAgenda.Locate('AGE_ID',id_CRUD,[]);
                       edtCodigo.Text      := IntToStr(DM1.ibdAgenda.FieldByName('AGE_ID').AsInteger);
                  end;

        tDelete : begin
                      HabilitaComponentes(false);
                      DM1.ibdContato.Locate('AGE_ID',id_CRUD,[]);
                      edtCodigo.Text      := IntToStr(DM1.ibdAgenda.FieldByName('AGE_ID').AsInteger);

                  end;
    end;
end;



procedure TfrmCadAgenda.HabilitaComponentes(status:Boolean);
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



function TfrmCadAgenda.MostraProximoID:Integer;
begin
      with DM1.ibqAuxiliar do
      begin
          Close;
          SQL.Clear;
          SQL.Add(' SELECT GEN_ID(GEN_TBL_AGENDA_ID, 0) pchave from RDB$DATABASE;');
          Open;

          Result := FieldByName('pchave').AsInteger +1;
          close;
      end;
end;



procedure TfrmCadAgenda.edtCodCartorioExit(Sender: TObject);
var
   nome_aux:string;
begin
     if edtCodCartorio.Enabled then
     if edtCodCartorio.Text <> '' then
     begin
        nome_aux := ValidaCartorio(StrToInt(Trim(edtCodCartorio.Text)));
        if nome_aux <> ''  then
           edtNomeContato.Text := nome_aux
        else
        begin
            MessageDlg('Contato não encontrado.',mtInformation,[mbOk],0);
            edtNomeContato.Clear;
            edtCodCartorio.Clear;
            edtCodCartorio.SetFocus;
        end;
     end
     else
     begin
          MessageDlg('Informar Contato em que contato trabalha .',mtInformation,[mbOk],0);
          edtNomeContato.Clear;
          edtCodCartorio.Clear;
          edtCodCartorio.SetFocus;
     end;
end;

procedure TfrmCadAgenda.edtCodCartorioKeyDown(Sender: TObject; var Key: Word;
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

            edtCodCartorio.Text := IntToStr(frmGridContato.id_con_retorno);
            frmGridContato.Free;
        end;
     end;
end;


function TfrmCadAgenda.ValidaCartorio(id:integer):string;
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
