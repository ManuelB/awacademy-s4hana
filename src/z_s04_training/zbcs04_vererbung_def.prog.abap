*&---------------------------------------------------------------------*
*& Include          ZBC401_VERERBUNG_DEF
*&---------------------------------------------------------------------*

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
* sichtbarkeit in Unterklasse
    CONSTANTS:
       c_pos_1 TYPE i VALUE 30.


  PRIVATE SECTION.

    TYPES:
    ty_planetypes TYPE TABLE OF saplane
    WITH NON-UNIQUE KEY planetype.

*----------------------------------------------
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
*-- class lcl_passenger_airplane
CLASS lcl_passenger_plane DEFINITION INHERITING FROM lcl_airplane.

  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING
          iv_name      TYPE string
          iv_planetype TYPE saplane-planetype
          iv_seats     TYPE s_seatsmax
        EXCEPTIONS
          wrong_planetype ,

      display_attributes REDEFINITION.

  PROTECTED SECTION.

    DATA: mv_seats TYPE s_seatsmax.

ENDCLASS." lcl_passenger_plane


******** class lcl_cargo_airplane
CLASS lcl_cargo_plane DEFINITION INHERITING FROM lcl_airplane.

  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING
          iv_name      TYPE string
          iv_planetype TYPE saplane-planetype
          iv_cargo     TYPE scplane-cargomax
        EXCEPTIONS
          wrong_planetype ,

      display_attributes REDEFINITION.

  PROTECTED SECTION.

    DATA: mv_cargo TYPE scplane-cargomax.

ENDCLASS." lcl_passenger_plane
