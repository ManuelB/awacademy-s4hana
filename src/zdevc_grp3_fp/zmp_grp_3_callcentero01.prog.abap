*&---------------------------------------------------------------------*
*& Include          ZMP_GRP_3_CALLCENTERO01
*&---------------------------------------------------------------------*

START-OF-SELECTION.

  CALL SCREEN 500.

MODULE status_0500 OUTPUT.
  Set PF-STATUS 'S1000'.
  IF cust_1 IS INITIAL.
    CREATE OBJECT cust_1
      EXPORTING
        container_name = 'CUST_1'.
    CREATE OBJECT cust_2
      EXPORTING
        container_name = 'CUST_2'.
    CREATE OBJECT picture1
      EXPORTING
        parent = cust_1.

    CALL FUNCTION 'DP_PUBLISH_WWW_URL'
      EXPORTING
        objid    = 'ZDEMOGR3'
        lifetime = cndp_lifetime_transaction
      IMPORTING
        url      = url.
    picture1->load_picture_from_url( url ).
    picture1->set_display_mode( picture1->display_mode_fit ).
    CREATE OBJECT text1
      EXPORTING
*       max_number_chars       =
*       style  = 0
*       wordwrap_mode          = WORDWRAP_AT_WINDOWBORDER
*       wordwrap_position      = -1
*       wordwrap_to_linebreak_mode = FALSE
*       filedrop_mode          = DROPFILE_EVENT_OFF
        parent = cust_2
*       lifetime               =
*       name   =
*      EXCEPTIONS
*       error_cntl_create      = 1
*       error_cntl_init        = 2
*       error_cntl_link        = 3
*       error_dp_create        = 4
*       gui_type_not_supported = 5
*       others = 6
      .
  ENDIF.
ENDMODULE.

MODULE status_0600 OUTPUT.
  SET TITLEBAR 'T600'.
  LOOP AT SCREEN.
    IF screen-name = 'ZGRP3_KUNDE-VORNAME'.
      SELECT SINGLE * FROM zgrp3_kunde
        WHERE kunnr = zgrp3_kunde-kunnr
        AND geburtsdatum = zgrp3_kunde-geburtsdatum.
    ENDIF.
  ENDLOOP.
ENDMODULE.
