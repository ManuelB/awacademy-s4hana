*&---------------------------------------------------------------------*
*& Report Z_S09_OO_INTERFACES
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S09_OO_INTERFACES.


INTERFACE lif_zahlung.
  METHODS pay IMPORTING im_value TYPE i.
ENDINTERFACE.


CLASS lcl_beleg DEFINITION.
  PUBLIC SECTION.
    INTERFACES lif_zahlung.
ENDCLASS.

CLASS lcl_beleg IMPLEMENTATION.
  METHOD lif_zahlung~pay.
    WRITE: |Zahlung des Belegs wurde durchgeführt. Betrag { im_value }|.
  ENDMETHOD.
ENDCLASS.


CLASS lcl_sonder_beleg DEFINITION.
  PUBLIC SECTION.
    INTERFACES lif_zahlung.
ENDCLASS.

CLASS lcl_sonder_beleg IMPLEMENTATION.
  METHOD lif_zahlung~pay.
    WRITE: |Zahlung des Belegs wurde durchgeführt. Betrag: { im_value }|.
  ENDMETHOD.
ENDCLASS.





START-OF-SELECTION.

DATA lo_beleg TYPE REF TO lcl_beleg.
DATA lo_sonder_beleg TYPE REF TO lcl_sonder_beleg.

lo_beleg = new lcl_beleg( ).
lo_sonder_beleg = new lcl_sonder_beleg( ).

lo_beleg->lif_zahlung~pay( im_value = 100 ).
lo_sonder_beleg->lif_zahlung~pay( im_value = 200 ).











*INTERFACE lif_zahlung.
*  METHODS pay.
*ENDINTERFACE.
*
*CLASS lcl_beleg DEFINITION.
*  PUBLIC SECTION.
*    INTERFACES lif_zahlung.
*ENDCLASS.
*
*CLASS lcl_beleg IMPLEMENTATION.
*  METHOD lif_zahlung~pay.
*    WRITE: |Zahlung des Belegs wurde durchgeführt.|.
*  ENDMETHOD.
*ENDCLASS.
*
*
*START-OF-SELECTION.
*
*DATA lo_beleg TYPE REF TO lcl_beleg.
*
*lo_beleg = new lcl_beleg( ).
*
*lo_beleg->lif_zahlung~pay( ).
