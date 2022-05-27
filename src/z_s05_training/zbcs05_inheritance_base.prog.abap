*&---------------------------------------------------------------------*
*& Report ZBC401_INHERITANCE_BASE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbcs05_inheritance_base.

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

*  PROTECTED SECTION.

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
          ev_seats type saplane-seatsmax
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
      ev_seats = ls_planetype-seatsmax.
    ELSE.
      RAISE wrong_planetype.
    ENDIF.

  ENDMETHOD." get_technical_atrributes.

ENDCLASS. " lcl_airplane implementation.

CLASS lcl_passenger_plane DEFINITION INHERITING FROM lcl_airplane.
  PUBLIC SECTION.

  data:
        mv_seats type saplane-seatsmax.
  methods display_seats
  IMPORTING
          iv_type    TYPE saplane-planetype
        EXPORTING
          ev_seats type saplane-seatsmax
        EXCEPTIONS
          wrong_planetype.
  methods display_attributes REDEFINITION.
*  methods constructor redefinition.

  ENDCLASS.

CLASS lcl_passenger_plane IMPLEMENTATION.
method display_seats.
  DATA: ls_planetype TYPE saplane.

    READ TABLE gt_planetypes INTO ls_planetype
    WITH TABLE KEY planetype = iv_type
    TRANSPORTING seatsmax.

    IF sy-subrc = 0.
      ev_seats = ls_planetype-seatsmax.
    ELSE.
     RAISE wrong_planetype.
    ENDIF.

  ENDMETHOD." get_technical_atrributes.

  method display_attributes.
    me->display_seats(
      EXPORTING
        iv_type         = mv_planetype
      IMPORTING
        ev_seats        = mv_seats
      EXCEPTIONS
        wrong_planetype = 1
        others          = 2
    ).
    IF SY-SUBRC <> 0.
     MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
       WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
    ENDIF.
    super->display_attributes( ).
     WRITE:
     / 'Max seats'(004) , at c_pos_1 mv_seats.
*    WRITE: super->display_attributes( ).
    endmethod.
  ENDCLASS.







**********************************************************







  class lcl_cargo_plane DEFINITION INHERITING FROM lcl_airplane.
    public section.
    methods:
    display_attributes REDEFINITION,
    constructor importing im_cargo type scplane-cargomax,
    display
        IMPORTING
          iv_type    TYPE saplane-planetype
        EXPORTING
ev_cargo type scplane-cargomax
        EXCEPTIONS
          wrong_planetype.


    TYPES:
    ty_cargotypes TYPE TABLE OF scplane
    WITH NON-UNIQUE KEY planetype.


    PRIVATE SECTION.
    class-DATA mv_cargo type scplane-cargomax.

    endclass.

class lcl_cargo_plane implementation.
  method constructor.

    super->constructor(
      EXPORTING
        iv_name         = mv_name
        iv_planetype    = mv_planetype
      EXCEPTIONS
        wrong_planetype = 1
        others          = 2
    ).
    IF SY-SUBRC <> 0.
     MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
       WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
    ENDIF.

   mv_cargo = im_cargo.


endmethod.

method display.

DATA: ls_planetype TYPE saplane.

    READ TABLE gt_planetypes INTO ls_planetype
    WITH TABLE KEY planetype = iv_type
    TRANSPORTING

    IF sy-subrc = 0.

    ELSE.
      RAISE wrong_planetype.
    ENDIF.
    endmethod.

method display_attributes.
   super->display_attributes( ).
  me->display(
    EXPORTING
      iv_type         = mv_planetype
    IMPORTING
      ev_cargo        = mv_cargo
    EXCEPTIONS
      wrong_planetype = 1
      others          = 2
  ).
  IF SY-SUBRC <> 0.
*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*     WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
  ENDIF.
   WRITE:
     / 'Cargo'(005) , at c_pos_1 mv_cargo.
*    WRITE: super->display_attributes( ).
    endmethod.
endclass.


DATA: go_airplane  TYPE REF TO lcl_airplane,
      gt_airplanes TYPE TABLE OF REF TO lcl_airplane,
      gv_count     TYPE i,
      go_passenger type ref to lcl_passenger_plane,
      gt_passenger type table of ref to  lcl_passenger_plane,
      go_cargo type ref to lcl_cargo_plane,
      gt_cargo type table of ref to lcl_cargo_plane.

START-OF-SELECTION.

  lcl_airplane=>display_n_o_airplanes( ).

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


CREATE OBJECT go_passenger
    EXPORTING
      iv_name         = 'LH Bayern'
      iv_planetype    = 'A380-800'
    EXCEPTIONS
      wrong_planetype = 1.
  IF sy-subrc = 0.
    APPEND go_passenger TO gt_passenger.
  ENDIF.


  CREATE OBJECT go_passenger
    EXPORTING
      iv_name         = 'AZ Mozzarella'
      iv_planetype    = 'A310-200F'
    EXCEPTIONS
      wrong_planetype = 1.
  IF sy-subrc = 0.
    APPEND go_passenger TO gt_passenger.
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


CREATE OBJECT go_cargo
    EXPORTING
      iv_name         = 'AA Los Angeles'
      iv_planetype    = '737-200SF'
    EXCEPTIONS
      wrong_planetype = 1.
  IF sy-subrc = 0.
    APPEND go_airplane TO gt_airplanes.
  ENDIF.


  LOOP AT gt_airplanes INTO go_airplane.
    go_airplane->display_attributes( ).
  ENDLOOP.

      LOOP AT gt_passenger INTO go_passenger.
    go_passenger->display_attributes( ).

  ENDLOOP.

  gv_count = lcl_airplane=>get_n_no_airplanes( ).
  SKIP 2.
  WRITE: / 'Number of Airplanes'(ca1), gv_count.
