@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GPI-ER-Entity'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X, 
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
// ------------------------------------------------------------------------------------------------
define view entity ZI_GPI_ER_ENTITY
// ------------------------------------------------------------------------------------------------
    as select from zdb_gpi_er_entty
    // -------------------------------------------------------------------------------------------- 
    // Link to parent   -> used for composition !! ==>
    association         to parent ZI_GPI_ER_SCENARIO as _Scenario on $projection.UuidScenario = _Scenario.Uuid
    // Link to children -> used for composition !! ==>
    composition [0..*]  of ZI_GPI_ER_ATTRIBUTE as _Attributes
    composition [0..*]  of ZI_GPI_ER_RELATION  as _Relations
// ------------------------------------------------------------------------------------------------
{
    key uuid as Uuid,
    uuid_scenario as UuidScenario,
    scenario_code as ScenarioCode,
    entity_name as EntityName,
    entity_visible as EntityVisible,
    entity_index as EntityIndex,
    created_by as CreatedBy,
    created_at as CreatedAt,
    last_changed_by as LastChangedBy,
    last_changed_at as LastChangedAt,
    
    _Scenario,
    _Attributes,
    _Relations
}
// ------------------------------------------------------------------------------------------------
// ------------------------------------------------------------------------------------------------
