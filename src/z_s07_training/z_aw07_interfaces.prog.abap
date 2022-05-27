*&---------------------------------------------------------------------*
*& Report Z_AW07_INTERFACES
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_aw07_interfaces.

INTERFACE lif_zahlung.
  METHODS pay IMPORTING im_value TYPE i.
ENDINTERFACE.

CLASS lcl_beleg DEFINITION.
  PUBLIC SECTION.
    INTERFACES lif_zahlung.
ENDCLASS.

CLASS lcl_beleg IMPLEMENTATION.
  METHOD lif_zahlung~pay.
    WRITE: |Zahlung wurde durchgefürt. Betrag { im_value }|.
  ENDMETHOD.
ENDCLASS.

"zweite Klasse"

CLASS lcl_sonderbeleg DEFINITION.
  PUBLIC SECTION.
    INTERFACES lif_zahlung.
ENDCLASS.

CLASS lcl_sonderbeleg IMPLEMENTATION.
  METHOD lif_zahlung~pay.
    WRITE: |Sonderbeleg: die Zahlung wurde durchgefürt. Betrag { im_value }|.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.

  DATA lo_beleg TYPE REF TO lcl_beleg.
  DATA lo_sonderbeleg TYPE REF TO lcl_sonderbeleg.

  lo_beleg = NEW lcl_beleg( ).
  lo_beleg->lif_zahlung~pay( im_value = 100  ).

  ULINE.

  lo_sonderbeleg = NEW lcl_sonderbeleg( ).
  lo_sonderbeleg->lif_zahlung~pay( im_value = 200  ).
