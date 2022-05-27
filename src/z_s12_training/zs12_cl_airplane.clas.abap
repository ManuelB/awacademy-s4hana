CLASS zs12_cl_airplane DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zs12_if_airplane .

    CLASS-METHODS class_constructor .
  PROTECTED SECTION.

    DATA c_pos_1 TYPE i VALUE 30 ##NO_TEXT.
  PRIVATE SECTION.

    DATA ty_planetypes TYPE zt03_ttyp_saplane .
    DATA mv_name TYPE string .
    DATA mv_planetype TYPE saplane-planetype .
    DATA mv_weight TYPE saplane-weight .
    DATA mv_tankcap TYPE saplane-tankcap .
    DATA gv_n_o_airplanes TYPE i .
    DATA gt_planetypes TYPE REF TO ty_planetypes .

    METHODS get_n_no_airplanes .
    CLASS-METHODS get_technical_attributes .
    METHODS display_n_o_airplanes .
ENDCLASS.



CLASS ZS12_CL_AIRPLANE IMPLEMENTATION.


  METHOD class_constructor.
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

  ENDMETHOD.


  METHOD display_n_o_airplanes.
    SKIP.
    WRITE:
     / 'Number of Airplanes:'(ca1), AT c_pos_1 gv_n_o_airplanes  LEFT-JUSTIFIED.
  ENDMETHOD.


  METHOD get_n_no_airplanes.
    rv_count = gv_n_o_airplanes.
  ENDMETHOD.


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
  ENDMETHOD.


  METHOD zs12_if_airplane~constructor.
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
  ENDMETHOD.


  METHOD zs12_if_airplane~display_attributes.
    / icon_ws_plane AS ICON,
    / 'Name of Airplane'(001) ,
    AT c_pos_1 mv_name,
      / 'Type of Airplane'(002) ,
      AT c_pos_1 mv_planetype,
        / 'Weight'(003) ,
        AT c_pos_1 mv_weight LEFT-JUSTIFIED,
          / 'Tank Capacity'(004) ,
          AT c_pos_1 mv_tankcap LEFT-JUSTIFIED.
          endmethod.
ENDCLASS.
