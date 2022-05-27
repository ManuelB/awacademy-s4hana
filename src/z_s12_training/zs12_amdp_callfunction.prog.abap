*&---------------------------------------------------------------------*
*& Report z_amdp_callfunction
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zs12_amdp_callfunction.

CLASS lcl_test_amdp DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS: run.
ENDCLASS.

CLASS lcl_test_amdp IMPLEMENTATION.
  METHOD run.
*    BREAK-POINT.

* AMDP Method call
    TRY. "Abfrage: Kann ich das ausführen?
        IF cl_abap_dbfeatures=>use_features( requested_features = VALUE #( ( cl_abap_dbfeatures=>call_amdp_method ) ( cl_abap_dbfeatures=>amdp_table_function ) ) ) = abap_true.

          NEW z_amdp_spfli_details( )->get_spfli_details_dp(
          EXPORTING iv_mandt = '100'
                    iv_carrid = 'AA'
          IMPORTING
                    et_spfli = DATA(lt_spfli)
          ).

        ENDIF.

      CATCH cx_abap_invalid_param_value.

    ENDTRY.

  ENDMETHOD.
ENDCLASS.
Parameters:


START-OF-SELECTION.

  lcl_test_amdp=>run( ).




  BREAK-POINT.
