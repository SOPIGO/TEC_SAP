CLASS lhc_ZI_GPI_PLAN_THEO DEFINITION INHERITING FROM CL_ABAP_BEHAVIOR_HANDLER.
  PRIVATE SECTION.

    METHODS CreateCalendar FOR MODIFY
      IMPORTING KEYS FOR ACTION ZI_GPI_PLAN_THEO~CreateCalendar.
    METHODS BuildData FOR MODIFY
      IMPORTING KEYS FOR ACTION ZI_GPI_PLAN_THEO~BuildData.

ENDCLASS.

CLASS lhc_ZI_GPI_PLAN_THEO IMPLEMENTATION.
* -------------------------------------------------------------------------------------------------
  METHOD CreateCalendar.
* -------------------------------------------------------------------------------------------------
    DATA LS_PLANNING TYPE   ZI_GPI_PLAN_THEO.
    DATA LT_PLANNING TYPE TABLE OF  ZI_GPI_PLAN_THEO.

    READ ENTITIES OF ZI_GPI_PLAN_THEO
    ENTITY ZI_GPI_PLAN_THEO
    ALL FIELDS  WITH CORRESPONDING #( KEYS )
    RESULT DATA(Lt_Entities) .
    IF LINES( Lt_Entities ) > 0 .
      MOVE-CORRESPONDING Lt_Entities[ 1 ] TO LS_PLANNING.
      DATA(Lo_Planning) = ZCLS_GPI_PLANNING_THEORICAL=>GET_INSTANCE( Ls_Planning ).
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
  METHOD BuildData.
    DATA Lo_DataBuilder TYPE REF TO   ZCLS_GPI_PLANNING_THEO_BUILDER.
    CREATE OBJECT LO_DATABUILDER.
    LO_DATABUILDER->BUILD_DATA(  ).
  ENDMETHOD.

ENDCLASS.
