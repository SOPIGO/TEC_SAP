@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'Projection View forzuuid_level_1_ET'
@ObjectModel.semanticKey: [ 'SemanticKey1' ]
@Search.searchable: true
define root view entity ZC_zuuid_level_1_ET01TP
  provider contract TRANSACTIONAL_QUERY
  as projection on ZR_zuuid_level_1_ET01TP as zuuid_level_1_ET
{
  key UuidLevel1,
  @Search.defaultSearchElement: true
  @Search.fuzzinessThreshold: 0.90 
  SemanticKey1,
  Description,
  LocalCreatedBy,
  LocalCreatedAt,
  LocalLastChangedBy,
  LocalLastChangedAt,
  LastChangedAt,
  _zuuid_level_2_ET : redirected to composition child ZC_zuuid_level_2_ETTP
  
}
