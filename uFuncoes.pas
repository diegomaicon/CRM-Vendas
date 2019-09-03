unit uFuncoes;


interface

uses
  System.SysUtils;

  type
      TEstado = (tInsert, tUpdate, tDelete, tBrowser);

  function ValidarEMail(email: string): Boolean;

implementation

function ValidarEMail(email: string): Boolean;
begin
 email := Trim(UpperCase(email));
 if Pos('@', email) > 1 then
 begin
   Delete(email, 1, pos('@', email));
   Result := (Length(email) > 0) and (Pos('.', email) > 2);
 end
 else
   Result := False;
end;

end.
