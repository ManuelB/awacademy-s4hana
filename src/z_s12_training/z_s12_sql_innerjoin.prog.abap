*&---------------------------------------------------------------------*
*& Report Z_S12_SQL_INNERJOIN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s12_sql_innerjoin.

DATA:
  cityfr TYPE spfli-cityfrom VALUE 'FRANKFURT',
  cityto TYPE spfli-cityto   VALUE 'OSAKA'.

cl_demo_input=>new(
  )->add_field( CHANGING field = cityfr
  )->add_field( CHANGING field = cityto )->request( ).

SELECT c~carrname, p~connid, f~fldate
       FROM ( ( scarr AS c
         INNER JOIN spfli AS p ON p~carrid   = c~carrid "p wird spfli zugeordnet
                              AND p~cityfrom = @cityfr "alle mit p-gekennzeichneten Daten sind nur in der Tabelle spfli
                              AND p~cityto   = @cityto )
  "Join on - erfolgt über ein Datenelement das in allen Tabellen zu finden ist
  "anderes sind zusätzliche Selektionsbedingungen
         INNER JOIN sflight AS f ON f~carrid = p~carrid
                                AND f~connid = p~connid )
       ORDER BY c~carrname, p~connid, f~fldate
       INTO TABLE @DATA(itab).
  cl_demo_output=>display( ITAB ).


DATA:
  carrid TYPE spfli-carrid VALUE 'LH',
  cityto TYPE spfli-cityto   VALUE 'SAN FRANCISCO'.

cl_demo_input=>new(
  )->add_field( CHANGING field = carrid
  )->add_field( CHANGING field = cityto )->request( ).

SELECT c~cityfrom, p~connid, f~fldate
       FROM ( ( scarr AS c
         INNER JOIN spfli AS p ON p~carrid   = @carrid
                              AND p~cityto = @cityto )
         INNER JOIN sflight AS f ON f~connid = p~connid
  and f~cityfrom = p~cityfrom )
       ORDER BY c~carrid, p~cityfrom, f~fldate
       INTO TABLE @DATA(itab2).
cl_demo_output=>display( itab2 ).
