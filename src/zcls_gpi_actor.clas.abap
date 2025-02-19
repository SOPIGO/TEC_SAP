CLASS ZCLS_GPI_ACTOR DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES: TT_Actors TYPE TABLE OF ZI_GPI_ACTOR WITH DEFAULT KEY.
    TYPES: TT_o_Actors TYPE TABLE OF REF TO Zcls_GPI_ACTOR WITH DEFAULT KEY.
* -------------------------------------------------------------------------------------------------
    DATA ST_DATA           TYPE ZDB_ACTOR.
    DATA Ptr2_system_uuid    TYPE REF TO IF_SYSTEM_UUID.
* -------------------------------------------------------------------------------------------------

    CLASS-METHODS GET_INSTANCE_FROM_ID
      IMPORTING
        IM_UUID           TYPE SYSUUID_X16
      RETURNING
        VALUE(RET_RESULT) TYPE REF TO  ZCLS_GPI_ACTOR   .


    METHODS  : DB_Read .

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCLS_GPI_ACTOR IMPLEMENTATION.

  METHOD DB_READ.
* -------------------------------------------------------------------------------------------------
    SELECT SINGLE *
    FROM   ZDB_ACTOR
    WHERE  UUID = @ME->ST_DATA-UUID
    INTO   @ME->ST_DATA.
* -------------------------------------------------------------------------------------------------
  ENDMETHOD.




  METHOD GET_INSTANCE_FROM_ID.
* -------------------------------------------------------------------------------------------------
    CREATE OBJECT RET_RESULT.
    RET_RESULT->ST_DATA-UUID = IM_UUID.
    RETURN RET_RESULT.
* -------------------------------------------------------------------------------------------------
  ENDMETHOD.

ENDCLASS.
