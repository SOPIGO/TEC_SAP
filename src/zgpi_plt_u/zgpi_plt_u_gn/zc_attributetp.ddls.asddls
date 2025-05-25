@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'Projection View forAttribute'
@ObjectModel.semanticKey: [ 'UUID' ]
//@Search.searchable: true
define view entity ZC_AttributeTP
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
  _Entity : redirected to parent ZC_EntityTP,
  _ZI_GPI_ER_SCNR : redirected to ZC_ZI_GPI_ER_SCNR01TP
  
}
