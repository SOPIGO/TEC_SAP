CLASS zcl_gpi_main_run DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.


    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_gpi_main_run IMPLEMENTATION.

 METHOD if_oo_adt_classrun~main.
    out->write( 'Hello world!' ).

    DATA(lo_type) = CAST cl_abap_typedescr( cl_abap_typedescr=>describe_by_name( 'ZI_GPI_ACTOR' ) ).

    Data lo_rtt_structure type REF TO  CL_ABAP_STRUCTDESCR.
    lo_rtt_structure = cast  CL_ABAP_STRUCTDESCR( cl_abap_typedescr=>describe_by_name( 'ZI_GPI_ACTOR' ) ).

  data lo_entity type REF TO ZCL_GPI_ENTITY.
   create OBJECT lo_entity .
   lo_entity->lo_adt_out = out.
   lo_entity->init_attributes(  ).

*
*  DATA LO_ENTITY_CDS       TYPE REF TO CL_SADL_ENTITY_CDS.
*  LO_ENTITY_CDS ?=    CL_SADL_ENTITY_FACTORY=>GET_INSTANCE( )->GET_ENTITY(
*                        IV_TYPE = 'CDS'
*                        IV_ID   = CONV #(  'ZI_GPI_ACTOR'  ) ).


     out->write(  lo_type->absolute_name ).

*
*DATA:
**  ls_business_data TYPE <structure_name>,
*  lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
*  lo_request       TYPE REF TO /iwbep/if_cp_request_create,
*  lo_response      TYPE REF TO /iwbep/if_cp_response_create.
*
*
*lo_client_proxy = /iwbep/cl_cp_factory_unit_tst=>create_v2_local_proxy(
*                EXPORTING
*                  is_service_key     = VALUE #( service_id      = 'ZGPI_SRVB_ER_EXTRCTR_WAPI'
*
*                                                service_version = '0001' )
*                   iv_do_write_traces = abap_true ).
*
**
*** Prepare business data
**ls_business_data = VALUE #(
**          uuid           = '11112222333344445555666677778888'
**          uuidscenario   = '11112222333344445555666677778888'
**          uuidentity     = '11112222333344445555666677778888'
**          fieldid        = 'Fieldid'
**          fieldvisible   = abap_true
**          fieldindex     = 10
**          fieldiskey     = abap_true
**          fieldname      = 'Fieldname'
**          createdby      = 'Createdby'
**          createdat      = 20170101123000
**          lastchangedby  = 'Lastchangedby'
**          lastchangedat  = 20170101123000 ).
*
*" Navigate to the resource and create a request for the create operation
*lo_request = lo_client_proxy->create_resource_for_entity_set( 'ZI_GPI_ER_ATTRIBUTE' )->create_request_for_create( ).
*
*" Set the business data for the created entity
** lo_request->set_business_data( ls_business_data ).
*
*" Execute the request
*lo_response = lo_request->execute( ).


 TRY.
    zcl_read_odata_metadata=>get_entity_associations(
    EXPORTING
      iv_service_url = 'YOUR_ODATA_SERVICE_URL' " Remplace par l'URL de ton service OData
      iv_entity_name = 'YourEntityName'        " Remplace par le nom de ton entité
      IMPORTING
      et_associations = data(lt_entity_associations)
    ).


    IF lt_entity_associations IS NOT INITIAL.
     out->write(  'Associations pour l''entité YourEntityName:' ).
      LOOP AT lt_entity_associations INTO DATA(ls_association).
        out->write( '- Nom:' && ls_association-name && ', Type cible:' && ls_association-target_type ).
      ENDLOOP.
    ELSE.
      out->write(  'Aucune association trouvée pour l''entité YourEntityName ou l''entité n''existe pas.' ).
    ENDIF.

  CATCH cx_web_http_client_error INTO DATA(lx_error).
    out->write( 'Erreur HTTP:' && lx_error->get_text( ) ).
  ENDTRY.
*
**  IF lv_error IS NOT INITIAL.
**    out->write( 'Erreur générale:' && lv_error ).
**  ENDIF.


  ENDMETHOD.


ENDCLASS.
