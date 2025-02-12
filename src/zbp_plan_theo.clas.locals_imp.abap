CLASS lhc_ZI_GPI_PLAN_THEO DEFINITION INHERITING FROM CL_ABAP_BEHAVIOR_HANDLER.
  PRIVATE SECTION.

    METHODS CreateCalendar FOR MODIFY
      IMPORTING KEYS FOR ACTION ZI_GPI_PLAN_THEO~CreateCalendar.

ENDCLASS.

CLASS lhc_ZI_GPI_PLAN_THEO IMPLEMENTATION.
* -------------------------------------------------------------------------------------------------
  METHOD CreateCalendar.
* -------------------------------------------------------------------------------------------------
    READ ENTITIES OF ZI_GPI_PLAN_THEO
    ENTITY ZI_GPI_PLAN_THEO
    ALL FIELDS  WITH CORRESPONDING #( KEYS )
    RESULT DATA(Lt_Entities).
    IF LINES( Lt_Entities ) > 0 .
      DATA(Ls_Planning) = Lt_Entities[ 1 ].
      DATA(Lo_Planning) = ZCLS_GPI_PLANNING_THEORICAL=>GET_INSTANCE( Ls_Planning-Uuid ).
      data(lt_xx) = Lo_Planning->GET_COURSES(  ).
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
