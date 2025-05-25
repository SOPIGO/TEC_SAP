CLASS lhc_ZR_GPI_ER_SCENARIO DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR zr_gpi_er_scenario RESULT result.

ENDCLASS.

CLASS lhc_ZR_GPI_ER_SCENARIO IMPLEMENTATION.

  METHOD get_global_authorizations.
  ENDMETHOD.

ENDCLASS.
