@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'Projection View forzuuid_level_2_ET'
@ObjectModel.semanticKey: [ 'SemanticKey2' ]
@Search.searchable: true
define view entity ZC_zuuid_level_2_ETTP
  as projection on ZR_zuuid_level_2_ETTP as zuuid_level_2_ET
{
  key UuidLevel2,
  ParentUUID,
  @Search.defaultSearchElement: true
  @Search.fuzzinessThreshold: 0.90 
  SemanticKey2,
  Description,
  LocalLastChangedAt,
  _zuuid_level_3_ET : redirected to composition child ZC_zuuid_level_3_ETTP,
  _zuuid_level_1_ET : redirected to parent ZC_zuuid_level_1_ET01TP
  
}
