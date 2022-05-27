FUNCTION ZS05_FLUGLISTE_RICHTIG.
*"--------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     REFERENCE(I_CARRID) TYPE  SFLIGHT-CARRID OPTIONAL
*"     REFERENCE(I_CONNID) TYPE  SFLIGHT-CONNID OPTIONAL
*"     REFERENCE(I_FLDATE) TYPE  SFLIGHT-FLDATE OPTIONAL
*"     REFERENCE(I_PRICE) TYPE  SFLIGHT-PRICE OPTIONAL
*"     REFERENCE(I_CURRENCY) TYPE  SFLIGHT-CURRENCY OPTIONAL
*"     REFERENCE(I_PLANETYPE) TYPE  SFLIGHT-PLANETYPE OPTIONAL
*"     REFERENCE(I_SEATSMAX) TYPE  SFLIGHT-SEATSMAX OPTIONAL
*"     REFERENCE(I_SEATSOCC) TYPE  SFLIGHT-SEATSOCC OPTIONAL
*"     REFERENCE(I_PAYMENTSUM) TYPE  SFLIGHT-PAYMENTSUM OPTIONAL
*"     REFERENCE(I_SEATSMAX_B) TYPE  SFLIGHT-SEATSMAX_B OPTIONAL
*"     REFERENCE(I_SEATSOCC_B) TYPE  SFLIGHT-SEATSOCC_B OPTIONAL
*"     REFERENCE(I_SEATSMAX_F) TYPE  SFLIGHT-SEATSMAX_F OPTIONAL
*"     REFERENCE(I_SEATSOCC_F) TYPE  SFLIGHT-SEATSMAX_F OPTIONAL
*"  EXPORTING
*"     REFERENCE(EX_FLUGLISTE) TYPE  SFLIGHT_TAB2
*"  TABLES
*"      FLUGLISTE STRUCTURE  SFLIGHT
*"  EXCEPTIONS
*"      NOTHING_FOUND
*"--------------------------------------------------------------------

 IF i_carrid IS NOT INITIAL.
    SELECT * FROM sflight INTO TABLE flugliste
      WHERE carrid = i_carrid.
  ELSE.
    SELECT * FROM sflight INTO TABLE flugliste.
  ENDIF.
  IF sy-subrc <> 0.
    RAISE nothing_found.
  ENDIF.

IF i_connid IS NOT INITIAL.
    SELECT * FROM sflight INTO TABLE flugliste
      WHERE connid = i_connid.
  ELSE.
    SELECT * FROM sflight INTO TABLE flugliste.
  ENDIF.
  IF sy-subrc <> 0.
    RAISE nothing_found.
  ENDIF.


IF i_fldate IS NOT INITIAL.
    SELECT * FROM sflight INTO TABLE flugliste
      WHERE fldate = i_fldate.
  ELSE.
    SELECT * FROM sflight INTO TABLE flugliste.
  ENDIF.
  IF sy-subrc <> 0.
    RAISE nothing_found.
  ENDIF.

  IF i_planetype IS NOT INITIAL.
    SELECT * FROM sflight INTO TABLE flugliste
      WHERE planetype = i_planetype.
  ELSE.
    SELECT * FROM sflight INTO TABLE flugliste.
  ENDIF.
  IF sy-subrc <> 0.
    RAISE nothing_found.
  ENDIF.

  IF i_seatsmax IS NOT INITIAL.
    SELECT * FROM sflight INTO TABLE flugliste
      WHERE seatsmax = i_seatsmax.
  ELSE.
    SELECT * FROM sflight INTO TABLE flugliste.
  ENDIF.
  IF sy-subrc <> 0.
    RAISE nothing_found.
  ENDIF.

  IF i_seatsocc IS NOT INITIAL.
    SELECT * FROM sflight INTO TABLE flugliste
      WHERE seatsocc = i_seatsocc.
  ELSE.
    SELECT * FROM sflight INTO TABLE flugliste.
  ENDIF.
  IF sy-subrc <> 0.
    RAISE nothing_found.
  ENDIF.

  IF i_paymentsum IS NOT INITIAL.
    SELECT * FROM sflight INTO TABLE flugliste
      WHERE paymentsum = i_paymentsum.
  ELSE.
    SELECT * FROM sflight INTO TABLE flugliste.
  ENDIF.
  IF sy-subrc <> 0.
    RAISE nothing_found.
  ENDIF.

  IF i_seatsocc_b IS NOT INITIAL.
    SELECT * FROM sflight INTO TABLE flugliste
      WHERE seatsocc_b = i_seatsocc_b.
  ELSE.
    SELECT * FROM sflight INTO TABLE flugliste.
  ENDIF.
  IF sy-subrc <> 0.
    RAISE nothing_found.
  ENDIF.


IF i_seatsmax_f IS NOT INITIAL.
    SELECT * FROM sflight INTO TABLE flugliste
      WHERE seatsmax_f = i_seatsmax_f.
  ELSE.
    SELECT * FROM sflight INTO TABLE flugliste.
  ENDIF.
  IF sy-subrc <> 0.
    RAISE nothing_found.
  ENDIF.


  IF i_seatsocc_f IS NOT INITIAL.
    SELECT * FROM sflight INTO TABLE flugliste
      WHERE seatsocc_f = i_seatsocc_f.
  ELSE.
    SELECT * FROM sflight INTO TABLE flugliste.
  ENDIF.
  IF sy-subrc <> 0.
    RAISE nothing_found.
  ENDIF.



SELECT * FROM sflight INTO TABLE ex_flugliste.

ENDFUNCTION.
