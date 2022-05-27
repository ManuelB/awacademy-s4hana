*&---------------------------------------------------------------------*
*& Report Z_S12_SQL_SELECT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s12_sql_select.




*select carrid, connid, SUM( seatsocc ) as seattaken
*  from sflight
*  GROUP BY carrid, connid
*  ORDER BY carrid, connid
*  into (@DATA(carrid),@DATA(connid),@DATA(seatsocc)).
*
*  ...
*  ENDSELECT.
*cl_demo_output=>display( carrid ).
*cl_demo_output=>display( connid ).
*cl_demo_output=>display( seatsocc ).



SELECT carrid, connid, SUM( seatsocc ) AS seattaken
FROM sflight
GROUP BY carrid, connid
ORDER BY carrid, connid
INTO TABLE @DATA(result).

...
*  ENDSELECT.
cl_demo_output=>display( result ).

DATA: BEGIN OF wa, "Beschreibung der Struktur
        carrid   TYPE sflight-carrid,
        connid   TYPE sflight-connid,
        seatsocc TYPE sflight-seatsocc,
      END OF wa,
      tline LIKE TABLE OF wa "Tabelle definiert
              WITH NON-UNIQUE DEFAULT KEY. " carrid connid und seatsocc werden nicht unique Schlüsselfelder (optional)

SELECT carrid, connid, SUM( seatsocc ) AS belegt "selektiert carrid, connid und Summe aller belegten Plätze
  FROM sflight
  GROUP BY carrid, connid "Summiert die Werte pro Flugnummer und Fluggesellschaft
  ORDER BY carrid, connid "Sortiert die Flugnummer und Fluggesellschaften
  INTO @wa.
  INSERT wa INTO TABLE tline. "Schreibt in interne Tabelle
ENDSELECT.

cl_demo_output=>display( tline ).
