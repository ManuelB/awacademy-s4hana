*&---------------------------------------------------------------------*
*& Report Z_S02_OO_INTERFACES_2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s02_oo_interfaces_2.

*************************************************
***** Interface Buchung
*************************************************
INTERFACE lif_buchung.
  METHODS verbuchen.
ENDINTERFACE.



*************************************************
**** lokale Klasse Rechnung, nicht instanzierbar
*************************************************
CLASS lcl_rechnung DEFINITION ABSTRACT.

  PUBLIC SECTION.
    METHODS: constructor.
    INTERFACES lif_buchung.
    METHODS: bezahlen.
    METHODS: set_status IMPORTING im_st TYPE c.
    METHODS: get_status EXPORTING ex_st TYPE c.
    .

  PROTECTED SECTION.
    CONSTANTS: c_open    TYPE c VALUE 'O'.
    CONSTANTS: c_pending TYPE c VALUE 'P'.
    CONSTANTS: c_closed  TYPE c VALUE 'C'.

    DATA status TYPE c VALUE c_open.
    .

ENDCLASS.


CLASS lcl_rechnung IMPLEMENTATION.
  METHOD constructor.
    me->set_status( im_st = im_st_const ).
  ENDMETHOD.

  METHOD lif_buchung~verbuchen.
    WRITE: | Verbucht |.
  ENDMETHOD.

  METHOD status.
    WRITE: | Status ist statisch. |.
  ENDMETHOD.

  METHOD bezahlen.
    WRITE: | Rechnung Bezahlung ok. |.
  ENDMETHOD.
ENDCLASS.


*************************************************
**** lokale Klasse Gutschrift
*************************************************

CLASS lcl_gutschrift DEFINITION.

  PUBLIC SECTION.

    INTERFACES lif_buchung.


ENDCLASS.


CLASS lcl_gutschrift IMPLEMENTATION.
  METHOD lif_buchung~verbuchen.           " Achtungn Tilde
    WRITE: | Verbucht |.
  ENDMETHOD.

ENDCLASS.



*************************************************
**** lokale Klasse Abschlag
*************************************************

CLASS lcl_abschlag DEFINITION INHERITING FROM lcl_rechnung.

  PUBLIC SECTION.

    .

ENDCLASS.


CLASS lcl_abschlag IMPLEMENTATION.
*  METHOD lif_buchung~verbuchen.           " Achtungn Tilde
*    WRITE: | Verbucht |.
*  ENDMETHOD.

*  Method status.
*        WRITE: | Status ist statisch. |.
*    ENDMETHOD.

*      Method bezahlen.
*                WRITE: | Bezahlung ok. |.
*    ENDMETHOD.
ENDCLASS.



*************************************************
***** Objekte erstellen
*************************************************


DATA: lo_rechnung    TYPE REF TO lcl_rechnung.
DATA: lo_Gutschrift  TYPE REF TO lcl_gutschrift.
DATA: lo_abschlag    TYPE REF TO lcl_abschlag.

START-OF-SELECTION.


  lo_gutschrift  = NEW lcl_gutschrift( ).
  lo_abschlag   = NEW lcl_abschlag( ).



  lo_gutschrift->lif_buchung~verbuchen( ).
  lo_abschlag->lif_buchung~verbuchen( ).
  lo_abschlag->lif_buchung~verbuchen( ).
