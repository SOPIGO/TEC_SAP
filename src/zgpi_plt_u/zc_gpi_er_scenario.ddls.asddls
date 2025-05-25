@EndUserText.label: 'Zi_GPI_ER_SCNR'
@AccessControl.authorizationCheck: #NOT_REQUIRED
// ------------------------------------------------------------------------------------------------
//  Root Entity !! (->Define Root)
// ------------------------------------------------------------------------------------------------
define root view entity ZC_GPI_ER_SCENARIO
  provider contract transactional_interface
  as projection on ZR_GPI_ER_SCENARIO
  // ------------------------------------------------------------------------------------------------
{
  key Uuid,
      ScenarioIndx,
      ScenarioTxt,
      EntityType,
      EntityName,
      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,
      _RootEntity : redirected to composition child ZC_GPI_ER_ENTITY
}
// ------------------------------------------------------------------------------------------------
// ------------------------------------------------------------------------------------------------
