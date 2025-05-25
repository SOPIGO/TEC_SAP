@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'Projection View forZI_GPI_ER_SCNR'
@ObjectModel.semanticKey: [ 'ScenarioTxt' ]
@Search.searchable: true
define root view entity ZC_ZI_GPI_ER_SCNR01TP
  provider contract TRANSACTIONAL_QUERY
  as projection on ZR_ZI_GPI_ER_SCNR01TP as ZI_GPI_ER_SCNR
{
  key UUID,
  ScenarioIndx,
  @Search.defaultSearchElement: true
  @Search.fuzzinessThreshold: 0.90 
  ScenarioTxt,
  EntityType,
  EntityName,
  CreatedBy,
  CreatedAt,
  LastChangedBy,
  LastChangedAt,
  _Entity : redirected to composition child ZC_EntityTP
  
}
