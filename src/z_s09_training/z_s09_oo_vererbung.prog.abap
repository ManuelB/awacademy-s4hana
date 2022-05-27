*&---------------------------------------------------------------------*
*& Report Z_S09_OO_VERERBUNG
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s09_oo_vererbung.

*****************************
* OBERKLASSE
*****************************


CLASS lcl_beleg DEFINITION.
  PUBLIC SECTION.

    METHODS: constructor IMPORTING im_st_const TYPE c. "im_= importing parameter)
    METHODS: close.
    METHODS: set_status IMPORTING im_st TYPE c. " im_st = importing status"
    METHODS: get_status RETURNING VALUE(re_st) TYPE string. " re_st = returning status"


  PROTECTED SECTION.

    CONSTANTS: c_open TYPE c VALUE 'O (Open)'.   "c_ = constante"
    CONSTANTS: c_pending TYPE c VALUE 'P (Pending)'.
    CONSTANTS: c_closed TYPE c VALUE 'C (Closed)'.


    DATA status TYPE c VALUE c_open.

  PRIVATE SECTION.

ENDCLASS.


CLASS lcl_beleg IMPLEMENTATION.
  METHOD constructor.
    me->set_status( im_st = im_st_const ).
  ENDMETHOD.


  METHOD close.
    me->set_status( im_st = c_closed ).
    "me->status = c_closed. "me zeigt immer "wo man sich gerade befindet".
    WRITE: |Beleg wurde geschlossen.|.
  ENDMETHOD.

  METHOD set_status.
    me->status = im_st.
  ENDMETHOD.

  METHOD get_status.
    re_st = me->status.
  ENDMETHOD.

ENDCLASS.


*****************************
* UNTERKLASSE GUTSCHRIFT
*****************************
CLASS lcl_gutschrift DEFINITION INHERITING FROM lcl_beleg.
  PUBLIC SECTION.
    METHODS: close REDEFINITION. "Polymorphie durch Redefinition von Methoden."
ENDCLASS.

CLASS lcl_gutschrift IMPLEMENTATION.
  METHOD close.
    me->set_status( im_st = c_closed ).
    WRITE:|Gutschrift wurde geschlossen.|.
  ENDMETHOD.
ENDCLASS.


*****************************
* UNTERKLASSE RECHNUNG
*****************************
CLASS lcl_Rechnung DEFINITION INHERITING FROM lcl_beleg.
    PUBLIC SECTION.
    METHODS: close REDEFINITION. "Polymorphie durch Redefinition von Methoden."

    PRIVATE SECTION.
    METHODS: pay.
ENDCLASS.

CLASS lcl_rechnung IMPLEMENTATION.
    METHOD close.
      me->pay( ).
    me->set_status( im_st = c_closed ).
    WRITE:|Rechnung wurde geschlossen.|.
    ENDMETHOD.

    METHOD: pay.
      WRITE: / |Rechnung wurde bezahlt.|.
      ENDMETHOD.

ENDCLASS.


*****************************
* AUFRUF
*****************************


START-OF-SELECTION.

  DATA lo_beleg TYPE REF TO lcl_beleg.      "lo= lokal objekt, TYPE Referenz zu lokale klasse beleg"
  DATA lo_gutschrift TYPE REF TO lcl_gutschrift.
  DATA lo_rechnung TYPE REF TO lcl_rechnung.

* Die Erzeugung eines Objekts in verschiedener Schreibweise
  CREATE OBJECT lo_beleg
    EXPORTING
      im_st_const = 'P'.

  "lo_beleg = NEW lcl_beleg( im_st = 'P' ). " 'P' für pending.
  lo_gutschrift = NEW lcl_gutschrift( im_st_const = 'P' ).
  lo_rechnung = NEW lcl_rechnung( im_st_const = 'P' ).



  lo_beleg->close( ).
  WRITE: |Beleg Status: { lo_beleg->get_status( ) }|.

  ULINE.

  lo_gutschrift->close( ).
  WRITE: |Gutschrift Status: { lo_gutschrift->get_status( ) }|.

  ULINE.

  lo_rechnung->close( ).
  WRITE: | Rechnung Satus: { lo_rechnung->get_status( ) }|.
