unit uCadCartorio;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.DBCtrls,
  Vcl.Mask, Vcl.ExtCtrls,uFuncoes;

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
    procedure btnCancelarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);

  private
    { Private declarations }
     procedure HabilitaComponentes(status:Boolean);
     function MostraProximoID:Integer;
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
    DM1.ibdCartorio.Post;
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
                   end;
        tUpdate : begin
                       HabilitaComponentes(true);
                       DM1.ibdCartorio.Locate('CAR_ID',dsCartorio.DataSet.FieldByName('CAR_ID').AsInteger,[]);
                       DM1.ibdCartorio.Edit;
                  end;

        tDelete : begin
                      HabilitaComponentes(false);
                      DM1.ibdCartorio.Locate('CAR_ID',dsCartorio.DataSet.FieldByName('CAR_ID').AsInteger,[]);
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

end.
