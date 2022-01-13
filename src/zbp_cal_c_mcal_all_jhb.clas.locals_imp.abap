CLASS lhc_holidayall DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS augment_cba_holiday FOR MODIFY
      IMPORTING entities FOR CREATE holidayall\_holiday.

ENDCLASS.

CLASS lhc_holidayall IMPLEMENTATION.

  METHOD augment_cba_holiday.
    DATA cba TYPE TABLE FOR CREATE zcal_i_mcal_jhb\_holidaytxt.
    DATA myrelates TYPE abp_behv_relating_tab.
    READ TABLE entities INDEX 1 INTO DATA(entity).

    LOOP AT entity-%target ASSIGNING FIELD-SYMBOL(<target>).
      APPEND sy-tabix TO myrelates.
      INSERT VALUE #( %cid_ref  = <target>-%cid
                      %is_draft = <target>-%is_draft
                      holiday   = <target>-holiday
                      %target = VALUE #(
                      (
                        %cid = |CREATECID{ sy-tabix }|
                        %is_draft = <target>-%is_draft
                        holiday = <target>-holiday
                        language = sy-langu
                        holidaydescription = <target>-holidaydescription
                        %control-holiday = if_abap_behv=>mk-on
                        %control-language = if_abap_behv=>mk-on
                        %control-holidaydescription = if_abap_behv=>mk-on
                      )
                      ) ) INTO TABLE cba.
    ENDLOOP.
    MODIFY AUGMENTING ENTITIES OF zcal_i_mcal_all_jhb
      ENTITY holidayroot
      CREATE BY \_holidaytxt
      FROM cba.
  ENDMETHOD.

ENDCLASS.

CLASS lhc_holidayroot DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS augment_update FOR MODIFY
      IMPORTING entities FOR UPDATE holidayroot.

ENDCLASS.

CLASS lhc_holidayroot IMPLEMENTATION.

  METHOD augment_update.
    DATA: text_update TYPE TABLE FOR UPDATE zcal_i_mcal_txt_jhb,
          text_cba    TYPE TABLE FOR CREATE zcal_i_mcal_jhb\_holidaytxt.
    DATA: myrelates_update TYPE abp_behv_relating_tab,
          myrelates_cba    TYPE abp_behv_relating_tab.

    READ ENTITIES OF zcal_i_mcal_all_jhb
      ENTITY holidayroot BY \_holidaytxt
        FROM VALUE #( FOR holiday_entity IN entities ( %tky = holiday_entity-%tky ) )
        LINK DATA(link).

    LOOP AT entities INTO DATA(entity) WHERE %control-holidaydescription = if_abap_behv=>mk-on.
      DATA(tabix) = sy-tabix.

      "If a Description with sy-langu already exists, perform an update. Else perform a create-by-association.
      IF line_exists( link[ KEY entity source-holiday  = entity-%key-holiday
                                       target-holiday  = entity-%key-holiday
                                       target-language = sy-langu ] ).
        APPEND tabix TO myrelates_update.

        APPEND VALUE #( %key-holiday       = entity-%key-holiday
                        %key-language      = sy-langu
                        %is_draft          = entity-%is_draft
                        holidaydescription = entity-holidaydescription
                        %control           = VALUE #( holidaydescription = entity-%control-holidaydescription ) )
         TO text_update.
      ELSE.

        APPEND tabix TO myrelates_cba.

        APPEND VALUE #( %tky         = entity-%tky
                        %target      = VALUE #( ( %cid               = |UPDATETEXTCID{ tabix }|
                                                  holiday            = entity-holiday
                                                  language           = sy-langu
                                                  %is_draft          = entity-%is_draft
                                                  holidaydescription = entity-holidaydescription
                                                  %control           = VALUE #( holiday            = if_abap_behv=>mk-on
                                                                                language           = if_abap_behv=>mk-on
                                                                                holidaydescription = entity-%control-holidaydescription ) ) ) )
          TO text_cba.
      ENDIF.
    ENDLOOP.

    MODIFY AUGMENTING ENTITIES OF zcal_i_mcal_all_jhb
      ENTITY holidaytext UPDATE FROM text_update RELATING TO entities BY myrelates_update
      ENTITY holidayroot CREATE BY \_holidaytxt FROM text_cba RELATING TO entities BY myrelates_cba.
  ENDMETHOD.

ENDCLASS.
