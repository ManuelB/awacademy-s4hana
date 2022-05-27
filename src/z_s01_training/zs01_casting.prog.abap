*&---------------------------------------------------------------------*
*& Report Z_T04_OO_INTERFACES_AUFGABE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zs01_casting.

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
*  METHODS lif_buchung~verbuchen REDEFINITION.
    METHODS bezahlen REDEFINITION.
ENDCLASS.

CLASS lcl_abschlag IMPLEMENTATION.
  METHOD bezahlen.
    WRITE: / |Abschlagsrechnung wurde bezahlt.|.
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

WRITE: / |Rückgabewert:  { lo_gutschrift->lif_buchung~verbuchen( ) }|.
ULINE.
WRITE: / |Rückgabewert:  { lo_abschlag->lif_buchung~verbuchen( ) }|.


**********************************************************************
*  EINFACHES CASTING
**********************************************************************

DATA LV_STRING TYPE STRING.
DATA LV_NUMBER TYPE i.

lv_number = 17.

lv_string = lv_number.

**********************************************************************
*  CASTING IN OO
**********************************************************************

DATA lo_abschlag_2 TYPE REF TO lcl_abschlag.
DATA lo_rechnung TYPE REF TO lcl_rechnung.


lo_abschlag_2 = lo_abschlag.
lo_rechnung = lo_abschlag.



BREAK-POINT.
