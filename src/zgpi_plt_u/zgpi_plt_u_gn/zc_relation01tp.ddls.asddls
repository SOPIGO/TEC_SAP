@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'Projection View forRelation'
@ObjectModel.semanticKey: [ 'UUID' ]
@Search.searchable: true
define view entity ZC_Relation01TP
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
  _Entity : redirected to parent ZC_EntityTP,
  _ZI_GPI_ER_SCNR : redirected to ZC_ZI_GPI_ER_SCNR01TP
  
}
