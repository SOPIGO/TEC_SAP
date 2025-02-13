@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Calendar'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
// ------------------------------------------------------------------------------------------------
define view entity ZI_GPI_CALENDAR
// ------------------------------------------------------------------------------------------------
  as select from zdb_calendar  
  // ----------------------------------------------------------------------------------------------
  // Link to parent -> used for composition !! ==>
  association        to parent ZI_GPI_PLAN_THEO as _PlanningTheo on $projection.PlTheoUuid = _PlanningTheo.Uuid
  association        to ZI_GPI_COURSE as _Course on $projection.CourseUuid = _Course.Uuid
// ------------------------------------------------------------------------------------------------    
{
  key uuid            as Uuid,
      pl_theo_uuid    as PlTheoUuid,      
      coursedate      as Coursedate,
      course_uuid     as CourseUuid,
      course_tainer   as CourseTainer,
      course_trainees as CourseTrainees,
      course_id_sf    as CourseIdSf,
      session_id_sf   as SessionIdSf,
      created_by      as CreatedBy,
      created_at      as CreatedAt,
      last_changed_by as LastChangedBy,
      last_changed_at as LastChangedAt,
      
      _Course,
      _PlanningTheo
}
// ------------------------------------------------------------------------------------------------
// ------------------------------------------------------------------------------------------------
