@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'CDS View forzuuid_level_2_ET'
define view entity ZR_zuuid_level_2_ETTP
  as select from ZUUID_LEVEL_2 as zuuid_level_2_ET
  association to parent ZR_zuuid_level_1_ET01TP as _zuuid_level_1_ET on $projection.ParentUUID = _zuuid_level_1_ET.UuidLevel1
  composition [0..*] of ZR_zuuid_level_3_ETTP as _zuuid_level_3_ET
{
  key UUID_LEVEL_2 as UuidLevel2,
  PARENT_UUID as ParentUUID,
  SEMANTIC_KEY_2 as SemanticKey2,
  DESCRIPTION as Description,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  LOCAL_LAST_CHANGED_AT as LocalLastChangedAt,
  _zuuid_level_3_ET,
  _zuuid_level_1_ET
  
}
