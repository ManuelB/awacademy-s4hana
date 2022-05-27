*&---------------------------------------------------------------------*
*& Report Z_S05_DEMO_CLASSGR2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S05_DEMO_CLASSGR2.


INTERFACE lif_rb.
  METHODS go_to_trx.
ENDINTERFACE.


*CLASS lcl_rb1 DEFINITION.
*  PUBLIC SECTION.
*    INTERFACES lif_rb.
*ENDCLASS.
*
*CLASS lcl_rb1 IMPLEMENTATION.
*
*  METHOD lif_rb~go_to_trx.
*     CALL TRANSACTION 'Z_GRP03_SWEETS' WITHOUT AUTHORITY-CHECK.
*  ENDMETHOD.
*ENDCLASS.



CLASS lcl_rb2 DEFINITION.
  PUBLIC SECTION.
   INTERFACES lif_rb.

ENDCLASS.

CLASS lcl_rb2 IMPLEMENTATION.

  METHOD  lif_rb~go_to_trx.
    CALL TRANSACTION 'Z_S05_GRDEMO5' WITHOUT AUTHORITY-CHECK.
  ENDMETHOD.
ENDCLASS.


CLASS lcl_rb3 DEFINITION.
  PUBLIC SECTION.
    INTERFACES lif_rb.
ENDCLASS.

CLASS lcl_rb3 IMPLEMENTATION.

  METHOD  lif_rb~go_to_trx.
    CALL TRANSACTION 'Z_S05_GRDEMO3' WITHOUT AUTHORITY-CHECK.
  ENDMETHOD.
ENDCLASS.



CLASS lcl_rb4 DEFINITION.
  PUBLIC SECTION.
     INTERFACES lif_rb.
ENDCLASS.

CLASS lcl_rb4 IMPLEMENTATION.

  METHOD  lif_rb~go_to_trx.
    CALL TRANSACTION 'Z_S05_GRDEMO4' WITHOUT AUTHORITY-CHECK.
  ENDMETHOD.
ENDCLASS.


START-OF-SELECTION.

  DATA:
        lo_rb2 TYPE REF TO lcl_rb2,
        lo_rb3 TYPE REF TO lcl_rb3,
        lo_rb4 TYPE REF TO lcl_rb4.





SELECTION-SCREEN BEGIN OF SCREEN 1100.

*    PARAMETERS rb1 RADIOBUTTON GROUP r1.
    PARAMETERS rb2 RADIOBUTTON GROUP r1.
    PARAMETERS rb3 RADIOBUTTON GROUP r1.
    PARAMETERS rb4 RADIOBUTTON GROUP r1.

  SELECTION-SCREEN END OF SCREEN 1100.



AT SELECTION-SCREEN OUTPUT.

  LOOP AT SCREEN.

 CASE sy-tcode.

WHEN 'Z_S05_GRDEMO5'.
  if 1000 = rb2.
   screen-active = 0.
   endif.
   modify screen.

   WHEN 'Z_S05_GRDEMO3'.
  if 1001 = rb3.
   screen-active = 0.
      endif.
   modify screen.

   WHEN 'Z_S05_GRDEMO4'.
  if 1002 = rb4.
   screen-active = 0.
      endif.
   modify screen.

  ENDCASE.

  endloop.

  AT SELECTION-SCREEN.

     CASE sy-tcode.

WHEN 'Z_S05_GRDEMO5'.
  lo_rb2 = NEW lcl_rb2( ).

      lo_rb2->lif_rb~go_to_trx( ).

      WHEN 'Z_S05_GRDEMO3'.
  lo_rb3 = NEW lcl_rb3( ).

      lo_rb3->lif_rb~go_to_trx( ).

      WHEN 'Z_S05_GRDEMO4'.
  lo_rb4 = NEW lcl_rb4( ).

      lo_rb4->lif_rb~go_to_trx( ).

      ENDCASE.
