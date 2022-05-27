*&---------------------------------------------------------------------*
*& Report ZBC401_INTERFACES_CASTING
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT y_demo_interfaces_casting.

INTERFACE lif_partner .
  METHODS display_partner.
ENDINTERFACE.

INTERFACE lif_license .
  METHODS get_license.
ENDINTERFACE.

CLASS lcl_rental DEFINITION.
  PUBLIC SECTION.
    INTERFACES lif_partner.
ENDCLASS.

CLASS lcl_rental IMPLEMENTATION.
  METHOD lif_partner~display_partner.
*-- implement coding here
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.

  DATA: i_ref1 TYPE REF TO lif_partner,
        i_ref2 TYPE REF TO lif_partner.
*
  DATA(o_ref1) = NEW lcl_rental( ).
  DATA(o_ref2) = NEW lcl_rental( ).

  CREATE OBJECT: o_ref1, o_ref2.

  o_ref2 ?= i_ref1.



  BREAK-POINT.
