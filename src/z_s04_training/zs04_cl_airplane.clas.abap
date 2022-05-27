class ZS04_CL_AIRPLANE definition
  public
  final
  create public .

public section.

  interfaces ZS04_IF_AIRPLANE .

  aliases GT_SAPLANE
    for ZS04_IF_AIRPLANE~C_POS_1 .

  methods CONSTRUCTOR
    importing
      value(IV_NAME) type STRING
      value(IV_PLANETYPE) type SAPLANE-PLANETYPE
    exceptions
      WRONG_PLANETYPE .
  class-methods CLASS_CONSTRUCTOR .
protected section.
private section.
ENDCLASS.



CLASS ZS04_CL_AIRPLANE IMPLEMENTATION.


  method CLASS_CONSTRUCTOR.
  endmethod.


  METHOD constructor.


  ENDMETHOD.


  METHOD zs04_if_airplane~display_attributes.

    WRITE:
    / icon_ws_plane AS ICON,
    / 'Name of Airplane'(001) , AT c_pos_1 mv_name,
    / 'Type of Airplane'(002) , AT c_pos_1 mv_planetype,
    / 'Weight'(003) , AT c_pos_1 mv_weight LEFT-JUSTIFIED,
    / 'Tank Capacity'(004) , AT c_pos_1 mv_tankcap LEFT-JUSTIFIED.

  ENDMETHOD.


  METHOD zs04_if_airplane~display_n_o_airplanes.

    SKIP.
    WRITE:
     / 'Number of Airplanes:'(ca1), AT c_pos_1 gv_n_o_airplanes  LEFT-JUSTIFIED.

  ENDMETHOD.


  METHOD zs04_if_airplane~get_n_no_airplanes.

    rv_count = gv_n_o_airplanes.

  ENDMETHOD.
ENDCLASS.
