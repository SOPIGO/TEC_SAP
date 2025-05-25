// ------------------------------------------------------------------------------------------------
@EndUserText.label                  : 'Projection-ER-Attribute'
@AccessControl.authorizationCheck   : #NOT_REQUIRED
@Metadata.allowExtensions           : true
// ------------------------------------------------------------------------------------------------
define view entity ZC_GPI_ER_ATTRIBUTE
// ------------------------------------------------------------------------------------------------
  as projection on ZR_GPI_ER_ATTRIBUTE
// ------------------------------------------------------------------------------------------------
{
  key  Uuid,
       UuidScenario,
       UuidEntity,
       FieldId,
       FieldVisible,
       FieldIndex,
       FieldIsKey,
       FieldName,
       CreatedBy,
       CreatedAt,
       LastChangedBy,
       LastChangedAt,
       _Entity   : redirected to parent ZC_GPI_ER_ENTITY,
       _Scenario : redirected to ZC_GPI_ER_SCENARIO
}
// ------------------------------------------------------------------------------------------------
