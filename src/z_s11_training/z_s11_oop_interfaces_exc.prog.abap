*&---------------------------------------------------------------------*
*& Report Z_S11_OOP_INTERFACES_EXC
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s11_oop_interfaces_exc.

INTERFACE lif_buchung.
  METHODS verbuchen.
ENDINTERFACE.

CLASS lcl_rechnung DEFINITION.
  PUBLIC SECTION.
    INTERFACES lif_buchung.
    METHODS  bezahlen.

  PROTECTED SECTION.
    DATA status TYPE string.
ENDCLASS.

CLASS lcl_rechnung IMPLEMENTATION.
  METHOD bezahlen.
  ENDMETHOD.
  METHOD lif_buchung~verbuchen.
    WRITE :/ |Verbuchung method of interface is implemented in oberklasselcl_rechnung.|.
  ENDMETHOD.

ENDCLASS.

CLASS lcl_abschlag DEFINITION INHERITING FROM lcl_rechnung.
  PUBLIC SECTION.
    METHODS: lif_buchung~verbuchen REDEFINITION.
ENDCLASS.
CLASS lcl_abschlag IMPLEMENTATION.
  METHOD lif_buchung~verbuchen.
    WRITE :/ |Verbuchen method of interface is implemented in unterklasse lcl_abschlag.|.
  ENDMETHOD.
ENDCLASS.





***********************************************************************

START-OF-SELECTION.
  DATA lo_rechnung TYPE REF TO lcl_rechnung.
  DATA lo_abschlag TYPE REF TO lcl_abschlag.
  lo_rechnung = NEW lcl_rechnung( ).
  lo_abschlag = NEW lcl_abschlag( ).

  lo_rechnung->lif_buchung~verbuchen( ).
  lo_abschlag->lif_buchung~verbuchen( ).
