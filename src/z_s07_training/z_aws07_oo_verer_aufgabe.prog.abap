*&---------------------------------------------------------------------*
*& Report Z_AWS07_OO_VERERBUNG
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_aws07_oo_verer_aufgabe.

*OBERKLASSE

CLASS lcl_beleg DEFINITION.
  PUBLIC SECTION.
    METHODS: constructor IMPORTING im_st_const TYPE c.
    METHODS: close.
    METHODS: set_status IMPORTING im_st TYPE c.
    METHODS: get_status RETURNING VALUE(re_st) TYPE string.

  PROTECTED SECTION.
    CONSTANTS: c_open TYPE c VALUE 'O'.
    CONSTANTS: c_pending TYPE c VALUE 'P'.
    CONSTANTS: c_closed TYPE c VALUE 'C'.

    DATA status TYPE c VALUE c_open.
  PRIVATE SECTION.
ENDCLASS.

CLASS lcl_beleg IMPLEMENTATION.
  METHOD constructor.
    me->set_status( im_st = im_st_const ).
  ENDMETHOD.
  METHOD close.
    me->set_status( im_st = c_closed ).
    WRITE:|Beleg wurde geschlossen.|.
  ENDMETHOD.

  METHOD set_status.
    me->status = im_st.
  ENDMETHOD.

  METHOD get_status.
    re_st = me->status.
  ENDMETHOD.

ENDCLASS.

*UNTERKLASSE GUTSCHRIFT
CLASS lcl_gutschrift DEFINITION INHERITING FROM lcl_beleg.
  PUBLIC SECTION.
*  *polymorphie durch Redefinition von Methoden
    METHODS: close REDEFINITION.

ENDCLASS.
CLASS lcl_gutschrift IMPLEMENTATION.
  METHOD close.
    me->set_status( im_st = c_closed ).
    WRITE:|Gutschrift wurde geschlossen.|.
  ENDMETHOD.
ENDCLASS.

*UNTERKLASSE RECHNUNG
CLASS lcl_rechnung DEFINITION INHERITING FROM lcl_beleg.
  PUBLIC SECTION.
*polymorphie durch Redefinition von Methoden
    METHODS: close REDEFINITION.
  PRIVATE SECTION.
    METHODS: pay.
ENDCLASS.

CLASS lcl_rechnung IMPLEMENTATION.
  METHOD close.
    me->pay( ).
    me->set_status( im_st = c_closed ).
    WRITE:|Rechnung wurde geschlossen.|.
    ENDMETHOD.
    METHOD pay.
      WRITE: / |Rechnung wurde bezahlt.|.
      ENDMETHOD.

ENDCLASS.
*AUFRUF

START-OF-SELECTION.

  DATA lo_beleg TYPE REF TO lcl_beleg.
  DATA lo_gutschrift TYPE REF TO lcl_gutschrift.
  DATA lo_rechnung TYPE REF TO lcl_rechnung.


*ERZEUGUNG EINES OBJEKTS IN VERSCHIEDENE SCHREIBWEISE

  CREATE OBJECT lo_beleg EXPORTING im_st_const = 'P'.

*  lo_beleg = NEW lcl_beleg( im_st = 'P' ).
  lo_gutschrift = NEW lcl_gutschrift( im_st_const = 'P').
  lo_rechnung = NEW lcl_rechnung( im_st_const = 'P').

  lo_beleg->close( ).
  WRITE: |Beleg Status: { lo_beleg->get_status( ) }|.
  ULINE.
  lo_gutschrift->close( ).
  WRITE: |Gutschrift Status: { lo_gutschrift->get_status( ) }|.
  ULINE.
  lo_rechnung->close( ).
  WRITE: |Rechnung Status: { lo_rechnung->get_status( ) }|.
