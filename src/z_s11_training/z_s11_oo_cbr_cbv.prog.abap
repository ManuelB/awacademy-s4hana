*&---------------------------------------------------------------------*
*& Report ZAWT03_OO_CBR_CBV
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s11_oo_cbr_cbv.

DATA gv_time TYPE t.

CLASS lcl_time_utility DEFINITION FINAL.

  PUBLIC SECTION.
    CLASS-METHODS display_time
      IMPORTING
        iv_time_by_reference_implicit            TYPE t
        REFERENCE(iv_time_by_reference_explicit) TYPE t
        VALUE(iv_time_by_value)                  TYPE t.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS lcl_time_utility IMPLEMENTATION.

  METHOD display_time.
    WRITE: / `Pass by reference (implicit):`.
    WRITE: / iv_time_by_reference_implicit.

    WRITE: / `Pass by reference (explicit):`.
    WRITE: / iv_time_by_reference_explicit.

    WRITE: / `Pass by value:`.
    WRITE: / iv_time_by_value.

    WAIT UP TO 2 SECONDS.
    gv_time = sy-uzeit.

    WRITE: / `Pass by reference (implicit) after 2 seconds wait:`.
    WRITE: / iv_time_by_reference_implicit.

    WRITE: / `Pass by reference (explicit) after 2 seconds wait:`.
    WRITE: / iv_time_by_reference_explicit.

    WRITE: / `Pass by value after 2 seconds wait:`.
    WRITE: / iv_time_by_value.

    iv_time_by_value = iv_time_by_value + 10.

    WRITE: / `Pass by value after adding 10 seconds to the input parameter:`.
    WRITE: / iv_time_by_value.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  gv_time = sy-uzeit.
  lcl_time_utility=>display_time(
      iv_time_by_reference_implicit = gv_time
      iv_time_by_reference_explicit = gv_time
      iv_time_by_value              = gv_time ).
