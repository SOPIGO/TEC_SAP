@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'Projection View forEntity'
@ObjectModel.semanticKey: [ 'UUID' ]
@Search.searchable: true
define view entity ZC_EntityTP
  as projection on ZR_EntityTP as Entity
{
  key UUID,
  UuidScenario,
  ScenarioCode,
  EntityName,
  EntityVisible,
  EntityIndex,
  CreatedBy,
  CreatedAt,
  LastChangedBy,
  LastChangedAt,
  _Relation : redirected to composition child ZC_Relation01TP,
  _Attribute : redirected to composition child ZC_AttributeTP,
  _ZI_GPI_ER_SCNR : redirected to parent ZC_ZI_GPI_ER_SCNR01TP
  
}
