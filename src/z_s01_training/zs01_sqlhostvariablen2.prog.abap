*&---------------------------------------------------------------------*
*& Report Z_S01_HOSTVAR2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s01_hostvar2.

*Verstanden.

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME.

  PARAMETERS:
    p_bookid   TYPE S_BOOK_ID DEFAULT '00000075',
    p_custid TYPE S_CUSTOMER DEFAULT '00000159'.

SELECTION-SCREEN END OF BLOCK a1.

*FOR UPDATE setzt eine Schreibsperre beim Lesen des Satzes.
*Die SELECT-Anweisung wird ausgeführt, wenn in WHERE-Bedingung alle Primärschlüsselfelder auf Gleichheit überprüft werden. Heißt Alle müssen wahr sein.
*Andernfalls ist die Ergebnismenge leergesetzt.
START-OF-SELECTION.

  SELECT SINGLE FOR UPDATE carrid, connid, price INTO @DATA(flights)
    FROM sflight
    WHERE carrid = @p_bookid
    AND connid = @p_custidd.




*Update rausnehmen.

  SELECT SINGLE bookid, customid INTO @DATA(flights)
    FROM sbook
    WHERE bookid = @p_bookid
    AND customid = @p_custid.

Write: / flights.


START-OF-SELECTION.

*SELECT SINGLE FOR UPDATE land, land_descript  INTO @(flights)
*  FROM zawt03_countries
*  WHERE land  = 'DE'.

BREAK-POINT.
*kein Endselect, weil keine Mehrzeilige Ergebnismenge.

*UPDATE zawt03_countries SET land_descript = 'Kartoffelland' WHERE Land = flights-land.
COMMIT WORK.


BREAK-POINT.
