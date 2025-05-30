@EndUserText.label                  : 'Projection-ER-Relation'
@AccessControl.authorizationCheck   : #NOT_REQUIRED
@Metadata.allowExtensions           : true
// ------------------------------------------------------------------------------------------------
define view entity ZC_GPI_ER_RELATION
// ------------------------------------------------------------------------------------------------
as projection on ZR_GPI_ER_RELATION
// ------------------------------------------------------------------------------------------------
{
  key Uuid as Uuid,
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

       _Entity   : redirected to parent ZC_GPI_ER_ENTITY,
       _Scenario : redirected to ZC_GPI_ER_SCENARIO
}
// ------------------------------------------------------------------------------------------------
// ------------------------------------------------------------------------------------------------
