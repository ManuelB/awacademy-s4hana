*&---------------------------------------------------------------------*
*& Report Z_S11_SQL_COUNT_DISTINCT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S11_SQL_COUNT_DISTINCT.

SELECT COUNT( carrid )
  FROM spfli
  where cityfrom = 'FRANKFURT'
  INTO @data(Count).


SELECT COUNT( distinct carrid )
  FROM scarr
  INTO @data(Count_Flugesellschaft).

SELECT COUNT( distinct carrid )
  FROM spfli
   where cityto = 'FRANKFURT'
  INTO @data(Count_Flugesellschaft_spfli).

*Calculating no of carriers flying to chicago and dispalying in a table
  SELECT carrid, COUNT( distinct carrid ) as no_of_carriers_to_chicago
  FROM spfli
   where cityto = 'CHICAGO'
    GROUP BY carrid
  INTO TABLE @data(Count_Flugesellschaft_spfli2).

  BREAK-POINT.
