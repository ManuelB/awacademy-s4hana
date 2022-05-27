*&---------------------------------------------------------------------*
*& Report Z_S02_VERERBUNG_1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s02_vererbung_1.

********************************************
***** Oberklasse
********************************************

CLASS lcl_beleg DEFINITION.
  PUBLIC SECTION.
    METHODS: constructor IMPORTING im_st_const TYPE c.                   " wird als erste aufgeführt. Muss ausgeführt werden (es seid denn optional)
    METHODS: close.                         " Eine Methode, die einen Beleg abschliessen soll
    METHODS: set_status IMPORTING im_st TYPE c.
    METHODS: get_status RETURNING VALUE(re_st) TYPE string.



  PROTECTED SECTION.                          " Die Sachen in der Privatesection werden mitgeerbt, aber man kann sie nicht aufrufen. Darum Protected Section.
    CONSTANTS: c_open    TYPE c VALUE 'O'.
    CONSTANTS: c_pending TYPE c VALUE 'P'.
    CONSTANTS: c_closed  TYPE c VALUE 'C'.
    DATA status TYPE c VALUE c_open.
ENDCLASS.


CLASS lcl_beleg IMPLEMENTATION.
  METHOD constructor.
    me->set_status( im_st = im_st_const ).
  ENDMETHOD.

  METHOD close.
    me->set_status( im_st = c_closed ).
    WRITE: | Beleg wurde gefuckingschlossen. |.
  ENDMETHOD.

  METHOD set_status.
    me->status = im_st.
  ENDMETHOD.

  METHOD get_status.
    re_st = me->status.
  ENDMETHOD.

ENDCLASS.



********************************************
***** Unterklasse Gutschrift
********************************************

CLASS lcl_gutschrift DEFINITION INHERITING FROM lcl_beleg.   "Vererbung
  PUBLIC SECTION.
    METHODS: close REDEFINITION.                              " Redefinition = Anpassen der Muttermethode = Polymorphie
ENDCLASS.

CLASS lcl_gutschrift IMPLEMENTATION.
  METHOD close.
*    me->set_status( im_st = c_closed ).
    WRITE: | Gutschrift wurde gefuckingschlossen. |.
  ENDMETHOD.
ENDCLASS.


********************************************
***** Unterklasse Rechnung
********************************************

CLASS lcl_rechnung DEFINITION INHERITING FROM lcl_beleg.   "Vererbung
  PUBLIC SECTION.
    METHODS: close REDEFINITION.
  PRIVATE SECTION.
    METHODS: pay.
ENDCLASS.

CLASS lcl_rechnung IMPLEMENTATION.
  METHOD close.
    me->pay( ).
    me->set_status( im_st = c_closed ).
    WRITE: | Rechnung wurde gefuckingschlossen. |.
  ENDMETHOD.
  METHOD pay.
    WRITE: | Rechnung wurde bezahlt. |.
  ENDMETHOD.
ENDCLASS.

********************************************
***** Aufruf
********************************************
START-OF-SELECTION.

  DATA lo_beleg TYPE REF TO lcl_beleg.
  DATA lo_gutschrift TYPE REF TO lcl_gutschrift.
  DATA lo_rechnung TYPE REF TO lcl_rechnung.

  CREATE OBJECT lo_beleg
    EXPORTING
      im_st_const = 'P'.                                      " Alter Shit


*  lo_beleg = NEW lcl_beleg( im_st_const = 'P' ).
  lo_gutschrift = NEW lcl_gutschrift( im_st_const = 'P' ).          " Neuer Shit
  lo_rechnung = NEW lcl_rechnung( im_st_const = 'P' ).          " Neuer Shit




  lo_beleg->close( ).                               " CALL METHOD lo_beleg->close( ).    <-- alte Syntax
  WRITE: | Belegstatus: { lo_beleg->get_status( ) }|.
  ULINE.
  lo_gutschrift->close( ).
  WRITE: | Belegstatus: { lo_gutschrift->get_status( ) }|.
  ULINE.
  lo_rechnung->close( ).
  WRITE: | Belegstatus: { lo_rechnung->get_status( ) }|.
