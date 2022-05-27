*&---------------------------------------------------------------------*
*& Report z_s09_assessment_probe
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s09_assessment_probe.



CLASS c_auto DEFINITION.

  PUBLIC SECTION.
    EVENTS:

      tank_leer.
    METHODS:
      constructor,
      fahren,
      tanken

        FOR EVENT tank_leer OF c_auto.

ENDCLASS.

CLASS c_auto IMPLEMENTATION.

  METHOD constructor.
    SET HANDLER me->tanken FOR me.

  ENDMETHOD.

  METHOD fahren.
    WRITE: / 'fahren'.

    RAISE EVENT tank_leer.

  ENDMETHOD.

  METHOD tanken.

    WRITE: / 'tanken'.
  ENDMETHOD.
ENDCLASS.

CLASS c_tankstelle DEFINITION.

  PUBLIC SECTION.

    EVENTS:

      guenstig.

    METHODS:

      set_preis IMPORTING im_preis TYPE i,
      get_preis RETURNING VALUE(re_preis) TYPE i,

      entscheiden,

      verkaufen FOR EVENT XXX OF c_tankstelle.

    DATA:

    preis TYPE i.

ENDCLASS.

CLASS c_tankstelle IMPLEMENTATION.

  METHOD set_preis.

    me->preis = XXX.

  ENDMETHOD.

  METHOD get_preis.

    XXX = me->preis.

  ENDMETHOD.

  METHOD entscheiden.
    IF me->get_preis( ) < 5000.

      RAISE EVENT guenstig.

    ELSE.
      WRITE: /'behalten'.

    ENDIF.
  ENDMETHOD.

  METHOD verkaufen.

    WRITE: / 'verkaufen'.
  ENDMETHOD.

ENDCLASS.
XXX
PARAMETERS:

preis TYPE i DEFAULT 2000.

DATA:
  r_auto       TYPE REF TO c_auto,
  r_tankstelle TYPE REF TO c_tankstelle.

r_auto = NEW c_auto( ).

r_tankstelle = NEW c_tankstelle( ).

SET HANDLER r_tankstelle->verkaufen FOR r_tankstelle.

r_auto->fahren( ).

r_tankstelle->set_preis( preis ).
XXX->entscheiden( ).
