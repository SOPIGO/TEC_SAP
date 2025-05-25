@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'CDS View forEntity'
define view entity ZR_EntityTP
  as select from ZDB_GPI_ER_ENTTY as Entity
  association to parent ZR_ZI_GPI_ER_SCNR01TP as _ZI_GPI_ER_SCNR on $projection.UuidScenario = _ZI_GPI_ER_SCNR.UUID
  composition [0..*] of ZR_Relation01TP as _Relation
  composition [0..*] of ZR_AttributeTP as _Attribute
{
  key UUID as UUID,
  UUID_SCENARIO as UuidScenario,
  SCENARIO_CODE as ScenarioCode,
  ENTITY_NAME as EntityName,
  ENTITY_VISIBLE as EntityVisible,
  ENTITY_INDEX as EntityIndex,
  CREATED_BY as CreatedBy,
  CREATED_AT as CreatedAt,
  LAST_CHANGED_BY as LastChangedBy,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  LAST_CHANGED_AT as LastChangedAt,
  _Relation,
  _Attribute,
  _ZI_GPI_ER_SCNR
  
}
