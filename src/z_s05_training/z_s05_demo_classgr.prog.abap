*&---------------------------------------------------------------------*
*& Report Z_S05_DEMO_CLASSGR
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s05_demo_classgr.

*
*CLASS lcl_radiobuttons DEFINITION ABSTRACT.
*  PUBLIC SECTION.
*    METHODS: go_to_trx.
*ENDCLASS.
*
*CLASS lcl_radiobuttons IMPLEMENTATION.
*
*  METHOD go_to_trx.
*    CALL TRANSACTION 'Z_GRP03_SWEETS' WITHOUT AUTHORITY-CHECK.
*  ENDMETHOD.
*ENDCLASS.

INTERFACE lif_rb.
  METHODS go_to_trx.
ENDINTERFACE.


CLASS lcl_rb1 DEFINITION.
  PUBLIC SECTION.
    INTERFACES lif_rb.
ENDCLASS.

CLASS lcl_rb1 IMPLEMENTATION.

  METHOD lif_rb~go_to_trx.
     CALL TRANSACTION 'Z_GRP03_SWEETS' WITHOUT AUTHORITY-CHECK.
  ENDMETHOD.
ENDCLASS.



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

  DATA: lo_rb1 TYPE REF TO lcl_rb1,
        lo_rb2 TYPE REF TO lcl_rb2,
        lo_rb3 TYPE REF TO lcl_rb3,
        lo_rb4 TYPE REF TO lcl_rb4.




  SELECTION-SCREEN BEGIN OF BLOCK b1.

    PARAMETERS rb1 RADIOBUTTON GROUP r1.
    PARAMETERS rb2 RADIOBUTTON GROUP r1.
    PARAMETERS rb3 RADIOBUTTON GROUP r1.
    PARAMETERS rb4 RADIOBUTTON GROUP r1.

  SELECTION-SCREEN END OF BLOCK b1.

  CASE 'X'.
    WHEN rb1.
      lo_rb1 = NEW lcl_rb1( ).

      lo_rb1->lif_rb~go_to_trx( ).

    WHEN rb2.
      lo_rb2 = NEW lcl_rb2( ).

      lo_rb2->lif_rb~go_to_trx( ).

    WHEN rb3.
      lo_rb3 = NEW lcl_rb3( ).

      lo_rb3->lif_rb~go_to_trx( ).

    WHEN rb4.
      lo_rb4 = NEW lcl_rb4( ).

      lo_rb4->lif_rb~go_to_trx( ).
      ENDCASE.





*CLASS lcl_radiobuttons DEFINITION ABSTRACT.
*  PUBLIC SECTION.
*    METHODS: go_to_trx.
*ENDCLASS.
*
*CLASS lcl_radiobuttons IMPLEMENTATION.
*
*  METHOD go_to_trx.
*    CALL TRANSACTION 'Z_GRP03_SWEETS' WITHOUT AUTHORITY-CHECK.
*  ENDMETHOD.
*ENDCLASS.
*
*
*CLASS lcl_rb1 DEFINITION INHERITING FROM lcl_radiobuttons.
*  PUBLIC SECTION.
*    METHODS go_to_trx REDEFINITION.
*ENDCLASS.
*
*CLASS lcl_rb1 IMPLEMENTATION.
*
*  METHOD go_to_trx.
*    super->go_to_trx( ).
*  ENDMETHOD.
*ENDCLASS.
*
*
*
*CLASS lcl_rb2 DEFINITION INHERITING FROM lcl_radiobuttons.
*  PUBLIC SECTION.
*    METHODS go_to_trx REDEFINITION.
*ENDCLASS.
*
*CLASS lcl_rb2 IMPLEMENTATION.
*
*  METHOD go_to_trx.
*    CALL TRANSACTION 'Z_S05_GRDEMO5' WITHOUT AUTHORITY-CHECK.
*  ENDMETHOD.
*ENDCLASS.
*
*
*CLASS lcl_rb3 DEFINITION INHERITING FROM lcl_radiobuttons.
*  PUBLIC SECTION.
*    METHODS go_to_trx REDEFINITION.
*ENDCLASS.
*
*CLASS lcl_rb3 IMPLEMENTATION.
*
*  METHOD go_to_trx.
*    CALL TRANSACTION 'Z_S05_GRDEMO3' WITHOUT AUTHORITY-CHECK.
*  ENDMETHOD.
*ENDCLASS.
*
*
*
*CLASS lcl_rb4 DEFINITION INHERITING FROM lcl_radiobuttons.
*  PUBLIC SECTION.
*    METHODS go_to_trx REDEFINITION.
*ENDCLASS.
*
*CLASS lcl_rb4 IMPLEMENTATION.
*
*  METHOD go_to_trx.
*    CALL TRANSACTION 'Z_S05_GRDEMO4' WITHOUT AUTHORITY-CHECK.
*  ENDMETHOD.
*ENDCLASS.
*
*
*START-OF-SELECTION.
*
*  DATA: lo_rb1 TYPE REF TO lcl_rb1,
*        lo_rb2 TYPE REF TO lcl_rb2,
*        lo_rb3 TYPE REF TO lcl_rb3,
*        lo_rb4 TYPE REF TO lcl_rb4.
*
*
*
*
*  SELECTION-SCREEN BEGIN OF BLOCK b1.
*
*    PARAMETERS rb1 RADIOBUTTON GROUP r1.
*    PARAMETERS rb2 RADIOBUTTON GROUP r1.
*    PARAMETERS rb3 RADIOBUTTON GROUP r1.
*    PARAMETERS rb4 RADIOBUTTON GROUP r1.
*
*  SELECTION-SCREEN END OF BLOCK b1.
*
*  CASE 'X'.
*    WHEN rb1.
*      lo_rb1 = NEW lcl_rb1( ).
*
*      lo_rb1->go_to_trx( ).
*
*    WHEN rb2.
*      lo_rb2 = NEW lcl_rb2( ).
*
*      lo_rb2->go_to_trx( ).
*
*    WHEN rb3.
*      lo_rb3 = NEW lcl_rb3( ).
*
*      lo_rb3->go_to_trx( ).
*
*    WHEN rb4.
*      lo_rb4 = NEW lcl_rb4( ).
*
*      lo_rb4->go_to_trx( ).
*      ENDCASE.
*
