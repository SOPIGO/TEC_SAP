CLASS lhc_ZR_GPI_ER_ATTRIBUTE DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR zr_gpi_er_attribute RESULT result.

    METHODS HideShow_Attribute FOR MODIFY
      IMPORTING keys FOR ACTION zr_gpi_er_attribute~HideShow_Attribute.

ENDCLASS.

CLASS lhc_ZR_GPI_ER_ATTRIBUTE IMPLEMENTATION.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD HideShow_Attribute.
  ENDMETHOD.

ENDCLASS.
