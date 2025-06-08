@AccessControl.authorizationCheck   : #NOT_REQUIRED
@EndUserText.label                  : 'GPI-ER-Relation'
@Metadata.allowExtensions           : true
// ------------------------------------------------------------------------------------------------
define view entity ZR_GPI_ER_RELATION
  // ------------------------------------------------------------------------------------------------
  as select from zdb_gpi_er_rel_a
  // --------------------------------------------------------------------------------------------
  // Link to parent -> used for composition !! ==>
  association to parent ZR_GPI_ER_ENTITY as _Entity   on $projection.UuidScnEnttySrc = _Entity.Uuid
  association [1] to ZR_GPI_ER_SCENARIO      as _Scenario on $projection.UuidScenario = _Scenario.Uuid
  // ------------------------------------------------------------------------------------------------
{
  key uuid                  as Uuid,
      uuid_scenario         as UuidScenario,
      uuid_scn_entty_src    as UuidScnEnttySrc,
      uuid_scn_entty_dst    as UuidScnEnttyDst,
      relation_cardinality  as RelationCardinality,
      relation_visible      as RelationVisible,
      relation_name         as RelationName,
      created_by            as CreatedBy,
      created_at            as CreatedAt,
      last_changed_by       as LastChangedBy,
      last_changed_at       as LastChangedAt,

      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at as LocalLastChangedAt,

      _Scenario,
      _Entity

}
// ------------------------------------------------------------------------------------------------
// ------------------------------------------------------------------------------------------------
