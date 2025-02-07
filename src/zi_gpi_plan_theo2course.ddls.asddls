@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Planning Theorical To Courses'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
//define root view entity ZI_GPI_PLAN_THEO2COURSE
define  view entity ZI_GPI_PLAN_THEO2COURSE
  as select from zdb_plan_th2crs
  
//  association [0..1] to ZI_GPI_PLAN_THEO as _PlanningTheo on $projection.UuidPlanningTheo = _PlanningTheo.Uuid

  association to   parent  ZI_GPI_PLAN_THEO as _PlanningTheo on $projection.UuidPlanningTheo = _PlanningTheo.Uuid
  
  
  association [0..1] to ZI_GPI_COURSE    as _Course       on $projection.UuidCourse = _Course.Uuid

{
  key uuid               as Uuid,
      uuid_planning_theo as UuidPlanningTheo,
      uuid_course        as UuidCourse,
      
      _Course.Text as CourseTxt,
       _Course ,
       _PlanningTheo
      
      
     
      
}
