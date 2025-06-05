

CLASS lhc_ZR_GPI_ER_SCENARIO DEFINITION INHERITING FROM cl_abap_behavior_handler.


  PUBLIC SECTION.
 DATA Ptr2_System_UUID       TYPE REF TO IF_SYSTEM_UUID.



  PRIVATE SECTION.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR zr_gpi_er_scenario RESULT result.
    METHODS buildmodel FOR MODIFY
      IMPORTING keys FOR ACTION zr_gpi_er_scenario~BuildModel RESULT result.

ENDCLASS.

CLASS lhc_ZR_GPI_ER_SCENARIO IMPLEMENTATION.



  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD BuildModel.
*  ME->Ptr2_System_UUID = CL_UUID_FACTORY=>CREATE_SYSTEM_UUID( ).
*      DATA LS_SC TYPE zdb_gpi_er_sc_a.
*      DATA LS_ET TYPE zdb_gpi_er_entty.
*
*    LS_SC-UUID               = Ptr2_System_UUID->CREATE_UUID_X16( ).
*     LS_SC-scenario_code = 'kkk'.
*
*    LS_ET-UUID               = Ptr2_System_UUID->CREATE_UUID_X16( ).
*     LS_ET-uuid_scenario =   LS_SC-UUID  .
*     ls_et-entity_name = 'E NAME XXX'.
*
*    INSERT  zdb_gpi_er_scnr     FROM @LS_SC.
*    INSERT  zdb_gpi_er_entty    FROM @LS_ET.
*
**   COMMIT WORK.


  ENDMETHOD.

ENDCLASS.
