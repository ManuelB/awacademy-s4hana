CLASS z_s01_fibonacci DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS: calculate
        IMPORTING number TYPE i
        RETURNING VALUE(ret) TYPE i.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS Z_S01_FIBONACCI IMPLEMENTATION.


  METHOD calculate.
    IF number EQ 0.
        ret = 0.
    ELSEIF number EQ 1.
        ret = 1.
    ELSE.
        ret = me->calculate( number - 1 ) + me->calculate( number - 2 ).
    ENDIF.

  ENDMETHOD.
ENDCLASS.
