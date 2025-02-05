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

*   clear data
    DELETE  from zdb_actor.
    DELETE  from zdb_course.
    DELETE  from zdb_plan_theo.
    DELETE  from zdb_calendar.

    Data ls_row_Actor type zdb_actor.
    ls_row_actor-uuid = system_uuid->create_uuid_x16( ).
    ls_row_actor-name_first = 'Jean'.
    ls_row_actor-name_last = 'Aimarre'.
    INSERT  zdb_actor from @ls_row_actor.


    Data ls_row_course type zdb_course.
        ls_row_course-uuid = system_uuid->create_uuid_x16( ).
        ls_row_course-text = 'Conduite en ville - 01 (bus)'.
       ls_row_course-maxtainee = 10.
    INSERT  zdb_course from @ls_row_course.

    Data ls_row_plan_theo type zdb_plan_theo.
    ls_row_plan_theo-uuid = system_uuid->create_uuid_x16( ).
    ls_row_plan_theo-description = 'Planning recyclage'.
    ls_row_plan_theo-attendee_amount = '10'.
    ls_row_plan_theo-datestart = '20250115'.
    ls_row_plan_theo-course_uuid = ls_row_course-uuid.
    INSERT  zdb_plan_theo from @ls_row_plan_theo.

    Data ls_row_calendar type zdb_calendar.
    ls_row_calendar-uuid = system_uuid->create_uuid_x16( ).
    ls_row_calendar-pl_theo_uuid = ls_row_plan_theo-uuid.
    ls_row_calendar-coursedate = sy-datum.
    ls_row_plan_theo-course_uuid = ls_row_course-uuid.
    INSERT  zdb_calendar from @ls_row_calendar.

    ls_row_calendar-uuid = system_uuid->create_uuid_x16( ).
    ls_row_calendar-coursedate = ls_row_calendar-coursedate + 1.
    INSERT  zdb_calendar from @ls_row_calendar.


    COMMIT WORK.
    out->write( 'DATA CREATED' ).
  ENDMETHOD.
ENDCLASS.
