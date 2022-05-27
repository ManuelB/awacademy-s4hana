CLASS z_t01_fibonacci DEFINITION
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



CLASS z_t01_fibonacci IMPLEMENTATION.
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
