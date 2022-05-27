*&---------------------------------------------------------------------*
*& Report Z_S04_OO_VERERBUNG_AUFG
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s04_oo_vererbung_aufg.


**********************************************************************
*Oberklasse

CLASS lcl_rechnung DEFINITION ABSTRACT.

  PUBLIC SECTION.
    METHODS:
      constructor,
      pay,
      set_status IMPORTING im_st TYPE i,
      get_status RETURNING VALUE(re_st) TYPE i.

  PROTECTED SECTION.
    CONSTANTS: c_open    TYPE i VALUE 1,
               c_closed  TYPE i VALUE 2,
               c_pending TYPE i VALUE 0.


    DATA:     status TYPE i VALUE c_open.

ENDCLASS.


CLASS lcl_rechnung IMPLEMENTATION.

  METHOD constructor.
    me->set_status( im_st = c_pending ).

  ENDMETHOD.

  METHOD set_status.
    me->status = im_st.
  ENDMETHOD.

  METHOD get_status.
    re_st = me->status.
  ENDMETHOD.

  METHOD pay.
  ENDMETHOD.

ENDCLASS.


**********************************************************************
*Unterklasse Teilrechnung

CLASS lcl_teil DEFINITION INHERITING FROM lcl_rechnung.
  PUBLIC SECTION.
    METHODS: pay REDEFINITION.
ENDCLASS.

CLASS lcl_teil IMPLEMENTATION.
  METHOD pay.
    me->set_status( im_st = c_closed ).
    WRITE:/ 'Teilrechnung beglichen.'.
  ENDMETHOD.
ENDCLASS.


**********************************************************************
*Unterklasse Abschlagsrechnung

CLASS lcl_abschlag DEFINITION INHERITING FROM lcl_rechnung.
  PUBLIC SECTION.
    METHODS: pay REDEFINITION.
ENDCLASS.

CLASS lcl_abschlag IMPLEMENTATION.
  METHOD pay.
    me->set_status( im_st = c_closed ).
    WRITE:/ 'Abschlag bezahlt.'.
  ENDMETHOD.
ENDCLASS.


**********************************************************************
*Aufruf

SELECTION-SCREEN BEGIN OF BLOCK a WITH FRAME.

  PARAMETERS: teil     TYPE i DEFAULT 1,
              abschlag TYPE i DEFAULT 2.

SELECTION-SCREEN END OF BLOCK a.


START-OF-SELECTION.

  DATA: lo_teil     TYPE REF TO lcl_teil,
        lo_abschlag TYPE REF TO lcl_abschlag.


*  lo_teil = NEW lcl_teil( ).
*  lo_abschlag = NEW lcl_abschlag( ).
*
*  lo_teil->set_status( im_st = teil ).
*  WRITE: / 'Teilrechnung Status:', lo_teil->get_status( ).
*
*  lo_abschlag->set_status( im_st = abschlag ).
*  WRITE: / 'Abschlagzahlung Status:', lo_abschlag->get_status( ).


  IF teil EQ 2.
    lo_teil = NEW lcl_teil( ).
    lo_teil->pay( ).
  ENDIF.

  IF abschlag EQ 2.
    lo_abschlag = NEW lcl_abschlag( ).
    lo_abschlag->pay( ).
  ENDIF.
