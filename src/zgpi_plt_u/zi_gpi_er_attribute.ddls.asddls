@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GPI-ER-Attribute'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
// ------------------------------------------------------------------------------------------------
define view entity ZI_GPI_ER_ATTRIBUTE 
// ------------------------------------------------------------------------------------------------
as select from zdb_gpi_er_att
    // -------------------------------------------------------------------------------------------- 
    // Link to root   -> used for composition !! ==>    
    // Link to parent -> used for composition !! ==>    
    association to          ZI_GPI_ER_SCENARIO  as _Scenario    on $projection.UuidScenario = _Scenario.Uuid
    association to parent   ZI_GPI_ER_ENTITY    as _Entity      on $projection.UuidEntity = _Entity.Uuid
    
// ------------------------------------------------------------------------------------------------
{
    key uuid as Uuid,    
    uuid_scenario as UuidScenario,
    uuid_entity as UuidEntity,
    field_id as FieldId,
    field_visible as FieldVisible,
    field_index as FieldIndex,
    field_is_key as FieldIsKey,
    field_name as FieldName,
    created_by as CreatedBy,
    created_at as CreatedAt,
    last_changed_by as LastChangedBy,
    last_changed_at as LastChangedAt,
    
    _Scenario,
    _Entity
    
}
// ------------------------------------------------------------------------------------------------

