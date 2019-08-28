unit uLogin;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Controls.Presentation, FMX.Edit, FMX.Layouts, FMX.Effects,
  FMX.Ani, FMX.TabControl,Vcl.Dialogs, Data.DB, Data.Win.ADODB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TfrmLogin = class(TForm)
    LayPrincipal: TLayout;
    Rectangle2: TRectangle;
    Rectangle4: TRectangle;
    ShadowEffect1: TShadowEffect;
    btnEntrar: TSpeedButton;
    Rectangle3: TRectangle;
    TabControl1: TTabControl;
    tbLoginAcesso: TTabItem;
    tbLoginCadastro: TTabItem;
    edtUsuario: TEdit;
    Label1: TLabel;
    FloatAnimation2: TFloatAnimation;
    FloatAnimation3: TFloatAnimation;
    edtSenha: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    btSalvarUsuario: TSpeedButton;
    StyleBook1: TStyleBook;
    Rectangle1: TRectangle;
    FloatAnimation1: TFloatAnimation;
    Layout1: TLayout;
    edtLogin: TEdit;
    lblVerificaUsuario: TLabel;
    edtUsuarioSenha: TEdit;
    edtUsuarioConfirma: TEdit;
    lblUsuarioNome: TLabel;
    lblUsuarioSenha: TLabel;
    lblUsuarioSenhaConfirmar: TLabel;
    btnCancelar: TSpeedButton;
    lblConfirmaSenha: TLabel;
    lblSenha: TLabel;
    lblUsuarioPendente: TLabel;
    retVoltarLogin: TRectangle;
    retAddUsuario: TRectangle;
    Rectangle6: TRectangle;
    ibqUser: TFDQuery;
    Salvar: TLabel;
    Label5: TLabel;
    edtNome: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    procedure btnEntrarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure edtLoginChangeTracking(Sender: TObject);
    procedure edtLoginExit(Sender: TObject);
    procedure edtLoginEnter(Sender: TObject);
    procedure Label4Click(Sender: TObject);
    procedure edtUsuarioSenhaExit(Sender: TObject);
    procedure edtUsuarioConfirmaExit(Sender: TObject);
    procedure edtUsuarioConfirmaChangeTracking(Sender: TObject);
    procedure retAddUsuarioClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure retVoltarLoginClick(Sender: TObject);
    procedure Rectangle6Click(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure SalvarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    bAlterarSenha :Boolean;
    sIDUsuario :string;
    usuario :String;
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

{$R *.fmx}

uses uPrincipal, uDM;

procedure TfrmLogin.edtUsuarioConfirmaChangeTracking(Sender: TObject);
begin
   if edtUsuarioSenha.Text <> edtUsuarioConfirma.Text then
   begin
      lblConfirmaSenha.Visible := True;
      lblConfirmaSenha.Text := 'Senhas diferentes';
   end
   else
      lblConfirmaSenha.Visible := False;
end;

procedure TfrmLogin.edtUsuarioConfirmaExit(Sender: TObject);
begin
   if edtUsuarioConfirma.Text = '' then
   begin
      lblConfirmaSenha.Text := 'Informe a senha';
      lblConfirmaSenha.Visible := True;
   end
   else
   begin
      lblConfirmaSenha.Visible := False;
   end;

end;

procedure TfrmLogin.edtLoginChangeTracking(Sender: TObject);
begin
   if edtlogin.Text <> '' then
   begin

       with DM1.ibqAuxiliar do
       begin
          Close;
          SQL.Clear;
          SQL.Add(' Select * from TBL_USUARIO                    '+#13+
                  ' Where USU_LOGIN = '+QuotedStr(edtlogin.text) );

          Open;

          if IsEmpty then
          begin
             lblVerificaUsuario.Text :=  'Dísponivel'; //Settings.FontColor := TAlphaColors.Red;
             lblVerificaUsuario.TextSettings.FontColor := TAlphaColors.Steelblue;
          end
          else
          begin
             lblVerificaUsuario.Text :=  'Indíponivel'; //Settings.FontColor := TAlphaColors.Red;
             lblVerificaUsuario.TextSettings.FontColor := TAlphaColors.Red;
          end;

       end;
   end
   else
   begin
      lblVerificaUsuario.Text :=  'Digite o nome de usuário'; //Settings.FontColor := TAlphaColors.Red;
      lblVerificaUsuario.TextSettings.FontColor := TAlphaColors.Red;
   end;

   lblVerificaUsuario.Visible := True;
end;

procedure TfrmLogin.edtLoginEnter(Sender: TObject);
begin
   if edtlogin.Text = '' then
   begin
      lblVerificaUsuario.Visible := True;
      lblVerificaUsuario.Text := 'Digite o nome de usuário';
      lblVerificaUsuario.TextSettings.FontColor := TAlphaColors.Red;
   end;
end;

procedure TfrmLogin.edtLoginExit(Sender: TObject);
begin
   if lblVerificaUsuario.Text = 'Dísponivel' then
      lblVerificaUsuario.Visible := False;
end;

procedure TfrmLogin.edtUsuarioSenhaExit(Sender: TObject);
begin
   if edtUsuarioSenha.Text = '' then
   begin
      lblSenha.Text := 'Informe a senha';
      lblSenha.Visible := True;
   end
   else
      lblSenha.Visible := False;

end;

procedure TfrmLogin.FormCreate(Sender: TObject);
begin
    TabControl1.ActiveTab := tbLoginAcesso;
    edtUsuario.SetFocus;

    //Facilitar o Login  no modo debug.
    {$IFDEF DEBUG}
    edtUsuario.Text := ParamStr(1);
    edtSenha.Text   := ParamStr(2);
    btnEntrar.SetFocus;
    {$ENDIF}
end;

procedure TfrmLogin.FormKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
    if (Key = 27)  then
        Application.Terminate;

end;

procedure TfrmLogin.Label4Click(Sender: TObject);
begin
   edtnome.Text := '';
   edtlogin.Text := '';
   edtUsuarioSenha.Text := '';
   edtUsuarioConfirma.Text := '';
   TabControl1.ActiveTab := tbLoginCadastro;
end;

procedure TfrmLogin.Rectangle6Click(Sender: TObject);
begin
     TabControl1.ActiveTab := tbLoginAcesso;
end;

procedure TfrmLogin.retAddUsuarioClick(Sender: TObject);
begin
   if (edtlogin.text <> '') and  (edtUsuarioSenha.text <> '')then
   begin
       if (not lblConfirmaSenha.Visible) and (not lblSenha.Visible) and
          (not lblVerificaUsuario.Visible) then
       begin
           with ibqUser do
           begin
             Close;
             SQL.Clear;
             SQL.Add('INSERT INTO TBL_USUARIO (USU_NAME,USU_LOGIN,USU_SENHA) VALUES ('+
                      Quotedstr(edtNome.text)+ ','+
                      Quotedstr(edtlogin.text)+ ','+
                      Quotedstr(edtUsuarioSenha.text)+')');
             ExecSQL;

           end;
          edtUsuario.Text := '';
          edtSenha.Text := '';
          TabControl1.ActiveTab := tbLoginAcesso;
       end;
   end
   else
     edtlogin.SetFocus;
end;

procedure TfrmLogin.retVoltarLoginClick(Sender: TObject);
begin
   TabControl1.ActiveTab := tbLoginAcesso;
end;

procedure TfrmLogin.SalvarClick(Sender: TObject);
begin
    retAddUsuarioClick(Self);
end;

procedure TfrmLogin.btnEntrarClick(Sender: TObject);
begin
    try
        with ibqUser do
        begin
            Close;
            SQL.Clear;
            SQL.Add(' Select * from TBL_USUARIO                     '+
                    ' Where USU_LOGIN = '+QuotedStr(edtUsuario.text) +
                    '   and USU_SENHA = '+QuotedStr(edtSenha.text));

            Open;

            if not IsEmpty then
            begin
                 Close;
                 try
                    frmPrincipal := TfrmPrincipal.Create(Self);
                    Self.hide;
                    frmPrincipal.ShowModal;
                 finally
                     frmPrincipal.Free;
                     self.close;
                 end;

            end
            else
            begin

                  with DM1.ibqAuxiliar do
                  begin
                      Close;
                      SQL.Clear;
                      SQL.Add(' Select * from TBL_USUARIO                    '+#13+
                              ' Where USU_LOGIN = '+QuotedStr(edtUsuario.text) );

                      Open;
                      if IsEmpty then
                      begin
                         MessageDlg('Usuário não cadastrado. Crie uma conta.',mtInformation,[mbOk],0);
                         edtUsuario.SetFocus;
                         edtUsuario.SelectAll;
                      end
                      else
                      begin
                         MessageDlg('Senha inválida',mtInformation,[mbOk],0);
                         edtSenha.SetFocus;
                         edtSenha.Text := '';
                      end;
                  end;
            end;
        end;
    except on E: Exception do
        MessageDlg('Problema ao buscar usuário. Erro:'+e.ToString,mtInformation,[mbOk],0);
    end;
end;

procedure TfrmLogin.btnSalvarClick(Sender: TObject);
begin
     retAddUsuarioClick(Self);
end;

procedure TfrmLogin.btnCancelarClick(Sender: TObject);
begin
   Application.Terminate;
end;

end.
