*&---------------------------------------------------------------------*
*& Report Z_S02_SQL_UPDATE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s02_sql_update.

*SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME.
*
*
*  PARAMETERS: p_carr   TYPE s_carr_id DEFAULT 'LH',
*              p_connid TYPE s_conn_id DEFAULT '0400'.
*
*SELECTION-SCREEN END OF BLOCK a1.
*
*
*START-OF-SELECTION.
*
*  SELECT SINGLE carrid, connid, price INTO @DATA(flights)
*    FROM sflight
*    WHERE carrid = @p_carr
*    AND connid = @p_connid.
*
*  BREAK-POINT.
*
*  UPDATE sflight SET price = '100.00' WHERE carrid = 'LH' AND connid = '0400'.
*  COMMIT WORK.

****
*Aufgabe: Einzelsatz lesen und ein UPDATE machen.
****

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME.


  PARAMETERS: p_ziel   TYPE s_to_city,
              p_Flzeit TYPE s_fltime.

SELECTION-SCREEN END OF BLOCK a1.


START-OF-SELECTION.

  SELECT SINGLE cityto, fltime INTO @DATA(spfli)
    FROM spfli
    WHERE cityto = @p_ziel
    AND fltime = @p_flzeit.

  BREAK-POINT.

  UPDATE spfli SET cityto = 'ACE' WHERE fltime <= '300'.

  IF sy-subrc EQ 0.
  COMMIT WORK. "erst dadurch wird die Sperre aufgehoben und es wird in die Datenbank geschrieben
  ENDIF.

*WRITE: / spfli.

  BREAK-POINT.
