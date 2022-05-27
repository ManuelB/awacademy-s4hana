*&---------------------------------------------------------------------*
*& Report ZAWT03_OO_CONSTRUCTOR
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s11_oo_constructor.

CLASS construc DEFINITION.

  PUBLIC SECTION.

    METHODS constructor.

    CLASS-METHODS class_constructor.

    METHODS call_method.

ENDCLASS.

CLASS construc IMPLEMENTATION.

  METHOD constructor.
    WRITE:/ 'Instance constructor triggered'.
  ENDMETHOD.

  METHOD class_constructor.
    WRITE:/ 'Static Class constructor triggered'.

  ENDMETHOD.

  METHOD call_method.
    WRITE: / '2nd Call of CONSTRUCTOR'.

  ENDMETHOD.

ENDCLASS.

DATA: object TYPE REF TO construc.

START-OF-SELECTION.

  CREATE OBJECT object.

  IF NOT object IS INITIAL.
    CALL METHOD object->call_method( ).
  ENDIF.
