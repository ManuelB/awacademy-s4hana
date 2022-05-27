*&---------------------------------------------------------------------*
*& Report ZAW_S04_HOSTVAR
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zaws04_sql_hostvar_2.

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME.
  PARAMETERS p_carrid TYPE s_carr_id.
SELECTION-SCREEN END OF BLOCK a1.


*START-OF-SELECTION.

  "SELECT carrid INTO @DATA(flights) FROM scarr WHERE carrid = @p_carrid.
  SELECT FROM scarr FIELDS carrid GROUP BY carrid INTO @DATA(flights).

  ENDSELECT.


*DATA lt_scarr  TYPE TABLE OF scarr.
*DATA ls_scarr  TYPE scarr.
*
*DATA lt_spfli  TYPE TABLE OF spfli.
*DATA ls_spfli  TYPE spfli.

  INCLUDE z_t04_i_flugdaten.
  DATA ls_spfli TYPE spfli.
  DATA ls_scarr TYPE scarr.
  DATA ls_sflight TYPE sflight.


  LOOP AT lt_scarr INTO ls_scarr WHERE carrid EQ p_carrid.
    WRITE: / | Alle Flugverbindungen der Fluggesellschaft: { ls_scarr-carrname } |.
  ENDLOOP.


  ULINE.


  LOOP AT lt_sflight INTO ls_sflight WHERE carrid EQ p_carrid.

    READ TABLE lt_spfli   WITH KEY carrid = p_carrid INTO ls_spfli.
    READ TABLE lt_scarr   WITH KEY carrid = p_carrid INTO ls_scarr.
    READ TABLE lt_sflight WITH KEY carrid = p_carrid INTO ls_sflight.

  "cl_demo_output=>display( flights ). (NICHT AKTIVIEREN!!! ENDLOSSCHLEIFE DIE SICH NICHT ABBRECHEN LÄSST!)

    WRITE: / "|Datum: { ls_sflight-fldate DATE = ISO }|,'|',
             |Abflugstadt: { ls_spfli-cityfrom },{ ls_spfli-countryfr }|,'|',
             |Zielstadt: { ls_spfli-cityto },{ ls_spfli-countryto }|,'|',
             |Distanz: { ls_spfli-distance }|,'|',
             |Flugzeit: { ls_spfli-fltime   } Min.|,'|',
             |Flugzeugtyp: { ls_sflight-planetype }|,'|',
             |Preis: { ls_sflight-price }€|,'|'.
             "|Buchungseinnahmen: { ls_sflight-paymentsum }€|.

  ENDLOOP.


  IF sy-subrc <> 0.
    WRITE: / 'KEINE FLUGVERBINDUNG GEFUNDEN!'.
  ENDIF.
