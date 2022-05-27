*&---------------------------------------------------------------------*
*& Report ZAWT03_EXEC_SQL_SIMPLE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zawt03_exec_sql_simple_r.

* data
DATA: carrid TYPE spfli-carrid VALUE 'LH',
      connid TYPE spfli-connid VALUE '400'.

cl_demo_input=>new(
  )->add_field( CHANGING field = carrid
  )->add_field( CHANGING field = connid )->request( ).


DATA: BEGIN OF wa,
        cityfrom TYPE spfli-cityfrom,
        cityto   TYPE spfli-cityto,
      END OF wa.

EXEC SQL.
  SELECT cityfrom, cityto
         INTO :wa
         FROM spfli
         WHERE mandt  = :sy-mandt
          AND carrid = :carrid
         AND connid = :connid
** syntax error wegen punkt ignorieren
ENDEXEC.

*-> Bedingung für Ausgesteuerung setzen
* Bedingung für Ausgabe -> check -> IF NOT -> IF xxxxx NE
cl_demo_output=>display( wa ).

"Embedded Native SQL
EXEC SQL.
  INSERT INTO demo_update VALUES( :sy-mandt, 'X', 1, 2, 3, 4 )
  commit work.
ENDEXEC.

BREAK-POINT.
"ADBC
TRY.
    NEW cl_sql_statement( )->execute_update(
          |INSERT INTO demo_update VALUES( '{
           sy-mandt }', 'X', 1, 2, 3, 4 )| ).
  CATCH cx_sql_exception.
    ...
ENDTRY.

BREAK-POINT.
