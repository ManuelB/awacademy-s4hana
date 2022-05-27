*&---------------------------------------------------------------------*
*& Report Z_S09_SQLCASE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s09_sqlcase.


SELECT FROM spfli
FIELDS carrid, connid, cityfrom, cityto, fltime AS Flugzeit,
CASE WHEN fltime < 100 THEN 'Kurzstrecke'
     WHEN fltime BETWEEN 100 AND 300 THEN 'Mittrlstrecke'
ELSE 'Landstrecke'
END AS fltime
ORDER BY carrid, connid
INTO TABLE @DATA(result).

BREAK-POINT
