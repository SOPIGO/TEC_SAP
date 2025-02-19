* -------------------------------------------------------------------------------------------------
*  Planning - Theorical
* -------------------------------------------------------------------------------------------------
CLASS ZCLS_GPI_SCHEDULE_ITEM DEFINITION
  PUBLIC


  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES: TT_Courses TYPE TABLE OF ZI_GPI_COURSE WITH DEFAULT KEY.
* -------------------------------------------------------------------------------------------------
    DATA ST_DATA           TYPE ZDB_SCHDLE_ITEM.
    DATA Ptr2_system_uuid    TYPE REF TO IF_SYSTEM_UUID.
    DATA Ptr2_coursetype     TYPE REF TO ZCLS_GPI_COURSE_TYPE.
    DATA Ptr2_planning       TYPE REF TO ZCLS_GPI_PLANNING_THEORICAL.
*    data Tbl_o_Learners         TYPE ZCLS_GPI_LEARNER=>TT_O_LEARNERS.
    data Tbl_o_Learners         TYPE ZCLS_GPI_ACTOR=>TT_O_ACTORS.
* -------------------------------------------------------------------------------------------------


    CLASS-METHODS GET_INSTANCE_FROM_ID
      IMPORTING
        IM_UUID           TYPE SYSUUID_X16
      RETURNING
        VALUE(RET_RESULT) TYPE REF TO ZCLS_GPI_SCHEDULE_ITEM  .

    CLASS-METHODS GET_INSTANCE
      IMPORTING
        IM_S_Data         TYPE  ZDB_SCHDLE_ITEM
      RETURNING
        VALUE(RET_RESULT) TYPE REF TO ZCLS_GPI_SCHEDULE_ITEM  .

    METHODS  : CONSTRUCTOR   IMPORTING
                               IM_Date        TYPE D            OPTIONAL
                               IM_COURSE_UUID TYPE SYSUUID_X16  OPTIONAL
                               IM_o_planning  TYPE ref to ZCLS_GPI_PLANNING_THEORICAL  OPTIONAL.

    METHODS  :   Schedule_Add_Item
      IMPORTING
        IM_COURSE_UUID TYPE SYSUUID_X16
        IM_COUSE_DATE  TYPE D,

      learners_add,
      learners_db_save,
      Add_Learner
        IMPORTING
          IM_S_Learner_UUID TYPE SYSUUID_X16.



  PROTECTED SECTION.
  PRIVATE SECTION.

    ""! This class handles customer data operations.
ENDCLASS.



CLASS ZCLS_GPI_SCHEDULE_ITEM IMPLEMENTATION.


  METHOD Add_Learner.
    learners_add(  ).
* -------------------------------------------------------------------------------------------------
    DATA LS_PLAN2LEARNER TYPE ZDB_PLAN_TH2ACS.
    LS_PLAN2LEARNER-UUID               = Ptr2_system_uuid->CREATE_UUID_X16( ).
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
    Me->Ptr2_system_uuid    = CL_UUID_FACTORY=>CREATE_SYSTEM_UUID( ).
    me->PTR2_PLANNING       = IM_O_PLANNING.
    ME->ST_DATA-UUID        = ME->Ptr2_system_uuid->CREATE_UUID_X16( ) .
    ME->ST_DATA-COURSE_UUID = IM_COURSE_UUID.
    ME->ST_DATA-COURSE_DATE = IM_DATE.

    Me->PTR2_COURSETYPE     = ZCLS_GPI_COURSE_TYPE=>GET_INSTANCE_FROM_ID(  IM_COURSE_UUID ).
    Me->PTR2_COURSETYPE->DB_READ( ).
* -------------------------------------------------------------------------------------------------
  ENDMETHOD.








  METHOD GET_INSTANCE.
* -------------------------------------------------------------------------------------------------
*    CREATE OBJECT RET_RESULT.
*    MOVE-CORRESPONDING IM_S_DATA TO RET_RESULT->ST_DATA.
*    RETURN RET_RESULT.
* -------------------------------------------------------------------------------------------------
  ENDMETHOD.


  METHOD GET_INSTANCE_FROM_ID.
* -------------------------------------------------------------------------------------------------
*    CREATE OBJECT RET_RESULT.
*    RET_RESULT->ST_DATA-UUID = IM_UUID.
*    RETURN RET_RESULT.
* -------------------------------------------------------------------------------------------------
  ENDMETHOD.

  METHOD learners_add.
* -------------------------------------------------------------------------------------------------
        Data(lv_max_learners_allowed) = me->PTR2_COURSETYPE->ST_DATA-MAXTAINEE.
        Data lv_max_learners_4planning type I.
        data lv_continue type BOOLEAN .
        Data lv_cnt_learners type I.
        Data lv_idx_learners type I.

        lv_continue = 'X'.
        lv_cnt_learners = 0.
        lv_idx_learners = 1.
        lv_max_learners_4planning = lines( me->PTR2_PLANNING->TBL_O_LEARNERS ).

        WHILE ( LV_CONTINUE =  'X').

            data(lo_leaner) = PTR2_PLANNING->TBL_O_LEARNERS[ lv_idx_learners ].
            APPEND LO_LEANER to me->Tbl_o_Learners.


*           Stop conditions =>
            if lv_idx_learners >= lv_max_learners_4planning.
              LV_CONTINUE = ''.
            endif.
            if LV_CNT_LEARNERS >= LV_MAX_LEARNERS_ALLOWED.
            LV_CONTINUE = ''.
            endif.

            lv_idx_learners = lv_idx_learners + 1.
            LV_CNT_LEARNERS = LV_CNT_LEARNERS + 1.

        ENDWHILE.


* -------------------------------------------------------------------------------------------------
  ENDMETHOD.


  METHOD learners_db_save.
* -------------------------------------------------------------------------------------------------
    DELETE  FROM ZDB_SCHDITM2LRNR WHERE  UUID_SCHEDULE_ITEM = @me->ST_DATA-UUID.

    data ls_db_row type  ZDB_SCHDITM2LRNR.
    LOOP AT TBL_O_LEARNERS into data(lo_leaner).
        LS_DB_ROW-UUID =  ME->PTR2_SYSTEM_UUID->CREATE_UUID_X16( ).
        LS_DB_ROW-UUID_LEARNER = LO_LEANER->ST_DATA-UUID.
        LS_DB_ROW-UUID_SCHEDULE_ITEM = me->ST_DATA-UUID.
        INSERT  ZDB_SCHDITM2LRNR FROM @LS_DB_ROW.
    ENDLOOP.
* -------------------------------------------------------------------------------------------------
  ENDMETHOD.



ENDCLASS.
