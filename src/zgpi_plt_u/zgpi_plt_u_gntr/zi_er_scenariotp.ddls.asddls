@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Projection View forER_Scenario'
define root view entity ZI_ER_ScenarioTP
  provider contract TRANSACTIONAL_INTERFACE
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
