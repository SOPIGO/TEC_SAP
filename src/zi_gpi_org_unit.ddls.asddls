@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Org. Unit'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
// ------------------------------------------------------------------------------------------------
@Metadata.allowExtensions: true
// ------------------------------------------------------------------------------------------------
define root view entity ZI_GPI_ORG_UNIT
  as select from zdb_org_unit
{
    key uuid as Uuid,
        text as Text,
        
        // Administrative data
        created_by as CreatedBy,
        created_at as CreatedAt,
        last_changed_by as LastChangedBy,
        last_changed_at as LastChangedAt
}
// ------------------------------------------------------------------------------------------------
// ------------------------------------------------------------------------------------------------
