*&---------------------------------------------------------------------*
*& Include          ZMP_GRP3_STROM_WECHSELF01
*&-----CLASS lcl_listener IMPLEMENTATION.
*-----------------------------------------*

CLASS lcl_listener IMPLEMENTATION.

  METHOD handle_double_click.
    DATA:
      my_caption TYPE c LENGTH 256.
    READ TABLE lt_kunde INDEX e_row-index INTO ls_kunde.
    CONCATENATE 'Lieferantenwechsel Status von:' ls_kunde-vorname  ls_kunde-name
      INTO my_caption SEPARATED BY space.
    SELECT * FROM   zgrp3_liefwe INTO TABLE lt_liefwe
      WHERE kunnr = ls_kunde-kunnr.

    IF dia IS INITIAL.
      CREATE OBJECT dia
        EXPORTING
          width   = 500
          height  = 200
          top     = 50
          left    = 50
          caption = my_caption.
      CREATE OBJECT alv2
        EXPORTING
          i_parent = dia.
    ELSE.
      alv2->refresh_table_display( ).
    ENDIF.
    CALL METHOD alv2->set_table_for_first_display
      EXPORTING
        i_structure_name = 'ZGRP3_LIEFWE'
      CHANGING
        it_outtab        = lt_liefwe.

  ENDMETHOD.

ENDCLASS.
