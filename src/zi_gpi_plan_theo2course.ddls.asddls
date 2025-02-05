@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZI_PLAN_THEO'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
define root view entity ZI_GPI_PLAN_THEO2COURSE
  as select from zdb_plan_theo
  /*
  association [0..*] to ZI_CALENDAR     as _CalendarItem   on $projection.Uuid  = _CalendarItem.PlTheoUuid
  association [0..1] to ZI_GPI_COURSE   as _Course   on $projection.CourseUuid  = _Course.Uuid
  */
{
  key uuid as Uuid
      /*
      ,
      Planning_theo_UUID as
      ook_id as BookId,
        key author_id as AuthorId
          */
}
