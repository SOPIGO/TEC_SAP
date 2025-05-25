@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Projection View forEntity'
define view entity ZI_EntityTP
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
  _Relation : redirected to composition child ZI_Relation01TP,
  _Attribute : redirected to composition child ZI_AttributeTP,
  _ZI_GPI_ER_SCNR : redirected to parent ZI_ZI_GPI_ER_SCNR01TP
  
}
