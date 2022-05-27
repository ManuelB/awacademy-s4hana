class ZS12_CL_PASSENGER_PLANE definition
  public
  final
  create public .

public section.

  interfaces ZS12_IF_AIRPLANE .
protected section.

  data MV_SEATS type S_SEATSMAX .
private section.
ENDCLASS.



CLASS ZS12_CL_PASSENGER_PLANE IMPLEMENTATION.


  method ZS12_IF_AIRPLANE~CLASS_CONSTRUCTOR.
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
  endmethod.


  method ZS12_IF_AIRPLANE~DISPLAY_ATTRIBUTES.
    super->display_attributes( ).

    WRITE: / 'Max Seats:'(006), AT c_pos_1 mv_seats LEFT-JUSTIFIED.
    ULINE.
  endmethod.
ENDCLASS.
