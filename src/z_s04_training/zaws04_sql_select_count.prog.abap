*&---------------------------------------------------------------------*
*& Report ZAWS04_SELECT_COUNT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zaws04_sql_select_count.

**********************************************************************
*Wie viele Fluggesellschaften starten von München:

SELECT COUNT( DISTINCT carrid )
  FROM zaws04_spfli
  WHERE cityfrom = 'MUNICH'
  INTO @DATA(Start_Munich).
cl_demo_output=>display( Start_Munich ).



**********************************************************************
*Wie viele Fluggesellschaften landen in San Francisco:

SELECT COUNT( DISTINCT carrid )
FROM zaws04_spfli
WHERE cityto = 'SAN FRANCISCO'
INTO @DATA(Ziel_SF).
cl_demo_output=>display( Ziel_SF ).



**********************************************************************
*Wie viele Fluggesellschaften haben als Hauswährung €:

SELECT COUNT( DISTINCT carrid )
FROM zaws04_scarr
WHERE currcode = 'EUR'
INTO @DATA(curr_eur).
cl_demo_output=>display( curr_eur ).



**********************************************************************
*Wie viele Fluggesellschaften fliegen am 23.01.2021:

DATA fldate TYPE sdate.

SELECT COUNT( DISTINCT carrid )
FROM sbook
WHERE fldate = '20210123'
INTO @DATA(fldate_2301).
cl_demo_output=>display( fldate_2301 ).



**********************************************************************
*Wie viele Ziele fliegt die Lufthansa von München aus an:

SELECT COUNT( cityto )
FROM zaws04_spfli
WHERE carrid = 'LH' AND
cityfrom = 'MUNICH'
INTO @DATA(lh_muc).
cl_demo_output=>display( lh_muc ).



**********************************************************************
*Welche Ziele fliegt die Lufthansa von München aus an:

SELECT DISTINCT cityto
  FROM zaws04_spfli
  WHERE carrid = 'LH' AND
  cityfrom = 'MUNICH'
  INTO TABLE @DATA(lh_mun_ziele).
cl_demo_output=>display( lh_mun_ziele ).
