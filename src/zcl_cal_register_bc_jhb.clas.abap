CLASS zcl_cal_register_bc_JHB DEFINITION
  PUBLIC
  INHERITING FROM cl_xco_cp_adt_simple_classrun
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  PROTECTED SECTION.
    METHODS: main REDEFINITION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_cal_register_bc_jhb IMPLEMENTATION.
  METHOD main.
    DATA(lo_business_configuration) = mbc_cp_api=>business_configuration(
      iv_identifier = 'ZCAL_JHB' && sy-uname
      iv_namespace  = '' ).
    TRY.
        lo_business_configuration->create(
          iv_name                  = |Public Holiday JHB| && sy-uname
          iv_description           = 'Maintain recurring holidays'
          iv_service_binding       = 'ZCAL_UI_MCAL_O4_JHB'
          iv_service_name          = 'ZCAL_UI_MCAL_JHB'
          iv_service_version       = 0001
          iv_root_entity_set       = 'HolidayAll'
          iv_transport             = 'TRLK901243'
          iv_skip_root_entity_list_rep = abap_true
        ).
        out->write( 'done' ).
      CATCH cx_mbc_api_exception INTO DATA(lx_err).
        out->write( lx_err ).
    ENDTRY.
  ENDMETHOD.
ENDCLASS.
