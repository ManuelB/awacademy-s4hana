*&---------------------------------------------------------------------*
*& Report Z_S12_SQL_SELECTCOUNT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s12_sql_selectcount.
"Wie viele Fluggesellschaften fliegen Walldorf an?
SELECT COUNT( DISTINCT carrid )
  FROM spfli
  WHERE cityto = 'WALLDORF'
  INTO @DATA(Ziel_Walldorf).
cl_demo_output=>display( Ziel_Walldorf ).

"Wie viele Fluggesellschaften starten von Rom?
SELECT COUNT( DISTINCT carrid )
FROM spfli
WHERE cityfrom = 'ROME'
INTO @DATA(start_ROM).
cl_demo_output=>display( start_ROM ).

"Wie viele Fluggesellschaften benutzen die Währung Dollar?
SELECT COUNT( DISTINCT carrid )
FROM scarr
WHERE currcode = 'USD'
INTO @DATA(Waehrung_USD).
cl_demo_output=>display( Waehrung_USD ).

*  SELECT COUNT( distinct carrid )
*  FROM spfli
*  WHERE cityto = 'WALLDORF'
*  INTO @DATA(count).
*  cl_demo_output=>display( count ).
