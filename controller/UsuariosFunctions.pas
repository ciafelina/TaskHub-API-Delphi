unit UsuariosFunctions;

interface

uses
  System.SysUtils, System.Classes, System.JSON, Data.DB, BaseConnetion, DataSet.Serialize,
  System.Generics.Collections, FireDAC.Comp.Client, FunctionsRotas;
type
  TCrudUsuarios = class
  private
    FDataModule: TFormBaseConnetion;
  public
    constructor Create(ADataModule: TFormBaseConnetion);
    function ListAll( const AQueryParams: TDictionary<string, string>  ): TDataSet;
    function Append(const AValue: TJSONObject): Boolean;
    function Update(const AValue: TJSONObject): Boolean;
    function Delete: Boolean;
    function GetById(const AId: Integer): TDataSet;
    function RecordCount: Int64;
  end;

implementation

{ TCrudUsuarios }

function TCrudUsuarios.Append(const AValue: TJSONObject): Boolean;
begin
  FDataModule.QryCadastroUsuarios.SQL.Add('where id is null');
  FDataModule.QryCadastroUsuariossenha_hash.Visible := true;
  FDataModule.QryCadastroUsuarios.Open;
  FDataModule.QryCadastroUsuarios.LoadFromJSON(AValue, false);
  Result := True;
end;

constructor TCrudUsuarios.Create(ADataModule: TFormBaseConnetion);
begin
  FDataModule := ADataModule;
end;

function TCrudUsuarios.Delete: Boolean;
begin
  FDataModule.QryCadastroUsuarios.Delete;
  Result := True;
end;

function TCrudUsuarios.GetById(const AId: Integer): TDataSet;
begin
  FDataModule.QryCadastroUsuarios.SQL.Add(' Where id = :Id');
  FDataModule.QryCadastroUsuarios.ParamByName('Id').Value := AId;
  FDataModule.QryCadastroUsuariossenha_hash.Visible := false;
  FDataModule.QryCadastroUsuarios.Open;
  Result := FDataModule.QryCadastroUsuarios;
end;

function TCrudUsuarios.ListAll( const AQueryParams: TDictionary<string, string>): TDataSet;
begin
  Pagination(FDataModule.QryPesquisaUsuarios, AQueryParams);
  Ordenacao(FDataModule.QryPesquisaUsuarios, AQueryParams);
  AplicaFiltros(FDataModule.QryPesquisaUsuarios, AQueryParams);

  FDataModule.QryPesquisaUsuarios.Open;
  Result := FDataModule.QryPesquisaUsuarios;
end;

function TCrudUsuarios.RecordCount: Int64;
begin
  FDataModule.QryRecordCountUsuarios.Open();
  Result := FDataModule.QryRecordCountUsuariosContador.AsInteger;
end;

function TCrudUsuarios.Update(const AValue: TJSONObject): Boolean;
begin
  FDataModule.QryCadastroUsuariossenha_hash.Visible := true;
  FDataModule.QryCadastrousuarios.MergeFromJSONObject(AValue, false);
  Result := True;
end;

end.
