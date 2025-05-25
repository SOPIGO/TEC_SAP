@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'CDS View forAttribute'
define view entity ZR_AttributeTP
  as select from ZDB_GPI_ER_ATT as Attribute
  association to parent ZR_EntityTP as _Entity on $projection.UuidEntity = _Entity.UUID
  association [1] to ZR_ZI_GPI_ER_SCNR01TP as _ZI_GPI_ER_SCNR on $projection.UuidScenario = _ZI_GPI_ER_SCNR.UUID
{
  key UUID as UUID,
  UUID_SCENARIO as UuidScenario,
  UUID_ENTITY as UuidEntity,
  FIELD_ID as FieldID,
  FIELD_VISIBLE as FieldVisible,
  FIELD_INDEX as FieldIndex,
  FIELD_IS_KEY as FieldIsKey,
  FIELD_NAME as FieldName,
  CREATED_BY as CreatedBy,
  CREATED_AT as CreatedAt,
  LAST_CHANGED_BY as LastChangedBy,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  LAST_CHANGED_AT as LastChangedAt,
  _Entity,
  _ZI_GPI_ER_SCNR
  
}
