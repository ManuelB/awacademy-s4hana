*&---------------------------------------------------------------------*
*& Report Z_T04_OO_INTERFACES
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zs01_z_t04_oo_interfaces.

INTERFACE lif_zahlung.
  METHODS pay IMPORTING im_value TYPE i.
ENDINTERFACE.

CLASS lcl_beleg DEFINITION.
  PUBLIC SECTION.
    INTERFACES lif_zahlung.
ENDCLASS.

CLASS lcl_beleg IMPLEMENTATION.
  METHOD lif_zahlung~pay.
    WRITE: |Zahlung des Belegs wurde durchgeführt. Betrag { im_value } |.
  ENDMETHOD.
ENDCLASS.



CLASS lcl_sonderbeleg DEFINITION.
  PUBLIC SECTION.
    INTERFACES lif_zahlung.
ENDCLASS.

CLASS lcl_sonderbeleg IMPLEMENTATION.
  METHOD lif_zahlung~pay.
    WRITE: |Zahlung des Sonderbelegs wurde durchgeführt. Betrag: { im_value } |.
  ENDMETHOD.
ENDCLASS.



START-OF-SELECTION.

DATA lo_beleg TYPE REF TO lcl_beleg.
DATA lo_sonderbeleg TYPE REF TO lcl_sonderbeleg.

lo_beleg = new lcl_beleg( ).
lo_sonderbeleg = NEW lcl_sonderbeleg( ).

lo_beleg->lif_zahlung~pay( im_value = 100 ).
lo_sonderbeleg->lif_zahlung~pay( im_value = 100 ).
