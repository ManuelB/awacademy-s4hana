*&---------------------------------------------------------------------*
*& Report ZS12_INTERFACES
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zs12_interfaces.

INTERFACE lif_zahlung.
  METHODS pay IMPORTING im_value TYPE i.
  METHODS pay EXPORTING im_value TYPE i.

ENDINTERFACE.


CLASS lcl_beleg DEFINITION.
  PUBLIC SECTION.
    INTERFACES lif_zahlung.

ENDCLASS.
*
*CLASS lcl_beleg IMPLEMENTATION.
*  METHOD lif_zahlung~pay.
*    WRITE: / |Zahlung des Beleges wurde durchgeführt. Betrag: { im_value }|.
*  ENDMETHOD.
*ENDCLASS.
*
*CLASS lcl_sonderbeleg DEFINITION.
*  PUBLIC SECTION.
*    INTERFACES lif_zahlung.
*ENDCLASS.
*
*CLASS lcl_sonderbeleg IMPLEMENTATION.
*  METHOD lif_zahlung~pay.
*    WRITE: / |Alle Sonderbelege wurden bezahlt. Betrag: { im_value }|.
*  ENDMETHOD.
*ENDCLASS.
*
*START-OF-SELECTION.
*
*  DATA lo_beleg TYPE REF TO lcl_beleg.
*  DATA lo_szahlung TYPE REF TO lcl_sonderbeleg.
*
*
*  lo_beleg = NEW lcl_beleg( )."Instanzierung
*
*  lo_beleg->lif_zahlung~pay( im_value = 100 ).
*
*  lo_szahlung = NEW lcl_sonderbeleg( ). "Instanzierung
*  lo_szahlung->lif_zahlung~pay( im_value = 200 ). "Aufruf der Methode
*EXPORTING Parameter-Fall
*  lo_szahlung->lif_zahlung~pay(
*  Importing
*    im_value = lv_irgendwas ). "Ich importiere aus lv_irgendwas den Wert dne die pay-Methode dann Exportiert.


******************************************************************************************************************
*Übung
******************************************************************************************************************

INTERFACE lif_buchung.
  METHODS verbuchen IMPORTING im_st TYPE c.
ENDINTERFACE.


CLASS lcl_Rechnung DEFINITION.
  PUBLIC SECTION.
    METHODS:
      bezahlen,
      set_status
        IMPORTING
          im_st TYPE c,
      get_status
        RETURNING VALUE(re_st) TYPE string.
    INTERFACES lif_buchung.
      PROTECTED SECTION.
    CONSTANTS:
      c_bezahlt      TYPE c VALUE 'b',
      c_abschlag     TYPE c VALUE 'a',
      c_gutschrift   TYPE c VALUE 'g',
      c_undefiniert  TYPE c VALUE 'u'.

    DATA status TYPE c .

ENDCLASS.

CLASS lcl_Rechnung IMPLEMENTATION.
  METHOD lif_buchung~verbuchen.
    me->bezahlen( ).
    WRITE: / |Die Zahlung einer Rechnung steht noch aus! Status: { im_st }|.
  ENDMETHOD.
    METHOD bezahlen.
    me->set_status( im_st = c_undefiniert ).
  ENDMETHOD.
ENDCLASS.

CLASS lcl_Abschlag DEFINITION INHERITING FROM lcl_rechnung.
  PUBLIC SECTION.
    METHODS:

    bezahlen REDEFINITION.
    private section.
*    abschlag.

ENDCLASS.

CLASS lcl_abschlag IMPLEMENTATION.
*  METHOD lif_buchung~verbuchen.
*    me->bezahlen( ).
*    WRITE: / |Die Zahlung eines Abschlages steht noch aus! Status: { im_st }|.
*  ENDMETHOD.
*  method abschlag.
*    me->set_status( im_st = c_abschlag ).
*    endmethod.
    METHOD bezahlen.
    me->set_status( im_st = c_abschlag ).
  ENDMETHOD.
ENDCLASS.

CLASS lcl_gutschrift DEFINITION.
  public section.

  Methods:
  gutschrift,
  set_status
        IMPORTING
          im_st TYPE c,
      get_status
        RETURNING VALUE(re_st) TYPE string.
  PRivate SECTION.
    CONSTANTS:
      c_bezahlt    TYPE c VALUE 'b',
      c_abschlag   TYPE c VALUE 'a',
      c_gutschrift TYPE c VALUE 'g',
      c_ausstehend TYPE c VALUE 'o'.

    DATA status TYPE c .
ENDCLASS.

CLASS lcl_gutschrift IMPLEMENTATION.
  METHOD gutschrift.
    me->set_status( im_st = c_gutschrift ).
  ENDMETHOD.
*  METHOD lif_buchung~verbuchen.
*    WRITE: 'Ihnen wurde der Betrag gutgeschrieben:' { im_st }.
*  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.

  DATA lo_rechnung TYPE REF TO lcl_rechnung.
  DATA lo_abschlag TYPE REF TO lcl_abschlag.
  DATA lo_gutschrift TYPE REF TO lcl_gutschrift.


  lo_rechnung = NEW lcl_rechnung( )."Instanzierung
  lo_abschlag = NEW lcl_abschlag( )."Instanzierung
  lo_gutschrift = NEW lcl_gutschrift( )."Instanzierung


  lo_rechnung->lif_buchung~verbuchen( im_st ).
  lo_abschlag->lif_buchung~verbuchen( im_st ).



**********************************************************************
* INTERFACE Buchung
**********************************************************************

INTERFACE lif_buchung.
  METHODS verbuchen RETURNING VALUE(re_erfolg) TYPE abap_bool.
ENDINTERFACE.

**********************************************************************
* OBERKLASSE Rechnung
**********************************************************************

CLASS lcl_rechnung DEFINITION ABSTRACT.
  PUBLIC SECTION.
    INTERFACES lif_buchung.

    METHODS: constructor.

  PROTECTED SECTION.
    METHODS:
      bezahlen,
      set_status IMPORTING im_st TYPE c,
      get_status EXPORTING ex_st TYPE c.


    CONSTANTS: c_open    TYPE c VALUE 'O',
               c_pending TYPE c VALUE 'P',
               c_closed  TYPE c VALUE 'C',
               c_unknown TYPE c VALUE 'U'.

    DATA: status TYPE c VALUE 'U'.

ENDCLASS.

CLASS lcl_rechnung IMPLEMENTATION.
  METHOD lif_buchung~verbuchen.
    me->bezahlen( ).
    me->set_status( im_st = c_closed ).
    re_erfolg = abap_true.
  ENDMETHOD.

  METHOD constructor.
    me->set_status( im_st = c_unknown ).
  ENDMETHOD.

  METHOD bezahlen.
    WRITE: |Oberklasse nicht Instanzierbar. Bitte eigene Methode implementieren|.
  ENDMETHOD.

  METHOD set_status.
    me->status = im_st.
  ENDMETHOD.

  METHOD get_status.
    ex_st = me->status.
  ENDMETHOD.

ENDCLASS.

**********************************************************************
* UNTERKLASSE Abschlag
**********************************************************************

CLASS lcl_abschlag DEFINITION INHERITING FROM lcl_rechnung.
  PROTECTED SECTION.
    METHODS bezahlen REDEFINITION.
ENDCLASS.

CLASS lcl_abschlag IMPLEMENTATION.
  METHOD bezahlen.
    WRITE: / | Abschlagsrechnung wurde bezahlt.|.
  ENDMETHOD.
ENDCLASS.

**********************************************************************
* UNABHÄNGIGE KLASSE GUTSCHRIFT
**********************************************************************

CLASS lcl_gutschrift DEFINITION.
  PUBLIC SECTION.
    INTERFACES lif_buchung.
  PRIVATE SECTION.
    METHODS: gutschrift.
ENDCLASS.

CLASS lcl_gutschrift IMPLEMENTATION.
  METHOD lif_buchung~verbuchen.
    me->gutschrift( ).
    re_erfolg = abap_true.
  ENDMETHOD.

  METHOD gutschrift.
    WRITE: / |Die Gutschrift wurde verbucht.|.
  ENDMETHOD.
ENDCLASS.

**********************************************************************
**********************************************************************
**********************************************************************

START-OF-SELECTION.

DATA lo_gutschrift TYPE REF TO lcl_gutschrift.
DATA lo_abschlag TYPE REF TO lcl_abschlag.

lo_gutschrift = new lcl_gutschrift( ).
lo_abschlag = new lcl_abschlag( ).

ULINE.
lo_gutschrift->lif_buchung~verbuchen( ).
ULINE.
lo_abschlag->lif_buchung~verbuchen( ).
