program main;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  Horse,
  Horse.JWT,
  Horse.Jhonson,
  Horse.HandleException,
  System.SysUtils,
  DBConnection in 'Utils\DBConnection.pas',
  BaseConnetion in 'DAO\BaseConnetion.pas' {FormBaseConnetion: TDataModule},
  UsuariosController in 'controller\UsuariosController.pas',
  UsuariosFunctions in 'controller\UsuariosFunctions.pas',
  FunctionsRotas in 'Utils\FunctionsRotas.pas',
  LoginController in 'controller\LoginController.pas',
  TarefasController in 'controller\TarefasController.pas',
  TarefasFunctions in 'controller\TarefasFunctions.pas';

begin
  THorse
    .Use(Jhonson)
    .Use(HandleException)
    .Use(HorseJWT(GetJWTPrivateKeyFromIni, THorseJWTConfig.New.SkipRoutes('/Login')));

  UsuariosController.RegistryRotas;
  LoginController.RegistryRotas;
  TarefasController.RegistryRotas;

     THorse.Listen(9000,
  procedure
  begin
    Writeln('Server is running on port '+THorse.Port.ToString);
  end);

end.
