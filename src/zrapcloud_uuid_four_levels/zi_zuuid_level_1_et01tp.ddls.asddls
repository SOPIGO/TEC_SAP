@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Projection View forzuuid_level_1_ET'
define root view entity ZI_zuuid_level_1_ET01TP
  provider contract TRANSACTIONAL_INTERFACE
  as projection on ZR_zuuid_level_1_ET01TP as zuuid_level_1_ET
{
  key UuidLevel1,
  SemanticKey1,
  Description,
  LocalCreatedBy,
  LocalCreatedAt,
  LocalLastChangedBy,
  LocalLastChangedAt,
  LastChangedAt,
  _zuuid_level_2_ET : redirected to composition child ZI_zuuid_level_2_ETTP
  
}
