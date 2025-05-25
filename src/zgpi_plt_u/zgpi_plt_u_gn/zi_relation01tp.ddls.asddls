@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Projection View forRelation'
define view entity ZI_Relation01TP
  as projection on ZR_Relation01TP as Relation
{
  key UUID,
  UuidScenario,
  UuidScnEnttySrc,
  UuidScnEnttyDst,
  RelationCardinality,
  RelationVisible,
  RelationName,
  CreatedBy,
  CreatedAt,
  LastChangedBy,
  LastChangedAt,
  _Entity : redirected to parent ZI_EntityTP,
  _ZI_GPI_ER_SCNR : redirected to ZI_ZI_GPI_ER_SCNR01TP
  
}
