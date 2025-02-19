* -------------------------------------------------------------------------------------------------
*  Planning - Theorical
* -------------------------------------------------------------------------------------------------
CLASS ZCLS_GPI_PLANNING_THEORICAL DEFINITION
  PUBLIC


  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
* -------------------------------------------------------------------------------------------------
    TYPES: TT_Courses           TYPE TABLE OF ZI_GPI_COURSE WITH DEFAULT KEY.
    DATA ST_DATA                TYPE ZDB_PLAN_THEO.
    DATA Ptr2_System_UUID         TYPE REF TO IF_SYSTEM_UUID.
    DATA Tbl_Schedule           TYPE TABLE OF REF TO ZCLS_GPI_SCHEDULE_ITEM.
* -------------------------------------------------------------------------------------------------



    CLASS-METHODS GET_INSTANCE_FROM_ID
      IMPORTING
        IM_PLANNING_UUID  TYPE SYSUUID_X16
      RETURNING
        VALUE(RET_RESULT) TYPE REF TO ZCLS_GPI_PLANNING_THEORICAL  .

    CLASS-METHODS GET_INSTANCE
      IMPORTING
        IM_PLANNING       TYPE  ZI_GPI_PLAN_THEO
      RETURNING
        VALUE(RET_RESULT) TYPE REF TO ZCLS_GPI_PLANNING_THEORICAL  .

    METHODS: CONSTRUCTOR.
    METHODS  :   Schedule_Build.
    METHODS  :   GET_Courses   RETURNING
                                 VALUE(RET_RESULTS) TYPE TT_Courses ,
      Schedule_Add_Item
        IMPORTING
          IM_COURSE_UUID TYPE SYSUUID_X16
          IM_COUSE_DATE  TYPE D,


      ADD_LEARNER
        IMPORTING
          IM_S_Learner_UUID TYPE SYSUUID_X16,
      Schedule_Save.



  PROTECTED SECTION.
  PRIVATE SECTION.
    ""! This class handles customer data operations.
ENDCLASS.



CLASS ZCLS_GPI_PLANNING_THEORICAL IMPLEMENTATION.


  METHOD Add_Learner.
* -------------------------------------------------------------------------------------------------
    DATA LS_PLAN2LEARNER TYPE ZDB_PLAN_TH2ACS.
    LS_PLAN2LEARNER-UUID               = Ptr2_System_UUID->CREATE_UUID_X16( ).
    LS_PLAN2LEARNER-UUID_LEARNER       = IM_S_LEARNER_UUID.
    LS_PLAN2LEARNER-UUID_PLANNING_THEO = ME->ST_DATA-UUID.
    INSERT  ZDB_PLAN_TH2ACS FROM @LS_PLAN2LEARNER.
*   COMMIT WORK.


*    MODIFY ENTITIES OF ZI_GPI_PLAN_THEO IN LOCAL MODE
*    ENTITY ZI_GPI_PLAN_THEO
*      CREATE BY \_Learners
*      FIELDS ( UuidLearner   ) WITH
*      VALUE #(
*      ( %KEY-Uuid =  ME->ST_DATA-UUID
*        %TARGET   = VALUE #( ( UuidLearner = IM_S_LEARNER_UUID  ) )
*      )
*    )
*     MAPPED DATA(MAPPED)
*            FAILED DATA(FAILED)
*            REPORTED DATA(REPORTED).

* -------------------------------------------------------------------------------------------------
  ENDMETHOD.


  METHOD Schedule_Add_Item.
* -------------------------------------------------------------------------------------------------
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
      CREATE BY \_ScheduleItem
      FIELDS ( CourseDate CourseUuid   ) WITH
      VALUE #(
      ( %KEY-Uuid = ME->ST_DATA-UUID  " The %key-id specifies the existing root entity to which the children will be associated.
        %TARGET   = VALUE #( (
                         CourseDate = IM_COUSE_DATE
                         CourseUuid = IM_COURSE_UUID
                         ) )
      )
    )
     MAPPED DATA(MAPPED)
            FAILED DATA(FAILED)
            REPORTED DATA(REPORTED).
* -------------------------------------------------------------------------------------------------
  ENDMETHOD.






  METHOD CONSTRUCTOR.
* -------------------------------------------------------------------------------------------------
    ME->Ptr2_System_UUID = CL_UUID_FACTORY=>CREATE_SYSTEM_UUID( ).
* -------------------------------------------------------------------------------------------------
  ENDMETHOD.


  METHOD Schedule_Build.
* -------------------------------------------------------------------------------------------------
    DATA LO_ScheduleItem TYPE REF TO ZCLS_GPI_SCHEDULE_ITEM.
    DATA(LT_COURSES) = ME->GET_COURSES(  ).
    DATA LV_DATE TYPE D.
    LV_DATE = ME->ST_DATA-DATESTART.
    LOOP AT LT_COURSES INTO DATA(LS_COURSE).
      CREATE OBJECT LO_SCHEDULEITEM
        EXPORTING
          IM_COURSE_UUID = LS_COURSE-Uuid
          IM_DATE        = LV_DATE
          IM_o_planning  = me.

      APPEND LO_SCHEDULEITEM TO ME->TBL_SCHEDULE.
    ENDLOOP.
    ME->schedule_Save(  ).
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


  METHOD GET_INSTANCE.
* -------------------------------------------------------------------------------------------------
    CREATE OBJECT RET_RESULT.
    MOVE-CORRESPONDING IM_PLANNING TO RET_RESULT->ST_DATA.
    RETURN RET_RESULT.
* -------------------------------------------------------------------------------------------------
  ENDMETHOD.


  METHOD GET_INSTANCE_FROM_ID.
* -------------------------------------------------------------------------------------------------
    CREATE OBJECT RET_RESULT.
    RET_RESULT->ST_DATA-UUID = IM_PLANNING_UUID.
    RETURN RET_RESULT.
* -------------------------------------------------------------------------------------------------
  ENDMETHOD.

  METHOD Schedule_Save.
    LOOP AT ME->TBL_SCHEDULE INTO DATA(LO_ScheduleItem).

      MODIFY ENTITIES OF ZI_GPI_PLAN_THEO IN LOCAL MODE
      ENTITY ZI_GPI_PLAN_THEO
        CREATE BY \_ScheduleItem
        FIELDS ( CourseDate CourseUuid   ) WITH
        VALUE #(
        ( %KEY-Uuid = ME->ST_DATA-UUID  " The %key-id specifies the existing root entity to which the children will be associated.
          %TARGET   = VALUE #( (
                           CourseDate = LO_SCHEDULEITEM->ST_DATA-COURSE_DATE
                           CourseUuid = LO_SCHEDULEITEM->ST_DATA-COURSE_UUID
                           ) )
        )
      )
       MAPPED DATA(MAPPED)
              FAILED DATA(FAILED)
              REPORTED DATA(REPORTED).

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
