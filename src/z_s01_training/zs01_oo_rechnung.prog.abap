*&---------------------------------------------------------------------*
*& Report ZS01_OO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zs01_oo.

*Oberklasse
CLASS lcl_Rechnung DEFINITION.
  PUBLIC SECTION.
    METHODS: constructor IMPORTING zustand TYPE i. "Gleich ansprechen.
    METHODS: pay.
    METHODS: set_zustand IMPORTING im_st TYPE i.
    METHODS: get_zustand RETURNING VALUE(re_st) TYPE string.

Set

    PROTECTED SECTION.

    CONSTANTS: i_0 TYPE i VALUE '0'.
    CONSTANTS: i_1 TYPE i VALUE '1'.
    CONSTANTS: i_2 TYPE i VALUE '2'.


    DATA: zustand TYPE i.


ENDCLASS.


CLASS lcl_rechnung IMPLEMENTATION.

  METHOD constructor.

    me->set_zustand( im_st = zustand ).

  ENDMETHOD.


  METHOD pay.

    me->set_zustand( im_st = i_1 ).
    me->zustand = i_1.
    WRITE:/ 'Offen'.

  ENDMETHOD.


  METHOD set_zustand.

    me->zustand = im_st.
  ENDMETHOD.


  METHOD get_zustand.
    re_st = me->zustand.
  ENDMETHOD.

ENDCLASS.


*Unterklassen
CLASS lcl_teil DEFINITION INHERITING FROM lcl_rechnung.
  PUBLIC SECTION.

    METHODS pay REDEFINITION.


ENDCLASS.


CLASS lcl_teil IMPLEMENTATION.

  METHOD pay.

    me->set_zustand( im_st = i_0 ).
    WRITE:/ 'Pending'.

  ENDMETHOD.

ENDCLASS.



CLASS lcl_absch DEFINITION INHERITING FROM lcl_rechnung.
  PUBLIC SECTION.

    METHODS: pay REDEFINITION.

ENDCLASS.



CLASS lcl_absch IMPLEMENTATION.
  METHOD pay.
*    me->get_zustand( ). "hier vorher pay.
    me->set_zustand( im_st = i_2 ).
    WRITE:/ 'Rechnung Gechlossen'.
  ENDMETHOD.

ENDCLASS.



*Aufruf
START-OF-SELECTION.

*HIER WERDEN DIE SPEICHERORTE für die OBJEKTE DEKLARIERT:
  DATA lo_rechnung TYPE REF TO lcl_rechnung.
  DATA lo_teil TYPE REF TO lcl_teil.
  DATA lo_absch TYPE REF TO lcl_absch.

*HIER WERDEN DIE OBJEKTE ERSTELLT.
  lo_rechnung = NEW lcl_rechnung( zustand = '1' ).
  lo_teil = NEW lcl_teil( zustand = '0' ).
  lo_absch = NEW lcl_absch( zustand = '2' ).


*Call Methode unnötg.
  lo_rechnung->pay( ).
  WRITE:/ | Rechnungszustand: { lo_rechnung->get_zustand( ) } |.

  DATA(lv_test) = lo_rechnung->get_zustand( ).

  lo_teil->pay( ).
  WRITE:/ | Rechnungszustand: { lo_teil->get_zustand( ) } |.

  lo_absch->pay( ).
  WRITE:/ | Rechnungszustand: { lo_absch->get_zustand( ) } |.

  lo_rechnung->get_zustand( ).
  lo_teil->get_zustand( ).
  lo_absch->get_zustand( ).
