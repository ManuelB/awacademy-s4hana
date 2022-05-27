*&---------------------------------------------------------------------*
*& Report Z_S03_OO_INTERFACES
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s03_oo_interfaces.

**** Wann Interface? Wenn man nicht von einer oberen Klasse vererben kann aber trotzdem eine Methode davon brauche.
**** je ne peux avoir une Vererbung que d'une seule classe. si je veux avoir des méthodes d'autres classes,
**** on fait un interface. un interface peut avoir plusieurs méthodes, ms aucun attribut. Tjs public section

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


  CLASS lcl_sonderbeleg DEFINITION.
  PUBLIC SECTION.
    INTERFACES lif_zahlung.
ENDCLASS.

CLASS lcl_sonderbeleg IMPLEMENTATION.
  METHOD lif_zahlung~pay.
    WRITE: |Zahlung des Sonderbelegs wurde durchgeführt. Betrag { im_value }|.
    ENDMETHOD.
  ENDCLASS.

  START-OF-SELECTION.

  DATA lo_beleg TYPE REF TO lcl_beleg.
  DATA lo_sonderbeleg TYPE REF TO lcl_sonderbeleg.

  lo_beleg = NEW lcl_beleg( ).
  lo_beleg->lif_zahlung~pay( im_value = 100 ).

ULINE.

  lo_sonderbeleg = NEW lcl_sonderbeleg(  ).
  lo_sonderbeleg->lif_zahlung~pay( im_value = 200 ).
