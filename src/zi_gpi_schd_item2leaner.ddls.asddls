@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Schedule Item To Leaner'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
// ------------------------------------------------------------------------------------------------
define view entity ZI_GPI_SCHD_ITEM2LEANER
  as select from zdb_schditm2lrnr
  // ----------------------------------------------------------------------------------------------
  // Link to parent -> used for composition !! ==>
  association        to parent ZI_GPI_Schedule_item as _ScheduleItem on $projection.UuidScheduleItem = _ScheduleItem.Uuid
  association [0..1] to ZI_GPI_ACTOR                as _Learner      on $projection.UuidLearner = _Learner.Uuid
  // ----------------------------------------------------------------------------------------------
{
  key uuid               as Uuid,
      uuid_schedule_item as UuidScheduleItem,
      uuid_learner       as UuidLearner,

      _ScheduleItem,
      _Learner
}
// ------------------------------------------------------------------------------------------------
// ------------------------------------------------------------------------------------------------
