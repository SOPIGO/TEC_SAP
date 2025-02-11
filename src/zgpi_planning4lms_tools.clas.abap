CLASS zgpi_planning4lms_tools DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zgpi_planning4lms_tools IMPLEMENTATION.

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
    DATA ls_row_Actor TYPE zdb_actor.
    ls_row_actor-uuid       = system_uuid->create_uuid_x16( ).
    ls_row_actor-name_first = 'Jean'.
    ls_row_actor-name_last  = 'Aimarre'.
    INSERT  zdb_actor FROM @ls_row_actor.


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


    ls_row_calendar-uuid            = system_uuid->create_uuid_x16( ).
    ls_row_calendar-pl_theo_uuid    = ls_row_plan_theo-uuid.
    ls_row_calendar-coursedate      = sy-datum.
    ls_row_plan_theo-course_uuid    = ls_row_course1-uuid.
    INSERT  zdb_calendar FROM @ls_row_calendar.

    ls_row_calendar-uuid            = system_uuid->create_uuid_x16( ).
    ls_row_calendar-coursedate      = ls_row_calendar-coursedate + 1.
    INSERT  zdb_calendar FROM @ls_row_calendar.

    COMMIT WORK.
    out->write( 'DATA CREATED' ).
  ENDMETHOD.
ENDCLASS.
