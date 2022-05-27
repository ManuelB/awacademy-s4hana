*&---------------------------------------------------------------------*
*& Report Z_S11_OOP_VERERBUNG
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s11_oop_vererbung.

*****************************************************
* OBERKLASSE
*****************************************************

CLASS lcl_beleg DEFINITION.
  PUBLIC SECTION.
    METHODS: constructor IMPORTING im_st_const TYPE c.
    METHODS: close.
    METHODS: set_status IMPORTING im_st TYPE c.
    METHODS: get_status RETURNING VALUE(re_st) TYPE string.


  PROTECTED SECTION.
    CONSTANTS:  c_closed TYPE c VALUE 'c'.
    CONSTANTS:  c_open TYPE c VALUE 'o'.
    CONSTANTS:  c_pending TYPE c VALUE 'p'.

    DATA status TYPE c VALUE c_open.
  PRIVATE SECTION.

ENDCLASS.

CLASS lcl_beleg IMPLEMENTATION.

  METHOD constructor.
    me->set_status( im_st = im_st_const ).
  ENDMETHOD.
  METHOD close.
    me->status = c_closed. "me zeigt die aktuelle instanz
    WRITE :|Beleg wurde geschlossen|.
  ENDMETHOD.

  METHOD set_status.
    me->status = im_st.
  ENDMETHOD.

  METHOD get_status.
    re_st = me->status.
  ENDMETHOD.
ENDCLASS.



******************************************************
* UNTERKLASSE gutschrift
*****************************************************

*polymorphie durch redefinition von Methoden
CLASS lcl_gutschrift DEFINITION INHERITING FROM lcl_beleg.
  PUBLIC SECTION.
    METHODS: close REDEFINITION.

ENDCLASS.

CLASS lcl_gutschrift IMPLEMENTATION.

  METHOD close.
*    me->status = c_closed. "me zeigt die aktuelle instanz
    me->set_status( im_st = c_closed ).
    WRITE :|Gutschrift wurde geschlossen|. " nach dem method redefinition kommt der Probleme `Field c_closed is unknown`
  ENDMETHOD.

ENDCLASS.

******************************************************
* UNTERKLASSE Rechnung
*****************************************************
CLASS lcl_rechnung DEFINITION INHERITING FROM lcl_beleg.
  PUBLIC SECTION.
    METHODS : close REDEFINITION.
    METHODS : pay.
ENDCLASS.

CLASS lcl_rechnung IMPLEMENTATION.
  METHOD close.

    me->pay( ). "self referenced me ruft der method pay of the same class
    me->set_status( im_st = c_closed ). "my status is a variable , which I set to c_closed
    WRITE :|Rechnung wurde geschlossen|.

  ENDMETHOD.

  METHOD pay.
    WRITE:/ |BILL PAID|.
  ENDMETHOD.
ENDCLASS.

******************************************************
* AUFRUF
*****************************************************

START-OF-SELECTION.
  DATA lo_beleg TYPE REF TO lcl_beleg.
  DATA lo_rechnung TYPE REF TO lcl_beleg.

  DATA lo_gutschrift TYPE REF TO lcl_gutschrift.
  CREATE OBJECT lo_beleg EXPORTING im_st_const = 'p'. "instance creation
*
*  lo_beleg = NEW lcl_beleg( im_st = 'p').
  lo_gutschrift = NEW lcl_gutschrift( im_st_const = 'o').
  lo_rechnung = NEW lcl_rechnung( im_st_const = 'p' ).

  lo_beleg->close( ).
  WRITE: |Beleg Status : { lo_beleg->get_status( ) }|.
  ULINE.
  call method lo_gutschrift->close( ).
*  call method close( ).
  lo_gutschrift->get_status( ).
  ULINE.
  lo_rechnung->close( ).
  lo_rechnung->get_status( ).
