@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZC_GPI_ER_SCENARIO'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZC_GPI_ER_SCENARIO as select from ZI_GPI_ER_SCENARIO
{
    key Uuid,
    ScenarioIndx,
    ScenarioTxt,
    EntityType,
    CreatedBy,
    CreatedAt,
    LastChangedBy,
    LastChangedAt,
    
    _File4CSDL.Mimetype,
    _File4CSDL.Filename,
    _File4CSDL.Attachment,
    
    /* Associations */
    _File4CSDL,
    _RootEntity
}
