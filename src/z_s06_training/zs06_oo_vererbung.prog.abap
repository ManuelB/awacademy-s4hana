*&---------------------------------------------------------------------*
*& Report ZS06_OO_VERERBUNG
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zs06_oo_vererbung.

**********************************************************************
"OBERKLASSE
**********************************************************************
CLASS lcl_beleg DEFINITION.

  PUBLIC SECTION.

    METHODS: constructor IMPORTING im_st_const TYPE c.                                           "called first
    METHODS: close.
    METHODS: set_status IMPORTING im_st TYPE c.
    METHODS: get_status RETURNING VALUE(re_st) TYPE string.


  PROTECTED SECTION.
    " is like private but can be used with (REDEFINE)
    CONSTANTS: c_open TYPE c VALUE 'o'.
    CONSTANTS: c_pending TYPE c VALUE 'p'.
    CONSTANTS: c_close TYPE c VALUE 'c'.


    DATA status TYPE c VALUE c_open.                                                              "status: open, pending, close (me = status)

  PRIVATE SECTION.                                                                                "everathing in the private section cann only be used here in the upper class

ENDCLASS.


CLASS lcl_beleg IMPLEMENTATION.

  "the close method and what it should do
  METHOD constructor.
    me->set_status( im_st = im_st_const ).
  ENDMETHOD.


  METHOD close.
    me->set_status( im_st = c_close ).
    WRITE:|Beleg wurde geschlossen|.
  ENDMETHOD.


  METHOD set_status.
    me->status = im_st.
  ENDMETHOD.


  METHOD get_status.
    re_st = me->status.
  ENDMETHOD.


ENDCLASS.


**********************************************************************
"UNTERKLASSE GUTSCHRIFT
**********************************************************************
CLASS lcl_gutschrift DEFINITION INHERITING FROM lcl_beleg.
  PUBLIC SECTION.
    METHODS: close REDEFINITION.
ENDCLASS.


CLASS lcl_gutschrift IMPLEMENTATION.


  METHOD close.
    me->set_status( im_st = c_close ).
    WRITE:|Gutschrift wurde geschlossen|.
  ENDMETHOD.
ENDCLASS.


**********************************************************************
"UNTERKLASSE RECHNUNG
**********************************************************************
CLASS lcl_rechnung DEFINITION INHERITING FROM lcl_beleg.

  PUBLIC SECTION.
    METHODS: close REDEFINITION.
    METHODS pay.                                                                   "polymorphie durch redefinition von methoden
ENDCLASS.


CLASS lcl_rechnung IMPLEMENTATION.
  METHOD close.
    me->pay( ).
    me->set_status( im_st = c_close ).
    WRITE:|Rechnung wurde geschlossen|.
  ENDMETHOD.

  METHOD pay.
    WRITE:|Rechnung wurde Bezahlt|.
  ENDMETHOD.

ENDCLASS.


**********************************************************************
"AUFRUF
**********************************************************************
START-OF-SELECTION.

  DATA o_beleg TYPE REF TO lcl_beleg.
  DATA o_gutschrift TYPE REF TO lcl_gutschrift.
  DATA o_rechnung TYPE REF TO lcl_rechnung.

  CREATE OBJECT o_gutschrift EXPORTING im_st_const = 'P'.                                          "or the new way to write it is:  o_gutschrift = NEW lcl_gutschrift
  CREATE OBJECT o_beleg EXPORTING im_st_const = 'P'.                                               "or the new way to write it is:  o_beleg = NEW lcl_beleg
  CREATE OBJECT o_rechnung EXPORTING im_st_const = 'P'.                                            "or the new way to write it is:  o_beleg = NEW lcl_rechnung

  ULINE."*******************************************************************

  o_gutschrift->close( ).WRITE: |Beleg Status: { o_beleg->get_status( ) }|.                        "calling the CLASS and METHOD into action and with "->" the CLOSE method

  ULINE."*******************************************************************

  o_beleg->close( ).WRITE: |Beleg Status: { o_beleg->get_status( ) }|.

  ULINE."*******************************************************************

  o_rechnung->close( ).WRITE: |Beleg Status: { o_beleg->get_status( ) }|.

  ULINE."*******************************************************************
