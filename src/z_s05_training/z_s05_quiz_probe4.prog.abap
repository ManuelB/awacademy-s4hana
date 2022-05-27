*&---------------------------------------------------------------------*
*& Report Z_S05_QUIZ_PROBE4
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S05_QUIZ_PROBE4.

*PARAMETERS: b type i default 4.
*data: res Type I VALUE 5.
*      WRITe: b, res.
*      perform rechne using res changing b.
*      write: b, res.
*      FORM rechne using b changing c.
*        DATA: res type i value 6.
*        c = res.
*        WRITE: b, res.
*        ENDFORM.

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
*
*                cl_demo_output=>display( result ).


*PARAMETERS: b TYPE i DEFAULT 4.
*DATA: res TYPE i VALUE 5.
*WRITE: b, res.
*PERFORM rechne USING res CHANGING b.
*WRITE: b, res.
*FORM rechne USING b CHANGING c.
*DATA: res TYPE i VALUE 6.
*c = res.
*WRITE: b, res.
*ENDFORM.

TYPEs:
BEGIN OF lty_s_car_attributes,
color(16) TYPE c,
np TYPE i,
doors TYPE p DECIMALS 1,
END OF lty_s_car_attributes,



BEGIN OF lty_s_car,
manufacturer(16) TYPE c,
model(16) TYPE c,

attributes TYPE lty_s_car_attributes,

END OF lty_s_car.



DATA car TYPE lty_s_car.

PARAMETERS: p_color TYPE lty_s_car_attributes-color.
