@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Actor'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
// ------------------------------------------------------------------------------------------------
@Metadata.allowExtensions: true
// ------------------------------------------------------------------------------------------------
define root view entity ZI_GPI_ACTOR
  as select from zdb_actor
// ------------------------------------------------------------------------------------------------  
association [1..1] to ZI_GPI_ORG_UNIT  as _OrgUnit      on $projection.UuidOrgUnit = _OrgUnit.Uuid  
{
  key uuid                  as Uuid,
      name_first            as NameFirst,
      name_last             as NameLast,
      uuid_org_unit         as UuidOrgUnit,   
      _OrgUnit.Text         as NameOrgUnit,
      
      // Administrative Data
      created_by      as CreatedBy,
      created_at      as CreatedAt,
      last_changed_by as LastChangedBy,
      last_changed_at as LastChangedAt
}
// ------------------------------------------------------------------------------------------------
// ------------------------------------------------------------------------------------------------
