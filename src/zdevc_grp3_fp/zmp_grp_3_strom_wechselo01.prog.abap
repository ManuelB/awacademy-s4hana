*&---------------------------------------------------------------------*
*& Include          ZMP_GRP_3_STROM_WECHSELO01
*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
DATA
  p_side TYPE i VALUE  1.

DATA:
  my_event    TYPE REF TO lcl_listener,
  lo_wechseln TYPE REF TO zcl_grp3_wechsel.

START-OF-SELECTION.

  CALL SCREEN 100.
MODULE status_0100 OUTPUT.
*  SET PF-STATUS 'STATUS100'.
*  SET TITLEBAR 'T100'.
  IF cont1 IS INITIAL. "is not bound
* Container erzeugen
    CREATE OBJECT cont1
      EXPORTING
        container_name = 'CUCTRL'.

    CREATE OBJECT dock
      EXPORTING
        side = p_side.

    CREATE OBJECT my_event.
* Anwendungscontrols erzeugen
    CREATE OBJECT alv1
      EXPORTING
        i_parent = cont1.
    SET HANDLER my_event->handle_double_click FOR alv1.
    lo_wechseln = NEW zcl_grp3_wechsel( ).

  ELSE.
    alv1->refresh_table_display( ).
  ENDIF.

* Methoden der Anwendungscontrols anwenden: Tabelle anzeigen
  CALL METHOD alv1->set_table_for_first_display
    EXPORTING
      i_structure_name = 'ZGRP3_KUNDE'
    CHANGING
      it_outtab        = lt_kunde.
  cl_gui_control=>set_focus( alv1 ).

  IF cont2 IS INITIAL.

    CREATE OBJECT cont2
      EXPORTING
        container_name = 'CUCTRL1'.

    CREATE OBJECT picture1
      EXPORTING
        parent = cont2.


    CALL FUNCTION 'DP_PUBLISH_WWW_URL'
      EXPORTING
        objid    = 'ZDEMOGR3'
        lifetime = cndp_lifetime_transaction
      IMPORTING
        url      = url.
    picture1->load_picture_from_url( url ).

  ENDIF.
  IF cont3 IS INITIAL.

    CREATE OBJECT: cont3
      EXPORTING
        container_name = 'CUCTRL2',
        edit
        EXPORTING
          parent = cont3.

  ENDIF.
ENDMODULE.

*&---------------------------------------------------------------------*
*& Module STATUS_0200 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0200 OUTPUT.

  SET PF-STATUS 'STATUS200'.
  SET TITLEBAR 'T200'.

  LOOP AT SCREEN.
    IF screen-name = 'ZGRP3_KUNDE-KUNNR'.
      SELECT SINGLE * FROM zgrp3_kunde
      WHERE kunnr = ls_kunde-kunnr
      AND status = ls_kunde-status.
      screen-input = 1.
    ENDIF.

    MODIFY SCREEN.
  ENDLOOP.

ENDMODULE.
