@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'CDS View forER_Scenario'
define root view entity ZR_ER_ScenarioTP
  as select from ZDB_GPI_ER_SCNR as ER_Scenario
{
  key UUID as UUID,
  SCENARIO_INDX as ScenarioIndx,
  SCENARIO_TXT as ScenarioTxt,
  ENTITY_TYPE as EntityType,
  ENTITY_NAME as EntityName,
  CREATED_BY as CreatedBy,
  @Semantics.systemDateTime.createdAt: true
  CREATED_AT as CreatedAt,
  LAST_CHANGED_BY as LastChangedBy,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  LAST_CHANGED_AT as LastChangedAt
  
}
