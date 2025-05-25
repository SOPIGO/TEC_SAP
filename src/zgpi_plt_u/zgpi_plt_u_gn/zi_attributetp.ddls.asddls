@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Projection View forAttribute'
define view entity ZI_AttributeTP
  as projection on ZR_AttributeTP as Attribute
{
  key UUID,
  UuidScenario,
  UuidEntity,
  FieldID,
  FieldVisible,
  FieldIndex,
  FieldIsKey,
  FieldName,
  CreatedBy,
  CreatedAt,
  LastChangedBy,
  LastChangedAt,
  _Entity : redirected to parent ZI_EntityTP,
  _ZI_GPI_ER_SCNR : redirected to ZI_ZI_GPI_ER_SCNR01TP
  
}
