*&---------------------------------------------------------------------*
*& Report Z_S05_VERERBUNG
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s05_vererbung.


*************************************************************************
*OBERKLASSE
************************************************************************

CLASS lcl_beleg DEFINITION.
  PUBLIC SECTION.
    METHODS: constructor IMPORTING im_st_const TYPE c.
    METHODS: close.
    METHODS: set_status IMPORTING im_st TYPE c. " importing parameter
    METHODS: get_status RETURNING VALUE(re_st) TYPE string. " importing parameter

  PROTECTED SECTION.
    CONSTANTS: c_open TYPE c VALUE 'O'.
    CONSTANTS: c_pending TYPE c VALUE 'P'.
    CONSTANTS: c_closed TYPE c VALUE 'C'.

*  PRivate SECTION.
    DATA: status TYPE c VALUE c_open.


ENDCLASS.

CLASS lcl_beleg IMPLEMENTATION.

  METHOD constructor.
    me->set_status( im_st = im_st_const ).

  ENDMETHOD.

  METHOD close.
    me->set_status( im_st = c_closed ).
    WRITE: / |Beleg Wurde geschlossen|.

  ENDMETHOD.

  METHOD set_status.
    me->status = im_st.

  ENDMETHOD.

  METHOD get_status.

    re_st = me->status.

  ENDMETHOD.

ENDCLASS.

*************************************************************************
*UNTERKLASSE GUTSCHRIFT
************************************************************************


CLASS lcl_gutschrift DEFINITION INHERITING FROM lcl_beleg.
  PUBLIC SECTION.
*POLYMORPHIE
METHODS: close REDEFINITION.
ENDCLASS.


CLASS lcl_gutschrift IMPLEMENTATION.
 METHOD close.
    me->set_status( im_st = c_closed ).
    WRITE: / |Gutschrift Wurde geschlossen|.
        ENDMETHOD.
ENDCLASS.

************************************************************************
*UNTERKLASSE RECHNUNG
************************************************************************

CLASS lcl_rechnung DEFINITION INHERITING FROM lcl_beleg.
  PUBLIC SECTION.
METHODS: close REDEFINITION.

    PRIVATE SECTION.
    METHODS: pay.
ENDCLASS.
CLASS lcl_rechnung IMPLEMENTATION.
 METHOD close.
   me->pay( ).
    me->set_status( im_st = c_closed ).
    WRITE: / |Rechnung Wurde geschlossen|.

ENDMETHOD.

METHOD pay.
   WRITE: / |Rechnung Wurde bezahlt|.
  endmethod.

ENDCLASS.





*************************************************************************
*AUFRUF
************************************************************************


START-OF-SELECTION.

  DATA lo_beleg TYPE REF TO lcl_beleg.
  DATA lo_gutschrift TYPE REF TO lcl_gutschrift.
  DATA lo_rechnung TYPE REF TO lcl_rechnung .

  CREATE OBJECT lo_beleg
    EXPORTING
      im_st_const = 'P'.
  lo_gutschrift = NEW lcl_gutschrift( im_st_const = 'P' ).
  lo_rechnung  = NEW lcl_rechnung( im_st_const = 'P' ).

  lo_beleg->close( ).
  "lo_beleg->get_status( ).
  WRITE: |BELEG: { lo_beleg->get_status( ) }|.

*DATA(lv_test) = lo_beleg->get_status( ).

ULINE.

  lo_gutschrift->close( ).
  lo_gutschrift->get_status( ).
WRITE: |GUTSCHRIFT: { lo_gutschrift->get_status( ) }|.


ULINE.

  lo_rechnung->close( ).
  lo_rechnung->get_status( ).
  WRITE: |RECHNUNG: { lo_rechnung->get_status( ) }|.
