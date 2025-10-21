unit FunctionsRotas;

interface

uses
  System.SysUtils, System.Classes, System.JSON, Data.DB, DataSet.Serialize, System.Generics.Collections, FireDAC.Comp.Client;

procedure Pagination(const AQuery: TFDQuery; const AQueryParams: TDictionary<string, string>);
procedure Ordenacao(const AQuery: TFDQuery; const AQueryParams: TDictionary<string, string>);
procedure AplicaFiltros(const AQuery: TFDQuery; const AQueryParams: TDictionary<string, string>);

implementation

procedure Pagination(const AQuery: TFDQuery; const AQueryParams: TDictionary<string, string>);
begin
  if AQueryParams.ContainsKey('limit') then
    begin
      AQuery.FetchOptions.RecsMax   := StrToIntDef(AQueryParams.Items['limit'], 10);
      AQuery.FetchOptions.RowsetSize := AQuery.FetchOptions.RecsMax;
    end;

  if AQueryParams.ContainsKey('offset') then
      AQuery.FetchOptions.RecsSkip := StrToIntDef(AQueryParams.Items['offset'], 0)
end;

procedure Ordenacao(const AQuery: TFDQuery; const AQueryParams: TDictionary<string, string>);
begin
  if not AQueryParams.ContainsKey('sort') then
    exit;

  var LSQLOrdenacao : string;

  var LOrdenacaoes := AQueryParams.Items['sort'].Split([';']);
  for var LOrdenacao in LOrdenacaoes do
    begin
      var LDadosOrdenacao := LOrdenacao.Split([',']);
      var LFildName := LDadosOrdenacao[0];
      if Assigned(AQuery.Fields.FindField(LFildName)) then
        begin

          if not LSQLOrdenacao.trim.IsEmpty then
            LSQLOrdenacao := LSQLOrdenacao + ' , ';

          LSQLOrdenacao := LSQLOrdenacao + LFildName;

          if Length(LDadosOrdenacao) = 2 then
            begin
              var LTipoOrdenacao := LDadosOrdenacao[1].Trim.ToLower;
              if LTipoOrdenacao.Equals('asc') or LTipoOrdenacao.Equals('desc') then
                LSQLOrdenacao := LSQLOrdenacao + ' ' + LTipoOrdenacao;
            end;
        end;

    end;
  if not LSQLOrdenacao.Trim.IsEmpty then
    AQuery.SQL.Add('order by ' + LSQLOrdenacao);

end;

procedure AplicaFiltros(const AQuery: TFDQuery; const AQueryParams: TDictionary<string, string>);
var
  Key, Value, CampoReal, ParamName: string;
  Field: TField;
begin
  if (AQueryParams = nil) or (AQueryParams.Count = 0) then
    Exit;

  for Key in AQueryParams.Keys do
  begin
    Field := AQuery.FindField(Key);
    if not Assigned(Field) then
      Continue;

    if SameText(Key, 'StatusTarefa') then
      CampoReal := 'T.Status'
    else if SameText(Key, 'StatusUsuario') then
      CampoReal := 'U.Status'
    else if SameText(Key, 'Nome') then
      CampoReal := 'U.Nome'
    else if SameText(Key, 'Email') then
      CampoReal := 'U.Email'
    else if SameText(Key, 'Titulo') then
      CampoReal := 'T.Titulo'
    else if SameText(Key, 'Descricao') then
      CampoReal := 'T.Descricao'
    else if SameText(Key, 'Usuario_id') then
      CampoReal := 'T.Usuario_id'
    else if SameText(Key, 'Criado_em') then
      CampoReal := 'T.Criado_em'
    else if SameText(Key, 'Atualizado_em') then
      CampoReal := 'T.Atualizado_em'
    else
      CampoReal := Key;

    Value := AQueryParams.Items[Key];
    ParamName := 'P_' + Key;

    if AQuery.SQL.Text.Contains('WHERE') then
      AQuery.SQL.Add(Format(' AND %s LIKE :%s', [CampoReal, ParamName]))
    else
      AQuery.SQL.Add(Format(' WHERE %s LIKE :%s', [CampoReal, ParamName]));

    AQuery.ParamByName(ParamName).AsString := '%' + Value + '%';
  end;
end;

end.
