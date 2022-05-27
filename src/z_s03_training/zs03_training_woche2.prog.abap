*&---------------------------------------------------------------------*
*& Report ZS03_TRAINING_WOCHE2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zs03_training_woche2.

*SELECT * INTO TABLE @DATA(tsbook)
*  FROM sbook.
*
*MODIFY zss03_sbook FROM TABLE tsbook.
*IF sy-subrc = 0.
*  COMMIT WORK.
*ENDIF.


*SELECT SINGLE * FROM spfli
*  WHERE carrid = 'LH' AND connid = '0400'
*  INTO @DATA(wa).
*cl_demo_output=>display( wa ).
*
*SELECT SINGLE * FROM spfli
*  WHERE carrid = 'LH' AND connid = '0400'
*  INTO @DATA(wa).
*cl_demo_output=>display( wa ).

*INITIALIZATION.
*
*SELECTION-SCREEN BEGIN OF BLOCK a1 with frame.
*
*PARAMETERS: p_carr TYPE S_CARR_ID DEFAULT 'AA',
* p_connid TYPE S_CONN_ID DEFAULT '0017',
* p_fltime TYPE S_FLTIME.
*
* SELECTION-SCREEN END OF BLOCK a1.
*
* START-OF-SELECTION.
*
* SELECT SINGLE FOR UPDATE carrid, connid, fltime
*   from ZS03_SPFLI
*   WHERE carrid = @p_carr and connid = @p_connid
*   INTO @DATA(flights).
*
*   UPDATE ZS03_SPFLI SET fltime = 111
*   WHERE carrid = @p_carr and connid = @p_connid.
*
*   if sy-subrc = 0.
*    COMMIT WORK.
*    ENDIF.
*    cl_demo_output=>display( flights ).


*SELECT DISTINCT cityto
*  FROM spfli
*  WHERE carrid = 'LH' AND cityfrom = 'MUNICH'
*  INTO @DATA(Lufthansa).
*ENDSELECT.
*cl_demo_output=>display( Lufthansa ).

*SELECT COUNT( DISTINCT carrid )
*  from ZS03_SPFLI
*  WHERE cityto = 'WALLDORF'
*  INTO @DATA(Verbindung_nach_Walldorf).
*  cl_demo_output=>display( Verbindung_nach_Walldorf ).

*SELECT FROM sflight
*  FIELDS carrid,
*  MIN( PRICE ) AS min_price,
*  MAX( PRICE ) AS max_price
*  GROUP BY carrid
*  INTO TABLE @DATA(result).
*
*   cl_demo_output=>display( result ).

*DATA: carrid TYPE zs03_Sbook-carrid VALUE 'LH',
*      connid TYPE zs03_Sbook-connid VALUE '400'.
*
*SELECT fldate, class, COUNT(*) AS class_cnt
*  FROM sbook
*  WHERE connid = @connid
*  GROUP BY carrid, fldate, class
*  HAVING carrid = @carrid
*  ORDER BY fldate, class
*  INTO TABLE @DATA(result).
*cl_demo_output=>display( result ).

*SELECT * FROM SFLIGHT
*  WHERE connid = '400' and carrid = 'LH'
*  ORDER BY PRIMARY KEY
*  INTO TABLE @DATA(wa).
*  cl_demo_output=>display( wa ).

*SELECT carrid, connid, MIN( seatsocc ) AS min
*  FROM sflight
*  GROUP BY carrid, connid
*  ORDER BY carrid ASCENDING, min DESCENDING
*  INTO TABLE @DATA(result).
*cl_demo_output=>display( result ).

*DATA:
*  cityfrom TYPE spfli-cityfrom VALUE 'FRANKFURT',
*  cityto   TYPE spfli-cityto VALUE 'OSAKA'.
*
*SELECT c~carrname, p~connid, b~passname
*  FROM scarr AS c
*  INNER JOIN spfli AS p ON p~carrid = c~carrid
*  AND p~cityfrom = @cityfrom
*  AND p~cityto = @cityto
*  INNER JOIN sbook AS b ON b~carrid = p~carrid
*  AND b~connid = p~connid
*  ORDER BY c~carrname, p~connid, b~passname
*  INTO TABLE @DATA(itab).
*cl_demo_output=>display( itab ).

DATA cityfrom TYPE spfli-cityfrom VALUE 'FRANKFURT'.

SELECT s~carrid, s~carrname
  FROM scarr AS s
  LEFT OUTER JOIN spfli AS p ON s~carrid = p~carrid
  AND p~cityfrom = @cityfrom
  WHERE p~connid IS NULL
  ORDER BY s~carrid, s~carrname
  INTO TABLE @DATA(itab).
cl_demo_output=>display( itab ).
