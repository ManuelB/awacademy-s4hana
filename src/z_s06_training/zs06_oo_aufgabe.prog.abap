*&---------------------------------------------------------------------*
*& Report ZS01_OO_AUFGABE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zs06_oo_aufgabe.

CLASS lcl_rechnung DEFINITION.

  PUBLIC SECTION.

    METHODS:
      constructor IMPORTING im_st_const TYPE i,
      pay,
      set_zustand IMPORTING im_st TYPE string,
      get_zustand RETURNING VALUE(re_st) TYPE string.

  PROTECTED SECTION.

    CONSTANTS:
      st_open    TYPE string VALUE '1',
      st_pending TYPE string VALUE '0',
      st_close   TYPE string VALUE '2'.

    DATA zustand TYPE i VALUE st_pending.

ENDCLASS.

CLASS lcl_rechnung IMPLEMENTATION.
  METHOD
    constructor.
  ENDMETHOD.
  METHOD
  pay.
  ENDMETHOD.
ENDCLASS.

CLASS lcl_teil DEFINITION INHERITING FROM lcl_rechnung.
  PUBLIC SECTION.
    METHODS pay REDEFINITION.

ENDCLASS.
CLASS lcl_teil IMPLEMENTATION.
  METHOD pay.
    me->set_zustand( im_st = st_pending ).
    WRITE:|Rechnung Pending|.
  ENDMETHOD.
ENDCLASS.
CLASS lcl_absch DEFINITION INHERITING FROM lcl_rechnung.
  PUBLIC SECTION.
    METHODS pay REDEFINITION.
ENDCLASS.
CLASS lcl_absch IMPLEMENTATION.
  METHOD pay.
    me->set_zustand( im_st = st_pending ).
    WRITE:|Rechnung Pending|.
  ENDMETHOD.
ENDCLASS.

DATA o_teil TYPE REF TO lcl_teil.
DATA o_absch TYPE REF TO lcl_absch.

START-OF-SELECTION.

  o_teil = NEW lcl_teil( im_st_const = 0 ).                                      "or the new way to write it is:  o_beleg = NEW lcl_beleg

  o_absch = NEW lcl_absch( im_st_const = 0 ).

  ULINE."*******************************************************************

  o_teil->pay( ).WRITE: |Beleg Status: { o_teil->set_zustand( ) }|.

  ULINE."*******************************************************************

  o_absch->pay( ).WRITE: |Beleg Status: { o_absch->set_zustand( ) }|.

  ULINE.
