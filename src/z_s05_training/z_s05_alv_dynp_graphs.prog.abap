*&---------------------------------------------------------------------*
*& Report Z_S05_ALV_DYNP_GRAPHS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s05_alv_dynp_graphs.

set screen 100.

TABLES:
  zgrp3_kunde.
DATA:
  "Container
  cust_1          TYPE REF TO cl_gui_custom_container,
  "Local-Tables
  lt_zgrp3_status TYPE TABLE OF zgrp3_kunde,
* Logo
  picture1        TYPE REF TO cl_gui_picture,
  url             TYPE cndp_url.
**********************************************************************

MODULE user_command_0100 INPUT.
  CASE sy-ucomm.
    WHEN 'CHECK'.

      SELECT * INTO TABLE lt_zgrp3_status
      FROM zgrp3_kunde
      WHERE kunnr = zgrp3_kunde-kunnr
      AND geburtsdatum = zgrp3_kunde-geburtsdatum.

    WHEN 'CLEAR'.
      CLEAR zgrp3_kunde-kunnr.
      CLEAR zgrp3_kunde-geburtsdatum.

    WHEN 'LEAVE'.
      LEAVE PROGRAM.

    WHEN 'BACK'.
      LEAVE PROGRAM.

  ENDCASE.
ENDMODULE.

MODULE status_0100 OUTPUT.

  IF cust_1 IS INITIAL. "is not bound

    CREATE OBJECT cust_1
      EXPORTING
        container_name = 'CUST_1'.

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
  ENDIF.



ENDMODULE.

*ZGRP3_ST_PREIS
*ZGRP3_ST_EMPFRATE
*ZGRP3_ST_OEKOANTEIL
*********************************************************************
******PREIS VERGLEICHEN**********************************************
*DATA : lt_preis     TYPE TABLE OF zgrp3_st_preis,
*       ls_preis     TYPE  zgrp3_st_preis,
*       ls_empf      TYPE  zgrp3_st_empfrate,
*       lt_empf      TYPE TABLE OF zgrp3_st_empfrate,
*       ls_oeko      TYPE  TABLE OF zgrp3_st_oekoanteil,
*       ls_oeko      TYPE zgrp3_st_oekoanteil,
*       lt_val_preis TYPE TABLE OF gprval,
*       ls_val_preis TYPE  gprval,
*       lt_col_preis TYPE TABLE OF gprtxt,
*       ls_col_preis TYPE  gprtxt,
*       o_grid       TYPE REF TO cl_gui_alv_grid,
*       o_cust       TYPE REF TO cl_gui_custom_container.
*
*SELECT * FROM zgrp3_tarife INTO CORRESPONDING FIELDS OF @DATA(.
