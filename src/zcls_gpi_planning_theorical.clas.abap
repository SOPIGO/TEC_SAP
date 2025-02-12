* -------------------------------------------------------------------------------------------------
*  Planning - Theorical
* -------------------------------------------------------------------------------------------------
CLASS ZCLS_GPI_PLANNING_THEORICAL DEFINITION
  PUBLIC


  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    DATA:  ST_DATA TYPE ZDB_PLAN_THEO.

    CLASS-METHODS GET_INSTANCE
      IMPORTING
        IM_PLANNING_UUID  TYPE SYSUUID_X16
      RETURNING
        VALUE(RET_RESULT) TYPE REF TO ZCLS_GPI_PLANNING_THEORICAL  .

    METHODS  :   CreateCalendar.
    METHODS  :   GET_Courses   RETURNING
                                 VALUE(RET_RESULTs) TYPE ZI_GPI_COURSE .

  PROTECTED SECTION.
  PRIVATE SECTION.
    ""! This class handles customer data operations.
ENDCLASS.



CLASS ZCLS_GPI_PLANNING_THEORICAL IMPLEMENTATION.

  METHOD GET_INSTANCE.
* -------------------------------------------------------------------------------------------------
    CREATE OBJECT RET_RESULT.
    RET_RESULT->ST_DATA-UUID = IM_PLANNING_UUID.
    RETURN RET_RESULT.
* -------------------------------------------------------------------------------------------------
  ENDMETHOD.



  METHOD GET_Courses.
* -------------------------------------------------------------------------------------------------
    "  DATA: lt_result TYPE TABLE OF ZI_GPI_PLAN_THEO2COURSE.

    READ ENTITIES OF ZI_GPI_PLAN_THEO
    ENTITY ZI_GPI_PLAN_THEO BY \_Courses
    ALL FIELDS WITH VALUE #( ( Uuid = ME->ST_DATA-UUID ) )
    RESULT DATA(LT_CHILD_RESULT).
* -------------------------------------------------------------------------------------------------
  ENDMETHOD.





  METHOD CreateCalendar.
* -------------------------------------------------------------------------------------------------
    " me->ST_DATA-DATESTART
    DATA(LT_COURSES) = ME->GET_COURSES(  ).
* -------------------------------------------------------------------------------------------------
  ENDMETHOD.


ENDCLASS.
* -------------------------------------------------------------------------------------------------
