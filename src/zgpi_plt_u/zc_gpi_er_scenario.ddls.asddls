@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZC_GPI_ER_SCENARIO'
// @Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
// ------------------------------------------------------------------------------------------------
//  Root Entity !! (->Define Root)
// ------------------------------------------------------------------------------------------------
define view entity ZC_GPI_ER_SCENARIO as select from ZI_GPI_ER_SCENARIO
// ------------------------------------------------------------------------------------------------ 
{
    key Uuid,
    ScenarioIndx,
    ScenarioTxt,
    EntityType,
    CreatedBy,
    CreatedAt,
    LastChangedBy,
    LastChangedAt,
    
    /*
    @Semantics.mimeType: true
    _File4CSDL.Mimetype,
    
    _File4CSDL.Filename,
    
    @Semantics.largeObject: {
        mimeType : 'Mimetype',
        fileName : 'Filename',
        contentDispositionPreference: #INLINE,
        acceptableMimeTypes: [ 'application/xml '  ]
      }    
    _File4CSDL.Attachment,
    */
    
    /* Associations */
    //_File4CSDL,
    
    _RootEntity
}
