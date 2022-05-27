*&---------------------------------------------------------------------*
*& Report Z_S09_AUFGABE_OO_ROBIN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S09_AUFGABE_OO_ROBIN.

CLASS lcl_rechnung DEFINITION.
  PUBLIC SECTION.

    METHODS: constructor IMPORTING im_zu_const TYPE c.
    METHODS: geschlossen.
    METHODS: set_zustand IMPORTING im_zu TYPE c.
    METHODS: get_zustand RETURNING VALUE(re_zu) TYPE string.


  PROTECTED SECTION.

    CONSTANTS: c_offen TYPE c VALUE 'O (Open)'.
    CONSTANTS: c_pending TYPE c VALUE 'P (Pending)'.
    CONSTANTS: c_geschlossen TYPE c VALUE 'C (Closed)'.


    DATA zustand TYPE c VALUE c_offen.

  PRIVATE SECTION.

ENDCLASS.

CLASS lcl_rechnung IMPLEMENTATION.
  METHOD constructor.
    me->set_zustand( im_zu = im_zu_const ).
  ENDMETHOD.


  METHOD geschlossen.
    me->set_zustand( im_zu = c_geschlossen ).
    WRITE: |Rechnung wurde geschlossen.|.
  ENDMETHOD.

  METHOD set_zustand.
    me->zustand = im_zu.
  ENDMETHOD.

  METHOD get_zustand.
    re_zu = me->zustand.
  ENDMETHOD.

ENDCLASS.



*****************************
* UNTERKLASSE Teilrechnungen
*****************************
CLASS lcl_teil DEFINITION INHERITING FROM lcl_rechnung.
  PUBLIC SECTION.
    METHODS geschlossen REDEFINITION.
ENDCLASS.

CLASS lcl_teil IMPLEMENTATION.
  METHOD geschlossen.
    me->set_zustand( im_zu = c_geschlossen ).
    WRITE:|Teilrechnung wurde geschlossen.|.
  ENDMETHOD.
ENDCLASS.


*****************************
* UNTERKLASSE Abschlagsrechnung
*****************************
CLASS lcl_absch DEFINITION INHERITING FROM lcl_teil.
    PUBLIC SECTION.
    METHODS geschlossen REDEFINITION.

    "PRIVATE SECTION.
    METHODS pay REDEFINITION.

    WRITE: / |Teilrechnung wurde bezahlt.|.

    ENDMETHOD.

ENDCLASS.

CLASS lcl_absch IMPLEMENTATION.
    METHOD geschlossen.
      me->pay( ).
    me->set_zustand( im_zu = c_geschlossen ).
    WRITE:|Abschlagsrechnung wurde geschlossen.|.
    ENDMETHOD.

    METHOD: pay.
      WRITE: / |Abschlagsrechnung wurde bezahlt.|.
      ENDMETHOD.

ENDCLASS.


*****************************
* AUFRUF
*****************************


START-OF-SELECTION.

  DATA lo_rechnung TYPE REF TO lcl_rechnung.
  DATA lo_teil TYPE REF TO lcl_tel.
  DATA lo_absch TYPE REF TO lcl_absch.


  CREATE OBJECT lo_rechnung
    EXPORTING
      im_zu_const = 'P'.


  lo_teil = NEW lcl_teil( im_zu_const = 'P' ).
  lo_rechnung = NEW lcl_rechnung( im_zu_const = 'P' ).



  lo_rechnung->geschlossen( ).
  WRITE: |Rechnung Zustand: { lo_beleg->get_status( ) }|.

  ULINE.

  lo_teil->geschlossen( ).
  WRITE: |Rechnung Zustand: { lo_teil->get_zustand( ) }|.

  ULINE.

  lo_absch->geschlossen( ).
  WRITE: | Rechnung Zustand: { lo_rechnung->get_zustand( ) }|.
