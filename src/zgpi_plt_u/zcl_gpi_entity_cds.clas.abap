class ZCL_GPI_ENTITY_CDS definition
  public
  inheriting from ZCL_GPI_ENTITY
  create public .

public section.

  types:
    BEGIN      OF   ST_ATTRIBUTE_CDS ,
*           SADL_DATA  TYPE IF_SADL_ENTITY=>TY_ELEMENT.
           INCLUDE    TYPE ST_ATTRIBUTE.
    TYPES: END        OF   ST_ATTRIBUTE_CDS .
  types:
    TT_attributes_cds  TYPE TABLE OF ST_ATTRIBUTE_CDS  WITH DEFAULT KEY .
  types:
    BEGIN OF ST_RELATION_CDS ,
    ALREADY_PROCESSED TYPE BOOLEAN,
    INCLUDE TYPE ST_RELATION.
   TYPES:  END OF ST_RELATION_CDS .
  types:
    TT_RELATIONs_CDS TYPE TABLE OF  ST_RELATION_CDS WITH DEFAULT KEY .
  types:
    BEGIN OF ST_ENTITY_CDS,
    INCLUDE TYPE zdb_gpi_er_entty ,
    NAME TYPE STRING,
    LEVEL TYPE I,
    PTR_OBJECT TYPE REF TO ZCL_GPI_ENTITY_CDS,
     PTR_SADL_ENTITY       TYPE REF TO   CL_ABAP_TYPEDESCR,
    END OF ST_ENTITY_CDS .
  types:
    TT_ENTITY_CDS TYPE TABLE OF ST_ENTITY_CDS  WITH DEFAULT KEY .
  types:
    BEGIN OF ST_CARDINALITY ,
    AS_TEXT TYPE STRING,
    AS_PLANT_UML TYPE STRING,
    ID  TYPE STRING,
    END OF ST_CARDINALITY .
  types:
    TT_CARDINALITY  TYPE TABLE OF ST_CARDINALITY  WITH DEFAULT KEY .
  types:
    TT_STRING TYPE TABLE OF STRING WITH DEFAULT KEY .

  class-data TBL_PROCESSED_ENTITIES type TABLE of String .
  data TBL_ATTRIBUTES_CDS type TT_ATTRIBUTES_CDS .
  data TBL_RELATIONS_CDS type TT_RELATIONS_CDS .


  class-methods GET_CARDINALITY_4_ASSOC
    importing
      !IM_CARDINALITY type I
    returning
      value(RET_RESULT) type ST_CARDINALITY .
  methods CONSTRUCTOR
    importing
      !IM_CDS_ENTITY_NAME type STRING optional
      !IM_SCENARIO_CODE type STRING optional
      !IM_LEVEL type I default 0
      !IM_O_SCENARIO type ref to ZCL_GPI_SCENARIO optional .
  methods EXIST_ENTITY
    importing
      !IM_ENTITY_NAME type STRING
    returning
      value(RET_RESULT) type BOOLEAN .
  methods FLTR_ENTITIES_VH .
  methods FLTR_RELAT_PRT_CHD_ONLY .
  methods GET_INVERSE_ASSOCIATION
    importing
      !IM_S_ASSOCIATION type ST_RELATION_CDS
    returning
      value(RET_RESULT) type ST_RELATION_CDS .
  methods INITIALIZE .
  methods INIT_ENTITIES
    returning
      value(RET_RESULTS) type TT_STRING .

  class-methods GET_CARDINALITY_TEXT
    importing
      !IM_CARDINALITY_ID type I
    returning
      value(RET_RESULT) type STRING .

  methods INIT_ATTRIBUTES
    redefinition .
  methods INIT_RELATIONS
    redefinition .
protected section.
private section.
ENDCLASS.



CLASS ZCL_GPI_ENTITY_CDS IMPLEMENTATION.


METHOD CONSTRUCTOR.
* -------------------------------------------------------------------------------------------------
* Created by  :  GODART PIERRE
* Description :
* Project     :
* -------------------------------------------------------------------------------------------------
  SUPER->CONSTRUCTOR( ).
*   IM_ENTITY_NAME = IM_CDS_ENTITY_NAME ).
*  ME->DATA_CORE-SCENARIO_CODE = IM_SCENARIO_CODE.
*  ME->DATA_CORE-ENTITY_INDEX  = IM_LEVEL.
*  ME->DATA_CORE-PTR2OBJ       = ME.
*  ME->PTR2SCENARIO            = IM_O_SCENARIO.
*  IF IM_O_SCENARIO IS NOT INITIAL.
*     ME->PTR2SCENARIO = IM_O_SCENARIO.
*  ENDIF.
ENDMETHOD.


METHOD EXIST_ENTITY.
*--------------------------------------------------------------------------------------------------
* Author : Pierre Godart
*--------------------------------------------------------------------------------------------------
*  DATA LS_ENTITY           TYPE ST_ENTITY_CDS.
*  RET_RESULT = ''.
*  LOOP AT ME->TBL_ENTITIES INTO LS_ENTITY.
*       IF LS_ENTITY-NAME = IM_ENTITY_NAME.
*          RET_RESULT = 'X'.
*          EXIT.
*       ENDIF.
*  ENDLOOP.
ENDMETHOD.


METHOD FLTR_ENTITIES_VH.
*--------------------------------------------------------------------------------------------------
* Author : Pierre Godart
*--------------------------------------------------------------------------------------------------
*  DATA LT_ENTITY_TMP      TYPE TABLE OF ST_ENTITY_CDS WITH DEFAULT KEY.
*  DATA LS_ASSOCIATION_LCL TYPE ST_ASSOCIATION_CDS.
*  DATA LT_ASSOCIATION_LCL TYPE TT_ASSOCIATION.
** DATA LS_ENTITY          TYPE ST_ENTITY.
*
*  LOOP AT ME->TBL_ENTITIES INTO DATA(LS_ENTITY).
*       IF LS_ENTITY-NAME CS 'VH'.
*       ELSE.
*          APPEND LS_ENTITY TO  LT_ENTITY_TMP.
*       ENDIF.
*  ENDLOOP.
*  ME->TBL_ENTITIES = LT_ENTITY_TMP.
*
** To be consistant => filter associations too ...
*  LOOP AT ME->TBL_ASSOCIATIONS INTO LS_ASSOCIATION_LCL.
*       IF  ME->EXIST_ENTITY( LS_ASSOCIATION_LCL-ENTITY_PARENT ) = 'X'
*       AND ME->EXIST_ENTITY( LS_ASSOCIATION_LCL-ENTITY_CHILD )  = 'X' .
*          APPEND LS_ASSOCIATION_LCL TO LT_ASSOCIATION_LCL.
*       ENDIF.
*  ENDLOOP.
*  ME->TBL_ASSOCIATIONS = LT_ASSOCIATION_LCL.

ENDMETHOD.


METHOD FLTR_RELAT_PRT_CHD_ONLY.
*--------------------------------------------------------------------------------------------------
* Author : Pierre Godart
*--------------------------------------------------------------------------------------------------
*  DATA LT_ENTITY_TMP      TYPE TABLE OF STRING WITH DEFAULT KEY.
*  DATA LS_ASSOCIATION_LCL TYPE ST_ASSOCIATION_CDS.
*  DATA LT_ASSOCIATION_LCL TYPE TT_ASSOCIATION.
*  DATA LS_INVERSE         TYPE ST_ASSOCIATION_CDS.
*  DATA LS_ENTITY_01       TYPE ST_ENTITY_CDS.
*  DATA LS_ENTITY_02       TYPE ST_ENTITY_CDS.
*
*
** To be consistant => filter associations too ...
*  LOOP AT ME->TBL_ASSOCIATIONS INTO LS_ASSOCIATION_LCL.
**       LS_INVERSE = ME->GET_INVERSE_ASSOCIATION( LS_ASSOCIATION_LCL ).
**       IF LS_INVERSE IS INITIAL.
***         no inverse => add
**          APPEND LS_ASSOCIATION_LCL TO LT_ASSOCIATION_LCL.
**       ELSE.
**         READ TABLE ME->TBL_ENTITIES WITH KEY NAME = LS_ASSOCIATION_LCL-ENTITY_PARENT INTO  LS_ENTITY_01.
**         READ TABLE ME->TBL_ENTITIES WITH KEY NAME = LS_ASSOCIATION_LCL-ENTITY_CHILD  INTO  LS_ENTITY_02.
**         IF LS_ENTITY_01-LEVEL < LS_ENTITY_02-LEVEL.
***           KEEP CURRENT
**            APPEND LS_ASSOCIATION_LCL TO LT_ASSOCIATION_LCL.
**         ELSE.
***           KEEP INVERSE
**            APPEND LS_INVERSE TO LT_ASSOCIATION_LCL.
**         ENDIF.
**       ENDIF.
*
*         READ TABLE ME->TBL_ENTITIES WITH KEY NAME = LS_ASSOCIATION_LCL-ENTITY_PARENT INTO  LS_ENTITY_01.
*         READ TABLE ME->TBL_ENTITIES WITH KEY NAME = LS_ASSOCIATION_LCL-ENTITY_CHILD  INTO  LS_ENTITY_02.
*         IF LS_ENTITY_01-LEVEL < LS_ENTITY_02-LEVEL.
**           KEEP CURRENT
*            APPEND LS_ASSOCIATION_LCL TO LT_ASSOCIATION_LCL.
*         ENDIF.
*
*  ENDLOOP.
*  ME->TBL_ASSOCIATIONS = LT_ASSOCIATION_LCL.
ENDMETHOD.


METHOD GET_CARDINALITY_4_ASSOC.
*--------------------------------------------------------------------------------------------------
* Author : Pierre Godart
*--------------------------------------------------------------------------------------------------
  CASE   IM_CARDINALITY.
    WHEN 1.
        RET_RESULT-AS_TEXT      = 'zero_to_one'.
        RET_RESULT-AS_PLANT_UML = ' "0" *-- "1"  '.
        RET_RESULT-ID           = 1.
    WHEN 2.
        RET_RESULT-AS_TEXT      = 'one'.
        RET_RESULT-AS_PLANT_UML = ' "1" *-- "1"  '.
        RET_RESULT-ID           = 1.
    WHEN 3.
        RET_RESULT-AS_TEXT      = 'many'.
        RET_RESULT-AS_PLANT_UML = ' "*" *-- "*"  '.
        RET_RESULT-ID           = 1.
    WHEN 4.
        RET_RESULT-AS_TEXT      = 'zero_to_many'.
        RET_RESULT-AS_PLANT_UML = ' "0" *-- "*"  '.
        RET_RESULT-ID           = 4.
    WHEN 5.
        RET_RESULT-AS_TEXT      = 'one_to_many'.
        RET_RESULT-AS_PLANT_UML = ' "1" *-- "*"  '.
        RET_RESULT-ID           = 5.
    WHEN OTHERS.
  ENDCASE.
ENDMETHOD.


method GET_CARDINALITY_TEXT.
  CASE            IM_CARDINALITY_ID.
    WHEN 1.       RET_RESULT = '0..1'.
    WHEN 2.       RET_RESULT = '1..1'.
    WHEN 3.       RET_RESULT = '0..N'. " Many-Deprecated
    WHEN 4.       RET_RESULT = '0..N'. " Many
    WHEN 5.       RET_RESULT = '1..N'.
    WHEN OTHERS.  RET_RESULT = '?..?'.
  ENDCASE.
endmethod.


METHOD GET_INVERSE_ASSOCIATION.
*--------------------------------------------------------------------------------------------------
* Author : Pierre Godart
*--------------------------------------------------------------------------------------------------
*  DATA LT_ENTITY_TMP      TYPE TABLE OF STRING WITH DEFAULT KEY.
*  DATA LS_ASSOCIATION_LCL TYPE ST_ASSOCIATION_CDS.
*  DATA LT_ASSOCIATION_LCL TYPE TT_ASSOCIATION.
*
*  CLEAR RET_RESULT.
*
** To be consistant => filter associations too ...
*  LOOP AT ME->TBL_ASSOCIATIONS INTO LS_ASSOCIATION_LCL.
*       IF  LS_ASSOCIATION_LCL-ENTITY_PARENT = IM_S_ASSOCIATION-ENTITY_CHILD
*       AND LS_ASSOCIATION_LCL-ENTITY_CHILD  = IM_S_ASSOCIATION-ENTITY_PARENT.
*           RET_RESULT = LS_ASSOCIATION_LCL.
*       ENDIF.
*  ENDLOOP.

ENDMETHOD.


METHOD INITIALIZE.
*--------------------------------------------------------------------------------------------------
* Author : Pierre Godart
*--------------------------------------------------------------------------------------------------

ENDMETHOD.


METHOD INIT_ATTRIBUTES.
** -------------------------------------------------------------------------------------------------
** AUTHOR      : GODART PIERRE - 2024
** DESCRIPTION :
** -------------------------------------------------------------------------------------------------
*  DATA LO_ENTITY_CDS       TYPE REF TO CL_SADL_ENTITY_CDS.
*  DATA LS_ATTRIBUTE_CDS    TYPE ST_ATTRIBUTE_CDS.
*  DATA LS_ATTRIBUTE_BASE   TYPE ST_ATTRIBUTE.
*  DATA LS_ATTRIBUTE_SADL   TYPE IF_SADL_ENTITY=>TY_ELEMENT.
*  DATA LT_ATTRIBUTES_SADL  TYPE IF_SADL_ENTITY=>TT_ELEMENTS.
*  DATA LT_PK               TYPE STRINGTAB.
*
*
*  LO_ENTITY_CDS ?=    CL_SADL_ENTITY_FACTORY=>GET_INSTANCE( )->GET_ENTITY(
*                        IV_TYPE = 'CDS'
*                        IV_ID   = CONV #( ME->DATA_CORE-ENTITY_NAME  ) ).
*
*  LO_ENTITY_CDS->IF_SADL_ENTITY~GET_ELEMENTS( IMPORTING ET_ELEMENTS =  LT_ATTRIBUTES_SADL  ).
*  LO_ENTITY_CDS->IF_SADL_ENTITY~GET_PRIMARY_KEY_ELEMENTS( IMPORTING ET_PRIMARY_KEY_ELEMENTS = LT_PK ).
*
*  LOOP AT LT_ATTRIBUTES_SADL INTO  LS_ATTRIBUTE_SADL.
*          MOVE-CORRESPONDING LS_ATTRIBUTE_SADL TO LS_ATTRIBUTE_CDS-SADL_DATA.
*          LS_ATTRIBUTE_CDS-FIELD_IS_KEY = ''.
*          LS_ATTRIBUTE_CDS-FIELD_NAME   = LS_ATTRIBUTE_CDS-SADL_DATA-NAME.
*          LS_ATTRIBUTE_CDS-FIELD_ID     = LS_ATTRIBUTE_CDS-FIELD_NAME.
*
*          LOOP AT LT_PK INTO DATA(LV_PK).
*               IF LS_ATTRIBUTE_CDS-FIELD_ID     = LV_PK.
*                  LS_ATTRIBUTE_CDS-FIELD_IS_KEY = 'X'.
*               ENDIF.
*          ENDLOOP.
*
*          MOVE-CORRESPONDING LS_ATTRIBUTE_CDS
*          TO                 LS_ATTRIBUTE_BASE.
**       APPEND LS_ATTRIBUTE_CDS  TO ME->TBL_ATTRIBUTES_CDS.
**       APPEND LS_ATTRIBUTE_BASE TO ME->TBL_ATTRIBUTES.
*  ENDLOOP.
ENDMETHOD.


METHOD INIT_ENTITIES.
*--------------------------------------------------------------------------------------------------
* Author : Pierre Godart
*--------------------------------------------------------------------------------------------------
*  DATA LS_ASSOCIATION_LCL  TYPE ST_ASSOCIATION_CDS.
*  DATA LV_ENTITY           TYPE STRING.
*  DATA LS_ENTITY           TYPE ST_ENTITY_CDS.
*  DATA LV_FOUND            TYPE BOOLEAN.
*  DATA LV_LEVEL            TYPE I.
*  LV_LEVEL = 0.
*  LOOP AT ME->TBL_ASSOCIATIONS INTO LS_ASSOCIATION_LCL.
*       IF ME->EXIST_ENTITY( LS_ASSOCIATION_LCL-ENTITY_PARENT ) <> 'X'.
*          LS_ENTITY-NAME  = LS_ASSOCIATION_LCL-ENTITY_PARENT.
*          LS_ENTITY-LEVEL = LV_LEVEL.
*          APPEND LS_ENTITY TO ME->TBL_ENTITIES .
*       ENDIF.
*       LV_LEVEL = LV_LEVEL + 1.
*       IF ME->EXIST_ENTITY( LS_ASSOCIATION_LCL-ENTITY_CHILD ) <> 'X'.
*          LS_ENTITY-NAME = LS_ASSOCIATION_LCL-ENTITY_CHILD.
*          LS_ENTITY-LEVEL = LV_LEVEL.
*          APPEND LS_ENTITY TO ME->TBL_ENTITIES .
*       ENDIF.
*       LV_LEVEL = LV_LEVEL + 1.
*  ENDLOOP.
ENDMETHOD.


method INIT_RELATIONS.
** -------------------------------------------------------------------------------------------------
** AUTHOR      : GODART PIERRE - 2024
** DESCRIPTION :
** -------------------------------------------------------------------------------------------------
** SUPER->INIT_RELATIONS( ).
*
*  DATA LS_RELATION_BASE    TYPE ST_RELATION.
*  DATA LS_RELATION_CDS     TYPE ST_RELATION_CDS.
*  DATA LV_ENTITY_NAME      TYPE STRING.
*  DATA LS_ASSOCIATION_SADL TYPE IF_SADL_ENTITY=>TY_ASSOCIATION.
*  DATA LT_ASSOCIATION_SADL TYPE IF_SADL_ENTITY=>TT_ASSOCIATIONS.
*  DATA LO_ENTITY_SADL_CDS  TYPE REF TO CL_SADL_ENTITY_CDS.
*  DATA LO_ENTITY_CDS       TYPE REF TO ZCL_GPI_ENTITY_CDS.
*
**  DATA LV_NEXT_LEVEL       TYPE I.
**  DATA LV_ITEM_COUNTER     TYPE I.
**  DATA LV_MAX_ASSOCIATIONS TYPE I.
*
**   LV_ITEM_COUNTER     = 0.
**   LV_MAX_ASSOCIATIONS = 1000. " =  IM_MAX_ITEMS.
** IF IM_MAX_DEEPEST_LEVEL > 0.
**  IF ME->IS_ENTITY_ALREADY_PROCESSED( CONV #( ME->DATA_CORE-ENTITY_NAME ) ) <> 'X'.
*
*      DATA(LO_ENTITY) = CL_SADL_ENTITY_FACTORY=>GET_INSTANCE( )->GET_ENTITY(
*                            IV_TYPE = 'CDS'
*                            IV_ID   = CONV #( ME->DATA_CORE-ENTITY_NAME ) ).
*
*      LO_ENTITY_SADL_CDS ?=   LO_ENTITY.
*      LO_ENTITY_SADL_CDS->IF_SADL_ENTITY~GET_ASSOCIATIONS( IMPORTING ET_ASSOCIATIONS = LT_ASSOCIATION_SADL ).
*
*      LOOP AT LT_ASSOCIATION_SADL  INTO LS_ASSOCIATION_SADL.
*              LS_RELATION_CDS-SADL_DATA = LS_ASSOCIATION_SADL.
*
*              CREATE OBJECT LO_ENTITY_CDS
*              EXPORTING     IM_CDS_ENTITY_NAME = CONV #( LS_ASSOCIATION_SADL-TARGET_ID ).
*
**             ------------------------------------------------
**             Table for generic processing =>
**             ------------------------------------------------
*              MOVE-CORRESPONDING LS_RELATION_CDS TO LS_RELATION_BASE.
*              LS_RELATION_BASE-PTR_ENTITY_SRC       = ME.
*              LS_RELATION_BASE-PTR_ENTITY_DST       = LO_ENTITY_CDS .
*              LS_RELATION_BASE-CARDINALITY_TX       = LS_ASSOCIATION_SADL-CARDINALITY.
*              LS_RELATION_BASE-CARDINALITY_ID       = LS_ASSOCIATION_SADL-CARDINALITY.
*              LS_RELATION_BASE-RELATION_NAME        = LS_ASSOCIATION_SADL-NAME .
*              LS_RELATION_BASE-RELATION_CARDINALITY = LS_ASSOCIATION_SADL-CARDINALITY.
*              LS_RELATION_BASE-RELATION_VISIBLE     = 'X'.
*
**              APPEND LS_RELATION_BASE TO ME->TBL_RELATIONS.
**              APPEND LS_RELATION_CDS  TO ME->TBL_RELATIONS_CDS.
*      ENDLOOP.

*
*METHOD IS_ENTITY_ALREADY_PROCESSED.
*  methods IS_ENTITY_ALREADY_PROCESSED
*    importing
*      !IM_ENTITY_NAME type /IWBEP/SBDM_NODE_NAME
*    returning
*      value(RET_RESULT) type BOOLEAN .
**--------------------------------------------------------------------------------------------------
** Author : Pierre Godart
**--------------------------------------------------------------------------------------------------
**  RET_RESULT = ''.
**  READ TABLE ME->TBL_ASSOCIATIONS WITH KEY ENTITY_PARENT = IM_ENTITY_NAME TRANSPORTING NO FIELDS.
**  IF SY-SUBRC = 0.
**     RET_RESULT = 'X'.
**  ENDIF.
*ENDMETHOD.
endmethod.
ENDCLASS.
