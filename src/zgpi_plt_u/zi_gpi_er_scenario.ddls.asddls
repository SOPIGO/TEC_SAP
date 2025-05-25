@EndUserText.label: 'Zi_GPI_ER_SCNR'
@AccessControl.authorizationCheck: #NOT_REQUIRED

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
//  Root Entity !! (->Define Root)
// ------------------------------------------------------------------------------------------------
define root view entity ZI_GPI_ER_SCENARIO

  provider contract transactional_interface

  // as select from zdb_gpi_er_scnr
  as projection on ZR_GPI_ER_SCENARIO
  // ------------------------------------------------------------------------------------------------
  // composition [0..*] of ZI_GPI_ER_ENTITY as _RootEntity
  // composition [0..1] of ZI_GPI_ER_FILE   as _File4CSDL
  // ------------------------------------------------------------------------------------------------
{
  key Uuid,
      ScenarioIndx,
      ScenarioTxt,
      EntityType,
      EntityName,
      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,


      _RootEntity : redirected to composition child ZI_GPI_ER_ENTITY

      // _RootEntity
      //   _File4CSDL
}
// ------------------------------------------------------------------------------------------------
// ------------------------------------------------------------------------------------------------
