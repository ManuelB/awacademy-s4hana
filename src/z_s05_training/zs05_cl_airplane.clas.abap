class ZS05_CL_AIRPLANE definition
  public
  create public .

public section.

  interfaces ZS05_IF_AIRPLANE .

  methods CONSTRUCTOR
    importing
      !IV_NAME type STRING
      !IV_PLANETYPE type SAPLANE-PLANETYPE
    exceptions
      WRONG_PLANETYPE .
  class-methods CLASS_CONSTRUCTOR .
protected section.
private section.
ENDCLASS.



CLASS ZS05_CL_AIRPLANE IMPLEMENTATION.


  method CLASS_CONSTRUCTOR.
     SELECT * FROM saplane INTO TABLE zs05_if_airplane~gt_planetypes.
  endmethod.


  method CONSTRUCTOR.
 zs05_if_airplane~mv_name = iv_name.
    zs05_if_airplane~mv_planetype = iv_planetype.

    zs05_if_airplane~get_technical_attributes(
      EXPORTING
        iv_type         = iv_planetype
      IMPORTING
        ev_weight       = zs05_if_airplane~mv_weight
        ev_tankcap      = zs05_if_airplane~mv_tankcap
      EXCEPTIONS
        wrong_planetype = 1
    ).

    IF sy-subrc NE 0.
      RAISE wrong_planetype.
    ELSE.
      zs05_if_airplane~gv_n_o_airplanes = zs05_if_airplane~gv_n_o_airplanes + 1.
    ENDIF.


  endmethod.


  method ZS05_IF_AIRPLANE~DISPLAY_ATTRIBUTES.
    WRITE:
     / icon_ws_plane AS ICON,
     / 'Name of Airplane'(001) , AT zs05_if_airplane~c_pos_1 zs05_if_airplane~mv_name,
     / 'Type of Airplane'(002) , AT zs05_if_airplane~c_pos_1 zs05_if_airplane~mv_planetype,
     / 'Weight'(003) , AT zs05_if_airplane~c_pos_1 zs05_if_airplane~mv_weight LEFT-JUSTIFIED,
     / 'Tank Capacity'(004) , AT zs05_if_airplane~c_pos_1 zs05_if_airplane~mv_tankcap LEFT-JUSTIFIED.
  endmethod.


  method ZS05_IF_AIRPLANE~DISPLAY_N_O_AIRPLANES.
    SKIP.
    WRITE:
     / 'Number of Airplanes:'(ca1), AT zs05_if_airplane~c_pos_1 zs05_if_airplane~gv_n_o_airplanes  LEFT-JUSTIFIED.
  endmethod.


  method ZS05_IF_AIRPLANE~GET_N_NO_AIRPLANES.
    rv_count = gv_n_o_airplanes.
  endmethod.


  method ZS05_IF_AIRPLANE~GET_TECHNICAL_ATTRIBUTES.
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
  endmethod.
ENDCLASS.
