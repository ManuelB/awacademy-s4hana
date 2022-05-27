*&---------------------------------------------------------------------*
*& Report Z_S02_EEXCEPTIONS_UEBUNG
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S02_EEXCEPTIONS_UEBUNG.
PARAMETERS:
p_alter TYPE i.

DATA:
alter TYPE i.

CLASS kauefer_zu_jung_exception DEFINITION
INHERITING FROM cx_static_check.
ENDCLASS.


CLASS laden DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS:
      alkoholkaufen
        IMPORTING alter TYPE i
        RAISING   kauefer_zu_jung_exception.
ENDCLASS.


CLASS laden IMPLEMENTATION.

  METHOD alkoholkaufen.

    IF alter > 18.
      MESSAGE |Zum Wohl!| TYPE 'S'.
    ELSE.
      RAISE EXCEPTION TYPE kauefer_zu_jung_exception.
    ENDIF.
  ENDMETHOD.
ENDCLASS.


START-OF-SELECTION.

  TRY.
      laden=>alkoholkaufen(
      EXPORTING alter = p_alter ).
    CATCH kauefer_zu_jung_exception INTO DATA(e_text).
      MESSAGE e_text->get_text( ) TYPE 'S' DISPLAY LIKE 'E'.
  ENDTRY.
