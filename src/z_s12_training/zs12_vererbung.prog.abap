*&---------------------------------------------------------------------*
*& Report ZS12_VERERBUNG
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zs12_vererbung.


************************************************************************
*Oberklasse
************************************************************************
CLASS lcl_beleg DEFINITION.
  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING
          im_st_const TYPE c.
    METHODS:
      close,
      set_status
        IMPORTING
          im_st TYPE c,
      get_status
        RETURNING VALUE(re_st) TYPE string.

  PROTECTED SECTION. "alle erbenden Klassen können die Attribute verwenden
    CONSTANTS:
      c_open    TYPE c VALUE 'O',
      c_pending TYPE c VALUE 'P',
      c_closed  TYPE c VALUE 'C'.
    DATA status TYPE c VALUE c_open.
ENDCLASS.

CLASS lcl_beleg IMPLEMENTATION.
  METHOD constructor.
    me->set_status( im_st = im_st_const ).
  ENDMETHOD.

  METHOD close.
    me->set_status( im_st = c_closed ).
    WRITE: 'Der Beleg wurde geschlossen.'.
  ENDMETHOD.
  METHOD set_status.
    me->status = im_st.
  ENDMETHOD.
  METHOD get_status.
    re_st = me->status.
  ENDMETHOD.

ENDCLASS.
************************************************************************
*Unterklasse
************************************************************************
CLASS lcl_gutschrift DEFINITION INHERITING FROM lcl_beleg.
  PUBLIC SECTION.

*Polymorphie durch redefinition der Methoden
    METHODS: close REDEFINITION. "redefinierte Methoden können keine Methoden aus der Oberklasse nutzen
ENDCLASS.

CLASS lcl_gutschrift IMPLEMENTATION.
  METHOD close.
    me->set_status( im_st = c_closed ).
    WRITE: 'Die Gutschrift wurde geschlossen.'.
  ENDMETHOD.
ENDCLASS.

CLASS lcl_rechnung DEFINITION INHERITING FROM lcl_beleg.
  PUBLIC SECTION.

*Polymorphie durch redefinition der Methoden
    METHODS: close REDEFINITION.
  PRIVATE SECTION.
    METHODS: pay.
ENDCLASS.

CLASS lcl_rechnung IMPLEMENTATION.
  METHOD close.
    me->pay( ).
    me->set_status( im_st = c_closed ).
    WRITE: 'Die Rechnung wurde geschlossen.'.
  ENDMETHOD.
  METHOD pay.
    WRITE: 'Rechnung wurde bezahlt.'.
  ENDMETHOD.
ENDCLASS.


************************************************************************
*Aufruf
************************************************************************
START-OF-SELECTION.
  DATA lo_beleg TYPE REF TO lcl_beleg.
  DATA lo_gutschrift TYPE REF TO lcl_beleg.
  DATA lo_rechnung TYPE REF TO lcl_beleg.

*Die Erzeugung eines Objektes
*create object lo_gutschrift.
*Neue Schreibweise:
  lo_beleg = NEW lcl_beleg( im_st_const = 'P' ).
  lo_gutschrift = NEW lcl_gutschrift( im_st_const = 'P' ).
  lo_rechnung = NEW lcl_gutschrift( im_st_const = 'P' ).

  lo_beleg->close( ).
  WRITE: |Beleg Status: { lo_beleg->get_status( ) }|.

  ULINE.
  lo_gutschrift->close( ).
  WRITE: |Gutschrift Status: { lo_gutschrift->get_status( ) }|.

  ULINE.
  lo_rechnung->close( ).
  WRITE: |Rechnungs Status: { lo_rechnung->get_status( ) }|.
