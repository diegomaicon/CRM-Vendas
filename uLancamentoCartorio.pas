unit uLancamentoCartorio;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls,uFuncoes;
type
  TfrmGridCartorio = class(TForm)
    tabSuperior: TPanel;
    tabMeio: TPanel;
    gridCartorio: TDBGrid;
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
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnInserirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnConsultarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnInserirKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    
  private
    { Private declarations }
    procedure Mostra();
    procedure HabilitaBotoesLaterais();
    procedure ChamaCrud(op:TEstado);

  public
    { Public declarations }

  end;

var
  frmGridCartorio: TfrmGridCartorio;

implementation

{$R *.dfm}

uses
  uCadCartorio,uDM;

procedure TfrmGridCartorio.btnAlterarClick(Sender: TObject);
begin
    ChamaCrud(tUpdate);
end;

procedure TfrmGridCartorio.btnConsultarClick(Sender: TObject);
begin
    ChamaCrud(tBrowser);
end;

procedure TfrmGridCartorio.btnExcluirClick(Sender: TObject);
begin
    ChamaCrud(tDelete);
end;

procedure TfrmGridCartorio.btnInserirClick(Sender: TObject);
begin
    ChamaCrud(tInsert);
end;

procedure TfrmGridCartorio.btnInserirKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if (Key = 27)  then
        close;
end;

procedure TfrmGridCartorio.Button1Click(Sender: TObject);
begin
    Mostra();
end;

procedure TfrmGridCartorio.dsConsultaDataChange(Sender: TObject; Field: TField);
begin
    HabilitaBotoesLaterais();
end;

procedure TfrmGridCartorio.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     if (Key = 27)  then
        close;
end;

procedure TfrmGridCartorio.FormShow(Sender: TObject);
begin
   Mostra();
   HabilitaBotoesLaterais();
end;

procedure TfrmGridCartorio.Mostra();
begin

    with ibqConsulta do
    begin
        Close;
        SQL.Clear;
        SQL.Add('Select * from TBL_CARTORIO '+#13+
                ' Where 1 = 1               ');
        if   Trim(edtBusca.Text) <> '' then
             SQL.Add(' and car_nome LIKE '+QuotedStr('%'+edtBusca.Text+'%') );
        Open;
    end;
end;

procedure TfrmGridCartorio.HabilitaBotoesLaterais();
begin
     btnAlterar.Enabled   := not dsConsulta.DataSet.IsEmpty;
     btnConsultar.Enabled := not dsConsulta.DataSet.IsEmpty;
     btnExcluir.Enabled   := not dsConsulta.DataSet.IsEmpty;
end;



procedure TfrmGridCartorio.ChamaCrud(op:TEstado);
begin
    try
        frmCadCartorio := TfrmCadCartorio.Create(Self);
        frmCadCartorio.CRUD := op;
        frmCadCartorio.ShowModal;
    finally
        frmCadCartorio.Free;
        Mostra();
    end;
end;

end.
