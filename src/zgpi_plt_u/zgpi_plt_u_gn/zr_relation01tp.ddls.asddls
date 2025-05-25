@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'CDS View forRelation'
define view entity ZR_Relation01TP
  as select from ZDB_GPI_ER_RELAT as Relation
  association to parent ZR_EntityTP as _Entity on $projection.UuidScnEnttySrc = _Entity.UUID
  association [1] to ZR_ZI_GPI_ER_SCNR01TP as _ZI_GPI_ER_SCNR on $projection.UuidScenario = _ZI_GPI_ER_SCNR.UUID
{
  key UUID as UUID,
  UUID_SCENARIO as UuidScenario,
  UUID_SCN_ENTTY_SRC as UuidScnEnttySrc,
  UUID_SCN_ENTTY_DST as UuidScnEnttyDst,
  RELATION_CARDINALITY as RelationCardinality,
  RELATION_VISIBLE as RelationVisible,
  RELATION_NAME as RelationName,
  CREATED_BY as CreatedBy,
  CREATED_AT as CreatedAt,
  LAST_CHANGED_BY as LastChangedBy,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  LAST_CHANGED_AT as LastChangedAt,
  _Entity,
  _ZI_GPI_ER_SCNR
  
}
