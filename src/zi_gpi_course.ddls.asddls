@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Course'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
// ------------------------------------------------------------------------------------------------
define view entity ZI_GPI_COURSE
  as select from zdb_course
// ------------------------------------------------------------------------------------------------
{ 
  key uuid            as Uuid,
      text            as Text,
      max_trainee     as MaxTrainee,
      created_by      as CreatedBy,
      created_at      as CreatedAt,
      last_changed_by as LastChangedBy,
      last_changed_at as LastChangedAt
}
// ------------------------------------------------------------------------------------------------
// ------------------------------------------------------------------------------------------------
