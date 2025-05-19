CLASS LHC_ZUUID_LEVEL_1_ET DEFINITION INHERITING FROM CL_ABAP_BEHAVIOR_HANDLER.
  PRIVATE SECTION.
    METHODS:
      GET_GLOBAL_AUTHORIZATIONS FOR GLOBAL AUTHORIZATION
        IMPORTING
           REQUEST requested_authorizations FOR zuuid_level_1_ET
        RESULT result,
      CALCULATESEMANTICKEY1 FOR DETERMINE ON SAVE
        IMPORTING
          KEYS FOR  zuuid_level_1_ET~CalculateSemanticKey1 .
ENDCLASS.

CLASS LHC_ZUUID_LEVEL_1_ET IMPLEMENTATION.
  METHOD GET_GLOBAL_AUTHORIZATIONS.
  ENDMETHOD.
  METHOD CALCULATESEMANTICKEY1.
  READ ENTITIES OF ZR_zuuid_level_1_ET01TP IN LOCAL MODE
    ENTITY zuuid_level_1_ET
      ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(entities).
  DELETE entities WHERE SemanticKey1 IS NOT INITIAL.
  Check entities is not initial.
  "Dummy logic to determine object_id
  SELECT MAX( SEMANTIC_KEY_1 ) FROM ZUUID_LEVEL_1 INTO @DATA(max_object_id).
  "Add support for draft if used in modify
  "SELECT SINGLE FROM FROM ZZUUID_LEVEL_00D FIELDS MAX( SemanticKey1 ) INTO @DATA(max_orderid_draft). "draft table
  "if max_orderid_draft > max_object_id
  " max_object_id = max_orderid_draft.
  "ENDIF.
  MODIFY ENTITIES OF ZR_zuuid_level_1_ET01TP IN LOCAL MODE
    ENTITY zuuid_level_1_ET
      UPDATE FIELDS ( SemanticKey1 )
        WITH VALUE #( FOR entity IN entities INDEX INTO i (
        %tky          = entity-%tky
        SemanticKey1     = max_object_id + i
  ) ).
  ENDMETHOD.
ENDCLASS.
