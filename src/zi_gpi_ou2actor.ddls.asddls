@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Org. Unit 2 Actor'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
} 
@Metadata.allowExtensions   : true
@Search.searchable          : true
// ------------------------------------------------------------------------------------------------
define root view entity ZI_GPI_OU2ACTOR
  // ----------------------------------------------------------------------------------------------
  as select from zdb_ou2actor
  // ----------------------------------------------------------------------------------------------
  // Link to parent -> used for composition !! ==>
  //  association        to parent ZI_GPI_PLAN_THEO as _PlanningTheo on $projection.UuidPlanningTheo = _PlanningTheo.Uuid
  association [0..1] to ZI_GPI_ACTOR    as _Actor   on $projection.UuidActor = _Actor.Uuid
  association [0..1] to ZI_GPI_ORG_UNIT as _OrgUnit on $projection.UuidOrgUnit = _OrgUnit.Uuid
  // ----------------------------------------------------------------------------------------------
{

  key uuid             as Uuid,
      uuid_org_unit    as UuidOrgUnit,
      uuid_actor       as UuidActor,

      @Search.defaultSearchElement: true
      _OrgUnit.Text    as OrgUnitTxt,
      _Actor.NameFirst as NameFirst,
      _Actor.NameLast  as NameLast,

      _OrgUnit,
      _Actor
}
// ------------------------------------------------------------------------------------------------
// ------------------------------------------------------------------------------------------------
