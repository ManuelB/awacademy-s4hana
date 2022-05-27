REPORT zaws04_amdp_report.

DATA lt_spfli TYPE TABLE OF spfli.

SELECTION-SCREEN BEGIN OF BLOCK a.
  PARAMETERS p_carrid TYPE sflight-carrid.
SELECTION-SCREEN END OF BLOCK a.

CLASS lcl_amdp_test DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS run.
ENDCLASS.

CLASS lcl_amdp_test IMPLEMENTATION.
  METHOD run.

    TRY.
        IF cl_abap_dbfeatures=>use_features( requested_features = VALUE #( ( cl_abap_dbfeatures=>call_amdp_method ) ( cl_abap_dbfeatures=>amdp_table_function ) ) ) = abap_true.

          NEW z_amdp_spfli_details( )->get_spfli_details_dp(
            EXPORTING
              iv_mandt  = '100'
              iv_carrid = p_carrid
            IMPORTING
              et_spfli  = lt_spfli
          ).

        ENDIF.

      CATCH cx_abap_invalid_param_value.

    ENDTRY.

  ENDMETHOD.
ENDCLASS.


START-OF-SELECTION.

  lcl_amdp_test=>run( ).

  IF NOT lt_spfli[] IS INITIAL.

    DATA(o_alv) = NEW cl_gui_alv_grid( i_parent = cl_gui_container=>default_screen i_appl_events = abap_true ).


**********************************************************************

*  Feldkatalog automatisch durch salv-Objekte erstellen lassen
    DATA: o_salv TYPE REF TO cl_salv_table.

    cl_salv_table=>factory( IMPORTING r_salv_table = o_salv
                            CHANGING  t_table      = lt_spfli ).

    DATA(it_fcat) = cl_salv_controller_metadata=>get_lvc_fieldcatalog( r_columns      = o_salv->get_columns( )
                                                                       r_aggregations = o_salv->get_aggregations( ) ).

* Layout des ALV setzen
    DATA(lv_layout) = VALUE lvc_s_layo( zebra      = abap_true             " ALV-Control: Alternierende Zeilenfarbe (Zebramuster)
                                        cwidth_opt = 'A'                   " ALV-Control: Spaltenbreite optimieren
                                        grid_title = 'Flugverbindungen' ). " ALV-Control: Text der Titelzeile

* ALV anzeigen
    o_alv->set_table_for_first_display( EXPORTING i_bypassing_buffer = abap_false  " Puffer ausschalten
                                                  i_save             = 'A'         " Anzeigevariante sichern
                                                  is_layout          = lv_layout   " Layout
                                        CHANGING  it_fieldcatalog    = it_fcat     " Feldkatalog
                                                  it_outtab          = lt_spfli ). " Ausgabetabelle

* Focus auf ALV setzen
    cl_gui_alv_grid=>set_focus( control = o_alv ).

* leere SAP-Toolbar ausblenden
    cl_abap_list_layout=>suppress_toolbar( ).

* erzwingen von cl_gui_container=>default_screen
    WRITE: space.

  ELSE.
    MESSAGE 'Für die gewählte Fluggesellschaft konnten keine Flüge gefunden werden' TYPE 'I' DISPLAY LIKE 'E'.
  ENDIF.
