@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label:'GPI-ER-Relation'

/*
@Metadata.allowExtensions: true
@AbapCatalog.viewEnhancementCategory: [#NONE]
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
*/
// ------------------------------------------------------------------------------------------------
define view entity ZI_GPI_ER_RELATION
  // ------------------------------------------------------------------------------------------------
  // as select from zdb_gpi_er_relat
  as projection on ZR_GPI_ER_RELATION
  // --------------------------------------------------------------------------------------------
  // Link to parent -> used for composition !! ==>
  // association        to parent    ZI_GPI_ER_ENTITY    as _Entity      on $projection.UuidScnEnttySrc  = _Entity.Uuid
  // association        to           ZI_GPI_ER_SCENARIO  as _Scenario    on $projection.UuidScenario     = _Scenario.Uuid
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


       _Entity   : redirected to parent ZI_GPI_ER_ENTITY,
       _Scenario : redirected to ZI_GPI_ER_SCENARIO

}
// ------------------------------------------------------------------------------------------------
// ------------------------------------------------------------------------------------------------
