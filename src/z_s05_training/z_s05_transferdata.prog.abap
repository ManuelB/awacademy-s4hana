*&---------------------------------------------------------------------*
*& Report Z_S05_TRANSFERDATA
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S05_TRANSFERDATA.

select * into TABLE @data(tspfli)
  FROM spfli.

  modify zs05_spfli FROM TABLE tspfli.

  IF sy-subrc = 0.
    commit work.
    endif.


select * into TABLE @data(tsscarr)
  FROM scarr.

  modify zs05_scarr1 FROM TABLE tsscarr.

  IF sy-subrc = 0.
    commit work.
    endif.


select * into TABLE @data(tsflight)
  FROM sflight.

  modify zs05_SFLIGHT FROM TABLE tsflight.

  IF sy-subrc = 0.
    commit work.
    endif.



select * into TABLE @data(tvbak)
  FROM vbak.

  modify ZS05_VBAK FROM TABLE tvbak.

  IF sy-subrc = 0.
    commit work.
    endif.



    BREAK-POINT.

    SELECT FROM zs05_SFLIGHT
      FIELDS carrid,
      MIN( price ) AS min_price,
      MAX( price ) AS max_price
      GROUP BY carrid
      INTO TABLE @DATA(result).



      cl_demo_output=>display( result ).

          SELECT FROM zs05_spfli
      FIELDS carrid, CITYFROM, CITYTO
      WHERE COUNTRYTO = 'DE'
      GROUP BY carrid, CITYFROM, CITYTO
            ORDER BY cityfrom ASCENDING
      INTO TABLE @DATA(result1).


      cl_demo_output=>display( result1 ).


     """"""""""""" DRITTE TABELLE MACHEN
      "ÜBER 1ST LOOPENN- MOVE CORRESPONDING FÜR JEDEN EINTRAG
      "EINTRAGE AUS 2 TABELLE ÜBER CARRID DAZULESEN - READ



"DATA carridp TYPE

DATA: carrid TYPE ZS05_SPFLI-carrid VALUE 'LH',
      countryfr TYPE ZS05_SPFLI-countryfr VALUE 'DE'.

cl_demo_input=>new(
 )->add_field( CHANGING field = carrid
 )->add_field( CHANGING field = countryfr )->request( ).

SELECT carrid, countryfr, cityfrom, cityto, countryto, distance
  FROM  ZS05_SPFLI
  WHERE countryfr = @countryfr
  GROUP BY carrid, countryfr, cityfrom, cityto, countryto, distance
  HAVING carrid = @carrid
  ORDER BY cityfrom ASCENDING
  INTO TABLE @DATA(result3).

  cl_demo_output=>display( result3 ).






  DATA: carrid2 TYPE ZS05_SFLIGHT-carrid VALUE 'LH',
      CURRENCY TYPE ZS05_SPFLI-countryfr VALUE 'EUR'.

cl_demo_input=>new(
 )->add_field( CHANGING field = CARRID
 )->add_field( CHANGING field = CURRENCY )->request( ).

SELECT carrid, price, CURRENCY, COUNT( * ) AS TotalCount , SUM( price ) AS TotalPrice
  FROM  ZS05_SFLIGHT
  WHERE currency = @currency
  GROUP BY carrid, price, CURRENCY
  HAVING carrid = @carrid2
  ORDER BY price DESCENDING
  INTO TABLE @DATA(result4).



SELECT COUNT( DISTINCT CONNID )
  from ZS05_spfli
  WHERE FLTIME GT 600
  GROUP BY connid, cityfrom, cityto
  INTO @DATA(lt_flights).
  ENDSELECT.

   cl_demo_output=>display( lt_flights ).
