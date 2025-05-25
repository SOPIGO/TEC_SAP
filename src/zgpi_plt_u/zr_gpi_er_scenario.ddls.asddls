// ------------------------------------------------------------------------------------------------
@AccessControl.authorizationCheck   : #NOT_REQUIRED
@Metadata.allowExtensions           : true
@EndUserText.label                  : 'Base View-GPI-ER-Scenario'
// ------------------------------------------------------------------------------------------------
//  Root Entity !! (->Define Root)
// ------------------------------------------------------------------------------------------------
define root view entity ZR_GPI_ER_SCENARIO
as select from zdb_gpi_er_scnr
// ------------------------------------------------------------------------------------------------
   composition [0..*] of ZR_GPI_ER_ENTITY as _RootEntity
// composition [0..1] of ZI_GPI_ER_FILE   as _File4CSDL
// ------------------------------------------------------------------------------------------------
{
  key uuid                  as Uuid,
      scenario_indx         as ScenarioIndx,
      scenario_txt          as ScenarioTxt,
      entity_type           as EntityType,
      entity_name           as EntityName,
      created_by            as CreatedBy,
      created_at            as CreatedAt,
      last_changed_by       as LastChangedBy,


      @Semantics.user.createdBy: true
      local_created_by      as LocalCreatedBy,
      @Semantics.systemDateTime.createdAt: true
      local_created_at      as LocalCreatedAt,
      local_last_changed_by as LocalLastChangedBy,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at as LocalLastChangedAt,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at       as LastChangedAt,

      _RootEntity
      //   _File4CSDL
}
// ------------------------------------------------------------------------------------------------
// ------------------------------------------------------------------------------------------------
