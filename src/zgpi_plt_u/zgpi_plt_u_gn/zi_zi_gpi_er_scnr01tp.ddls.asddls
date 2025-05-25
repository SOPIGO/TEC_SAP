@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Projection View forZI_GPI_ER_SCNR'
define root view entity ZI_ZI_GPI_ER_SCNR01TP
  provider contract TRANSACTIONAL_INTERFACE
  as projection on ZR_ZI_GPI_ER_SCNR01TP as ZI_GPI_ER_SCNR
{
  key UUID,
  ScenarioIndx,
  ScenarioTxt,
  EntityType,
  EntityName,
  CreatedBy,
  CreatedAt,
  LastChangedBy,
  LastChangedAt,
  _Entity : redirected to composition child ZI_EntityTP
  
}
