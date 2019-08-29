program CRMVendas;

uses
  Vcl.Forms,
  uPrincipal in 'uPrincipal.pas' {frmPrincipal},
  uLogin in 'uLogin.pas' {frmLogin},
  uDM in 'uDM.pas' {DM1: TDataModule},
  uLancamentoCartorio in 'uLancamentoCartorio.pas' {frmGridCartorio},
  uCadCartorio in 'uCadCartorio.pas' {frmCadCartorio},
  uFuncoes in 'uFuncoes.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDM1, DM1);
  Application.CreateForm(TfrmLogin, frmLogin);
  try
     frmLogin.ShowModal;
  finally
     frmLogin.Free;
  end;


  Application.Run;
end.
