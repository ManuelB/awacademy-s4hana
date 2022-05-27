*&---------------------------------------------------------------------*
*& Include          ZSD_GRP1_DEALINGSWEETSF01
*&---------------------------------------------------------------------*

CLASS lcl_mp1_grp1 IMPLEMENTATION.

  METHOD neuart.
    ENDMETHOD.

  METHOD neupreis.
    SELECT SINGLE FOR UPDATE artnr, vkpreis, mnvkpreis FROM zsd_grp1_sw
    WHERE artnr = @artnr
    AND vkpreis = @neupr
    INTO @DATA(ls_neupreis).
    IF neupr >= ls_neupreis-mnvkpreis. "IF-Schachtelung???
      UPDATE zsd_grp1_sw SET vkpreis = @neupr WHERE artnr = @artnr.
    ELSE.
      MESSAGE e003.
    ENDIF.
    IF neupr <= ls_neupreis-vkpreis * '1.25'.
      UPDATE zsd_grp1_sw SET vkpreis = @neupr WHERE artnr = @artnr.
    ELSE.
      MESSAGE e004.
    ENDIF.
  ENDMETHOD.

  METHOD warenbestand.
    SELECT artnr, artname, artgr, akbes
      FROM zsd_grp1_sw
      ORDER BY artgr
      INTO TABLE @DATA(warenbestand).
    cl_demo_output=>display( warenbestand ).
  ENDMETHOD.

  METHOD auslisten.
      SELECT SINGLE FOR UPDATE artnr, activeflag FROM zsd_grp1_sw
    WHERE artnr = @artnr
    INTO @DATA(ls_artnr).
    UPDATE zsd_grp1_sw SET activeflag = ' ' WHERE artnr = @artnr.
    MESSAGE: e005 WITH artnr.
    ENDMETHOD.

ENDCLASS.
