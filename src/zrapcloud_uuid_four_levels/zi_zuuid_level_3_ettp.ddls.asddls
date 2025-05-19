@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Projection View forzuuid_level_3_ET'
define view entity ZI_zuuid_level_3_ETTP
  as projection on ZR_zuuid_level_3_ETTP as zuuid_level_3_ET
{
  key UuidLevel3,
  ParentUUID,
  RootUUID,
  SemanticKey3,
  Description,
  LocalLastChangedAt,
  _zuuid_level_2_ET : redirected to parent ZI_zuuid_level_2_ETTP,
  _zuuid_level_1_ET : redirected to ZI_zuuid_level_1_ET01TP
  
}
