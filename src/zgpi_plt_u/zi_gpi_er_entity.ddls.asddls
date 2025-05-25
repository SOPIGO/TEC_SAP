@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GPI-ER-Entity'

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
define view entity ZI_GPI_ER_ENTITY
  // ------------------------------------------------------------------------------------------------
  //  as select from zdb_gpi_er_entty
  as projection on ZR_GPI_ER_ENTITY
  // --------------------------------------------------------------------------------------------
  // Link to parent / root   -> used for composition !! ==>
  // association         to parent ZI_GPI_ER_SCENARIO as _Scenario on $projection.UuidScenario = _Scenario.Uuid
  // Link to children -> used for composition !! ==>
  // composition [0..*]  of ZI_GPI_ER_ATTRIBUTE as _Attributes
  // composition [0..*]  of ZI_GPI_ER_RELATION  as _Relations
  // ------------------------------------------------------------------------------------------------
{
  key Uuid,
      UuidScenario,
      ScenarioCode,
      EntityName,
      EntityVisible,
      EntityIndex,
      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,
      
      
     //   _zuuid_level_3_ET : redirected to composition child ZI_zuuid_level_3_ETTP,
  _Scenario : redirected to parent ZI_GPI_ER_SCENARIO,
  
     _Attributes : redirected to composition child ZI_GPI_ER_ATTRIBUTE,
      _Relations : redirected to composition child ZI_GPI_ER_RELATION

/*
      _Scenario,
      _Attributes,
      _Relations
      */
}
// ------------------------------------------------------------------------------------------------
// ------------------------------------------------------------------------------------------------
