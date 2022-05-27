*&---------------------------------------------------------------------*
*& Report ZAWT03_WITH_ENDWITH
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zawt03_with_endwith_r.

DATA carrids TYPE RANGE OF sflight-carrid.

...

WITH
  +flights AS ( SELECT FROM sflight
                       FIELDS carrid,
                              connid,
                              AVG( seatsocc AS DEC( 16,2 ) ) AS avg
                       WHERE carrid IN @carrids
                       GROUP BY carrid, connid
                       ORDER BY carrid, connid UP TO 10 ROWS )
                       ##db_feature_mode[limit_in_subselect_or_cte]

  SELECT FROM +flights AS f
           INNER JOIN scarr AS s
             ON f~carrid = s~carrid
         FIELDS s~carrname, f~connid, f~avg
         ORDER BY s~carrname, f~connid
         INTO TABLE @DATA(itab).

BREAK-POINT.
