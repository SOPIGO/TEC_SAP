@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Projection View forzuuid_level_2_ET'
define view entity ZI_zuuid_level_2_ETTP
  as projection on ZR_zuuid_level_2_ETTP as zuuid_level_2_ET
{
  key UuidLevel2,
  ParentUUID,
  SemanticKey2,
  Description,
  LocalLastChangedAt,
  _zuuid_level_3_ET : redirected to composition child ZI_zuuid_level_3_ETTP,
  _zuuid_level_1_ET : redirected to parent ZI_zuuid_level_1_ET01TP
  
}
