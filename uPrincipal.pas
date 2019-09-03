unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Menus, Vcl.StdCtrls,
  Vcl.Buttons, System.ImageList, Vcl.ImgList, Vcl.Imaging.pngimage;

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
    lblUsuario: TLabel;
    lbl1: TLabel;
    Image1: TImage;
    ImageList1: TImageList;
    procedure btnInserirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
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
  uDM, uLogin, uLancamentoCartorio, uLancamentoContatos;


procedure TfrmPrincipal.btnAlterarClick(Sender: TObject);
begin
    try
        frmGridContato := TfrmGridContato.Create(Self);
        frmGridContato.ShowModal;
    finally
        frmGridContato.Free;
    end;
end;

procedure TfrmPrincipal.btnInserirClick(Sender: TObject);
begin
    try
        frmGridCartorio := TfrmGridCartorio.Create(Self);
        frmGridCartorio.ShowModal;
    finally
        frmGridCartorio.Free;
    end;
end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
     lblUsuario.Caption := DM1.vgbUsuario;
end;

end.
