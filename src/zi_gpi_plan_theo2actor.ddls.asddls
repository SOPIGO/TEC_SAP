@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Planning Theorical To Learners'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
// ------------------------------------------------------------------------------------------------
define view entity ZI_GPI_PLAN_THEO2ACTOR
  // ----------------------------------------------------------------------------------------------
  as select from zdb_plan_th2acs
  // ----------------------------------------------------------------------------------------------
  // Link to parent -> used for composition !! ==>
  association        to parent ZI_GPI_PLAN_THEO as _PlanningTheo on $projection.UuidPlanningTheo = _PlanningTheo.Uuid
  association [0..1] to ZI_GPI_ACTOR            as _Learner      on $projection.UuidLearner = _Learner.Uuid
  // ----------------------------------------------------------------------------------------------
{
  key uuid               as Uuid,
      uuid_planning_theo as UuidPlanningTheo,

      @Consumption.valueHelpDefinition: [{
      entity: {     name    : 'ZI_GPI_ACTOR' ,
                    element : 'Uuid'  }     }]
      uuid_learner       as UuidLearner,

      _Learner.NameLast       as Learner_NameL,
      _Learner.NameFirst      as Learner_NameF,
      
      _Learner,
      _PlanningTheo
}
// ------------------------------------------------------------------------------------------------
// ------------------------------------------------------------------------------------------------
