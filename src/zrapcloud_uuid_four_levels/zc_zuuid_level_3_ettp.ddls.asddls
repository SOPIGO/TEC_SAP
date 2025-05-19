@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'Projection View forzuuid_level_3_ET'
@ObjectModel.semanticKey: [ 'SemanticKey3' ]
@Search.searchable: true
define view entity ZC_zuuid_level_3_ETTP
  as projection on ZR_zuuid_level_3_ETTP as zuuid_level_3_ET
{
  key UuidLevel3,
  ParentUUID,
  RootUUID,
  @Search.defaultSearchElement: true
  @Search.fuzzinessThreshold: 0.90 
  SemanticKey3,
  Description,
  LocalLastChangedAt,
  _zuuid_level_2_ET : redirected to parent ZC_zuuid_level_2_ETTP,
  _zuuid_level_1_ET : redirected to ZC_zuuid_level_1_ET01TP
  
}
