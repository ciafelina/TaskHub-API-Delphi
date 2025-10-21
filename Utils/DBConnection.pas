unit DBConnection;

interface

uses
  System.SysUtils, System.Classes, System.JSON, Data.DB, DataSet.Serialize, System.Generics.Collections, FireDAC.Comp.Client;

procedure ConfigurarConexaoPeloINI(AConexao: TFDConnection);
function GetJWTPrivateKeyFromIni: string;

implementation

uses
  System.IniFiles, System.IOUtils;

procedure ConfigurarConexaoPeloINI(AConexao: TFDConnection);
var
  LIniFile: TIniFile;
  LExePath, LParentDir, LConfigPath, LIniFilePath: string;
begin
  // Garante que o caminho para o .ini seja o mesmo do execut�vel
   LExePath := ExtractFilePath(ParamStr(0));
  // 2. Sobe um n�vel de diret�rio. De 'C:\...\src\Tests\' vai para 'C:\...\src'
  LParentDir := TPath.GetDirectoryName(ExcludeTrailingPathDelimiter(LExePath));
  // 3. Combina o caminho pai com a pasta 'Config'. Resultado: 'C:\...\src\Config'
  LConfigPath := TPath.Combine(LParentDir, 'Config');
  // 4. Monta o caminho final para o arquivo config.ini
  LIniFilePath := TPath.Combine(LConfigPath, 'config.ini');

  if not FileExists(LIniFilePath) then
    raise Exception.Create('Arquivo de configura��o "' + LIniFilePath + '" n�o encontrado.');
  LIniFile := TIniFile.Create(LIniFilePath);
  try
    // Limpa os par�metros antigos antes de carregar os novos
    AConexao.Params.Clear;
    // Carrega as configura��es do arquivo .ini
    AConexao.Params.Add('DriverID='      + LIniFile.ReadString('Database', 'DriverID', 'MSSQL'));
    AConexao.Params.Add('Server='        + LIniFile.ReadString('Database', 'Server', ''));
    AConexao.Params.Add('Database='      + LIniFile.ReadString('Database', 'Database', ''));
    AConexao.Params.Add('User_Name='     + LIniFile.ReadString('Database', 'User_Name', ''));
    AConexao.Params.Add('Password='      + LIniFile.ReadString('Database', 'Password', ''));
    AConexao.Params.Add('CharacterSet='  + LIniFile.ReadString('Database', 'CharacterSet', 'UTF8'));
    AConexao.LoginPrompt := False;
  finally
    LIniFile.Free;
  end;
end;

function GetJWTPrivateKeyFromIni: string;
var
  LIniFile: TIniFile;
  LExePath, LParentDir, LConfigPath, LIniFilePath: string;
begin
  // L�gica para encontrar o arquivo config.ini (a mesma que voc� j� tem)
  LExePath := ExtractFilePath(ParamStr(0));
  LParentDir := TPath.GetDirectoryName(ExcludeTrailingPathDelimiter(LExePath));
  LConfigPath := TPath.Combine(LParentDir, 'Config');
  LIniFilePath := TPath.Combine(LConfigPath, 'config.ini');

  if not FileExists(LIniFilePath) then
    raise Exception.Create('Arquivo de configura��o "' + LIniFilePath + '" n�o encontrado.');

  LIniFile := TIniFile.Create(LIniFilePath);
  try
    // L� a chave da se��o [JWT] e propriedade "Secret"
    Result := LIniFile.ReadString('JWT', 'Secret', '');
    if Result.Trim.IsEmpty then
      raise Exception.Create('A chave "Secret" n�o foi encontrada na se��o [JWT] do arquivo config.ini');
  finally
    LIniFile.Free;
  end;
end;

end.
