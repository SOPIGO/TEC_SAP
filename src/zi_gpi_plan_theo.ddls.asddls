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
// ------------------------------------------------------------------------------------------------
define root view entity ZI_GPI_PLAN_THEO
  // ----------------------------------------------------------------------------------------------
  as select from zdb_plan_theo
//  association [0..*] to ZI_GPI_CALENDAR         as _CalendarItem on $projection.Uuid = _CalendarItem.PlTheoUuid
  association [0..1] to ZI_GPI_COURSE           as _Course       on $projection.CourseUuid = _Course.Uuid
  composition [0..*] of ZI_GPI_PLAN_THEO2COURSE as _Courses
  
    composition [0..*] of ZI_GPI_CALENDAR         as _CalendarItem 
    
    //on $projection.Uuid = _CalendarItem.PlTheoUuid
  // ----------------------------------------------------------------------------------------------
{
  key uuid            as Uuid,
      course_uuid     as CourseUuid,
      description     as Description,
      datestart       as Datestart,
      attendee_amount as AttendeeAmount,
      created_by      as CreatedBy,
      created_at      as CreatedAt,
      last_changed_by as LastChangedBy,
      last_changed_at as LastChangedAt,

      _CalendarItem,
      _Courses,
      _Course

}
// ------------------------------------------------------------------------------------------------
// ------------------------------------------------------------------------------------------------
