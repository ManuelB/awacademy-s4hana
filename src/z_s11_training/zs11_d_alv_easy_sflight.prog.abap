*&---------------------------------------------------------------------*
*& Report ZS11_DEMO_DYNPRO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zs11_d_alv_easy_sflight.

TABLES:
  spfli, sflight.

DATA:
* Container
  cont1    TYPE REF TO cl_gui_custom_container,
*  Anwendung Controls
  alv1     TYPE REF TO cl_gui_alv_grid,
lt_sflight TYPE TABLE OF sflight.

CALL SCREEN 100.

MODULE user_command_0100 INPUT.
  CASE sy-ucomm.
    WHEN 'SHOW'.
      IF spfli-carrid IS INITIAL. "auch mit is not bound möglich
        SELECT * FROM sflight INTO TABLE lt_sflight.
      ELSE.
        SELECT * FROM sflight INTO TABLE lt_sflight "data beschaffungen
          WHERE carrid = spfli-carrid.
      ENDIF.
      IF sy-subrc <> 0.    "when select query is successful sy-subrc=0.
        CLEAR sflight.
      ENDIF.
    WHEN 'BACK'.
      LEAVE PROGRAM.
  ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
* SET PF-STATUS 'xxxxxxxx'. "stichwort:menu painter
* SET TITLEBAR 'xxx'.

  IF cont1 IS INITIAL.

    CREATE OBJECT cont1
      EXPORTING
        container_name = 'CUCTRL'. "container object erzeugt

    CREATE OBJECT alv1
      EXPORTING
        i_parent          = cont1.
*
    endif.


  CALL METHOD alv1->set_table_for_first_display
    EXPORTING
      i_structure_name = 'SFLIGHT'
    CHANGING
      it_outtab        = lt_sflight.


ENDMODULE.
