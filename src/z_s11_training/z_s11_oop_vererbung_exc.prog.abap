*&---------------------------------------------------------------------*
*& Report Z_S11_OOP_VERERBUNG_EXC
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s11_oop_vererbung_exc.

CLASS lcl_rechnung DEFINITION.
  PUBLIC SECTION.
    METHODS : constructor IMPORTING im_zustand_const TYPE i.
    METHODS: pay.
    METHODS : set_zustand IMPORTING im_zustand TYPE i.
    METHODS : get_zustand RETURNING VALUE(re_zustand) TYPE i.

  PROTECTED SECTION.
    CONSTANTS : c_pending TYPE i VALUE 0.
    CONSTANTS : c_open TYPE i VALUE 1.
    CONSTANTS : c_closed TYPE i VALUE 2.

    DATA zustand TYPE i VALUE c_open.
ENDCLASS.

CLASS lcl_rechnung IMPLEMENTATION.
  METHOD constructor.
    me->set_zustand( im_zustand = im_zustand_const ). "um Zustand pending zu setzen
  ENDMETHOD.
  METHOD pay.
    me->zustand = c_open.
    WRITE : |Rechnung wurde bezahlt.|.
  ENDMETHOD.

  METHOD set_zustand. "fills the protected variable(zustand) durch importing parameter
    me->zustand = im_zustand.
  ENDMETHOD.
  METHOD get_zustand.
    re_zustand = me->zustand.
  ENDMETHOD.
ENDCLASS.

*********  unterklasse*****

CLASS lcl_teil DEFINITION INHERITING FROM lcl_rechnung.
  PUBLIC SECTION.
    METHODS: pay REDEFINITION.
ENDCLASS.

CLASS lcl_teil IMPLEMENTATION.
  METHOD pay.
*    me->set_zustand( im_zustand = c_closed ).
    WRITE : |Teil-Rechnung wurde pending.|.
  ENDMETHOD.
ENDCLASS.

*        *********  unterklasse abschlagrechnung*****

CLASS lcl_abschlag DEFINITION INHERITING FROM lcl_rechnung.
  PUBLIC SECTION.
    METHODS: pay REDEFINITION.
ENDCLASS.

CLASS lcl_abschlag IMPLEMENTATION.
  METHOD pay.
    me->set_zustand( im_zustand = c_open ).
    WRITE : |Abschlagrechnung- wurde nicht bezahlt.|.
  ENDMETHOD.
ENDCLASS.

****************************   aufruf   ********

START-OF-SELECTION.

  DATA lo_rechnung TYPE REF TO lcl_rechnung.
  DATA lo_teil TYPE REF TO lcl_teil.
  DATA lo_abschlag TYPE REF TO lcl_abschlag.

  CREATE OBJECT lo_rechnung EXPORTING im_zustand_const = 0. "pending
  CREATE OBJECT lo_abschlag EXPORTING im_zustand_const = 1. "closed
  CREATE OBJECT lo_teil EXPORTING im_zustand_const = 2. "paid


  lo_rechnung->pay( ).
  WRITE: |Rechnung status : { lo_rechnung->get_zustand( ) }|.
  ULINE.

  lo_abschlag->pay( ).
  WRITE: |Rechnung status : { lo_abschlag->get_zustand( ) }|.
  ULINE.
  lo_teil->pay( ).
  WRITE: |Rechnung status : { lo_teil->get_zustand( ) }|.
