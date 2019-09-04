unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Menus, Vcl.StdCtrls,
  Vcl.Buttons, System.ImageList, Vcl.ImgList, Vcl.Imaging.pngimage, Vcl.Grids;

type
  TfrmPrincipal = class(TForm)
    Panel1: TPanel;
    tabSuperior: TPanel;
    btnLancCartorio: TBitBtn;
    btnLancContato: TBitBtn;
    btnLancAtividade: TBitBtn;
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
    Label1: TLabel;
    StringGrid1: TStringGrid;
    procedure btnLancCartorioClick(Sender: TObject);
    procedure btnLancContatoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnLancAtividadeClick(Sender: TObject);
    procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
  private
    { Private declarations }
    procedure MostraAtividade;


  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation


{$R *.dfm}


uses
  uDM, uLogin, uLancamentoCartorio, uLancamentoContatos,uFuncoes, uCadAtividade,
  uCadContato;


procedure TfrmPrincipal.btnLancContatoClick(Sender: TObject);
begin
    try
        frmGridContato := TfrmGridContato.Create(Self);
        frmGridContato.ShowModal;
    finally
        frmGridContato.Free;
    end;
end;

procedure TfrmPrincipal.btnLancAtividadeClick(Sender: TObject);
begin
    try
        frmCadAtividade := TfrmCadAtividade.Create(Self);
        frmCadAtividade.CRUD    := tInsert;
        frmCadAtividade.ShowModal;
    finally
        frmCadAtividade.Free;
        MostraAtividade();
    end;
end;

procedure TfrmPrincipal.btnLancCartorioClick(Sender: TObject);
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
     MostraAtividade();
end;

procedure TfrmPrincipal.MostraAtividade();
var
  i:Word;
begin
     with DM1.ibqAuxiliar do
     begin
         Close;
         SQL.Clear;
         sql.Add(' Select * from TBL_AGENDA                            '+#13+
                 ' inner join TBL_CONTATOS ON AGE_CON_ID = CON_ID       '+#13+
                 ' where  AGE_USU_ID  = '+  IntToStr(DM1.vgbCodUsuario) +#13+
                 '    AND AGE_DATA  = ' + QuotedStr(formatDateTime('dd.mm.yyyy', now)));
         Open;

         if not IsEmpty then
         begin
             i := 0;
             StringGrid1.RowCount := RecordCount;
             while not Eof do
             begin
                StringGrid1.Cells[0, i] := formatDateTime('dd/mm/yyyy', FieldByName('AGE_DATA').AsDateTime) +' - ' +FieldByName('AGE_TAREFA').AsString +' - ' +FieldByName('CON_NOME').AsString;
                Next;
                i:= i + 1;
             end;
             StringGrid1.Refresh;
         end;
         close;
     end;
end;



procedure TfrmPrincipal.StringGrid1DrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
//var
 //      sTexto: String;
begin
  {if ARow = 0 then
  begin // Trata apenas as colunas da primeira linha.
    with TStringGrid(Sender) do
    begin
      Canvas.FillRect(Rect); // Limpa o conteúdo da célula.
      sTexto := Cells[ACol, ARow];
      Canvas.TextRect(Rect, sTexto, [tfWordBreak,tfVerticalCenter,tfCenter]);
    end;
  end;
   }
end;

end.
