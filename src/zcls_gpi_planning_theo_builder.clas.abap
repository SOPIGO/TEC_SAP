CLASS ZCLS_GPI_PLANNING_THEO_BUILDER DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES: TT_string TYPE TABLE OF STRING WITH DEFAULT KEY.

    INTERFACES IF_OO_ADT_CLASSRUN.
    CLASS-METHODS GET_LIST_OF_ACTORS
      RETURNING
        VALUE(RET_RESULTS) TYPE TT_string.
    CLASS-METHODS GET_LIST_OF_ORG_UNITS
      RETURNING
        VALUE(RET_RESULTS) TYPE TT_string.
    CLASS-METHODS CREATE_ORG_UNITS.
    CLASS-METHODS CREATE_ACTORS.
    CLASS-METHODS CREATE_ACTOR_2_ORG_UNIT.
    CLASS-METHODS CREATE_ACTOR_2_PlanningTheo.


  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCLS_GPI_PLANNING_THEO_BUILDER IMPLEMENTATION.


  METHOD CREATE_ACTORS.
*   -----------------------------------------------------------------------------------------------
*   Actors
*   -----------------------------------------------------------------------------------------------
    DATA LV_UUID_X16      TYPE SYSUUID_X16.
    DATA LO_SYSTEM_UUID   TYPE REF TO IF_SYSTEM_UUID.
    DATA LO_EXCPTION_UUIS TYPE REF TO CX_UUID_ERROR.
    DATA LS_DB_ROW        TYPE ZDB_ACTOR.
    DATA(LT_ACTORS) = ZCLS_GPI_PLANNING_THEO_BUILDER=>GET_LIST_OF_ACTORS( ).

    LO_SYSTEM_UUID = CL_UUID_FACTORY=>CREATE_SYSTEM_UUID( ).
    LOOP AT LT_ACTORS INTO DATA(LV_ACTOR).
      SPLIT LV_ACTOR AT ' ' INTO TABLE DATA(LT_ACTOR_NAMES).
      LS_DB_ROW-UUID       = LO_SYSTEM_UUID->CREATE_UUID_X16( ).
      LS_DB_ROW-NAME_FIRST = LT_ACTOR_NAMES[  1 ].
      LS_DB_ROW-NAME_LAST  = LT_ACTOR_NAMES[  2 ].
      INSERT  ZDB_ACTOR FROM @LS_DB_ROW.
    ENDLOOP.
    COMMIT WORK.
  ENDMETHOD.


  METHOD CREATE_ACTOR_2_ORG_UNIT.
*   -----------------------------------------------------------------------------------------------
*   Actors
*   -----------------------------------------------------------------------------------------------
    DATA LS_DB_ROW_ORG_UNIT     TYPE ZDB_ORG_UNIT.
    DATA LS_DB_ROW_OU2ACTOR     TYPE ZDB_OU2ACTOR.
    DATA LO_SYSTEM_UUID         TYPE REF TO IF_SYSTEM_UUID.

    LO_SYSTEM_UUID = CL_UUID_FACTORY=>CREATE_SYSTEM_UUID( ).

    SELECT *
    FROM   ZDB_ACTOR
    INTO   TABLE @DATA(LT_DB_ROW_ACTOR).

    SELECT *
    FROM   ZDB_ORG_UNIT
    INTO   TABLE @DATA(LT_DB_ROW_ORG_UNIT).

    DATA LV_INDEX_OU TYPE I.
    DATA LV_INDEX_OU_MAX TYPE I.

    LV_INDEX_OU = 1.
    LV_INDEX_OU_MAX = LINES( LT_DB_ROW_ORG_UNIT ).

    LOOP AT LT_DB_ROW_ACTOR INTO DATA(LS_DB_ROW_ACTOR).
      LS_DB_ROW_OU2ACTOR-UUID = LO_SYSTEM_UUID->CREATE_UUID_X16( ).
      LS_DB_ROW_OU2ACTOR-UUID_ACTOR = LS_DB_ROW_ACTOR-UUID.
      LS_DB_ROW_OU2ACTOR-UUID_ORG_UNIT = LT_DB_ROW_ORG_UNIT[ LV_INDEX_OU  ]-UUID.
      LV_INDEX_OU = LV_INDEX_OU + 1.
      IF LV_INDEX_OU > LV_INDEX_OU_MAX.
        LV_INDEX_OU = 1.
      ENDIF.
      INSERT  ZDB_OU2ACTOR FROM @LS_DB_ROW_OU2ACTOR.
    ENDLOOP.
    COMMIT WORK.
  ENDMETHOD.


  METHOD CREATE_ACTOR_2_PlanningTheo.
*   -----------------------------------------------------------------------------------------------
*   -----------------------------------------------------------------------------------------------
    DATA LS_DB_ROW_PLAN2LEANER     TYPE ZDB_PLAN_TH2ACS.
    DATA LO_SYSTEM_UUID         TYPE REF TO IF_SYSTEM_UUID.
    DATA LV_LEARNER_AMOUNT         TYPE I.

    LV_LEARNER_AMOUNT   = 10.

    LO_SYSTEM_UUID = CL_UUID_FACTORY=>CREATE_SYSTEM_UUID( ).

    SELECT *
    FROM   ZDB_ACTOR
    INTO   TABLE @DATA(LT_DB_ROW_ACTOR).

    SELECT *
    FROM   ZDB_PLAN_THEO
    INTO   TABLE @DATA(LT_DB_ROW_PLANNING).

    DATA LV_INDEX TYPE I.
    DATA LV_INDEX_MAX TYPE I.

    LV_INDEX = 1.
    LV_INDEX_MAX = LINES( LT_DB_ROW_ACTOR ).

    LOOP AT LT_DB_ROW_PLANNING INTO DATA(LS_DB_ROW_PLANNING).
      DO LV_LEARNER_AMOUNT TIMES.
        LS_DB_ROW_PLAN2LEANER-UUID = LO_SYSTEM_UUID->CREATE_UUID_X16( ).
        LS_DB_ROW_PLAN2LEANER-UUID_PLANNING_THEO = LS_DB_ROW_PLANNING-UUID.
        LS_DB_ROW_PLAN2LEANER-UUID_LEARNER = LT_DB_ROW_ACTOR[ LV_INDEX ]-UUID.
        INSERT  ZDB_PLAN_TH2ACS FROM @LS_DB_ROW_PLAN2LEANER.
        LV_INDEX = LV_INDEX + 1.
        IF LV_INDEX > LV_INDEX_MAX.
          LV_INDEX = 1.
        ENDIF.
      ENDDO.
    ENDLOOP.
    COMMIT WORK.
  ENDMETHOD.


  METHOD CREATE_ORG_UNITS.
*   -----------------------------------------------------------------------------------------------
*   Org. Units
*   -----------------------------------------------------------------------------------------------
    DATA LV_UUID_X16      TYPE SYSUUID_X16.
    DATA LO_SYSTEM_UUID   TYPE REF TO IF_SYSTEM_UUID.
    DATA LO_EXCPTION_UUIS TYPE REF TO CX_UUID_ERROR.
    DATA LS_DB_ROW        TYPE ZDB_ORG_UNIT.
    DATA(LT_OU) = ZCLS_GPI_PLANNING_THEO_BUILDER=>GET_LIST_OF_ORG_UNITS( ).

    LO_SYSTEM_UUID = CL_UUID_FACTORY=>CREATE_SYSTEM_UUID( ).
    LOOP AT LT_OU INTO DATA(LV_OU).
      LS_DB_ROW-UUID       = LO_SYSTEM_UUID->CREATE_UUID_X16( ).
      LS_DB_ROW-TEXT       = LV_OU.
      INSERT  ZDB_ORG_UNIT FROM @LS_DB_ROW.
    ENDLOOP.
  ENDMETHOD.


  METHOD GET_LIST_OF_ACTORS.
    APPEND 'Madison Rush' TO Ret_Results.
    APPEND 'Kaiser Hubbard' TO Ret_Results.
    APPEND 'Rosie Hall' TO Ret_Results.
    APPEND 'Thomas McLaughlin' TO Ret_Results.
    APPEND 'Stephanie Gould' TO Ret_Results.
    APPEND 'Blaine Velazquez' TO Ret_Results.
    APPEND 'Jaliyah Griffin' TO Ret_Results.
    APPEND 'Ayden Brandt' TO Ret_Results.
    APPEND 'Loretta Medina' TO Ret_Results.
    APPEND 'George Rosales' TO Ret_Results.
    APPEND 'Kinley Bailey' TO Ret_Results.
    APPEND 'Axel McMahon' TO Ret_Results.
    APPEND 'Belen Hammond' TO Ret_Results.
    APPEND 'Francis Crawford' TO Ret_Results.
    APPEND 'Aubree Griffin' TO Ret_Results.
    APPEND 'Ayden Johnston' TO Ret_Results.
    APPEND 'Laila Zimmerman' TO Ret_Results.
    APPEND 'Sergio Avery' TO Ret_Results.
    APPEND 'Meghan McIntyre' TO Ret_Results.
    APPEND 'Eliseo Juarez' TO Ret_Results.
    APPEND 'Juliet Jensen' TO Ret_Results.
    APPEND 'Cash Benjamin' TO Ret_Results.
    APPEND 'Jianna Haynes' TO Ret_Results.
    APPEND 'Kason May' TO Ret_Results.
    APPEND 'Adriana Blankenship' TO Ret_Results.
    APPEND 'Ernesto Doyle' TO Ret_Results.
    APPEND 'Annalise Warner' TO Ret_Results.
    APPEND 'Jaxton Knapp' TO Ret_Results.
    APPEND 'Linda Cardenas' TO Ret_Results.
    APPEND 'Johnathan Stephens' TO Ret_Results.
    APPEND 'Millie Carlson' TO Ret_Results.
    APPEND 'Paul Shaw' TO Ret_Results.
    APPEND 'Emersyn Banks' TO Ret_Results.
    APPEND 'Martin Stark' TO Ret_Results.
    APPEND 'Kamilah Huber' TO Ret_Results.
    APPEND 'Mac Proctor' TO Ret_Results.
    APPEND 'Chandler Maddox' TO Ret_Results.
    APPEND 'Lyric Skinner' TO Ret_Results.
    APPEND 'Mara Fernandez' TO Ret_Results.
    APPEND 'Bentley Floyd' TO Ret_Results.
    APPEND 'Yaretzi McLean' TO Ret_Results.
    APPEND 'Crosby Hickman' TO Ret_Results.
    APPEND 'Scarlette Sloan' TO Ret_Results.
    APPEND 'Ocean Patton' TO Ret_Results.
    APPEND 'Lorelei Sierra' TO Ret_Results.
    APPEND 'Dayton Cuevas' TO Ret_Results.
    APPEND 'Adele Reid' TO Ret_Results.
    APPEND 'Josue Schneider' TO Ret_Results.
    APPEND 'Delaney Jensen' TO Ret_Results.
    APPEND 'Natalia Bond' TO Ret_Results.

  ENDMETHOD.


  METHOD GET_LIST_OF_ORG_UNITS.
    APPEND 'Namur-Luxembourg-Arlon' TO Ret_Results.
    APPEND 'Namur-Luxembourg-Florennes' TO Ret_Results.
    APPEND 'Namur-Luxembourg-Libramont' TO Ret_Results.
    APPEND 'Namur-Luxembourg-Namur' TO Ret_Results.
    APPEND 'Liège-Verviers-Jemeppe' TO Ret_Results.
    APPEND 'Liège-Verviers-Robermont' TO Ret_Results.
    APPEND 'Charleroi-Genson' TO Ret_Results.
    APPEND 'Charleroi-Jumet' TO Ret_Results.
  ENDMETHOD.


  METHOD IF_OO_ADT_CLASSRUN~MAIN.
    DATA: L_UUID_X16 TYPE SYSUUID_X16.
    DATA: SYSTEM_UUID TYPE REF TO IF_SYSTEM_UUID.
    DATA: OREF        TYPE REF TO CX_UUID_ERROR.

    SYSTEM_UUID = CL_UUID_FACTORY=>CREATE_SYSTEM_UUID( ).

*   -----------------------------------------------------------------------------------------------
*   RESET
*   -----------------------------------------------------------------------------------------------
    DELETE  FROM ZDB_ACTOR.
    DELETE  FROM ZDB_COURSE.
    DELETE  FROM ZDB_PLAN_THEO.
    DELETE  FROM ZDB_PLAN_TH2CRS.
    DELETE  FROM ZDB_PLAN_TH2ACS.
    DELETE  FROM ZDB_CALENDAR.
    DELETE  FROM ZDB_ORG_UNIT.
    DELETE  FROM ZDB_OU2ACTOR.

    ZCLS_GPI_PLANNING_THEO_BUILDER=>CREATE_ORG_UNITS( ).
    ZCLS_GPI_PLANNING_THEO_BUILDER=>CREATE_ACTORS( ).
    ZCLS_GPI_PLANNING_THEO_BUILDER=>CREATE_ACTOR_2_ORG_UNIT( ).




*   -----------------------------------------------------------------------------------------------
*   COURSES
*   -----------------------------------------------------------------------------------------------
    DATA LS_ROW_COURSE1 TYPE ZDB_COURSE.
    DATA LS_ROW_COURSE2 TYPE ZDB_COURSE.
    DATA LS_ROW_COURSE3 TYPE ZDB_COURSE.
    DATA LS_ROW_COURSE4 TYPE ZDB_COURSE.

    LS_ROW_COURSE1-UUID         = SYSTEM_UUID->CREATE_UUID_X16( ).
    LS_ROW_COURSE1-TEXT         = 'Conduite en ville - 01 (bus)'.
    LS_ROW_COURSE1-MAXTAINEE    = 10.
    INSERT  ZDB_COURSE FROM @LS_ROW_COURSE1.

    LS_ROW_COURSE2-UUID         = SYSTEM_UUID->CREATE_UUID_X16( ).
    LS_ROW_COURSE2-TEXT         = 'Conduite en ville - 02 (bus)'.
    LS_ROW_COURSE2-MAXTAINEE    = 10.
    INSERT  ZDB_COURSE FROM @LS_ROW_COURSE2.

    LS_ROW_COURSE3-UUID         = SYSTEM_UUID->CREATE_UUID_X16( ).
    LS_ROW_COURSE3-TEXT         = 'Conduite en ville - 03 (bus)'.
    LS_ROW_COURSE3-MAXTAINEE    = 10.
    INSERT  ZDB_COURSE FROM @LS_ROW_COURSE3.

    LS_ROW_COURSE4-UUID         = SYSTEM_UUID->CREATE_UUID_X16( ).
    LS_ROW_COURSE4-TEXT         = 'Conduite en ville - 04 (bus)'.
    LS_ROW_COURSE4-MAXTAINEE    = 10.
    INSERT  ZDB_COURSE FROM @LS_ROW_COURSE4.
*   -----------------------------------------------------------------------------------------------


*   -----------------------------------------------------------------------------------------------
*   PLANNING THEORICAL
*   -----------------------------------------------------------------------------------------------
    DATA LS_ROW_PLAN_THEO        TYPE ZDB_PLAN_THEO.
    DATA ls_row_plan_theo2Crs1   TYPE ZDB_PLAN_TH2CRS.
    DATA LS_ROW_CALENDAR         TYPE ZDB_CALENDAR.
    DATA ls_row_plan_theo2Lrnr   TYPE ZDB_PLAN_TH2ACS.

    LS_ROW_PLAN_THEO-UUID            = SYSTEM_UUID->CREATE_UUID_X16( ).
    LS_ROW_PLAN_THEO-DESCRIPTION     = 'Planning recyclage'.
    LS_ROW_PLAN_THEO-ATTENDEE_AMOUNT = '10'.
    LS_ROW_PLAN_THEO-DATESTART       = '20250115'.
    LS_ROW_PLAN_THEO-COURSE_UUID     = LS_ROW_COURSE1-UUID.
    INSERT  ZDB_PLAN_THEO FROM @LS_ROW_PLAN_THEO.

    LS_ROW_PLAN_THEO2CRS1-UUID               = SYSTEM_UUID->CREATE_UUID_X16( ).
    LS_ROW_PLAN_THEO2CRS1-UUID_COURSE        = LS_ROW_COURSE1-UUID .
    LS_ROW_PLAN_THEO2CRS1-UUID_PLANNING_THEO = LS_ROW_PLAN_THEO-UUID .
    INSERT  ZDB_PLAN_TH2CRS FROM @LS_ROW_PLAN_THEO2CRS1.


*   --------------------------------------------------------------------------------------
*   CALENDAR
*   --------------------------------------------------------------------------------------
    LS_ROW_CALENDAR-PL_THEO_UUID    = LS_ROW_PLAN_THEO-UUID.

    " out->WRITE( | UUID => { ls_row_course1-uuid } | ).

    LS_ROW_CALENDAR-UUID            = SYSTEM_UUID->CREATE_UUID_X16( ).
    LS_ROW_CALENDAR-COURSE_DATE     = CL_ABAP_CONTEXT_INFO=>GET_SYSTEM_DATE( ).
    LS_ROW_CALENDAR-COURSE_UUID     = LS_ROW_COURSE1-UUID.
    INSERT  ZDB_CALENDAR FROM @LS_ROW_CALENDAR.

    LS_ROW_CALENDAR-UUID            = SYSTEM_UUID->CREATE_UUID_X16( ).
    LS_ROW_CALENDAR-COURSE_DATE     = LS_ROW_CALENDAR-COURSE_DATE + 1.
    LS_ROW_CALENDAR-COURSE_UUID     = LS_ROW_COURSE2-UUID.
    INSERT  ZDB_CALENDAR FROM @LS_ROW_CALENDAR.
*   --------------------------------------------------------------------------------------


*   --------------------------------------------------------------------------------------
*   LEARNER
*   --------------------------------------------------------------------------------------
    ZCLS_GPI_PLANNING_THEO_BUILDER=>CREATE_ACTOR_2_PlanningTheo(  ).
*   --------------------------------------------------------------------------------------
    COMMIT WORK.
    OUT->WRITE( 'DATA CREATED' ).
  ENDMETHOD.
ENDCLASS.
