unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Menus, Vcl.StdCtrls,
  Vcl.Buttons, System.ImageList, Vcl.ImgList, Vcl.Imaging.pngimage, Vcl.Grids,
  Vcl.ComCtrls;

type
  TfrmPrincipal = class(TForm)
    Panel1: TPanel;
    tabSuperior: TPanel;
    btnLancCartorio: TBitBtn;
    btnLancContato: TBitBtn;
    btnLancCompromisso: TBitBtn;
    btnLancAtividade: TBitBtn;
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
    Panel5: TPanel;
    Label2: TLabel;
    StringGrid1: TStringGrid;
    StatusBar1: TStatusBar;
    procedure btnLancCartorioClick(Sender: TObject);
    procedure btnLancContatoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnLancCompromissoClick(Sender: TObject);
    procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure btnLancAtividadeClick(Sender: TObject);
  private
    { Private declarations }
    procedure MostraAtividade;
    procedure AtualizaPainelControle();

  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation


{$R *.dfm}


uses
  uDM, uLogin, uLancamentoCartorio, uLancamentoContatos,uFuncoes, uCadAgenda,
  uCadContato, uCadAtividade;


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
        AtualizaPainelControle();
    end;
end;

procedure TfrmPrincipal.btnLancCompromissoClick(Sender: TObject);
begin
    try
        frmCadAgenda := TfrmCadAgenda.Create(Self);
        frmCadAgenda.CRUD    := tInsert;
        frmCadAgenda.ShowModal;
    finally
        frmCadAgenda.Free;
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
     AtualizaPainelControle();
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


procedure TfrmPrincipal.AtualizaPainelControle();
begin
  with DM1.ibqAuxiliar do
  begin
     Close;
     SQL.Clear;
     SQL.Add(' select ati_tipo,COUNT(*) AS quantidade from tbl_atividade  '+#13+
             ' GROUP BY ati_tipo ');
     Open;
     if not IsEmpty then
     begin
        First;
        while not eof do
        begin
           case FieldByName('ati_tipo').AsInteger of
                1:  StatusBar1.Panels[1].Text := 'Ligações: '+inttostr(FieldByName('quantidade').AsInteger);
                2:  StatusBar1.Panels[2].Text := 'Email: '+inttostr(FieldByName('quantidade').AsInteger);
                3:  StatusBar1.Panels[3].Text := 'Visitas: '+inttostr(FieldByName('quantidade').AsInteger);
                4:  StatusBar1.Panels[4].Text := 'Outros: '+inttostr(FieldByName('quantidade').AsInteger);
           end;
           Next;
        end;

     end;
     Close;
  end;

end;

end.
