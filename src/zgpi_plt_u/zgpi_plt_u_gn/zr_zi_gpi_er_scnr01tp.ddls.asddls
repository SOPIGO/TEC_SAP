@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'CDS View forZI_GPI_ER_SCNR'
define root view entity ZR_ZI_GPI_ER_SCNR01TP
  as select from ZDB_GPI_ER_SCNR as ZI_GPI_ER_SCNR
  composition [0..*] of ZR_EntityTP as _Entity
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
  LAST_CHANGED_AT as LastChangedAt,
  _Entity
  
}
