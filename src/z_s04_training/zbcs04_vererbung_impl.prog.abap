*&---------------------------------------------------------------------*
*& Include          ZBC401_VERERBUNG_IMPL
*&---------------------------------------------------------------------*

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
    TRANSPORTING weight tankcap seatsmax.

    IF sy-subrc = 0.
      ev_weight = ls_planetype-weight.
      ev_tankcap = ls_planetype-tankcap.

    ELSE.
      RAISE wrong_planetype.
    ENDIF.

  ENDMETHOD." get_technical_atrributes.

ENDCLASS. " lcl_airplane implementation.

CLASS lcl_passenger_plane IMPLEMENTATION.

  METHOD constructor.

    super->constructor(
      EXPORTING
        iv_name         = iv_name
        iv_planetype    = iv_planetype
      EXCEPTIONS
        wrong_planetype = 1
    ).

    IF sy-subrc NE 0.
      RAISE wrong_planetype .
    ENDIF.

    mv_seats = iv_seats.

  ENDMETHOD.

  METHOD display_attributes.

    super->display_attributes( ).

    WRITE: / 'Max Seats:'(006), AT c_pos_1 mv_seats LEFT-JUSTIFIED.
    ULINE.

  ENDMETHOD.

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
      RAISE wrong_planetype .
    ENDIF.

    mv_cargo = '45000'.

  ENDMETHOD.

  METHOD display_attributes.

    super->display_attributes( ).

    WRITE: / 'Max. Cargo:'(005), AT c_pos_1 mv_cargo LEFT-JUSTIFIED.
    ULINE.

  ENDMETHOD.

ENDCLASS.
