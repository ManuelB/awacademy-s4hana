*&---------------------------------------------------------------------*
*& Report Z_S11_PROBE_ASESSMENT_UML
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s11_ass2_uml2code.

INTERFACE natuerlichePerson.
  METHODS:  istAngestelltBei IMPORTING Organisation TYPE string RETURNING VALUE(re_bool) type xfeld,
    name RETURNING VALUE(re_name) TYPE string.
ENDINTERFACE.

INTERFACE organisation.
ENDINTERFACE.

CLASS Praesident DEFINITION.

  PUBLIC SECTION.
    INTERFACES natuerlichePerson.
    METHODS:istAngestelltBei IMPORTING Organisation type string returning value(re_bool) TYPE xfeld,
      name RETURNING VALUE(re_name) TYPE string.
    DATA:
      vorname  TYPE string,
      nachname TYPE string.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS Praesident IMPLEMENTATION.

  METHOD natuerlicheperson~istangestelltbei.
    WRITE:/ 'I am interface method'.
  ENDMETHOD.
  METHOD natuerlicheperson~name.
    WRITE:/ 'I am interface method'.
  ENDMETHOD.

  METHOD istangestelltbei.
    WRITE:/ 'I am class method'.
  ENDMETHOD.
  METHOD name.
    WRITE:/ 'I am class method'.
  ENDMETHOD.


ENDCLASS.
