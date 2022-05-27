*&---------------------------------------------------------------------*
*& Report Z_S04_OO_VERERBUNG
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s04_oo_vererbung.


**********************************************************************
*Oberklasse

CLASS lcl_beleg DEFINITION.

  PUBLIC SECTION.

    METHODS: constructor IMPORTING im_st_const TYPE c.

    METHODS:
      close,
      set_status IMPORTING im_st TYPE c,
      get_status RETURNING VALUE(re_st) TYPE string.

  PROTECTED SECTION.
    CONSTANTS: c_open    TYPE c VALUE 'O',
               c_pending TYPE c VALUE 'P',
               c_closed  TYPE c VALUE 'C'.


    DATA:     status TYPE c VALUE c_open.

ENDCLASS.


CLASS lcl_beleg IMPLEMENTATION.
  METHOD constructor.
    me->set_status( im_st = im_st_const ).
  ENDMETHOD.

  METHOD close.
    me->set_status( im_st = c_closed ).
    WRITE: / 'Beleg wurde geschlossen -'.
  ENDMETHOD.

  METHOD set_status.
    me->status = im_st.
  ENDMETHOD.

  METHOD get_status.
    re_st = me->status.
  ENDMETHOD.

ENDCLASS.



**********************************************************************
*Unterklasse Gutschrift

CLASS lcl_gutschrift DEFINITION INHERITING FROM lcl_beleg.
  PUBLIC SECTION.
    METHODS: close REDEFINITION. "Polymorphie durch REDEFINITION von Methoden.
ENDCLASS.

CLASS lcl_gutschrift IMPLEMENTATION.
  METHOD close.
    me->set_status( im_st = c_closed ).
    WRITE: / 'Gutschrift wurde geschlossen -'.
  ENDMETHOD.
ENDCLASS.



**********************************************************************
*Unterklasse Rechnung

CLASS lcl_rechnung DEFINITION INHERITING FROM lcl_beleg.
  PUBLIC SECTION.
    METHODS: close REDEFINITION. "Polymorphie durch REDEFINITION von Methoden.

  PRIVATE SECTION.
    METHODS: pay.
ENDCLASS.

CLASS lcl_rechnung IMPLEMENTATION.
  METHOD close.
    me->pay( ).
    me->set_status( im_st = c_closed ).
    WRITE: / 'Rechnung wurde geschlossen -'.
  ENDMETHOD.

  METHOD pay.
    WRITE: / 'Rechnung wurde bezahlt.'.
  ENDMETHOD.

ENDCLASS.



**********************************************************************
*Aufruf

START-OF-SELECTION.

  DATA: lo_beleg      TYPE REF TO lcl_beleg,
        lo_gutschrift TYPE REF TO lcl_gutschrift,
        lo_rechnung   TYPE REF TO lcl_rechnung.



  "Erzeugung eines Objekts (Instanziierung)

  CREATE OBJECT lo_beleg EXPORTING im_st_const = 'P'.   "Alte SChreibweise

  lo_gutschrift = NEW lcl_gutschrift( im_st_const = 'P' ).   "Neue Schreibweise

  lo_rechnung = NEW lcl_rechnung( im_st_const = 'P' ).




  lo_beleg->close( ). "CALL METHOD davor ist mittlerweile überflüssig
  WRITE: 'Beleg', lo_beleg->get_status( ).

  ULINE.

  lo_gutschrift->close( ).
  WRITE: 'Gutschrift', lo_gutschrift->get_status( ).

  ULINE.

  lo_rechnung->close( ).
  WRITE: 'Rechnung', lo_rechnung->get_status( ).
