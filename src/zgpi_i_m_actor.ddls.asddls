@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface Managed Actor (BO)'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}

@Metadata.allowExtensions: true
define root view entity ZGPI_I_M_ACTOR as select from zgpi_db_actor  
{
    key actor_uuid as ActorUuid,
    name_first as NameFirst,
    name_last as NameLast
}
