CLASS lhc_ZI_GPI_PLAN_THEO DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS CreateCalendar FOR MODIFY
      IMPORTING keys FOR ACTION zi_gpi_plan_theo~CreateCalendar.

ENDCLASS.

CLASS lhc_ZI_GPI_PLAN_THEO IMPLEMENTATION.
* -------------------------------------------------------------------------------------------------
  METHOD CreateCalendar.



    " Read travel instances to approve
    READ ENTITIES OF zi_gpi_plan_theo
    ENTITY zi_gpi_plan_theo
    ALL FIELDS  WITH CORRESPONDING #( keys )
    RESULT DATA(LT_entities).

data(eee) =  LINES( LT_entities ).

*    " Update status to 'Approved'
*    MODIFY ENTITIES OF ZI_Travel_M
*      ENTITY Travel
*        UPDATE SET FIELDS WITH VALUE #(
*          FOR travel IN travels
*          ( %tky    = travel-%tky
*            Status  = 'A' ) ) " 'A' represents Approved
*      REPORTED DATA(reported).

  ENDMETHOD.
* -------------------------------------------------------------------------------------------------
ENDCLASS.
