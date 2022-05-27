*&---------------------------------------------------------------------*
*& Report Z_AW07_HOST_VARIABLEN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_AW07_HOST_VARIABLEN.




SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME.
  PARAMETERS p_cityfr type s_from_cit.
  PARAMETERS p_cityto type s_to_city.
  SELECTION-SCREEN END of block a1.



  START-OF-SELECTION.

 SELECT SINGLE for UPDATE cityfrom,


*  select carrid, airpto  INTO @data(flights)
*    from sflight
*    WHERE carrid = @p_carr.

*START-OF-SELECTION.

SELECT SINGLE FOR UPDATE land, land_descript  INTO @DATA(flights)
  FROM zawt03_countries
  WHERE land  = 'DE'.

BREAK-POINT.

UPDATE zawt03_countries SET land_descript = 'Kartoffelland' WHERE Land = flights-land.
COMMIT WORK.
