*&---------------------------------------------------------------------*
*& Report Z_S01_JOIN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s01_join.

*Verstanden.

INCLUDE z_t04_i_flugdaten. "Enthällt bereits erzeugte Tabellen mit selektierten Flugdaten.

*Inner Join: Nur Einträge, die sich in beiden Tabellen befinden, werden angezeigt.

*SELECT f~carrid, "Alle Spalten, die du haben willst.
*  f~connid,
*  c~carrname
*  FROM sflight AS f " Die Tabelle, die du nutzen willst. Alias ist wichtig bei Joins. 1. genannte Tabelle links, 2. rechts.
*  INNER JOIN scarr AS c
*  ON f~carrid = c~carrid " Bedingung.
*  INTO TABLE @DATA(it_output). "Deklaration einer Tabelle zum speichern.
*
*cl_demo_output=>display( it_output ). "class Output"


*left join: Alle Überschneidungen + rest von linken Tabelle.

*SELECT f~carrid,
*  f~connid,
*  c~carrname
*  FROM sflight AS f
*  LEFT OUTER JOIN scarr AS c
*  ON f~carrid = c~carrid
*  INTO TABLE @DATA(it_output).
*
*cl_demo_output=>display( it_output ).
*

* Alle Überschneidungen + rest von rechten Tabelle.
*SELECT f~carrid,
*  f~connid,
*  c~carrname
*  FROM sflight AS f
*  RIGHT OUTER JOIN scarr AS c
*  ON f~carrid = c~carrid
*  INTO TABLE @DATA(it_output).
*
*cl_demo_output=>display( it_output ).


**Mehrere Joins.
*SELECT f~carrid,
*  f~connid,
*  c~carrname,
*  s~cityfrom,
*  s~cityto
*  FROM sflight AS f
*  LEFT OUTER JOIN scarr AS c
*  ON f~carrid = c~carrid
*  INNER JOIN spfli AS s " Deklaration des Nächsten joins
*  ON f~carrid = s~carrid
*  AND f~connid = s~connid
*
*  INTO TABLE @DATA(it_output).
*
*cl_demo_output=>display( it_output ).


*Full join. ALLES
*Cross join = Alle kombinationsmöglichkeiten der Werte.
