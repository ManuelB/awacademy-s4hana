*&---------------------------------------------------------------------*
*& Report zbc401_constructor_prinzip
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s11_constructor_prinzip.

CLASS construc DEFINITION.

  PUBLIC SECTION.

    METHODS constructor.

    CLASS-METHODS class_constructor.

ENDCLASS.

CLASS construc IMPLEMENTATION.

  METHOD constructor.
    WRITE:/ 'Instance constructor triggered'.
  ENDMETHOD.

  METHOD class_constructor.
    WRITE:/ 'Static Class constructor triggered'.

  ENDMETHOD.

ENDCLASS.

DATA: object  TYPE REF TO construc,
      object1 TYPE REF TO construc,
      object2 TYPE REF TO construc,
      object3 TYPE REF TO construc.

START-OF-SELECTION.

*- ersmalige instanziierung der Klasse
  CREATE OBJECT object.
  ULINE.
*- ersmalige instanziierung der Klasse
  CREATE OBJECT object1.
  CREATE OBJECT object2.
  CREATE OBJECT object3.
