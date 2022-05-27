*&---------------------------------------------------------------------*
*& Report ZS06_EXTRA_SESH1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zs06_extra_sesh1.

CLASS raindrops DEFINITION.
  PUBLIC SECTION.

    METHODS: modolo

      IMPORTING p_input          TYPE i
      RETURNING VALUE(result) TYPE string.
ENDCLASS.

CLASS raindrops IMPLEMENTATION.

  METHOD modolo.
    DATA:
          rain TYPE string.

    IF p_input MOD 3 = 0.
      rain = rain && 'Pling'.
    ENDIF.
    IF p_input MOD 5 = 0.
      rain = rain && 'Plang'.
    ENDIF.
    IF p_input MOD 7 = 0.
      rain = rain && 'Plong'.
    ENDIF.
    IF rain = ''.
      result = p_input.
    ELSE.
      result = rain.
    ENDIF.

  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  PARAMETERS:
  p_input TYPE i DEFAULT 100.

  DATA(my_raindrops) = NEW raindrops( ).
Write:
  my_raindrops->modolo( p_input ).
