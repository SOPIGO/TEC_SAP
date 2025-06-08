@EndUserText.label                  : 'Projection-ER-Scenario'
@AccessControl.authorizationCheck   : #NOT_REQUIRED
@Metadata.allowExtensions           : true
// ------------------------------------------------------------------------------------------------
//  Root Entity !! (->Define Root)
// ------------------------------------------------------------------------------------------------
define root view entity ZC_GPI_ER_SCENARIO
  provider contract transactional_query
  as projection on ZR_GPI_ER_SCENARIO
  // ------------------------------------------------------------------------------------------------
{
  key Uuid,
      ScenarioCode,
      ScenarioDescription,
      EntityType,
      EntityName,

      LocalCreatedBy,
      LocalCreatedAt,
      LocalLastChangedBy,
      LocalLastChangedAt,
      LastChangedAt,

      _RootEntity : redirected to composition child ZC_GPI_ER_ENTITY  
}
// ------------------------------------------------------------------------------------------------
// ------------------------------------------------------------------------------------------------
