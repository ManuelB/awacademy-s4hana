*&---------------------------------------------------------------------*
*& Report Z_S02_SQL_TABELLE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s02_sql_tabelle.


*** Tabelle einlesen und in eigene reinfüllen

select * INTO TABLE @DATA(tspfli) "achtung, nur 1x machen
  FROM spfli.

  BREAK-POINT.

  modify zs02_spfli from table tspfli.

  IF sy-subrc = 0.
    COMMIT WORK.

  ENDIF.




*  select * INTO TABLE @DATA(tsflight)
*  FROM sflight.
*
*  BREAK-POINT.
*
*  modify ZS02_SFLIGHT from table tsflight.
*
*  IF sy-subrc = 0.
*    COMMIT WORK.
*
*  ENDIF.



*SELECT * INTO TABLE @DATA(tscarr)
*FROM scarr.
*
**BREAK-POINT.
*
*modify ZS02_Scarr FROM TABLE tscarr.
*
*
*IF sy-subrc = 0.
*  COMMIT WORK.
*
*ENDIF.
