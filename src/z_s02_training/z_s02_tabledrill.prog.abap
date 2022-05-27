*&---------------------------------------------------------------------*
*& Report Z_S02_TABLEDRILL
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S02_TABLEDRILL.


***** Typisierung für Struktur für interne Tabelle machen
Types:
BEGIN OF lty_s_radls,
  brand type string,
  model type string,
  color(10) type c,
  size(2) type n,
  pdate type dats,
  END OF lty_s_radls
  .


***** Struktur machen und Tabelle machen
DATA:
ls_radls type lty_s_radls,
lt_radls type table of lty_s_radls.

***** Tabelle befüllen
***** einzelne Zeile (Leisten) zur Tabelle hinzufügen
ls_radls-brand = 'Kona'.
ls_radls-model = 'Sutra ltd'.
ls_radls-color = 'grey'.
ls_radls-size = 52.
ls_radls-pdate = '20200315'.
APPEND ls_radls to lt_radls.

ls_radls-brand = 'Scott'.
ls_radls-model = 'LSD pro'.
ls_radls-color = 'yellow'.
ls_radls-size = 18.
ls_radls-pdate = '19960507'.
APPEND ls_radls to lt_radls.

ls_radls-brand = 'Cinelli'.
ls_radls-model = 'Pornorelli'.
ls_radls-color = 'pink'.
ls_radls-size = 54.
ls_radls-pdate = '20211005'.
APPEND ls_radls to lt_radls.

ls_radls-brand = 'Surly'.
ls_radls-model = 'Roady'.
ls_radls-color = 'red'.
ls_radls-size = 48.
ls_radls-pdate = '20180426'.
APPEND ls_radls to lt_radls.


***** Ausgeben
LOOP AT lt_radls INTO ls_radls.
  WRITE:
/ 'Brand: ', ls_radls-brand,
/ 'Model: ', ls_radls-model,
/ 'Color: ', ls_radls-color,
/ 'Size: ', ls_radls-size,
/ 'Production Date: ', ls_radls-pdate.
ENDLOOP.


***** strukturgleiche Struktur typisieren aus Tabelle oder aus Struktur
DATA: ls_fils1 like line of lt_radls.
DATA: ls_fils2 like ls_radls.
      .


***** Einen Eintrag für Farbe bei Kona änder mit Feldsymbol

FIELD-SYMBOLS <wa> like ls_radls.

LOOP AT lt_radls ASSIGNING <wa> WHERE brand = 'Kona'.
<wa>-color = 'kackgrün'.
ENDLOOP.



***** Ausgeben
LOOP AT lt_radls INTO ls_radls.
  WRITE:
/ 'Brand: ', ls_radls-brand,
/ 'Model: ', ls_radls-model,
/ 'Color: ', ls_radls-color,
/ 'Size: ', ls_radls-size,
/ 'Production Date: ', ls_radls-pdate.
ENDLOOP.


BREAK-POINT.
