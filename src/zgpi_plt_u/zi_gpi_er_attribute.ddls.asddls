@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GPI-ER-Attribute'

/*
@AbapCatalog.viewEnhancementCategory: [#NONE]

@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
*/
// ------------------------------------------------------------------------------------------------
define view entity ZI_GPI_ER_ATTRIBUTE
  // ------------------------------------------------------------------------------------------------
  as projection on ZR_GPI_ER_ATTRIBUTE
  // --------------------------------------------------------------------------------------------
  // Link to root   -> used for composition !! ==>
  // Link to parent -> used for composition !! ==>
  // association to          ZI_GPI_ER_SCENARIO  as _Scenario    on $projection.UuidScenario = _Scenario.Uuid
  // association to parent   ZI_GPI_ER_ENTITY    as _Entity      on $projection.UuidEntity = _Entity.Uuid

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


       _Entity   : redirected to parent ZI_GPI_ER_ENTITY,
       _Scenario : redirected to ZI_GPI_ER_SCENARIO


}
// ------------------------------------------------------------------------------------------------
