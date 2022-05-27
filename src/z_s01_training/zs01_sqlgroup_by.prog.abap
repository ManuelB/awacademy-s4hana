*&---------------------------------------------------------------------*
*& Report Z_S01_GROUP_BY
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s01_group_by.

*verstanden.

*
*SELECT FROM sflight
*  FIELDS carrid,
*  MIN( price ) AS Cheapest,
*  MAX( price ) AS Luxury
*  GROUP BY carrid
*  ORDER BY carrid DESCENDING
*  INTO TABLE @DATA(tresult).
*
*BREAK-POINT.


*Was ist das Ziel der Suche.
*Er sucht den MinWert und MaxWert der Preise für die jeweilige FLuggesellschaft. und fasst diese Zusammen.
*SELECT FROM sflight
*  FIELDS carrid, "Fluggeselleschaftid.
*  min( price ) as min_price, " Werte auswählen
*  Max( price ) as max_price
*GROUP BY carrid "GROUP BY fasst Gruppen von Zeilen der Ergebnismenge zu einer Zeile zusammen.
*  into table @data(result).

*Ausgabe der Daten.
*  cl_demo_output=>display( result ).


*  Having

*  Deklaration von Variable
DATA: carrid TYPE sbook-carrid VALUE 'LH',
      connid TYPE sbook-connid VALUE '400'.

*  Baut Eingabe Felder.
cl_demo_input=>new(
)->add_field( CHANGING field = carrid
)->add_field( CHANGING field = connid )->request( ).


* Gibt für Flugdatum die Klasse und die Menge an. Count = Menge, als Zählvariable.
SELECT fldate, class, COUNT( * ) AS class_count
  FROM sbook "Welche Tabelle?
  WHERE connid = @connid "Bedingung im Textfeld Überprüft alle connids "@" ist ein Fluchtsymbol.
  GROUP BY carrid, fldate, class " Gruppiert mehrere Zeilen der Felder in eine.
  HAVING carrid = @carrid "Ist eine nachfolgende Einschränkung nachdem wir die Datenmenge haben. z.B. > 3000.
  ORDER BY fldate, class "SOrtiert nach fldate, dann class
  INTO TABLE @DATA(result). "fügt in variable ein und deklariert gleichzeitig eine Tabelle.


cl_demo_output=>display( result ). "output.
