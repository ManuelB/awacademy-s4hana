class ZS06_CL_AIRPLANE definition
  public
  create public .

public section.

  data RV_COUNT type I .

  class-methods CLASS_CONSTRUCTOR .
protected section.
private section.

  data TY_PLANETYPES type ACMHEX_PLANETYPE .

  methods DISPLAY_N_O_AIRPLANES .
  methods GET_N_NO_AIRPLANES .
ENDCLASS.



CLASS ZS06_CL_AIRPLANE IMPLEMENTATION.


  method CLASS_CONSTRUCTOR.
  endmethod.


  method DISPLAY_N_O_AIRPLANES.
  endmethod.


  method GET_N_NO_AIRPLANES.
  endmethod.
ENDCLASS.
