*&---------------------------------------------------------------------*
*& Report Z_S05_OO_INTERFACES
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s05_oo_interfaces.

INTERFACE lif_zahlung.
  METHODS pay
    IMPORTING im_value TYPE i.

ENDINTERFACE.

CLASS lcl_beleg DEFINITION.
  PUBLIC SECTION. "immer in Public section.
    INTERFACES lif_zahlung.
ENDCLASS.

CLASS lcl_beleg IMPLEMENTATION.
  METHOD lif_zahlung~pay.
    WRITE: / |Zahlung des Belegs wurde durchgeführt. Betrag { im_value }|.
  ENDMETHOD.
ENDCLASS.

CLASS lcl_sondern_beleg DEFINITION.
  PUBLIC SECTION.
    INTERFACES lif_zahlung.
ENDCLASS.

CLASS lcl_sondern_beleg IMPLEMENTATION.
  METHOD lif_zahlung~pay.
    WRITE: / |Zahlung des Sondernbelegs wurde nicht durchgeführt. Betrag { im_value }| COLOR COL_NEGATIVE.
  ENDMETHOD.
ENDCLASS.


START-OF-SELECTION.

  DATA lo_beleg TYPE REF TO lcl_beleg.
  DATA lo_sondern_beleg TYPE REF TO lcl_sondern_beleg.

  lo_sondern_beleg = NEW lcl_sondern_beleg( ).
  lo_beleg = NEW lcl_beleg( ).


  lo_beleg->lif_zahlung~pay( im_value = 120  ).
  lo_sondern_beleg->lif_zahlung~pay( im_value = 100 ).
