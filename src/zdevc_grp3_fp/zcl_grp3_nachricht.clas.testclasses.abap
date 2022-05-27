*"* use this source file for your ABAP unit test classes
class ltcl_ definition final for testing
  duration short
  risk level harmless.

  private section.
    methods:
      test_constructor for testing raising cx_static_check.
endclass.


class ltcl_ implementation.

  method test_constructor.

    DATA l_Cut TYPE REF TO ZCL_GRP3_NACHRICHT.

    l_Cut = new ZCL_GRP3_NACHRICHT( IM_K_KUNNR = '0001'
      IM_K_NAME = 'Max'
      IM_K_VORNAME = 'Mustermann'
      IM_K_ANREDE = 'Herr'
      IM_K_GBDAT = '16071986'
      IM_K_STRASSE = 'Teststr.'
      IM_K_HAUSNR = '5'
      IM_K_PLZ = '12345'
      IM_K_ORT = 'München'
      IM_A_ANBIETERNAME = 'SWM'
      IM_A_STRASSE = 'Teststr.'
      IM_A_HAUSNR = '10'
      IM_A_PLZ = '12345'
      IM_A_ORT = 'München' ).

    cl_abap_unit_assert=>assert_equals( msg = 'msg' exp = 'Kunde: 0001 Max Mustermann 16071986 Teststr. 5 12345 München Anbieter: SWM Teststr. 10 12345 München' act = l_Cut->get_edi( ) ).
  endmethod.

endclass.
