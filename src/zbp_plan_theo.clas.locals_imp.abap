CLASS lhc_ZI_GPI_PLAN_THEO DEFINITION INHERITING FROM CL_ABAP_BEHAVIOR_HANDLER.
  PRIVATE SECTION.

    METHODS CreateCalendar FOR MODIFY
      IMPORTING KEYS FOR ACTION ZI_GPI_PLAN_THEO~CreateCalendar.

ENDCLASS.

CLASS lhc_ZI_GPI_PLAN_THEO IMPLEMENTATION.
* -------------------------------------------------------------------------------------------------
  METHOD CreateCalendar.
* -------------------------------------------------------------------------------------------------
    data ls_planning type   ZI_GPI_PLAN_THEO.
    data lt_planning type TABLE of  ZI_GPI_PLAN_THEO.

    READ ENTITIES OF ZI_GPI_PLAN_THEO
    ENTITY ZI_GPI_PLAN_THEO
    ALL FIELDS  WITH CORRESPONDING #( KEYS )
    RESULT data(Lt_Entities) .
    IF LINES( Lt_Entities ) > 0 .
"      ls_planning = conv #( Lt_Entities[ 1 ] ).
 MOVE-CORRESPONDING Lt_Entities[ 1 ] to LS_PLANNING.
      DATA(Lo_Planning) = ZCLS_GPI_PLANNING_THEORICAL=>GET_INSTANCE( Ls_Planning ).
      " data(lt_xx) = Lo_Planning->GET_COURSES(  ).
    "  Lo_Planning->DB_read( ).
      LO_PLANNING->CREATECALENDAR(  ).
    ENDIF.



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
