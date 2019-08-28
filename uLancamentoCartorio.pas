unit uLancamentoCartorio;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls;

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
  private
    { Private declarations }
    procedure Mostra();
    procedure HabilitaBotoesLaterais();

  public
    { Public declarations }
  end;

var
  frmGridCartorio: TfrmGridCartorio;

implementation

{$R *.dfm}

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

end.
