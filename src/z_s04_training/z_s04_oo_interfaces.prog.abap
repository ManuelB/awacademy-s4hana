*&---------------------------------------------------------------------*
*& Report Z_S04_OO_INTERFACES
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s04_oo_interfaces.


**********************************************************************
*Deklaration des Interfaces und seiner Methode(n)

INTERFACE lif_zahlung.
  METHODS pay IMPORTING im_value TYPE i.
ENDINTERFACE.


**********************************************************************
*Bekanntmachung des Interfaces bei der Definition einer Klasse.

CLASS lcl_beleg DEFINITION.
  PUBLIC SECTION.
    INTERFACES lif_zahlung. "Interfaces dürfen nur in der PUBLIC SECTION definiert werden!
ENDCLASS.


**********************************************************************
*Implementierung der Klasse mit Aufruf des Interfaces und seiner ~Methode(n).

CLASS lcl_beleg IMPLEMENTATION.
  METHOD lif_zahlung~pay.
    WRITE: / |Zahlung des Belegs wurde durchgeführt. Betrag: { im_value } EUR|.
  ENDMETHOD.
ENDCLASS.


**********************************************************************
*Bei einer weiteren Klasse

CLASS lcl_sonderbeleg DEFINITION.
  PUBLIC SECTION.
    INTERFACES lif_zahlung.
ENDCLASS.

CLASS lcl_sonderbeleg IMPLEMENTATION.
  METHOD lif_zahlung~pay.
    WRITE: / |Zahlung des Sonderbelegs wurde durchgeführt. Betrag: { im_value } EUR|.
  ENDMETHOD.
ENDCLASS.


**********************************************************************
START-OF-SELECTION.


  DATA: lo_beleg TYPE REF TO lcl_beleg,
        lo_sonderbeleg TYPE REF TO lcl_sonderbeleg.


  lo_beleg = NEW lcl_beleg( ).
  lo_sonderbeleg = NEW lcl_sonderbeleg( ).

  lo_beleg->lif_zahlung~pay( im_value = 100 ).
  lo_sonderbeleg->lif_zahlung~pay( im_value = 200 ).
