@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Zi_GPI_ER_SCNR'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X, 
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
// ------------------------------------------------------------------------------------------------
//  Root Entity !! (->Define Root)
// ------------------------------------------------------------------------------------------------
define root view entity ZI_GPI_ER_SCENARIO as select from zdb_gpi_er_scnr
// ------------------------------------------------------------------------------------------------
 composition [0..*] of ZI_GPI_ER_ENTITY as _RootEntity
// composition [0..1] of ZI_GPI_ER_FILE   as _File4CSDL 
// ------------------------------------------------------------------------------------------------ 
{
    key uuid as Uuid,
    scenario_indx as ScenarioIndx,
    scenario_txt as ScenarioTxt,
    entity_type as EntityType,
    created_by as CreatedBy,
    created_at as CreatedAt,
    last_changed_by as LastChangedBy,
    last_changed_at as LastChangedAt,
    
   
    _RootEntity
 //   _File4CSDL
}
// ------------------------------------------------------------------------------------------------
// ------------------------------------------------------------------------------------------------
