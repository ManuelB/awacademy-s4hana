*&---------------------------------------------------------------------*
*& Report Z_S03_OO_INTERFACE_AUFGABE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s03_oo_interface_aufgabe.

***** cf Z_T04_OO_INTERFACES_AUFGABE


INTERFACE lif_buchung.
  METHODS verbuchen IMPORTING im_value TYPE i.
ENDINTERFACE.

**************
*OBERKLASSE RECHNUNG

CLASS lcl_rechnung DEFINITION ABSTRACT.

  PUBLIC SECTION.
    INTERFACES lif_buchung.
    METHODS: set_status IMPORTING im_st TYPE c.

    METHODS: bezahlen.
    CONSTANTS: c_open TYPE c VALUE 'O'.
    CONSTANTS: c_pending TYPE c VALUE 'P'.
    CONSTANTS: c_closed TYPE c VALUE 'C'.

    DATA status TYPE c VALUE c_closed.


ENDCLASS.

CLASS lcl_rechnung IMPLEMENTATION.

  METHOD set_status.
    me->status = im_st.
  ENDMETHOD.
  METHOD bezahlen.
    me->set_status( im_st = c_closed ).
    WRITE: |Rechnung wurde bezahlt.|.
  ENDMETHOD.
  METHOD lif_buchung~verbuchen.
    WRITE: |Abstrakte Klasse: nicht möglich|.
  ENDMETHOD.
ENDCLASS.

*****************
* UNTERKLASSE  ABSCHLAG

CLASS lcl_abschlag DEFINITION INHERITING FROM lcl_rechnung.
  PUBLIC SECTION.
    METHODS lif_buchung~verbuchen REDEFINITION.
ENDCLASS.
CLASS lcl_abschlag IMPLEMENTATION.
  METHOD lif_buchung~verbuchen.
    WRITE: |Abschlag wurde verbucht.|.
  ENDMETHOD.
ENDCLASS.

*****************
*UNABHÄNGIGE KLASSE GUTSCHRIFT


CLASS lcl_gutschrift DEFINITION.
  PUBLIC SECTION.
    METHODS: set_status IMPORTING im_st TYPE c.
    INTERFACES lif_buchung.
  PROTECTED SECTION.

    CONSTANTS: c_open TYPE c VALUE 'O'.
    CONSTANTS: c_pending TYPE c VALUE 'P'.
    CONSTANTS: c_closed TYPE c VALUE 'C'.

    DATA status TYPE c VALUE c_closed.

ENDCLASS.

CLASS lcl_gutschrift IMPLEMENTATION.

  METHOD set_status.
    me->status = im_st.
  ENDMETHOD.

  METHOD lif_buchung~verbuchen.
    WRITE: |Verbuchung der Gutschrift wurde durchgeführt. Betrag { im_value }|.
  ENDMETHOD.

ENDCLASS.

*****************************************
START-OF-SELECTION.


  DATA lo_abschlag TYPE REF TO lcl_abschlag.
  DATA lo_gutschrift TYPE REF TO lcl_gutschrift.


  lo_abschlag = NEW lcl_abschlag( ).
  lo_abschlag->lif_buchung~verbuchen( im_value = 100 ).

  ULINE.

  lo_gutschrift = NEW lcl_gutschrift( ).
  lo_gutschrift->lif_buchung~verbuchen( im_value = 200 ).
