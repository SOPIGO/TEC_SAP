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
  composition [0..*] of ZI_GPI_PLAN_THEO2COURSE as _Courses
  composition [0..*] of ZI_GPI_PLAN_THEO2ACTOR  as _Learners
  composition [0..*] of ZI_GPI_Schedule_item    as _ScheduleItem
  // ----------------------------------------------------------------------------------------------
{
  key uuid            as Uuid,
      description     as Description,
      datestart       as Datestart,
      attendee_amount as AttendeeAmount,
      created_by      as CreatedBy,
      created_at      as CreatedAt,
      last_changed_by as LastChangedBy,
      last_changed_at as LastChangedAt,

      // Associations ...
      _Courses,
      _Learners,
       _ScheduleItem
}
// ------------------------------------------------------------------------------------------------
// ------------------------------------------------------------------------------------------------
