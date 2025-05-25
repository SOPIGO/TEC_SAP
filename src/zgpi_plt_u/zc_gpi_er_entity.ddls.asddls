@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GPI-ER-Entity'
// ------------------------------------------------------------------------------------------------
define view entity ZC_GPI_ER_ENTITY
  // ------------------------------------------------------------------------------------------------
  as projection on ZR_GPI_ER_ENTITY
  // ------------------------------------------------------------------------------------------------
{
  key Uuid,
      UuidScenario,
      ScenarioCode,
      EntityName,
      EntityVisible,
      EntityIndex,
      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,

      _Scenario   : redirected to parent ZC_GPI_ER_SCENARIO,
      _Attributes : redirected to composition child ZC_GPI_ER_ATTRIBUTE,
      _Relations  : redirected to composition child ZC_GPI_ER_RELATION

}
// ------------------------------------------------------------------------------------------------
// ------------------------------------------------------------------------------------------------
