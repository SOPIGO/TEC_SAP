

CLASS lhc_ZR_GPI_ER_SCENARIO DEFINITION INHERITING FROM cl_abap_behavior_handler.


  PUBLIC SECTION.
 DATA Ptr2_System_UUID       TYPE REF TO IF_SYSTEM_UUID.



  PRIVATE SECTION.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR zr_gpi_er_scenario RESULT result.
    METHODS buildmodel FOR MODIFY
      IMPORTING keys FOR ACTION zr_gpi_er_scenario~BuildModel RESULT result.

ENDCLASS.

CLASS lhc_ZR_GPI_ER_SCENARIO IMPLEMENTATION.



  METHOD get_global_authorizations.
  ENDMETHOD.

METHOD BuildModel.
*  ---------------------------------------------------------------------------------
*  ---------------------------------------------------------------------------------
    Data Lv_Scenario_UUID       Type sysuuid_x16.
    Data Lv_Entity_Root_UUID    Type sysuuid_x16.

*   1) Access current entity (Scenario):
*   1.A) Get Root Entity-key
    READ TABLE keys index 1 into data(Ls_Scenario_Key).
    Lv_Scenario_UUID  = Ls_Scenario_Key-Uuid.

*   1.B) Get Root Entity-Data
    READ ENTITY ZC_GPI_ER_SCENARIO
    ALL FIELDS WITH VALUE #( ( %key-Uuid = Lv_Scenario_UUID ) )
    RESULT FINAL(Lt_Scenario_entity)
    FAILED FINAL(Lt_Scenario_read_failed).
    READ TABLE Lt_Scenario_entity index 1 into data(Ls_Scenario_Data).

*   2) Update related entity (Entity)
    MODIFY ENTITIES OF ZC_GPI_ER_SCENARIO
    ENTITY zc_gpi_er_scenario
    CREATE by \_RootEntity
    FROM VALUE #( (  Uuid       = Lv_Scenario_UUID
                     %target    = VALUE #( (    %cid                  = 'CID_DUMMY'
                                                EntityName            = Ls_Scenario_Data-EntityName
                                                %control-EntityName   = if_abap_behv=>mk-on ) )
                     ) )
    MAPPED      DATA(lt_mapped)
    FAILED      DATA(lt_failed)
    REPORTED    DATA(lt_reported).

    lv_entity_root_uuid = lt_mapped-zc_gpi_er_entity[ 1 ]-Uuid.


*  3) Use RTTi to get entity information ...
    DATA(Lo_RTTI_Hlpr)      = new zdmo_cl_rap_xco_cloud_lib(   ).
    DATA(Lo_RTTI_Entity)    = Lo_RTTI_Hlpr->get_view_entity( conv #( Ls_Scenario_Data-EntityName  ) ).

*   3.1) Get entity attributes + Create on DB
    DATA(lt_fields)         = Lo_RTTI_Entity->fields->all->get( ).
    LOOP    AT lt_fields ASSIGNING FIELD-SYMBOL(<fs_field>).
            DATA(ls_field) = <fs_field>->content( )->get( ).

            MODIFY ENTITIES OF ZC_GPI_ER_SCENARIO
            ENTITY zc_gpi_er_entity
            CREATE by \_Attributes
            FROM VALUE #( (  Uuid       = lv_entity_root_uuid
                             %target    = VALUE #( (    %cid                  = 'CID_DUMMY'
                                                        FieldName             = ls_field-original_name
                                                        %control-FieldName    = if_abap_behv=>mk-on ) )
                             ) )
            MAPPED      DATA(lt_Att_mapped)
            FAILED      DATA(lt_Att_failed)
            REPORTED    DATA(lt_Att_reported).
    ENDLOOP.


*   3.1) Get entity associations + Create on DB
    DATA(lt_associations) = Lo_RTTI_Entity->associations->all->get( ).
    LOOP    AT lt_associations ASSIGNING FIELD-SYMBOL(<fs_association>).
            DATA(ls_association) = <fs_association>->content( )->get( ).

            MODIFY ENTITIES OF ZC_GPI_ER_SCENARIO
            ENTITY zc_gpi_er_entity
            CREATE by \_Relations
            FROM VALUE #( (  Uuid       = lv_entity_root_uuid
                             %target    = VALUE #( (    %cid                  = 'CID_DUMMY'
                                                        RelationName          = ls_association-alias
                                                        %control-RelationName = if_abap_behv=>mk-on ) )
                             ) )
            MAPPED      DATA(lt_Rel_mapped)
            FAILED      DATA(lt_Rel_failed)
            REPORTED    DATA(lt_Rel_reported).

    ENDLOOP.

*   3.1) Get entity associations + Create on DB
    DATA(lt_compositions) = Lo_RTTI_Entity->compositions->all->get( ).
    LOOP    AT lt_compositions ASSIGNING FIELD-SYMBOL(<fs_composition>).
            DATA(ls_composition) = <fs_composition>->content( )->get( ).

*            MODIFY ENTITIES OF ZC_GPI_ER_SCENARIO
*            ENTITY zc_gpi_er_entity
*            CREATE by \_Relations
*            FROM VALUE #( (  Uuid       = lv_entity_root_uuid
*                             %target    = VALUE #( (    %cid                        = 'CID_DUMMY'
*                                                        UuidScnEnttySrc             = lv_entity_root_uuid
*                                                        %control-UuidScnEnttySrc    = if_abap_behv=>mk-on ) )
*                             ) )
*            MAPPED      DATA(lt_Rel_mapped)
*            FAILED      DATA(lt_Rel_failed)
*            REPORTED    DATA(lt_Rel_reported).

    ENDLOOP.

*  ---------------------------------------------------------------------------------
*  ---------------------------------------------------------------------------------
  ENDMETHOD.

ENDCLASS.
