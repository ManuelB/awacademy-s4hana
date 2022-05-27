*&---------------------------------------------------------------------*
*& Report Z_S02_ASS2_ASS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s02_ass2_ass.



**** Aufgbabe 10 ***

**** UML zu ABAP

INTERFACE lif_organisation.
ENDINTERFACE.

INTERFACE lif_natuerlicheperson.
  METHODS:
    name
      RETURNING VALUE(re_name) TYPE string,
    istAngestelltBei
      IMPORTING
                organisation      TYPE string
      RETURNING VALUE(re_emplyed) TYPE xfeld.
ENDINTERFACE.

CLASS praesident DEFINITION.
  PUBLIC SECTION.
    INTERFACES: lif_natuerlicheperson.

    DATA vorname TYPE string.
    DATA nachname TYPE string.
ENDCLASS.


CLASS praesident IMPLEMENTATION.
  METHOD lif_natuerlicheperson~name.
    WRITE: | Name: { re_name }|.
  ENDMETHOD.

  METHOD lif_natuerlicheperson~istangestelltbei.
    WRITE: | Person ist angestellt |.
  ENDMETHOD.
ENDCLASS.
