*&---------------------------------------------------------------------*
*& Report ZAW_S04_HOSTVAR
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zaws04_sql_hostvar.

START-OF-SELECTION.

SELECT SINGLE FOR UPDATE land, land_descript  INTO @DATA(flights)
  FROM zawt03_countries
  WHERE land  = 'DE'.

BREAK-POINT.

UPDATE zawt03_countries SET land_descript = 'Kartoffelland' WHERE Land = flights-land.
COMMIT WORK.
