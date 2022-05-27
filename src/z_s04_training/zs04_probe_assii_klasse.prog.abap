REPORT zs04_probe_assii_klasse.

*CLASS lcx_kauefer_zu_jung_exception DEFINITION INHERITING FROM cx_static_check.
*ENDCLASS.
*
*CLASS lcl_laden DEFINITION.
*  PUBLIC SECTION.
*    METHODS alkohol_kaufen IMPORTING im_alter TYPE i RAISING   lcx_kauefer_zu_jung_exception.
*ENDCLASS.
*
*CLASS lcl_laden IMPLEMENTATION.
*  METHOD alkohol_kaufen.
*  IF im_alter < 18.
*  RAISE EXCEPTION
*  ENDMETHOD.
*ENDCLASS.
*
*




*
*
*
*CLASS laden IMPLEMENTATION.
*
*
*
*  METHOD alkohol_kaufen.
*    IF
*    endmethod.
*
*
*
*ENDCLASS.
*
*
*
*CLASS cx_kaufer_zu_jung_exception IMPLEMENTATION.
*ENDCLASS.
*
*
*
*
*START-OF-SELECTION.
*
*
*
*  PARAMETERS:
*  p_alter TYPE i DEFAULT 17.
