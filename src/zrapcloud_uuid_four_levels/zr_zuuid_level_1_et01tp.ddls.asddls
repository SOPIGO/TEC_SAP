@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'CDS View forzuuid_level_1_ET'
define root view entity ZR_zuuid_level_1_ET01TP
  as select from ZUUID_LEVEL_1 as zuuid_level_1_ET
  composition [0..*] of ZR_zuuid_level_2_ETTP as _zuuid_level_2_ET
{
  key UUID_LEVEL_1 as UuidLevel1,
  SEMANTIC_KEY_1 as SemanticKey1,
  DESCRIPTION as Description,
  @Semantics.user.createdBy: true
  LOCAL_CREATED_BY as LocalCreatedBy,
  @Semantics.systemDateTime.createdAt: true
  LOCAL_CREATED_AT as LocalCreatedAt,
  LOCAL_LAST_CHANGED_BY as LocalLastChangedBy,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  LOCAL_LAST_CHANGED_AT as LocalLastChangedAt,
  @Semantics.systemDateTime.lastChangedAt: true
  LAST_CHANGED_AT as LastChangedAt,
  _zuuid_level_2_ET
  
}
