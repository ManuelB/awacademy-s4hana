*&---------------------------------------------------------------------*
*& Report z_s05_aufgabe_exceptions
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s05_aufgabe_exceptions.

CLASS cx_kaufer_zu_jung_exception DEFINITION
INHERITING FROM cx_static_check.

ENDCLASS.

CLASS laden DEFINITION.
PUBLIC SECTION.
CLASS-METHODS:
alkohol_kaufen IMPORTING im_alter TYPE i


RAISING cx_kaufer_zu_jung_exception.

ENDCLASS.

CLASS laden IMPLEMENTATION.

method alkohol_kaufen.
if
endmethod.

ENDCLASS.

CLASS cx_kaufer_zu_jung_exception IMPLEMENTATION.
ENDCLASS.


START-OF-SELECTION.

PARAMETERS:
p_alter TYPE i DEFAULT 17.
