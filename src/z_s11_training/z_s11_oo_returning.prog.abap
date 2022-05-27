*&---------------------------------------------------------------------*
*& Report ZAWT03_OO_RETURNING
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S11_OO_RETURNING.

DATA gv_time_by_value TYPE t.

CLASS lcl_time_utility DEFINITION FINAL.

  PUBLIC SECTION.
    CLASS-METHODS do_nothing
      RETURNING
        VALUE(result) TYPE t.
    CLASS-METHODS get_time_120000_successfully
      RETURNING
        VALUE(result) TYPE t.
    CLASS-METHODS get_time_120000_with_exception
      RETURNING
        VALUE(result) TYPE t
      RAISING
        cx_abap_datfm_invalid_date.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS lcl_time_utility IMPLEMENTATION.

  METHOD do_nothing.

  ENDMETHOD.

  METHOD get_time_120000_successfully.
    result = '120000'.
  ENDMETHOD.

  METHOD get_time_120000_with_exception.
    result = '120000'.
    RAISE EXCEPTION TYPE cx_abap_datfm_invalid_date.
  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.
  gv_time_by_value = sy-uzeit.

  WRITE: / `Start time:`.
  WRITE: / gv_time_by_value.

  WRITE: / `Do nothing:`.

  gv_time_by_value = lcl_time_utility=>do_nothing( ).

  WRITE: / `Pass by value:`.
  WRITE: / gv_time_by_value.

  WRITE: / `Method call successful:`.

  CLEAR gv_time_by_value.

  gv_time_by_value = lcl_time_utility=>get_time_120000_successfully( ).

  WRITE: / `Pass by value:`.
  WRITE: / gv_time_by_value.

  WRITE: / `Method call unsuccessful:`.

  CLEAR gv_time_by_value.

  TRY.
      gv_time_by_value = lcl_time_utility=>get_time_120000_with_exception( ).
    CATCH cx_abap_datfm_invalid_date.
      " do nothing
  ENDTRY.

  WRITE: / `Pass by value:`.
  WRITE: / gv_time_by_value.
