*&---------------------------------------------------------------------*
*& Report Z_S11_SQL_SELECT_DISTINCT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S11_SQL_SELECT_DISTINCT.

PARAMETERS : p_carrid type spfli-carrid DEFAULT 'AZ',
p_cityfr type spfli-cityfrom DEFAULT 'ROME'.

SELECT carrid, countryfr, cityfrom, countryto, cityto, distance "Selects all the countries with given carrier id and cityfrom
  FROM spfli
  Where carrid = @p_carrid AND
  cityfrom = @p_cityfr
  INTO TABLE @DATA(result).
    cl_demo_output=>display( result ).



  SELECT DISTINCT carrid, countryfr, cityfrom "Removes the rows that occur more than once in a multi row result set.
  FROM spfli
  Where carrid = @p_carrid AND
  cityfrom = @p_cityfr
  INTO TABLE @DATA(result2).
    cl_demo_output=>display( result2 ).
