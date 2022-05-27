*&---------------------------------------------------------------------*
*& Report ZBC401_INHERITANCE_BASE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbcs12_inheritance_base_hana.

TYPE-POOLS icon.

CLASS lcl_airplane DEFINITION.

  PUBLIC SECTION.

    METHODS:
      constructor
        IMPORTING
          iv_name      TYPE string
          iv_planetype TYPE saplane-planetype
        EXCEPTIONS
          wrong_planetype,
*
      display_attributes.

    CLASS-METHODS:
      class_constructor,
      display_n_o_airplanes,
      get_n_no_airplanes
        RETURNING VALUE(rv_count) TYPE i.

  PROTECTED SECTION.

    CONSTANTS:
    c_pos_1 TYPE i VALUE 30.

  PRIVATE SECTION.

    TYPES:
    ty_planetypes TYPE TABLE OF saplane
    WITH NON-UNIQUE KEY planetype.



    DATA: mv_name      TYPE string,
          mv_planetype TYPE saplane-planetype,
          mv_weight    TYPE saplane-weight,
          mv_tankcap   TYPE saplane-tankcap.

    CLASS-DATA:
      gv_n_o_airplanes TYPE i,
      gt_planetypes    TYPE ty_planetypes.

    CLASS-METHODS:
      get_technical_attributes
        IMPORTING
          iv_type    TYPE saplane-planetype
        EXPORTING
          ev_weight  TYPE saplane-weight
          ev_tankcap TYPE saplane-tankcap
        EXCEPTIONS
          wrong_planetype.

ENDCLASS. " lcl_airplane definition.
*------------------------------------
CLASS lcl_airplane IMPLEMENTATION.

  METHOD class_constructor.
    SELECT * FROM saplane INTO TABLE gt_planetypes.
  ENDMETHOD.

  METHOD constructor.

    mv_name = iv_name.
    mv_planetype = iv_planetype.

    get_technical_attributes(
      EXPORTING
        iv_type         = iv_planetype
      IMPORTING
        ev_weight       = mv_weight
        ev_tankcap      = mv_tankcap
      EXCEPTIONS
        wrong_planetype = 1
    ).

    IF sy-subrc NE 0.
      RAISE wrong_planetype.
    ELSE.
      gv_n_o_airplanes = gv_n_o_airplanes + 1.
    ENDIF.

  ENDMETHOD." constructor.

  METHOD display_attributes.

    WRITE:
     / icon_ws_plane AS ICON,
     / 'Name of Airplane'(001) , AT c_pos_1 mv_name,
     / 'Type of Airplane'(002) , AT c_pos_1 mv_planetype,
     / 'Weight'(003) , AT c_pos_1 mv_weight LEFT-JUSTIFIED,
     / 'Tank Capacity'(004) , AT c_pos_1 mv_tankcap LEFT-JUSTIFIED.

  ENDMETHOD. " display_attributes.

  METHOD display_n_o_airplanes.
    SKIP.
    WRITE:
     / 'Number of Airplanes:'(ca1), AT c_pos_1 gv_n_o_airplanes  LEFT-JUSTIFIED.
  ENDMETHOD."  display_n_o_airplanes.

  METHOD get_n_no_airplanes.
    rv_count = gv_n_o_airplanes.
  ENDMETHOD." get_n_no_airplanes.

  METHOD get_technical_attributes.
    DATA: ls_planetype TYPE saplane.

    READ TABLE gt_planetypes INTO ls_planetype
    WITH TABLE KEY planetype = iv_type
    TRANSPORTING weight tankcap.

    IF sy-subrc = 0.
      ev_weight = ls_planetype-weight.
      ev_tankcap = ls_planetype-tankcap.
*      ev_seats = ls_planetype-seatsmax.
*      ev_cargo = ls_planetype-cargomax.
    ELSE.
      RAISE wrong_planetype.
    ENDIF.

  ENDMETHOD." get_technical_atrributes.

ENDCLASS. " lcl_airplane implementation.

CLASS lcl_passenger_plane DEFINITION INHERITING FROM lcl_airplane.
  PUBLIC SECTION.

    DATA:
          mv_seats TYPE saplane-seatsmax.
*    METHODS display_seats
*      IMPORTING
*        iv_type  TYPE saplane-planetype
*      EXPORTING
*        ev_seats TYPE saplane-seatsmax
*      EXCEPTIONS
*        wrong_planetype.
*    METHODS display_attributes REDEFINITION.
*  methods constructor redefinition.

ENDCLASS.

CLASS lcl_passenger_plane IMPLEMENTATION.
*  METHOD display_seats.
*    DATA: ls_planetype TYPE saplane.
*
*    READ TABLE gt_planetypes INTO ls_planetype
*    WITH TABLE KEY planetype = iv_type
*    TRANSPORTING seatsmax.
*
*    IF sy-subrc = 0.
*      ev_seats = ls_planetype-seatsmax.
*    ELSE.
*      RAISE wrong_planetype.
*    ENDIF.
*
*  ENDMETHOD." get_technical_atrributes.
*
*  METHOD display_attributes.
*    me->display_seats(
*      EXPORTING
*        iv_type         = mv_planetype
*      IMPORTING
*        ev_seats        = mv_seats
*      EXCEPTIONS
*        wrong_planetype = 1
*        OTHERS          = 2
*    ).
*    IF sy-subrc <> 0.
*      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
*        WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
*    ENDIF.
*    super->display_attributes( ).
*    WRITE:
*    / 'Max seats'(009) , AT c_pos_1 mv_seats.
**    WRITE: super->display_attributes( ).
*  ENDMETHOD.
ENDCLASS.


CLASS lcl_cargo_plane DEFINITION INHERITING FROM lcl_airplane.
  PUBLIC SECTION.

    METHODS:
      constructor
        IMPORTING
          iv_name      TYPE string
          iv_planetype TYPE saplane-planetype
          iv_cargo     TYPE scplane-cargomax
        EXCEPTIONS
          wrong_planetype,

      display_attributes REDEFINITION.

  PROTECTED SECTION.
    DATA: mv_cargo TYPE scplane-cargomax.
ENDCLASS.

CLASS lcl_cargo_plane IMPLEMENTATION.
  METHOD constructor.
    super->constructor(
      EXPORTING
        iv_name         = iv_name
        iv_planetype    = iv_planetype
      EXCEPTIONS
        wrong_planetype = 1
    ).

    IF sy-subrc NE 0.
      RAISE wrong_planetype.
    ENDIF.

    mv_cargo = '45000'.

  ENDMETHOD.
  METHOD display_attributes.
    super->display_attributes( ).
    WRITE: /'Max. Cargo'(007) , AT c_pos_1 mv_cargo LEFT-JUSTIFIED.
    ULINE.
  ENDMETHOD.

ENDCLASS.


DATA: go_airplane  TYPE REF TO lcl_airplane,
      gt_airplanes TYPE TABLE OF REF TO lcl_airplane,
      gv_count     TYPE i,
      go_passenger TYPE REF TO lcl_passenger_plane,
*      gt_passenger TYPE TABLE OF REF TO  lcl_passenger_plane,
      go_cargo     TYPE REF TO lcl_cargo_plane.
*      gt_cargo     TYPE TABLE OF REF TO lcl_cargo_plane.

START-OF-SELECTION.

*  lcl_cargo_plane=>display_n_o_airplanes( ).
  lcl_airplane=>display_n_o_airplanes( ).
*
*  go_cargo = new lcl_cargo_plane(
*    iv_name      = 'LH Berlin'
*    iv_planetype = 'A321'
*    iv_cargo     = '45000'
*  ).
*
*  go_airplane = new lcl_airplane(
*    iv_name      = 'LH Berlin'
*    iv_planetype = 'A321'
*  ).
*go_cargo->display_attributes( ).
*go_airplane->display_attributes( ).
*-------------------------
  CREATE OBJECT go_airplane
    EXPORTING
      iv_name         = 'LH Berlin'
      iv_planetype    = 'A321'
    EXCEPTIONS
      wrong_planetype = 1.
  IF sy-subrc = 0.
    APPEND go_airplane TO gt_airplanes.
  ENDIF.

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
  CREATE OBJECT go_airplane
    EXPORTING
      iv_name         = 'AA New York'
      iv_planetype    = '747-400'
    EXCEPTIONS
      wrong_planetype = 1.
  IF sy-subrc = 0.
    APPEND go_airplane TO gt_airplanes.
  ENDIF.







*go_passenger = new lcl_passenger_plane(
*  iv_name      = 'US Hercules'
*  iv_planetype = '747-200F'
*).
*

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
