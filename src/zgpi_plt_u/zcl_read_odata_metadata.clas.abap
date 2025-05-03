CLASS zcl_read_odata_metadata DEFINITION PUBLIC FINAL CREATE PUBLIC.
  PUBLIC SECTION.
    TYPES:
      BEGIN OF ty_association,
        name         TYPE string,
        target_type  TYPE string,
      END OF ty_association.
    TYPES: ty_association_table TYPE STANDARD TABLE OF ty_association WITH KEY name.


    CLASS-METHODS get_entity_associations
      IMPORTING
        iv_service_url   TYPE string
        iv_entity_name   TYPE string
      EXPORTING
        et_associations  TYPE ty_association_table
        ev_error         TYPE string
      RAISING
        cx_web_http_client_error.


  PRIVATE SECTION.
    CLASS-METHODS parse_metadata
      IMPORTING
        iv_xml_content   TYPE string
        iv_entity_name   TYPE string
      EXPORTING
        et_associations  TYPE ty_association_table.
ENDCLASS.

CLASS zcl_read_odata_metadata IMPLEMENTATION.
  METHOD get_entity_associations.
*    DATA: lo_http_client TYPE REF TO if_web_http_client.
*    DATA: lv_metadata_url TYPE string.
*    DATA: lv_xml_content  TYPE string.
*
*    lv_metadata_url = iv_service_url && '/$metadata'.
*
*    TRY.
*      lo_http_client = cl_web_http_client_manager=>create_http_client( lv_metadata_url ).
*      lo_http_client->send( if_web_http_client=>co_request_method_get ).
*
*      IF lo_http_client->get_status_code( ) BETWEEN 200 AND 299.
*        lv_xml_content = lo_http_client->get_response_entity( )->get_string( ).
*        et_associations = parse_metadata(
*          iv_xml_content = lv_xml_content
*          iv_entity_name = iv_entity_name
*        ).
*      ELSE.
*        ev_error = |Erreur lors de la récupération des métadonnées. Code HTTP: { lo_http_client->get_status_code( ) }|.
*      ENDIF.
*
*    CATCH cx_web_http_client_error INTO DATA(lx_http_error).
*      ev_error = lx_http_error->get_text( ).
*      RAISE lx_http_error.
*    ENDTRY.
  ENDMETHOD.

  METHOD parse_metadata.
*    DATA: lo_xml_parser   TYPE REF TO cl_xml_document.
*    DATA: lt_entity_types TYPE abap_elemntab.
*    DATA: ls_entity_type  TYPE abap_elemntab.
*    DATA: lt_properties   TYPE abap_elemntab.
*    DATA: ls_property     TYPE abap_elemntab.
*    DATA: lt_nav_props    TYPE abap_elemntab.
*    DATA: ls_nav_prop     TYPE abap_elemntab.
*
*    CREATE OBJECT lo_xml_parser.
*    TRY.
*      lo_xml_parser->load_xml( iv_xml_content ).
*    CATCH cx_xml_parser INTO DATA(lx_xml_error).
*      " Gérer l'erreur de parsing XML (peut-être logguer l'erreur)
*      RETURN.
*    ENDTRY.
*
*    lt_entity_types = lo_xml_parser->get_elements_by_tag_name( 'EntityType' ).
*
*    LOOP AT lt_entity_types INTO ls_entity_type.
*      DATA(lv_entity_name_from_xml) = ls_entity_type-attributes->get_attribute( 'Name' ).
*      IF lv_entity_name_from_xml = iv_entity_name.
*        lt_nav_props = lo_xml_parser->get_elements_by_tag_name( 'NavigationProperty' PARENT = ls_entity_type ).
*        LOOP AT lt_nav_props INTO ls_nav_prop.
*          DATA(lv_nav_prop_name) = ls_nav_prop-attributes->get_attribute( 'Name' ).
*          DATA(lv_nav_prop_type) = ls_nav_prop-attributes->get_attribute( 'Type' ).
*          APPEND INITIAL LINE TO et_associations ASSIGNING FIELD-SYMBOL(<ls_association>).
*          <ls_association>-name = lv_nav_prop_name.
*          <ls_association>-target_type = lv_nav_prop_type.
*        ENDLOOP.
*        EXIT. " Une fois l'entité trouvée, on peut arrêter la boucle
*      ENDIF.
*    ENDLOOP.
  ENDMETHOD.
ENDCLASS.

