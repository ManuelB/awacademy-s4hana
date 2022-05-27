*&---------------------------------------------------------------------*
*& Report Z_S05_GRAPHS_SYNPROS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_grp_3_graphic.
********************************************************************
*****PREIS VERGLEICHEN**********************************************
DATA : lt_preis     TYPE TABLE OF ZGRP3_ST_PREIS,
       lt_preis_fnl TYPE TABLE OF ZGRP3_ST_PREIS,
       ls_preis     TYPE ZGRP3_ST_PREIS,
       lt_val_preis    TYPE TABLE OF gprval,
       ls_val_preis    TYPE  gprval,
       lt_col_preis    TYPE TABLE OF gprtxt,
       ls_col_preis    TYPE  gprtxt,
       o_grid    TYPE REF TO cl_gui_alv_grid,
       o_cust    TYPE REF TO cl_gui_custom_container,
       my_preis type string.

SET SCREEN 300.

START-OF-SELECTION.

 SELECT ANBIETERNAME ANBIETERTARIF ARBEITSPREIS FROM ZGRP3_TARIFE INTO TABLE lt_preis.
  IF lt_preis IS NOT INITIAL.
  SORT lt_preis BY ARBEITSPREIS.

   LOOP AT lt_preis INTO ls_preis .
    COLLECT  ls_preis INTO lt_preis_fnl.
   ENDLOOP.

   LOOP AT lt_preis_fnl INTO ls_preis .
   ls_col_preis-coltxt  = ls_preis-anbietername.
   APPEND ls_col_preis TO lt_col_preis.

CASE sy-tabix.
  WHEN 1.
    ls_val_preis-val1 = ls_preis-arbeitspreis.
  WHEN 2.
    ls_val_preis-val2 = ls_preis-arbeitspreis.
  WHEN 3.
    ls_val_preis-val3 = ls_preis-arbeitspreis.
  WHEN 4.
    ls_val_preis-val4 = ls_preis-arbeitspreis.
  WHEN 5.
    ls_val_preis-val5 = ls_preis-arbeitspreis.
  WHEN 6.
    ls_val_preis-val6 = ls_preis-arbeitspreis.
  WHEN 7.
    ls_val_preis-val7 = ls_preis-arbeitspreis.
  WHEN 8.
    ls_val_preis-val8 = ls_preis-arbeitspreis.
  WHEN 9.
    ls_val_preis-val9 = ls_preis-arbeitspreis.
  WHEN 10.
    ls_val_preis-val10 = ls_preis-arbeitspreis.
  WHEN 11.
    ls_val_preis-val11 = ls_preis-arbeitspreis.
  WHEN 12.
    ls_val_preis-val11 = ls_preis-arbeitspreis.
ENDCASE.
   CLEAR : ls_col_preis, ls_preis.
 ENDLOOP.
   APPEND ls_val_preis TO lt_val_preis.
   CLEAR ls_val_preis.
ELSE.
  WRITE :/ 'No records are selected, change the selection criteria'.
ENDIF.

MODULE user_command_0300 INPUT.
case sy-ucomm.
 when 'PREIS'.



  when 'END'.
    LEAVE PROGRAM.
    ENDCASE.
ENDMODULE.
*MODULE user_command_0300 INPUT.
*
* CASE sy-ucomm. "user command
*    WHEN 'SHOW'.
*
*
*ENDMODULE.

MODULE status_0300 OUTPUT.
* SET PF-STATUS 'xxxxxxxx'.
* SET TITLEBAR 'xxx'.
  CREATE OBJECT o_cust
  EXPORTING
    container_name              = 'CC1'.

CREATE OBJECT o_grid
  EXPORTING
    i_parent          = o_cust.

CALL METHOD o_grid->set_table_for_first_display
  EXPORTING
    i_structure_name              = 'ZGRP3_ST_PREIS'
  CHANGING
    it_outtab                     = lt_preis_fnl.

    CALL FUNCTION 'GFW_PRES_SHOW'
      EXPORTING
       CONTAINER               = 'CC2'
        presentation_type       = 27
       HEADER                  = 'Anbieterpreis kWh'
      tables
        values                  = lt_val_preis
        column_texts            = lt_col_preis.
              .
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0300  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
