*&---------------------------------------------------------------------*
*& Report Z_S02_OO_INTERFACES_1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s02_oo_interfaces_1.


****** Interface machen

INTERFACE lif_zahlung.
  METHODS pay IMPORTING im_value type i.
ENDINTERFACE.



****** Klasse "Beleg" anlegen
CLASS lcl_beleg DEFINITION.

  PUBLIC SECTION.

    INTERFACES lif_zahlung.

ENDCLASS.


CLASS lcl_beleg IMPLEMENTATION.
  METHOD lif_zahlung~pay.           " Achtungn Tilde
    WRITE: | Zahlung wurde durchgeführt. Betrag { im_value } |.
  ENDMETHOD.
ENDCLASS.



****** Klasse "Sonderbeleg" anlegen
CLASS lcl_sonderbeleg DEFINITION.
  PUBLIC SECTION.
    INTERFACES lif_zahlung.
ENDCLASS.

CLASS lcl_sonderbeleg IMPLEMENTATION.
  METHOD lif_zahlung~pay.
    WRITE: | Zahlung wurde durchgeführt. Betrag { im_value } |.
  ENDMETHOD.

ENDCLASS.


START-OF-SELECTION.


***** Objekte erstellen

  DATA lo_sonderbeleg TYPE REF TO lcl_sonderbeleg.
  DATA lo_beleg       TYPE REF TO lcl_beleg.

  lo_beleg =       NEW lcl_beleg( ).
  lo_sonderbeleg = NEW lcl_sonderbeleg( ).

  lo_beleg->lif_zahlung~pay( im_value = 100 ).
  lo_sonderbeleg->lif_zahlung~pay( im_value = 100 ).


  BREAK-POINT.
