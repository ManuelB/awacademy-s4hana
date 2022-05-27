*&---------------------------------------------------------------------*
*& Report Z_S11_HOST_VAR
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s11_host_var.


*SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME.
*  PARAMETERS: p_cfrm type spfli-countryfr,
**type spfli-countryfr VALUE CHECK, "Entry 'US' does not exist in SGEOCITY (check entry)
**p_cfrm2 TYPE land1 value check. "does not show the suggested input help because there is no search help associated to data element land1.,
**p_cfrm2 TYPE land1 value check. "does not check the entries against value table in land1 domain.
*
*
**  p_carrid type s_carr_id VALUE CHECK. "VALUE CHECK not working
**  p_carrid type s_carr_id.
*  p_carrid type spfli-carrid VALUE CHECK.
*SELECTION-SCREEN END OF BLOCK a1.
*
*
*
*  SELECT carrid, connid, countryfr, cityfrom, cityto, arrtime, countryto INTO @DATA(flights)
*    FROM spfli
*    WHERE countryfr = @p_cfrm
*    AND carrid = @p_carrid.
*
*
*
*
*
*write :/ flights-carrid, flights-connid, flights-countryfr, flights-cityfrom, flights-countryto,
*flights-cityto, flights-arrtime.
*ENDSELECT.

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME.
  PARAMETERS : p_carr TYPE s_carr_id,
  p_flight type s_date,
  p_preis type s_price.
SELECTION-SCREEN END OF BLOCK a1.



SELECT SINGLE carrid, connid, fldate, price into @DATA(flights)
  FROM sflight
  WHERE carrid = @p_carr
  and fldate = @p_flight
  and price >= @p_preis.

BREAK-POINT.
