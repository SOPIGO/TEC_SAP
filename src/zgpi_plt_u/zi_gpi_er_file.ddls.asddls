@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZI_GPI_ER_FILE'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_GPI_ER_FILE
// ------------------------------------------------------------------------------------------------
    as select from zdb_gpi_er_file
    // -------------------------------------------------------------------------------------------- 
    // Link to parent   -> used for composition !! ==>
    association         to parent ZI_GPI_ER_SCENARIO as _Scenario on $projection.UuidScenario = _Scenario.Uuid    
// ------------------------------------------------------------------------------------------------    
{
    key uuid as Uuid,
    uuid_scenario as UuidScenario,
    attachment as Attachment,
    mimetype as Mimetype,
    filename as Filename ,
    
    _Scenario
}
// ------------------------------------------------------------------------------------------------
