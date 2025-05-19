@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'CDS View forzuuid_level_3_ET'
define view entity ZR_zuuid_level_3_ETTP
  as select from ZUUID_LEVEL_3 as zuuid_level_3_ET
  association to parent ZR_zuuid_level_2_ETTP as _zuuid_level_2_ET on $projection.ParentUUID = _zuuid_level_2_ET.UuidLevel2
  association [1] to ZR_zuuid_level_1_ET01TP as _zuuid_level_1_ET on $projection.RootUUID = _zuuid_level_1_ET.UuidLevel1
{
  key UUID_LEVEL_3 as UuidLevel3,
  PARENT_UUID as ParentUUID,
  ROOT_UUID as RootUUID,
  SEMANTIC_KEY_3 as SemanticKey3,
  DESCRIPTION as Description,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  LOCAL_LAST_CHANGED_AT as LocalLastChangedAt,
  _zuuid_level_2_ET,
  _zuuid_level_1_ET
  
}
