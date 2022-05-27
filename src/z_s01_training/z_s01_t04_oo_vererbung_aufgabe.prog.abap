*&---------------------------------------------------------------------*
*& Report Z_T04_OO_VERERBUNG
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s01_t04_oo_vererbung_aufgabe.






**********************************************************************
* OBERKLASSE
**********************************************************************

CLASS lcl_rechnung DEFINITION ABSTRACT.
  PUBLIC SECTION.
    METHODS: constructor.
    METHODS: pay.
    METHODS: set_zustand IMPORTING im_st TYPE i.
*    METHODS: get_zustand RETURNING VALUE(re_st) TYPE i.

  PROTECTED SECTION.
    CONSTANTS: c_open    TYPE i VALUE 1.
    CONSTANTS: c_pending TYPE i VALUE 0.
    CONSTANTS: c_closed  TYPE i VALUE 2.

    DATA zustand TYPE c VALUE c_open.
  PRIVATE SECTION.
ENDCLASS.


CLASS lcl_rechnung IMPLEMENTATION.
  METHOD constructor.
    me->set_zustand( im_st = c_pending ).
  ENDMETHOD.

  METHOD set_zustand.
    me->zustand = im_st.
  ENDMETHOD.

  METHOD pay.
  ENDMETHOD.
ENDCLASS.


**********************************************************************
* UNTERKLASSE Teilrechnungen
**********************************************************************

CLASS lcl_teil DEFINITION INHERITING FROM lcl_rechnung.
  PUBLIC SECTION.

    METHODS: pay REDEFINITION.

ENDCLASS.


CLASS lcl_teil IMPLEMENTATION.
  METHOD pay.
    me->set_zustand( im_st = c_closed ).
    WRITE:/ |Teilrechnung beglichen.|.
  ENDMETHOD.
ENDCLASS.




**********************************************************************
* UNTERKLASSE Abschlagsrechnungen
**********************************************************************
CLASS lcl_abschlag DEFINITION INHERITING FROM lcl_rechnung.
  PUBLIC SECTION.

    METHODS: pay REDEFINITION.

ENDCLASS.


CLASS lcl_abschlag IMPLEMENTATION.
  METHOD pay.
    me->set_zustand( im_st = c_closed ).
    WRITE:/ |Abschlagsrechnung beglichen.|.
  ENDMETHOD.
ENDCLASS.



**********************************************************************
* AUFRUF
**********************************************************************

START-OF-SELECTION.


  DATA lo_teil TYPE REF TO lcl_teil.
  DATA lo_ab TYPE REF TO lcl_abschlag.

  SELECTION-SCREEN BEGIN OF BLOCK b1.
    PARAMETERS p_teil RADIOBUTTON GROUP r1.
    PARAMETERS p_ab RADIOBUTTON GROUP r1.
  SELECTION-SCREEN END OF BLOCK b1.




  IF p_teil EQ abap_true.
    lo_teil = NEW lcl_teil( ).

    lo_teil->pay( ).

  ELSE. "p_ab
    lo_ab = NEW lcl_abschlag( ).

    lo_ab->pay( ).
  ENDIF.
