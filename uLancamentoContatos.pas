unit uLancamentoContatos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls,uFuncoes;
type
  TfrmGridContato = class(TForm)
    tabLateral: TPanel;
    tabMeio: TPanel;
    gridContato: TDBGrid;
    Panel1: TPanel;
    btnInserir: TBitBtn;
    btnAlterar: TBitBtn;
    btnConsultar: TBitBtn;
    btnExcluir: TBitBtn;
    ibqConsulta: TFDQuery;
    dsConsulta: TDataSource;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel6: TPanel;
    edtBusca: TEdit;
    Button1: TButton;
    procedure dsConsultaDataChange(Sender: TObject; Field: TField);
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure i(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnInserirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnConsultarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnInserirKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure gridContatoDblClick(Sender: TObject);
    
  private
    { Private declarations }
    procedure Mostra();
    procedure HabilitaBotoesLaterais();
    procedure ChamaCrud(op:TEstado);

  public
    { Public declarations }
     var
        func_F8:Boolean;
        id_con_retorno:Integer;
  end;

var
  frmGridContato: TfrmGridContato;

implementation

{$R *.dfm}

uses
  uDM, uCadContato;

procedure TfrmGridContato.btnAlterarClick(Sender: TObject);
begin
    ChamaCrud(tUpdate);
end;

procedure TfrmGridContato.btnConsultarClick(Sender: TObject);
begin
    ChamaCrud(tBrowser);
end;

procedure TfrmGridContato.btnExcluirClick(Sender: TObject);
begin
    ChamaCrud(tDelete);
end;

procedure TfrmGridContato.btnInserirClick(Sender: TObject);
begin
    try
       DM1.ibdContato.Open;
       if not DM1.ibdContato.IsEmpty then
          ChamaCrud(tInsert)
       else   
            MessageDlg('É necessário que cadastre um cartório.',mtInformation,[mbOk],0);      
    finally
        DM1.ibdContato.Close;
    end;
    
    
end;

procedure TfrmGridContato.btnInserirKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if (Key = 27)  then
        close;
end;

procedure TfrmGridContato.Button1Click(Sender: TObject);
begin
    Mostra();
end;

procedure TfrmGridContato.dsConsultaDataChange(Sender: TObject; Field: TField);
begin
    HabilitaBotoesLaterais();
end;

procedure TfrmGridContato.i(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     if (Key = VK_ESCAPE)  then
        close;
end;

procedure TfrmGridContato.FormShow(Sender: TObject);
begin
   Mostra();
   HabilitaBotoesLaterais();
end;

procedure TfrmGridContato.gridContatoDblClick(Sender: TObject);
begin
    if func_F8 then
    begin
      id_con_retorno := gridContato.DataSource.DataSet.FieldByName('CON_ID').AsInteger;
      Close;
    end
    else
        btnConsultar.Click;

end;

procedure TfrmGridContato.Mostra();
begin
    with ibqConsulta do
    begin
        Close;
        SQL.Clear;
        SQL.Add(' Select (CAST(CAR_ID AS VARCHAR(10)) || '+QuotedStr(' - ')+' ||CAR_NOME) AS CARTORIO, CT.*   '+#13+
                ' from TBL_CONTATOS  CT                                                                       '+#13+
                ' inner join TBL_CARTORIO ON CON_CAR_ID = CAR_ID                                              '+#13+
                ' Where 1 = 1               ');
        if   Trim(edtBusca.Text) <> '' then
             SQL.Add(' and con_nome LIKE '+QuotedStr('%'+edtBusca.Text+'%') );
        Open;
    end;
end;

procedure TfrmGridContato.HabilitaBotoesLaterais();
begin
     btnAlterar.Enabled   := not dsConsulta.DataSet.IsEmpty;
     btnConsultar.Enabled := not dsConsulta.DataSet.IsEmpty;
     btnExcluir.Enabled   := not dsConsulta.DataSet.IsEmpty;
end;



procedure TfrmGridContato.ChamaCrud(op:TEstado);
begin
    try
        frmCadContato := TfrmCadContato.Create(Self);
        frmCadContato.CRUD    := op;
        frmCadContato.id_CRUD := gridContato.DataSource.DataSet.FieldByName('CON_ID').AsInteger;
        frmCadContato.ShowModal;
    finally
        frmCadContato.Free;
        Mostra();
    end;
end;

end.
