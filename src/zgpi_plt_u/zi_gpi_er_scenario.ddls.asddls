@EndUserText.label: 'Zi_GPI_ER_SCNR'
@AccessControl.authorizationCheck: #NOT_REQUIRED
// ------------------------------------------------------------------------------------------------
//  Root Entity !! (->Define Root)
// ------------------------------------------------------------------------------------------------
define root view entity ZI_GPI_ER_SCENARIO
  provider contract transactional_interface
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

      _RootEntity : redirected to composition child ZI_GPI_ER_ENTITY
}
// ------------------------------------------------------------------------------------------------
// ------------------------------------------------------------------------------------------------
