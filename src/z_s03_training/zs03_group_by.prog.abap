*&---------------------------------------------------------------------*
*& Report ZS03_GROUP_BY
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zs03_group_by.


*SELECT FROM ZS03_SFLIGHT
*  FIELDS carrid,
*  MIN( price ) as min_price,
*  MAX( price ) as max_price
*  Group by carrid
*  INTO TABLE @DATA(result).
*
*  cl_demo_output=>display( result ).

* Aufgabe HAVING UND ORDER.



* BEISPIEL VON RAINER

*DATA: carrid TYPE sbook-carrid VALUE 'LH',
*      connid TYPE sbook-connid VALUE '400'.
*
*cl_demo_input=>new(
*)->add_field( CHANGING field = carrid
*)->add_field( CHANGING field = connid )->request( ).
*
*SELECT fldate, class, COUNT(*) AS BookingClass
****   bookingclass = Anzahl der Buchungen pro Klasse
*  FROM sbook
*  WHERE connid = @connid
*  GROUP BY carrid, fldate, class
*  HAVING carrid = @carrid
*  ORDER BY fldate ASCENDING, class DESCENDING
*  INTO TABLE @DATA(result).
*
*  cl_demo_output=>display( result ).

**** AUFGABE SELECT ENDSELECT :

*DATA : BEGIN OF wa,
*         carrid   TYPE zs03_sflight-carrid,
*         connid   TYPE zs03_sflight-connid,
*         seatsocc TYPE zs03_sflight-seatsocc,
*       END OF wa,
*       tline LIKE TABLE OF wa.
**      on est pas obligé de définir avant
*
*SELECT Carrid, connid, SUM( seatsocc ) AS belegt
*FROM zs03_sflight
*GROUP BY carrid, connid
*order BY carrid, connid
*INTO @wa.
* INSERT wa INTO TABLE tline.
** il faut mettre le insert, sinon on a seulement la derniere ligne dans notre structure wa.
*
*ENDSELECT.


**** AUFGABE SELECT COUNT : Anzahl der Fluggeseellschaften, die NY bedienen.


*SELECT COUNT( DISTINCT carrid )
*  FROM spfli
*  WHERE cityto = 'WALLDORF'
*  INTO @DATA(Ziel_WALLDORF).
*cl_demo_output=>display( Ziel_WALLDORF ).

*******   AUFGABE SELECT DISTINCT

*SELECT DISTINCT cityfrom
*  FROM spfli
*  WHERE carrid ='LH'
*  OR carrid ='JL'
*  AND cityto = 'WALLDORF'
*  INTO TABLE @DATA(origins).
*
*cl_demo_output=>display( origins ).

********************** Aufgabe INNERJOIN
*BEISPIEL RAINER


*DATA:
*  cityfr TYPE spfli-cityfrom VALUE 'FRANKFURT',
*  cityto TYPE spfli-cityto   VALUE 'OSAKA'.
*
**cl_demo_input=>new(
**  )->add_field( CHANGING field = cityfr
**  )->add_field( CHANGING field = cityto )->request( ).
*
*SELECT c~carrname, p~connid, f~fldate
*       FROM ( ( scarr AS c
*
*
*         INNER JOIN spfli AS p ON p~carrid   = c~carrid
*                              AND p~cityfrom = @cityfr
*                              AND p~cityto   = @cityto )
*
*
*         INNER JOIN sflight AS f ON f~carrid = p~carrid
*                                AND f~connid = p~connid )
*
*
*       ORDER BY c~carrname, p~connid, f~fldate
*
*       INTO TABLE @DATA(itab).
*  BREAK-POINT.

*  MEIN BEISPIEL

DATA:
  cityfrom TYPE spfli-cityfrom VALUE 'FRANKFURT',
  cityto TYPE spfli-cityto   VALUE 'OSAKA'.


SELECT c~carrname, p~connid, b~passname
       FROM ( ( scarr AS c


         INNER JOIN spfli AS p ON p~carrid   = c~carrid
                              AND p~cityfrom = @cityfrom
                              AND p~cityto   = @cityto )


         INNER JOIN sbook AS b ON b~carrid = p~carrid
                                AND b~connid = p~connid )


       ORDER BY c~carrname, p~connid, b~passname

       INTO TABLE @DATA(itab).
       cl_demo_output=>display( itab ).
