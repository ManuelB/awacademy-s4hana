*&---------------------------------------------------------------------*
*& Report ZMP_GRP_3_CALLCENTER
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmp_grp_3_callcenter.

INCLUDE ZMP_GRP_3_CALLCENTERTOP.  "Global Data
INCLUDE ZMP_GRP_3_CALLCENTERF01.  "Form-Routines
INCLUDE ZMP_GRP_3_CALLCENTERO01.  "PBO-Modules
INCLUDE ZMP_GRP_3_CALLCENTERI01.  "PAI-Modules
*TABLES:
*  zgrp3_kunde.
*DATA:
*  "Container
*  cust_1   TYPE REF TO cl_gui_custom_container,
*  cust_2   TYPE REF TO cl_gui_custom_container,
*  "Local-Tables
*  text1    TYPE REF TO cl_gui_textedit,
** Logo
*  picture1 TYPE REF TO cl_gui_picture,
*  url      TYPE cndp_url,
*  ls_kunde TYPE zgrp3_kunde,
*  lt_kunde TYPE TABLE OF zgrp3_kunde.
***********************************************************************
*CALL SCREEN 500.
*
*MODULE user_command_0500 INPUT.
*  CASE sy-ucomm.
*    WHEN 'CHECK'.
*
*      SELECT * INTO TABLE lt_kunde
*                       FROM zgrp3_kunde
*                       WHERE kunnr = zgrp3_kunde-kunnr
*                       AND geburtsdatum = zgrp3_kunde-geburtsdatum.
*    WHEN 'CLEAR'.
*      CLEAR zgrp3_kunde-kunnr.
*      CLEAR zgrp3_kunde-geburtsdatum.
*    WHEN 'LEAVE'.
*      LEAVE PROGRAM.
*    WHEN 'BACK'.
*      LEAVE PROGRAM.
*  ENDCASE.
*ENDMODULE.
*
*MODULE user_command_0600 INPUT.
*  CASE sy-ucomm.
*    WHEN 'CLEAR'.
*      CLEAR zgrp3_kunde-kunnr.
*      CLEAR zgrp3_kunde-geburtsdatum.
*      CLEAR zgrp3_kunde-name.
*      CLEAR zgrp3_kunde-vorname.
*      CLEAR zgrp3_kunde-strasse.
*      CLEAR zgrp3_kunde-hausnr.
*      CLEAR zgrp3_kunde-plz.
*      CLEAR zgrp3_kunde-ort.
*      CLEAR zgrp3_kunde-pers_haushalt.
*      CLEAR zgrp3_kunde-akt_anbieter.
*      CLEAR zgrp3_kunde-anbietertarif.
*      CLEAR zgrp3_kunde-status.
*  ENDCASE.
*ENDMODULE.
*
*MODULE status_0500 OUTPUT.
*
*  IF cust_1 IS INITIAL. "is not bound
*
*    CREATE OBJECT cust_1
*      EXPORTING
*        container_name = 'CUST_1'.
*
*
*    CREATE OBJECT cust_2
*      EXPORTING
*        container_name = 'CUST_2'.
*
*
*    CREATE OBJECT picture1
*      EXPORTING
*        parent = cust_1.
*
*
*    CALL FUNCTION 'DP_PUBLISH_WWW_URL'
*      EXPORTING
*        objid    = 'ZDEMOGR3'
*        lifetime = cndp_lifetime_transaction
*      IMPORTING
*        url      = url.
*    picture1->load_picture_from_url( url ).
*
*    CREATE OBJECT text1
*      EXPORTING
**       max_number_chars       =
**       style  = 0
**       wordwrap_mode          = WORDWRAP_AT_WINDOWBORDER
**       wordwrap_position      = -1
**       wordwrap_to_linebreak_mode = FALSE
**       filedrop_mode          = DROPFILE_EVENT_OFF
*        parent = cust_2
**       lifetime               =
**       name   =
**      EXCEPTIONS
**       error_cntl_create      = 1
**       error_cntl_init        = 2
**       error_cntl_link        = 3
**       error_dp_create        = 4
**       gui_type_not_supported = 5
**       others = 6
*      .
*
*  ENDIF.
*ENDMODULE.
*
*MODULE status_0600 OUTPUT.
*  SET TITLEBAR 'T600'.
*  LOOP AT SCREEN.
*    IF screen-name = 'ZGRP3_KUNDE-VORNAME'.
*      SELECT SINGLE * FROM zgrp3_kunde
*        WHERE kunnr = zgrp3_kunde-kunnr
*        AND geburtsdatum = zgrp3_kunde-geburtsdatum.
*    ENDIF.
*  ENDLOOP.
*ENDMODULE.
