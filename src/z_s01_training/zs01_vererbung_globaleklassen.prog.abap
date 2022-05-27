*&---------------------------------------------------------------------*
*& Report ZBC401_VERERBUNG
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zs01_vererbung_globaleklassen.

TYPE-POOLS icon.

INCLUDE zbc401_vererbung_def.
INCLUDE zbc401_vererbung_impl.



*---------------------------------------------------
DATA: go_airplane  TYPE REF TO lcl_airplane,
      gt_airplanes TYPE TABLE OF REF TO lcl_airplane,
      gv_count     TYPE i,
*
      go_passenger TYPE REF TO lcl_passenger_plane,
      go_cargo     TYPE REF TO lcl_cargo_plane.

START-OF-SELECTION.

  lcl_airplane=>display_n_o_airplanes( ).

*-------------------------
  CREATE OBJECT go_cargo
    EXPORTING
      iv_name         = 'XX CARGO'
      iv_planetype    = '767-200'
      iv_cargo        = ''
    EXCEPTIONS
      wrong_planetype = 1.
  IF sy-subrc = 0.
    APPEND go_cargo TO gt_airplanes.
  ENDIF.
*-------------------------
  CREATE OBJECT go_passenger
    EXPORTING
      iv_name         = 'AA Bochum'
      iv_planetype    = '737-800'
      iv_seats        = '15'
    EXCEPTIONS
      wrong_planetype = 1.
  IF sy-subrc = 0.
    APPEND go_passenger TO gt_airplanes.
  ENDIF.
*-------------------------
  CREATE OBJECT go_airplane
    EXPORTING
      iv_name         = 'AA New York'
      iv_planetype    = '747-400'
    EXCEPTIONS
      wrong_planetype = 1.
  IF sy-subrc = 0.
    APPEND go_airplane TO gt_airplanes.
  ENDIF.
*-------------------------
  CREATE OBJECT go_airplane
    EXPORTING
      iv_name         = 'US Hercules'
      iv_planetype    = '747-200F'
    EXCEPTIONS
      wrong_planetype = 1.
  IF sy-subrc = 0.
    APPEND go_airplane TO gt_airplanes.
  ENDIF.

  LOOP AT gt_airplanes INTO go_airplane.
    go_airplane->display_attributes( ).
  ENDLOOP.

  gv_count = lcl_airplane=>get_n_no_airplanes( ).
  SKIP 2.
  WRITE: / 'Number of Airplanes'(ca1), gv_count.
