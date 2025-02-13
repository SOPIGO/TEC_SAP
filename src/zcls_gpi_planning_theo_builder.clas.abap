CLASS zcls_gpi_planning_theo_builder DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES: TT_string TYPE TABLE OF string WITH DEFAULT KEY.

    INTERFACES if_oo_adt_classrun.
    CLASS-METHODS get_list_of_actors
      RETURNING
        value(ret_results) TYPE TT_string.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcls_gpi_planning_theo_builder IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.
    DATA: l_uuid_x16 TYPE sysuuid_x16.
    DATA: system_uuid TYPE REF TO if_system_uuid.
    DATA: oref        TYPE REF TO cx_uuid_error.

    system_uuid = cl_uuid_factory=>create_system_uuid( ).

*   -----------------------------------------------------------------------------------------------
*   RESET
*   -----------------------------------------------------------------------------------------------
    DELETE  FROM zdb_actor.
    DELETE  FROM zdb_course.
    DELETE  FROM zdb_plan_theo.
    DELETE  FROM zdb_plan_th2crs.
    DELETE  FROM zdb_calendar.

*   -----------------------------------------------------------------------------------------------
*   ACTORS
*   -----------------------------------------------------------------------------------------------
    DATA lv_leaner_id_01 TYPE zdb_course-UUID.
    DATA lv_leaner_id_02 TYPE zdb_course-UUID.
    DATA lv_leaner_id_03 TYPE zdb_course-UUID.
    DATA lv_leaner_id_04 TYPE zdb_course-UUID.
    DATA ls_row_Actor TYPE zdb_actor.
    ls_row_actor-uuid       = system_uuid->create_uuid_x16( ).
    ls_row_actor-name_first = 'Jean'.
    ls_row_actor-name_last  = 'Aimarre'.
    INSERT  zdb_actor FROM @ls_row_actor.
    Data(lt_actors) = me->GET_LIST_OF_ACTORS(  ).
    loop at LT_ACTORS into Data(lv_actor).
        SPLIT LV_ACTOR at ' ' INTO TABLE data(lt_actor_names).
        ls_row_actor-uuid       = system_uuid->create_uuid_x16( ).
        ls_row_actor-name_first = LT_ACTOR_NAMES[  1 ].
        ls_row_actor-name_last  = LT_ACTOR_NAMES[  2 ].
        INSERT  zdb_actor FROM @ls_row_actor.
        case sy-tabix.
          when 1. LV_LEANER_ID_01 = ls_row_actor-uuid  .
          when 2. LV_LEANER_ID_02 = ls_row_actor-uuid  .
          when 3. LV_LEANER_ID_03 = ls_row_actor-uuid  .
        endcase.

    endloop.




*   -----------------------------------------------------------------------------------------------
*   COURSES
*   -----------------------------------------------------------------------------------------------
    DATA ls_row_course1 TYPE zdb_course.
    DATA ls_row_course2 TYPE zdb_course.
    DATA ls_row_course3 TYPE zdb_course.
    DATA ls_row_course4 TYPE zdb_course.

    ls_row_course1-uuid         = system_uuid->create_uuid_x16( ).
    ls_row_course1-text         = 'Conduite en ville - 01 (bus)'.
    ls_row_course1-maxtainee    = 10.
    INSERT  zdb_course FROM @ls_row_course1.

    ls_row_course2-uuid         = system_uuid->create_uuid_x16( ).
    ls_row_course2-text         = 'Conduite en ville - 02 (bus)'.
    ls_row_course2-maxtainee    = 10.
    INSERT  zdb_course FROM @ls_row_course2.

    ls_row_course3-uuid         = system_uuid->create_uuid_x16( ).
    ls_row_course3-text         = 'Conduite en ville - 03 (bus)'.
    ls_row_course3-maxtainee    = 10.
    INSERT  zdb_course FROM @ls_row_course3.

    ls_row_course4-uuid         = system_uuid->create_uuid_x16( ).
    ls_row_course4-text         = 'Conduite en ville - 04 (bus)'.
    ls_row_course4-maxtainee    = 10.
    INSERT  zdb_course FROM @ls_row_course4.
*   -----------------------------------------------------------------------------------------------


*   -----------------------------------------------------------------------------------------------
*   PLANNING THEORICAL
*   -----------------------------------------------------------------------------------------------
    DATA ls_row_plan_theo        TYPE zdb_plan_theo.
    DATA ls_row_plan_theo2Crs1   TYPE zdb_plan_th2crs.
    DATA ls_row_calendar         TYPE zdb_calendar.
    DATA ls_row_plan_theo2Lrnr   TYPE ZDB_PLAN_TH2ACS.

    ls_row_plan_theo-uuid            = system_uuid->create_uuid_x16( ).
    ls_row_plan_theo-description     = 'Planning recyclage'.
    ls_row_plan_theo-attendee_amount = '10'.
    ls_row_plan_theo-datestart       = '20250115'.
    ls_row_plan_theo-course_uuid     = ls_row_course1-uuid.
    INSERT  zdb_plan_theo FROM @ls_row_plan_theo.

    ls_row_plan_theo2crs1-uuid               = system_uuid->create_uuid_x16( ).
    ls_row_plan_theo2crs1-uuid_course        = ls_row_course1-uuid .
    ls_row_plan_theo2crs1-uuid_planning_theo = ls_row_plan_theo-uuid .
    INSERT  zdb_plan_th2crs FROM @ls_row_plan_theo2crs1.


*   --------------------------------------------------------------------------------------
*   CALENDAR
*   --------------------------------------------------------------------------------------
    ls_row_calendar-uuid            = system_uuid->create_uuid_x16( ).
    ls_row_calendar-pl_theo_uuid    = ls_row_plan_theo-uuid.
    ls_row_calendar-course_date     = cl_abap_context_info=>get_system_date( ).
    ls_row_plan_theo-course_uuid    = ls_row_course1-uuid.
    INSERT  zdb_calendar FROM @ls_row_calendar.

    ls_row_calendar-uuid            = system_uuid->create_uuid_x16( ).
    ls_row_calendar-course_date     = ls_row_calendar-course_date + 1.
    INSERT  zdb_calendar FROM @ls_row_calendar.
*   --------------------------------------------------------------------------------------


*   --------------------------------------------------------------------------------------
*   LEARNER
*   --------------------------------------------------------------------------------------
     ls_row_plan_theo2Lrnr-uuid                 = system_uuid->create_uuid_x16( ).
     ls_row_plan_theo2Lrnr-UUID_PLANNING_THEO   = ls_row_plan_theo-uuid.
     ls_row_plan_theo2Lrnr-UUID_LEARNER         = LV_LEANER_ID_01.
     INSERT  ZDB_PLAN_TH2ACS FROM @ls_row_plan_theo2Lrnr.
*   --------------------------------------------------------------------------------------


    COMMIT WORK.
    out->write( 'DATA CREATED' ).


    GET_LIST_OF_ACTORS( ).
  ENDMETHOD.




  METHOD GET_LIST_OF_ACTORS.
        append 'Madison Rush' to Ret_Results.
        append 'Kaiser Hubbard' to Ret_Results.
        append 'Rosie Hall' to Ret_Results.
        append 'Thomas McLaughlin' to Ret_Results.
        append 'Stephanie Gould' to Ret_Results.
        append 'Blaine Velazquez' to Ret_Results.
        append 'Jaliyah Griffin' to Ret_Results.
        append 'Ayden Brandt' to Ret_Results.
        append 'Loretta Medina' to Ret_Results.
        append 'George Rosales' to Ret_Results.
        append 'Kinley Bailey' to Ret_Results.
        append 'Axel McMahon' to Ret_Results.
        append 'Belen Hammond' to Ret_Results.
        append 'Francis Crawford' to Ret_Results.
        append 'Aubree Griffin' to Ret_Results.
        append 'Ayden Johnston' to Ret_Results.
        append 'Laila Zimmerman' to Ret_Results.
        append 'Sergio Avery' to Ret_Results.
        append 'Meghan McIntyre' to Ret_Results.
        append 'Eliseo Juarez' to Ret_Results.
        append 'Juliet Jensen' to Ret_Results.
        append 'Cash Benjamin' to Ret_Results.
        append 'Jianna Haynes' to Ret_Results.
        append 'Kason May' to Ret_Results.
        append 'Adriana Blankenship' to Ret_Results.
        append 'Ernesto Doyle' to Ret_Results.
        append 'Annalise Warner' to Ret_Results.
        append 'Jaxton Knapp' to Ret_Results.
        append 'Linda Cardenas' to Ret_Results.
        append 'Johnathan Stephens' to Ret_Results.
        append 'Millie Carlson' to Ret_Results.
        append 'Paul Shaw' to Ret_Results.
        append 'Emersyn Banks' to Ret_Results.
        append 'Martin Stark' to Ret_Results.
        append 'Kamilah Huber' to Ret_Results.
        append 'Mac Proctor' to Ret_Results.
        append 'Chandler Maddox' to Ret_Results.
        append 'Lyric Skinner' to Ret_Results.
        append 'Mara Fernandez' to Ret_Results.
        append 'Bentley Floyd' to Ret_Results.
        append 'Yaretzi McLean' to Ret_Results.
        append 'Crosby Hickman' to Ret_Results.
        append 'Scarlette Sloan' to Ret_Results.
        append 'Ocean Patton' to Ret_Results.
        append 'Lorelei Sierra' to Ret_Results.
        append 'Dayton Cuevas' to Ret_Results.
        append 'Adele Reid' to Ret_Results.
        append 'Josue Schneider' to Ret_Results.
        append 'Delaney Jensen' to Ret_Results.
        append 'Natalia Bond' to Ret_Results.

  ENDMETHOD.

ENDCLASS.
