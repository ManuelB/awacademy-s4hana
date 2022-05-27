*&---------------------------------------------------------------------*
*& Report ZS12_VERERBUNG_UEBUNG
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zs12_vererbung_uebung.


************************************************************************
*Oberklasse
************************************************************************
CLASS lcl_Rechnung DEFINITION.
  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING
          im_st_const TYPE i.
    METHODS:
*      closed,
      pay,
        "EXPORTING
          "ex_pay TYPE string,
      set_status
        IMPORTING
          im_st TYPE i,
      get_status
        RETURNING VALUE(re_st) TYPE string.

  PROTECTED SECTION.
    CONSTANTS:
      c_open    TYPE i VALUE 1,
      c_pending TYPE i VALUE 0,
      c_closed  TYPE i VALUE 2.
    DATA: status TYPE i.

ENDCLASS.

CLASS lcl_rechnung IMPLEMENTATION.
  METHOD constructor.
    me->set_status( im_st = im_st_const ).
  ENDMETHOD.
*  METHOD closed.
*    me->set_status( im_st = c_closed ).
*    WRITE: 'Alle Rechnungen sind beglichen.'.
*  ENDMETHOD.
  METHOD pay.
    me->set_status( im_st = c_open ).
*    WRITE: 'Es stehen noch Rechnungen zur Bezahlung aus.'.
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
CLASS lcl_teil DEFINITION INHERITING FROM lcl_rechnung.
  PUBLIC SECTION.
    METHODS: pay REDEFINITION.
      "closed REDEFINITION.
ENDCLASS.

CLASS lcl_teil IMPLEMENTATION.
*  METHOD closed.
*    me->pay( ).
*    me->set_status( im_st = c_pending ).
*    WRITE: 'Einige Teilrechnungen müssen noch bezahlt werden.'.
*  ENDMETHOD.
  METHOD pay.
      me->set_status( im_st = c_closed ).
    WRITE: 'Alle Teilrechnungen sind beglichen.'.
  ENDMETHOD.
ENDCLASS.

************************************************************************
*Unterklasse
************************************************************************
CLASS lcl_absch DEFINITION INHERITING FROM lcl_rechnung.
  PUBLIC SECTION.
    METHODS: pay REDEFINITION.
      "closed REDEFINITION.
ENDCLASS.

CLASS lcl_absch IMPLEMENTATION.
*  METHOD closed.
*    me->pay( ).
*    me->set_status( im_st = c_closed ).
*    "WRITE: 'Alle Rechnungen sind bezahlt.'.
*  ENDMETHOD.
  METHOD pay.
      me->set_status( im_st = c_closed ).
      Write: 'Alle abgeschlossenen Rechnungen sind beglichen.'.
    "WRITE: 'Die Rechnungen wurden bezahlt.'.
  ENDMETHOD.
ENDCLASS.

************************************************************************
*Aufruf
************************************************************************
START-OF-SELECTION.
  DATA:
    lo_rechnung TYPE REF TO lcl_rechnung,
    lo_teil     TYPE REF TO lcl_rechnung,
    lo_absch    TYPE REF TO lcl_rechnung.

  lo_rechnung = NEW lcl_rechnung( im_st_const = 0 ).
  lo_teil = NEW lcl_teil( im_st_const = 0 ).
  lo_absch = NEW lcl_absch( im_st_const = 0 ).

  lo_rechnung->pay( ).
  WRITE: |Rechnungsstatus: { lo_rechnung->get_status( ) }|.
  ULINE.

  lo_teil->pay( ).
  WRITE: |Teilrechnungsstatus: { lo_teil->get_status( ) }|.
  ULINE.

  lo_absch->pay( ).
  WRITE: |Rechnungen beglichen: { lo_absch->get_status( ) }|.
