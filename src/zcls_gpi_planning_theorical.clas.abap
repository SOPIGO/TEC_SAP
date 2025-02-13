* -------------------------------------------------------------------------------------------------
*  Planning - Theorical
* -------------------------------------------------------------------------------------------------
CLASS ZCLS_GPI_PLANNING_THEORICAL DEFINITION
  PUBLIC


  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES: TT_Courses TYPE TABLE OF ZI_GPI_COURSE WITH DEFAULT KEY.
    DATA:  ST_DATA TYPE ZDB_PLAN_THEO.

    CLASS-METHODS GET_INSTANCE_FROM_ID
      IMPORTING
        IM_PLANNING_UUID  TYPE SYSUUID_X16
      RETURNING
        VALUE(RET_RESULT) TYPE REF TO ZCLS_GPI_PLANNING_THEORICAL  .

CLASS-METHODS GET_INSTANCE
      IMPORTING
        IM_PLANNING  TYPE  ZI_GPI_PLAN_THEO
      RETURNING
        VALUE(RET_RESULT) TYPE REF TO ZCLS_GPI_PLANNING_THEORICAL  .

    METHODS  :   CreateCalendar.
    METHODS  :   GET_Courses   RETURNING
                                 VALUE(RET_RESULTS) TYPE TT_Courses ,
      CALENDAR_ADDITEM
        IMPORTING
          IM_COURSE_UUID TYPE sysuuid_x16
          IM_COUSE_DATE  TYPE D.



  PROTECTED SECTION.
  PRIVATE SECTION.
    ""! This class handles customer data operations.
ENDCLASS.



CLASS ZCLS_GPI_PLANNING_THEORICAL IMPLEMENTATION.

  METHOD GET_INSTANCE.
* -------------------------------------------------------------------------------------------------
    CREATE OBJECT RET_RESULT.
    MOVE-CORRESPONDING IM_PLANNING to RET_RESULT->ST_DATA.
    RETURN RET_RESULT.
* -------------------------------------------------------------------------------------------------
  ENDMETHOD.



  METHOD GET_Courses.
* -------------------------------------------------------------------------------------------------
    "  DATA: lt_result TYPE TABLE OF ZI_GPI_PLAN_THEO2COURSE.

    READ ENTITIES OF ZI_GPI_PLAN_THEO
    ENTITY ZI_GPI_PLAN_THEO BY \_Courses
    ALL FIELDS WITH VALUE #( ( Uuid = ME->ST_DATA-UUID ) )
    RESULT DATA(LT_Planning2Courses).

    LOOP AT LT_Planning2Courses INTO DATA(LS_Planning2Courses).
      SELECT SINGLE *
      FROM   ZI_GPI_COURSE
      WHERE  UUID = @LS_PLANNING2COURSES-UuidCourse
      INTO   @DATA(LS_COURSE).
      IF SY-SUBRC = 0.
        APPEND LS_COURSE TO RET_RESULTS.
      ENDIF.
    ENDLOOP.


* -------------------------------------------------------------------------------------------------
  ENDMETHOD.



  METHOD CreateCalendar.
* -------------------------------------------------------------------------------------------------
    DATA(LT_COURSES) = ME->GET_COURSES(  ).
    DATA LV_DATE TYPE D.

    LV_DATE = ME->ST_DATA-DATESTART.
    LOOP AT LT_COURSES INTO DATA(LS_COURSE).
      ME->CALENDAR_ADDITEM( IM_Course_UUID = LS_COURSE-Uuid
                            IM_COUSE_DATE  = LV_DATE ).

    ENDLOOP.


* -------------------------------------------------------------------------------------------------
  ENDMETHOD.



  METHOD CALENDAR_ADDITEM.
**       direct DB update ==>
*        data system_uuid TYPE REF TO if_system_uuid.
*        data ls_calendar_item type ZDB_CALENDAR.
*        system_uuid = cl_uuid_factory=>create_system_uuid( ).
*        LS_CALENDAR_ITEM-UUID =  system_uuid->create_uuid_x16( ).
*        LS_CALENDAR_ITEM-COURSEDATE = IM_COUSE_DATE.
*        LS_CALENDAR_ITEM-COURSE_UUID = IM_COURSE_UUID.
*        LS_CALENDAR_ITEM-PL_THEO_UUID = me->ST_DATA-UUID.
*        INSERT ZDB_CALENDAR from  @LS_CALENDAR_ITEM.


  MODIFY ENTITIES OF ZI_GPI_PLAN_THEO IN LOCAL MODE
  ENTITY ZI_GPI_PLAN_THEO

    CREATE BY \_CalendarItem
    FIELDS ( CourseDate CourseUuid   ) WITH
    VALUE #(
    ( %key-Uuid = me->ST_DATA-UUID  " The %key-id specifies the existing root entity to which the children will be associated.
      %target = VALUE #( (
    "    %cid = 'CID_CHILD1_1'
        CourseDate = IM_COUSE_DATE
        CourseUuid = IM_COURSE_UUID
      ) )
    )
  )
   MAPPED DATA(mapped)
          FAILED DATA(failed)
          REPORTED DATA(reported).


  ENDMETHOD.

  METHOD GET_INSTANCE_FROM_ID.
    CREATE OBJECT RET_RESULT.
    RET_RESULT->ST_DATA-UUID = IM_PLANNING_UUID.
    RETURN RET_RESULT.
  ENDMETHOD.

ENDCLASS.
* -------------------------------------------------------------------------------------------------
