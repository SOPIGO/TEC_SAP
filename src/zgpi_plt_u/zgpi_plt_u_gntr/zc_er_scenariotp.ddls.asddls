@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'Projection View forER_Scenario'
@ObjectModel.semanticKey: [ 'UUID' ]
@Search.searchable: true
define root view entity ZC_ER_ScenarioTP
  provider contract TRANSACTIONAL_QUERY
  as projection on ZR_ER_ScenarioTP as ER_Scenario
{
  key UUID,
  ScenarioIndx,
  ScenarioTxt,
  EntityType,
  EntityName,
  CreatedBy,
  CreatedAt,
  LastChangedBy,
  LastChangedAt
  
}
