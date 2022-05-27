*&---------------------------------------------------------------------*
*& Report Z_S11_ASSESSMENT_1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S11_ASSESSMENT_1.




*PARAMETERS:
*  g_amnt  TYPE p length 5 decimals 2 DEFAULT 200,
*   p_grcrs RADIOBUTTON GROUP rb_1,
* p_c_gds RADIOBUTTON GROUP rb_1.
*
*data : res_g_amnt type p length 5 decimals 2,
*      res_vat type p length 5 decimals 2.
*
*case 'X'.
*  when p_grcrs.
*
*PERFORM cal_groceries USING g_amnt CHANGING res_g_amnt res_vat.
*write :/ 'The gross amount is :', res_g_amnt, 'The calculated vat is :', res_vat.
*
* when p_c_gds.
*
*PERFORM cal_c_goods USING g_amnt CHANGING res_g_amnt res_vat.
*write :/ 'The gross amount is :', res_g_amnt, 'The calculated vat is :', res_vat.
*endcase.
*
**
*
*FORM cal_groceries USING amnt CHANGING g_amnt vat.
* vat =  ( 7 / 100 ) * amnt.
* g_amnt = amnt.
*ENDFORM.
*
*FORM cal_c_goods USING amnt CHANGING g_amnt vat.
* vat =  ( 19 / 100 ) * amnt.
* g_amnt = amnt.
*ENDFORM.
*
*form ausgabe USING a op b res.
*  data x type i value 3.
*WRITE: /3 a,
*       / op, b.
*ULINE /3(12).
*WRITE: /3 res.
*ENDFORM.

*SELECT carrid, connid, SUM( seatsocc ) AS seatsocc
*
*       FROM sflight
*
*       GROUP BY carrid, connid
*
*       ORDER BY carrid, connid
*
*       INTO TABLE @DATA(fluege).
*
*ENDSELECT.
***************************************************************************************************************
*SELECT FROM spfli
*             FIELDS carrid,
*                          connid,
*                          cityfrom,
*                          cityto,
*              CASE WHEN fltime < 225 THEN 'Kurzstrecke'
*                         WHEN fltime BETWEEN 225 AND 300 THEN 'Mittelstrecke'
*                         ELSE 'Langstrecke'
*              END AS flkat
*       ORDER BY carrid, connid
*       INTO TABLE @DATA(result).
****************************************************************************************************************
PARAMETERS: b TYPE i DEFAUlT 4.
DATA: res TYPE i VALUE 5.
WRITE: b, res.
PERFORM rechne USING res CHANGING b.
WRITE:b, res.
FORM rechne USING b CHANGING c.
  DATA: res TYPE i VALUE 6.
  c = res.
  WRITE: b, res.
ENDFORM.
***************************************************************************************************************
