*&---------------------------------------------------------------------*
*& Report Z_S04_OO_INTERFACES_AUFG
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s04_oo_interfaces_aufg.

**********************************************************************
*Interface

INTERFACE lif_buchung.
  METHODS verbuchen." RETURNING VALUE(re_gebucht) TYPE abap_bool.
ENDINTERFACE.


**********************************************************************
*Oberklasse Rechnung

CLASS lcl_rechnung DEFINITION ABSTRACT.

  PUBLIC SECTION.
    INTERFACES lif_buchung.

*    METHODS: constructor.

  PROTECTED SECTION.
    METHODS:
      bezahlen,
      set_status IMPORTING im_st TYPE c,
      get_status EXPORTING ex_st TYPE c.

    CONSTANTS: c_open    TYPE c VALUE 'O',
               c_pending TYPE c VALUE 'P',
               c_closed  TYPE c VALUE 'C',
               C_unknown TYPE c VALUE 'U'.

    DATA: status TYPE c VALUE 'U'.

*  PRIVATE   SECTION.
*    METHODS bezahlen.

ENDCLASS.


CLASS lcl_rechnung IMPLEMENTATION.

  METHOD lif_buchung~verbuchen.
    me->bezahlen( ).
    me->set_status( im_st = c_closed ).
*    re_gebucht = abap_true.
  ENDMETHOD.

*  METHOD constructor.
*    me->set_status( im_st = c_unknown ).
*  ENDMETHOD.

  METHOD bezahlen.
  ENDMETHOD.

  METHOD set_status.
    me->status = im_st.
  ENDMETHOD.

  METHOD get_status.
    ex_st = me->status.
  ENDMETHOD.

*  METHOD bezahlen.
*  ENDMETHOD.

ENDCLASS.



**********************************************************************
*Unterklasse Abschlag

CLASS lcl_abschlag DEFINITION INHERITING FROM lcl_rechnung.
  PROTECTED SECTION.
    METHODS bezahlen REDEFINITION.
ENDCLASS.

CLASS lcl_abschlag IMPLEMENTATION.
  METHOD bezahlen.
    WRITE: / |Abschlagsrechnung wurde bezahlt|.
  ENDMETHOD.
ENDCLASS.



**********************************************************************
*Nicht erbende Klasse Gutschrift.

CLASS lcl_gutschrift DEFINITION.
  PUBLIC SECTION.
    INTERFACES lif_buchung.
  PRIVATE SECTION.
    METHODS gutschrift.
ENDCLASS.

CLASS lcl_gutschrift IMPLEMENTATION.
  METHOD lif_buchung~verbuchen.
    me->gutschrift( ).
*    re_gebucht = abap_true.
  ENDMETHOD.
  METHOD gutschrift.
    WRITE: / |Gutschrift wurde verbucht|.
  ENDMETHOD.
ENDCLASS.


**********************************************************************
START-OF-SELECTION.
**********************************************************************

  DATA: lo_abschlag   TYPE REF TO lcl_abschlag,
        lo_gutschrift TYPE REF TO lcl_gutschrift.

  lo_abschlag = NEW lcl_abschlag( ).
  lo_gutschrift = NEW lcl_gutschrift( ).


lo_abschlag->lif_buchung~verbuchen( ).
lo_gutschrift->lif_buchung~verbuchen( ).




**********************************************************************
*CASTING
**********************************************************************

DATA: lv_string TYPE string,
      lv_number TYPE i.

lv_number = 17.

lv_string = lv_number.

BREAK-POINT.
