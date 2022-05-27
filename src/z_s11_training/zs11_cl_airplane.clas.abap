class ZS11_CL_AIRPLANE definition
  public
  final
  create public .

public section.

  interfaces ZS11_IF_AIRPLANE .
protected section.

  constants C_POS_1 type I value 30 ##NO_TEXT.
private section.

  data MV_NAME type STRING .
  data MV_PLANETYPE type SAPLANE-PLANETYPE .
  data MV_WEIGHT type SAPLANE-WEIGHT .
  data MV_TANKCAP type SAPLANE-TANKCAP .
ENDCLASS.



CLASS ZS11_CL_AIRPLANE IMPLEMENTATION.


  method ZS11_IF_AIRPLANE~DISPLAY_ATTRIBUTES.
    WRITE:
     / icon_ws_plane AS ICON,
     / 'Name of Airplane'(001) , AT c_pos_1 mv_name,
     / 'Type of Airplane'(002) , AT c_pos_1 mv_planetype,
     / 'Weight'(003) , AT c_pos_1 mv_weight LEFT-JUSTIFIED,
     / 'Tank Capacity'(004) , AT c_pos_1 mv_tankcap LEFT-JUSTIFIED.

  endmethod.
ENDCLASS.
