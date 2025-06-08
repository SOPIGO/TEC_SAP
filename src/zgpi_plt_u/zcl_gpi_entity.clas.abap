class ZCL_GPI_ENTITY definition
  public
  create public .

public section.

  types:
    BEGIN OF ST_PARAM_N_V ,
    NAME TYPE STRING,
    VALUE TYPE STRING,
      END OF ST_PARAM_N_V .
  types:
    TT_PARAM_N_V TYPE TABLE OF  ST_PARAM_N_V  WITH DEFAULT KEY .
  types:
    BEGIN OF ST_ATTRIBUTE .
    TYPES:
     DUMMY           TYPE STRING.
    INCLUDE TYPE       zdb_gpi_er_att.
 TYPES:  END OF  ST_ATTRIBUTE .
  types:
    TT_ATTRIBUTES TYPE TABLE OF  ST_ATTRIBUTE  WITH DEFAULT KEY .

  types:
    BEGIN OF ENUM T_KIND BASE TYPE CHAR3,
         UNKOWN VALUE IS INITIAL,
         CDS VALUE 'CDS' ,
         ODATA VALUE 'ODT',
         CLASS VALUE 'CLS',
       END OF ENUM T_KIND .
  types:
    BEGIN OF ST_RELATION .
    TYPES:
    NAME           TYPE STRING,
    CARDINALITY_TX TYPE STRING,
    CARDINALITY_ID TYPE I,
    PTR_ENTITY_SRC TYPE REF TO ZCL_GPI_ENTITY,
    PTR_ENTITY_DST TYPE REF TO ZCL_GPI_ENTITY.
    INCLUDE TYPE       ZDB_GPI_ER_RELAT.
   TYPES: END OF  ST_RELATION .
  types:
    TT_RELATIONS TYPE TABLE OF ST_RELATION WITH DEFAULT KEY .
  data DATA_CORE type ZDB_GPI_ER_ENT_a .

  data lo_adt_out type ref to if_oo_adt_classrun_out.

  class-methods DB_RESET_ALL .
  class-methods DB_SCENARIO_GET_NEW
    returning
      value(RET_RESULT) type STRING .
  class-methods GET_VH_FOR_SCENARIO
    returning
      value(RET_RESULTS) type TT_PARAM_N_V .


  methods DB_READ .
  methods DB_READ_ATTRIBUTES .
  methods DB_READ_ENTITY .
  methods DB_READ_RELATIONS .
  methods DB_SCENARIO_DELETE
    importing
      !IM_SCENARIO_CODE type STRING optional .
  methods DB_SCENARIO_MAX_VISI_ENTITY
    importing
      !IM_MAX_VISIBLE_ENTITY type I .
  methods INIT_ATTRIBUTES .
  methods INIT_RELATIONS .
  methods SERIALIZE_TO_DB_CORE
    importing
      !IM_SCENARIO_CODE type CHAR40 optional
      !IM_ENTITY_INDEX type NUMC2 optional .
  methods SERIALIZE_TO_DB
    importing
      !IM_SCENARIO_CODE type CHAR40 optional
      !IM_ENTITY_INDEX type NUMC2 optional .

  methods SERIALIZE_TO_DB_ATTRIBUTES .
protected section.
private section.
ENDCLASS.



CLASS ZCL_GPI_ENTITY IMPLEMENTATION.


method DB_READ.
*--------------------------------------------------------------------------------------------------
* Author : Pierre Godart
*--------------------------------------------------------------------------------------------------
* DATA LS_DB_ENTITY     TYPE ZDB_GPI_ER_ENTTY.
* DATA LT_DB_ENTITY     TYPE TABLE OF ZDB_GPI_ER_ENTTY WITH DEFAULT KEY.
* DATA LT_DB_ATTRIBUTES TYPE TABLE OF ZDB_GPI_ER_ATT WITH DEFAULT KEY.
* DATA LS_ATTRIBUTE     TYPE ST_ATTRIBUTE.
*
* SELECT  *
* INTO   TABLE LT_DB_ENTITY
* FROM   ZDB_GPI_ER_ENTTY
* WHERE  SCENARIO_CODE = ME->DATA_CORE-SCENARIO_CODE.
* IF     SY-SUBRC = 0.
*        SORT LT_DB_ENTITY BY ENTITY_INDEX ASCENDING.
*        READ TABLE LT_DB_ENTITY INDEX 1 INTO ME->DATA_CORE.
*
**     -------------------------------------------------------------------------
**       Attributes
**     -------------------------------------------------------------------------
*      SELECT  *
*      INTO   TABLE LT_DB_ATTRIBUTES
*      FROM   ZDB_GPI_ER_ATT
*      WHERE  UUID_SCN_ENTTY = ME->DATA_CORE-UUID.
*      DELETE ME->TBL_ATTRIBUTES WHERE FIELD_VISIBLE <> 'X'.
*      LOOP AT LT_DB_ATTRIBUTES INTO DATA(LS_DB_ATTRIBUTE).
*           MOVE-CORRESPONDING LS_DB_ATTRIBUTE TO LS_ATTRIBUTE.
*           APPEND LS_ATTRIBUTE TO ME->TBL_ATTRIBUTES.
*      ENDLOOP.
* ENDIF.


*
*     LS_DB_ENTITY-UUID          = /BOBF/CL_FRW_FACTORY=>GET_NEW_KEY( ).
*     LS_DB_ENTITY-SCENARIO_CODE = IM_SCENARIO_CODE.
*     IF LS_DB_ENTITY-SCENARIO_CODE IS INITIAL.
*        LS_DB_ENTITY-SCENARIO_CODE = LV_SCN_CODE.
*     ENDIF.
*     LS_DB_ENTITY-ENTITY_NAME    = ME->DATA_CORE-ENTITY_NAME.
*     LS_DB_ENTITY-ENTITY_VISIBLE = 'X'.
*     LS_DB_ENTITY-ENTITY_INDEX   = LV_INDEX.
*     " Admin. data =>
*     GET TIME STAMP FIELD LS_DB_ENTITY-LCHG_DATE_TIME.
*     LS_DB_ENTITY-LCHG_UNAME     = SY-UNAME.
*
*     INSERT ZDB_GPI_ER_ENTTY FROM LS_DB_ENTITY.
*     ME->DATA_CORE-ENTITY_UUID =  LS_DB_ENTITY-UUID.
*
**     -------------------------------------------------------------------------------------------------
**     Attributes
**     -------------------------------------------------------------------------------------------------
*      SORT ME->TBL_ATTRIBUTES BY FIELD_IS_KEY DESCENDING.
*      LV_INDEX_FLD = 0.
*      LOOP AT ME->TBL_ATTRIBUTES INTO DATA(LS_ATTRIBUTE).
*           CLEAR LS_DB_FIELD.
*           LS_DB_FIELD-UUID           = /BOBF/CL_FRW_FACTORY=>GET_NEW_KEY( ).
*           LS_DB_FIELD-UUID_SCN_ENTTY = LS_DB_ENTITY-UUID  .
*           LS_DB_FIELD-FIELD_INDEX    = LV_INDEX_FLD .
*           LS_DB_FIELD-FIELD_ID       = LS_ATTRIBUTE-FIELD_ID.
*           LS_DB_FIELD-FIELD_VISIBLE  = 'X'.
*           LS_DB_FIELD-FIELD_IS_KEY   = LS_ATTRIBUTE-FIELD_IS_KEY.
*
*           LS_DB_FIELD-CREA_UNAME     = SY-UNAME.
*           LS_DB_FIELD-LCHG_UNAME     = SY-UNAME.
*           GET TIME STAMP FIELD LS_DB_FIELD-CREA_DATE_TIME.
*           GET TIME STAMP FIELD LS_DB_FIELD-LCHG_DATE_TIME.
*           INSERT ZDB_GPI_ER_ATT FROM LS_DB_FIELD.
*           LV_INDEX_FLD = LV_INDEX_FLD + 1.
*      ENDLOOP.
**     -------------------------------------------------------------------------------------------------


*      LOOP AT ME->TBL_RELATIONS INTO DATA(LS_RELATION).
*           IF LS_RELATION-PTR_ENTITY_DST IS NOT INITIAL.
*              LV_INDEX = LV_INDEX + 1.
**     -------------------------------------------------------------------------------------------------
**     Related Entities
**     -------------------------------------------------------------------------------------------------
*
*              LS_RELATION-PTR_ENTITY_DST->SERIALIZE_TO_DB( IM_SCENARIO_CODE = CONV #( LV_SCN_CODE )
*                                                           IM_ENTITY_INDEX  = LV_INDEX ).
*
**     -------------------------------------------------------------------------------------------------
**     Relation
**     -------------------------------------------------------------------------------------------------
*              IF  LS_RELATION-PTR_ENTITY_SRC IS NOT INITIAL
*              AND LS_RELATION-PTR_ENTITY_DST IS NOT INITIAL.
*                  LS_DB_RELATION-UUID                 = /BOBF/CL_FRW_FACTORY=>GET_NEW_KEY( ).
*                  LS_DB_RELATION-UUID_SCN_ENTTY_SRC   = LS_RELATION-PTR_ENTITY_SRC->DATA_CORE-ENTITY_UUID.
*                  LS_DB_RELATION-UUID_SCN_ENTTY_DST   = LS_RELATION-PTR_ENTITY_DST->DATA_CORE-ENTITY_UUID.
*                  LS_DB_RELATION-RELATION_CARDINALITY = ZCL_GPI_ENTITY_CDS=>GET_CARDINALITY_TEXT( LS_RELATION-CARDINALITY_ID ).
*                  LS_DB_RELATION-CREA_UNAME           = SY-UNAME.
*                  LS_DB_RELATION-LCHG_UNAME           = SY-UNAME.
*                  GET TIME STAMP FIELD  LS_DB_RELATION-CREA_DATE_TIME.
*                  GET TIME STAMP FIELD  LS_DB_RELATION-LCHG_DATE_TIME.
*                  IF  LS_DB_RELATION-UUID_SCN_ENTTY_SRC IS NOT INITIAL
*                  AND LS_DB_RELATION-UUID_SCN_ENTTY_DST IS NOT INITIAL.
*                      INSERT ZDB_GPI_ER_RELAT FROM  LS_DB_RELATION.
*                  ENDIF.
*              ENDIF.
*           ENDIF.
*      ENDLOOP.
**     -------------------------------------------------------------------------------------------------

* ENDIF.
endmethod.


method DB_READ_ATTRIBUTES.
*--------------------------------------------------------------------------------------------------
* Author : Pierre Godart
*--------------------------------------------------------------------------------------------------
*  DATA LS_ATTRIBUTE     TYPE ST_ATTRIBUTE.
*  DATA LT_DB_ATTRIBUTES TYPE TABLE OF ZDB_GPI_ER_att WITH DEFAULT KEY.
*  SELECT  *
*  INTO   TABLE @LT_DB_ATTRIBUTES
*  FROM   ZDB_GPI_ER_ATT
*  WHERE  UUID_SCN_ENTTY = ME->DATA_CORE-UUID.
*  DELETE ME->TBL_ATTRIBUTES WHERE FIELD_VISIBLE <> 'X'.
*  LOOP AT LT_DB_ATTRIBUTES INTO DATA(LS_DB_ATTRIBUTE).
*       MOVE-CORRESPONDING LS_DB_ATTRIBUTE TO LS_ATTRIBUTE.
*       APPEND LS_ATTRIBUTE TO ME->TBL_ATTRIBUTES.
*  ENDLOOP.
endmethod.


method DB_READ_ENTITY.
*--------------------------------------------------------------------------------------------------
* Author : Pierre Godart
*--------------------------------------------------------------------------------------------------
* SELECT SINGLE *
* INTO   @ME->DATA_CORE
* FROM   ZDB_GPI_ER_ENTTY
* WHERE  SCENARIO_CODE = ME->DATA_CORE-SCENARIO_CODE
* AND    ENTITY_NAME   = ME->DATA_CORE-ENTITY_NAME.
* IF     SY-SUBRC = 0.
* ENDIF.
endmethod.


method DB_READ_RELATIONS.
*--------------------------------------------------------------------------------------------------
* Author : Pierre Godart
*--------------------------------------------------------------------------------------------------
* DATA LT_DB_RELATIONS  TYPE TABLE OF ZDB_GPI_ER_RELAT WITH DEFAULT KEY.
* DATA LS_RELATION      TYPE ST_RELATION.
*
* SELECT  *
* INTO   TABLE @LT_DB_RELATIONS
* FROM   ZDB_GPI_ER_RELAT
* WHERE  UUID_SCN_ENTTY_SRC = ME->DATA_CORE-UUID.
* DELETE  LT_DB_RELATIONS WHERE RELATION_VISIBLE <> 'X'.
* LOOP AT LT_DB_RELATIONS INTO DATA(LS_DB_RELATION).
*      MOVE-CORRESPONDING LS_DB_RELATION TO LS_RELATION.
*      APPEND LS_RELATION TO ME->TBL_RELATIONS.
* ENDLOOP.

*
* DATA LS_DB_ENTITY     TYPE ZDB_GPI_ER_ENTTY.
* DATA LT_DB_ENTITY     TYPE TABLE OF ZDB_GPI_ER_ENTTY WITH DEFAULT KEY.
*
* DATA LS_ATTRIBUTE     TYPE ST_ATTRIBUTE.
*
* SELECT  *
* INTO   TABLE LT_DB_ENTITY
* FROM   ZDB_GPI_ER_ENTTY
* WHERE  SCENARIO_CODE = ME->DATA_CORE-SCENARIO_CODE.
* IF     SY-SUBRC = 0.
*        SORT LT_DB_ENTITY BY ENTITY_INDEX ASCENDING.
*        READ TABLE LT_DB_ENTITY INDEX 1 INTO ME->DATA_CORE.
*
**     -------------------------------------------------------------------------
**       Attributes
**     -------------------------------------------------------------------------
*      DELETE ME->TBL_ATTRIBUTES WHERE FIELD_VISIBLE <> 'X'.
*      LOOP AT LT_DB_ATTRIBUTES INTO DATA(LS_DB_ATTRIBUTE).
*           MOVE-CORRESPONDING LS_DB_ATTRIBUTE TO LS_ATTRIBUTE.
*           APPEND LS_ATTRIBUTE TO ME->TBL_ATTRIBUTES.
*      ENDLOOP.
* ENDIF.


*
*     LS_DB_ENTITY-UUID          = /BOBF/CL_FRW_FACTORY=>GET_NEW_KEY( ).
*     LS_DB_ENTITY-SCENARIO_CODE = IM_SCENARIO_CODE.
*     IF LS_DB_ENTITY-SCENARIO_CODE IS INITIAL.
*        LS_DB_ENTITY-SCENARIO_CODE = LV_SCN_CODE.
*     ENDIF.
*     LS_DB_ENTITY-ENTITY_NAME    = ME->DATA_CORE-ENTITY_NAME.
*     LS_DB_ENTITY-ENTITY_VISIBLE = 'X'.
*     LS_DB_ENTITY-ENTITY_INDEX   = LV_INDEX.
*     " Admin. data =>
*     GET TIME STAMP FIELD LS_DB_ENTITY-LCHG_DATE_TIME.
*     LS_DB_ENTITY-LCHG_UNAME     = SY-UNAME.
*
*     INSERT ZDB_GPI_ER_ENTTY FROM LS_DB_ENTITY.
*     ME->DATA_CORE-ENTITY_UUID =  LS_DB_ENTITY-UUID.
*
**     -------------------------------------------------------------------------------------------------
**     Attributes
**     -------------------------------------------------------------------------------------------------
*      SORT ME->TBL_ATTRIBUTES BY FIELD_IS_KEY DESCENDING.
*      LV_INDEX_FLD = 0.
*      LOOP AT ME->TBL_ATTRIBUTES INTO DATA(LS_ATTRIBUTE).
*           CLEAR LS_DB_FIELD.
*           LS_DB_FIELD-UUID           = /BOBF/CL_FRW_FACTORY=>GET_NEW_KEY( ).
*           LS_DB_FIELD-UUID_SCN_ENTTY = LS_DB_ENTITY-UUID  .
*           LS_DB_FIELD-FIELD_INDEX    = LV_INDEX_FLD .
*           LS_DB_FIELD-FIELD_ID       = LS_ATTRIBUTE-FIELD_ID.
*           LS_DB_FIELD-FIELD_VISIBLE  = 'X'.
*           LS_DB_FIELD-FIELD_IS_KEY   = LS_ATTRIBUTE-FIELD_IS_KEY.
*
*           LS_DB_FIELD-CREA_UNAME     = SY-UNAME.
*           LS_DB_FIELD-LCHG_UNAME     = SY-UNAME.
*           GET TIME STAMP FIELD LS_DB_FIELD-CREA_DATE_TIME.
*           GET TIME STAMP FIELD LS_DB_FIELD-LCHG_DATE_TIME.
*           INSERT ZDB_GPI_ER_ATT FROM LS_DB_FIELD.
*           LV_INDEX_FLD = LV_INDEX_FLD + 1.
*      ENDLOOP.
**     -------------------------------------------------------------------------------------------------


*      LOOP AT ME->TBL_RELATIONS INTO DATA(LS_RELATION).
*           IF LS_RELATION-PTR_ENTITY_DST IS NOT INITIAL.
*              LV_INDEX = LV_INDEX + 1.
**     -------------------------------------------------------------------------------------------------
**     Related Entities
**     -------------------------------------------------------------------------------------------------
*
*              LS_RELATION-PTR_ENTITY_DST->SERIALIZE_TO_DB( IM_SCENARIO_CODE = CONV #( LV_SCN_CODE )
*                                                           IM_ENTITY_INDEX  = LV_INDEX ).
*
**     -------------------------------------------------------------------------------------------------
**     Relation
**     -------------------------------------------------------------------------------------------------
*              IF  LS_RELATION-PTR_ENTITY_SRC IS NOT INITIAL
*              AND LS_RELATION-PTR_ENTITY_DST IS NOT INITIAL.
*                  LS_DB_RELATION-UUID                 = /BOBF/CL_FRW_FACTORY=>GET_NEW_KEY( ).
*                  LS_DB_RELATION-UUID_SCN_ENTTY_SRC   = LS_RELATION-PTR_ENTITY_SRC->DATA_CORE-ENTITY_UUID.
*                  LS_DB_RELATION-UUID_SCN_ENTTY_DST   = LS_RELATION-PTR_ENTITY_DST->DATA_CORE-ENTITY_UUID.
*                  LS_DB_RELATION-RELATION_CARDINALITY = ZCL_GPI_ENTITY_CDS=>GET_CARDINALITY_TEXT( LS_RELATION-CARDINALITY_ID ).
*                  LS_DB_RELATION-CREA_UNAME           = SY-UNAME.
*                  LS_DB_RELATION-LCHG_UNAME           = SY-UNAME.
*                  GET TIME STAMP FIELD  LS_DB_RELATION-CREA_DATE_TIME.
*                  GET TIME STAMP FIELD  LS_DB_RELATION-LCHG_DATE_TIME.
*                  IF  LS_DB_RELATION-UUID_SCN_ENTTY_SRC IS NOT INITIAL
*                  AND LS_DB_RELATION-UUID_SCN_ENTTY_DST IS NOT INITIAL.
*                      INSERT ZDB_GPI_ER_RELAT FROM  LS_DB_RELATION.
*                  ENDIF.
*              ENDIF.
*           ENDIF.
*      ENDLOOP.
**     -------------------------------------------------------------------------------------------------

* ENDIF.
endmethod.


METHOD DB_RESET_ALL.
*--------------------------------------------------------------------------------------------------
* Author : Pierre Godart
*--------------------------------------------------------------------------------------------------
 DELETE FROM ZDB_GPI_ER_ATT.
 DELETE FROM ZDB_GPI_ER_ENT_A.
 DELETE FROM ZDB_GPI_ER_RELAT.
ENDMETHOD.


METHOD DB_SCENARIO_DELETE.
*----------------------------------------------------------------------------------
* Author : Pierre Godart
*----------------------------------------------------------------------------------
*  DATA LS_DB_ENTITY TYPE ZDB_GPI_ER_ENTTY.
*  DATA LS_DB_FIELD  TYPE ZDB_GPI_ER_ATT.
*  DATA LT_DB_FIELD  TYPE TABLE OF ZDB_GPI_ER_ATT.
*  DATA LV_SCENARIO  TYPE STRING.
*
*  LV_SCENARIO = IM_SCENARIO_CODE.
*  IF IM_SCENARIO_CODE IS INITIAL.
*     LV_SCENARIO = ME->SCENARIO.
*  ENDIF.
*
*  SELECT  *
*  INTO    LS_DB_ENTITY
*  FROM    ZDB_GPI_ER_ENTTY
*  WHERE   SCENARIO_CODE = IM_SCENARIO_CODE.
*          SELECT  *
*          INTO    TABLE LT_DB_FIELD
*          FROM    ZDB_GPI_ER_ATT
*          WHERE   UUID_SCN_ENTTY = LS_DB_ENTITY-UUID.
*
*          DELETE ZDB_GPI_ER_ATT   FROM TABLE LT_DB_FIELD.
*          DELETE ZDB_GPI_ER_ENTTY FROM LS_DB_ENTITY.
*  ENDSELECT.

ENDMETHOD.


  method DB_SCENARIO_GET_NEW.
  endmethod.


method DB_SCENARIO_MAX_VISI_ENTITY.
*----------------------------------------------------------------------------------
* Author : Pierre Godart
*----------------------------------------------------------------------------------
* DATA LS_DB_ENTITY TYPE ZDB_GPI_ER_ENTTY.
* DATA LT_DB_ENTITY TYPE TABLE OF ZDB_GPI_ER_ENTTY.
* DATA LS_DB_FIELD  TYPE ZDB_GPI_ER_ATT.
* DATA LV_INDEX     TYPE NUMC2.
* DATA LV_INDEX_MAX TYPE NUMC2.
* DATA LV_SCN_CODE  TYPE STRING.
*
* LV_INDEX_MAX = IM_MAX_VISIBLE_ENTITY - 1.
* IF LV_INDEX_MAX > 0.
*
**    LV_INDEX = IM_ENTITY_INDEX.
*  IF LV_INDEX IS INITIAL.
*     LV_INDEX = '00'.
*  ENDIF.
*
**    LV_SCN_CODE = IM_SCENARIO_CODE.
*  IF LV_SCN_CODE IS INITIAL.
*     LV_SCN_CODE = ME->SCENARIO.
*  ENDIF.
*
* SELECT *
* INTO   TABLE  LT_DB_ENTITY
* FROM   ZDB_GPI_ER_ENTTY
* WHERE  SCENARIO_CODE = LV_SCN_CODE.
*
* LOOP AT LT_DB_ENTITY INTO LS_DB_ENTITY.
*      IF LV_INDEX > LV_INDEX_MAX.
*         LS_DB_ENTITY-ENTITY_VISIBLE = ''.
*         UPDATE ZDB_GPI_ER_ENTTY FROM LS_DB_ENTITY.
*         COMMIT WORK.
*      ENDIF.
*      LV_INDEX = LV_INDEX + 1.
* ENDLOOP.
* ENDIF.


endmethod.


  METHOD GET_VH_FOR_SCENARIO.
*  DATA LS_ROW TYPE ST_PARAM_N_V.
*DATA LV_ER_SCENARIO TYPE  ZDB_GPI_ER_ENTTY-SCENARIO_CODE.
*
*
*  SELECT SCENARIO_CODE
*  INTO LV_ER_SCENARIO
*  FROM ZDB_GPI_ER_ENTTY
*  GROUP BY SCENARIO_CODE .
*
*    LS_ROW-NAME =  LV_ER_SCENARIO.
*    LS_ROW-VALUE =  LV_ER_SCENARIO.
*     APPEND LS_ROW TO RET_RESULTS.
*
*  ENDSELECT.

  ENDMETHOD.


method INIT_ATTRIBUTES.
*    ----------------------------------------------------------------------------------
*     Author : Pierre Godart
*    ----------------------------------------------------------------------------------
    Data lo_rtt_structure type REF TO  CL_ABAP_STRUCTDESCR.

    lo_rtt_structure = cast  CL_ABAP_STRUCTDESCR( cl_abap_typedescr=>describe_by_name( 'ZI_GPI_ACTOR' ) ).
    LOOP AT lo_rtt_structure->components into data(ls_component).
    lo_adt_out->write(  ls_component-name ).
    ENDLOOP.
endmethod.


  method INIT_RELATIONS.
  endmethod.


METHOD SERIALIZE_TO_DB.
**----------------------------------------------------------------------------------
** Author : Pierre Godart
**----------------------------------------------------------------------------------
* DATA LS_DB_ENTITY   TYPE ZDB_GPI_ER_ENTTY.
* DATA LS_DB_FIELD    TYPE ZDB_GPI_ER_ATT.
* DATA LS_DB_RELATION TYPE ZDB_GPI_ER_RELAT.
*
* DATA LV_INDEX     TYPE NUMC2.
* DATA LV_INDEX_FLD TYPE NUMC2.
* DATA LV_SCN_CODE  TYPE STRING.
*
*     LV_INDEX = IM_ENTITY_INDEX.
*  IF LV_INDEX IS INITIAL.
*     LV_INDEX = '00'.
*  ENDIF.
*
*     LV_SCN_CODE = IM_SCENARIO_CODE.
*  IF LV_SCN_CODE IS INITIAL.
*     LV_SCN_CODE = ME->DATA_CORE-SCENARIO_CODE.
*  ENDIF.
*
*
*
* SELECT SINGLE *
* INTO   @LS_DB_ENTITY
* FROM   ZDB_GPI_ER_ENTTY
* WHERE  SCENARIO_CODE = LV_SCN_CODE
* AND    ENTITY_NAME   = ME->DATA_CORE-ENTITY_NAME.
* IF  SY-SUBRC <> 0. " Doesnt exist => continue
*     LS_DB_ENTITY-UUID          = /BOBF/CL_FRW_FACTORY=>GET_NEW_KEY( ).
*     LS_DB_ENTITY-SCENARIO_CODE = IM_SCENARIO_CODE.
*     IF LS_DB_ENTITY-SCENARIO_CODE IS INITIAL.
*        LS_DB_ENTITY-SCENARIO_CODE = LV_SCN_CODE.
*     ENDIF.
*
*     LS_DB_ENTITY-SCENARIO_CODE  = LV_SCN_CODE .
*     LS_DB_ENTITY-ENTITY_NAME    = ME->DATA_CORE-ENTITY_NAME.
*     LS_DB_ENTITY-ENTITY_VISIBLE = 'X'.
*     LS_DB_ENTITY-ENTITY_INDEX   = LV_INDEX.
*     " Admin. data =>
*     GET TIME STAMP FIELD LS_DB_ENTITY-LCHG_DATE_TIME.
*     LS_DB_ENTITY-LCHG_UNAME     = SY-UNAME.
*
*     INSERT ZDB_GPI_ER_ENTTY FROM LS_DB_ENTITY.
*     ME->DATA_CORE-UUID =  LS_DB_ENTITY-UUID.
*
**     -------------------------------------------------------------------------------------------------
**     Attributes
**     -------------------------------------------------------------------------------------------------
*      ME->SERIALIZE_TO_DB_ATTRIBUTES( ).
**     -------------------------------------------------------------------------------------------------
*
*
*      LOOP AT ME->TBL_RELATIONS INTO DATA(LS_RELATION).
*           IF LS_RELATION-PTR_ENTITY_DST IS NOT INITIAL.
*              LV_INDEX = LV_INDEX + 1.
**     -------------------------------------------------------------------------------------------------
**     Related Entities
**     -------------------------------------------------------------------------------------------------
*
*              LS_RELATION-PTR_ENTITY_DST->SERIALIZE_TO_DB( IM_SCENARIO_CODE = CONV #( LV_SCN_CODE  )
*                                                           IM_ENTITY_INDEX  = LV_INDEX ).
*
**     -------------------------------------------------------------------------------------------------
**     Relation
**     -------------------------------------------------------------------------------------------------
*              IF  LS_RELATION-PTR_ENTITY_SRC IS NOT INITIAL
*              AND LS_RELATION-PTR_ENTITY_DST IS NOT INITIAL.
*                  CLEAR LS_DB_RELATION.
*                  MOVE-CORRESPONDING LS_RELATION TO LS_DB_RELATION.
*
*                  LS_DB_RELATION-UUID                 = /BOBF/CL_FRW_FACTORY=>GET_NEW_KEY( ).
*                  LS_DB_RELATION-UUID_SCN_ENTTY_SRC   = LS_RELATION-PTR_ENTITY_SRC->DATA_CORE-UUID.
**                 LS_DB_RELATION-UUID_SCN_ENTTY_SRC   = LS_RELATION-PTR_ENTITY_SRC->DATA_CORE-ENTITY_UUID.
**                 LS_DB_RELATION-UUID_SCN_ENTTY_DST   = LS_RELATION-PTR_ENTITY_DST->DATA_CORE-ENTITY_UUID.
*                  LS_DB_RELATION-UUID_SCN_ENTTY_DST   = LS_RELATION-PTR_ENTITY_DST->DATA_CORE-UUID.
*                  LS_DB_RELATION-RELATION_CARDINALITY = ZCL_GPI_ENTITY_CDS=>GET_CARDINALITY_TEXT( LS_RELATION-CARDINALITY_ID ).
*                  LS_DB_RELATION-CREA_UNAME           = SY-UNAME.
*                  LS_DB_RELATION-LCHG_UNAME           = SY-UNAME.
*                  LS_DB_RELATION-RELATION_NAME        = LS_RELATION-NAME.
*                  GET TIME STAMP FIELD  LS_DB_RELATION-CREA_DATE_TIME.
*                  GET TIME STAMP FIELD  LS_DB_RELATION-LCHG_DATE_TIME.
*                  IF  LS_DB_RELATION-UUID_SCN_ENTTY_SRC IS NOT INITIAL
*                  AND LS_DB_RELATION-UUID_SCN_ENTTY_DST IS NOT INITIAL.
*                      INSERT ZDB_GPI_ER_RELAT FROM  LS_DB_RELATION.
*                  ENDIF.
*              ENDIF.
*           ENDIF.
*      ENDLOOP.
**     -------------------------------------------------------------------------------------------------

* ENDIF.




ENDMETHOD.


method SERIALIZE_TO_DB_ATTRIBUTES.
**--------------------------------------------------------------------------------------------------
** Author : Pierre Godart
**--------------------------------------------------------------------------------------------------
*  DATA LV_INDEX     TYPE NUMC2.
*  DATA LV_INDEX_FLD TYPE NUMC2.
*  DATA LS_DB_FIELD  TYPE ZDB_GPI_ER_ATT.
*
*  SORT ME->TBL_ATTRIBUTES BY FIELD_IS_KEY DESCENDING.
*  LV_INDEX_FLD = 0.
*  LOOP AT ME->TBL_ATTRIBUTES INTO DATA(LS_ATTRIBUTE).
*       CLEAR LS_DB_FIELD.
*       MOVE-CORRESPONDING LS_ATTRIBUTE TO LS_DB_FIELD.
*       LS_DB_FIELD-UUID           = /BOBF/CL_FRW_FACTORY=>GET_NEW_KEY( ).
**       LS_DB_FIELD-UUID_SCN_ENTTY = ME->DATA_CORE-UUID.
*       LS_DB_FIELD-FIELD_INDEX    = LV_INDEX_FLD .
*       LS_DB_FIELD-FIELD_VISIBLE  = 'X'.
**       LS_DB_FIELD-CREA_UNAME     = SY-UNAME.
**       LS_DB_FIELD-LCHG_UNAME     = SY-UNAME.
**       GET TIME STAMP FIELD LS_DB_FIELD-CREA_DATE_TIME.
**       GET TIME STAMP FIELD LS_DB_FIELD-LCHG_DATE_TIME.
*       INSERT ZDB_GPI_ER_ATT FROM @LS_DB_FIELD.
*       LV_INDEX_FLD = LV_INDEX_FLD + 1.
*  ENDLOOP.
endmethod.


METHOD SERIALIZE_TO_DB_CORE.
**----------------------------------------------------------------------------------
** Author : Pierre Godart
**----------------------------------------------------------------------------------
*  DATA LS_DB_ENTITY   TYPE ZDB_GPI_ER_ENTTY.
*
*  CLEAR LS_DB_ENTITY.
*  MOVE-CORRESPONDING ME->DATA_CORE TO LS_DB_ENTITY.
*
*  LS_DB_ENTITY-UUID          = /BOBF/CL_FRW_FACTORY=>GET_NEW_KEY( ).
*  LS_DB_ENTITY-ENTITY_VISIBLE = 'X'.
*  LS_DB_ENTITY-ENTITY_INDEX   = 1.
*  LS_DB_ENTITY-last_changed_by    = SY-UNAME.
*  GET TIME STAMP FIELD LS_DB_ENTITY-last_changed_at.
*
*  INSERT ZDB_GPI_ER_ENTTY FROM @LS_DB_ENTITY.

ENDMETHOD.
ENDCLASS.
