unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Menus, Vcl.StdCtrls,
  Vcl.Buttons;

type
  TfrmPrincipal = class(TForm)
    Panel1: TPanel;
    tabSuperior: TPanel;
    btnInserir: TBitBtn;
    btnAlterar: TBitBtn;
    btnConsultar: TBitBtn;
    btnExcluir: TBitBtn;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel6: TPanel;
    PopupMenu1: TPopupMenu;
    procedure btnInserirClick(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation


{$R *.dfm}


uses
  uLogin, uLancamentoCartorio;


procedure TfrmPrincipal.btnInserirClick(Sender: TObject);
begin
    try
        frmGridCartorio := TfrmGridCartorio.Create(Self);
        frmGridCartorio.ShowModal;
    finally
        frmGridCartorio.Free;
    end;
end;

end.
