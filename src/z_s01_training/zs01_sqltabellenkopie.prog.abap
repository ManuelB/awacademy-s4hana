*&---------------------------------------------------------------------*
*& Report Z_S01_SPFLIKOPIEUEBERTR
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s01_spflikopieuebertr.


*Verstanden.

*Kopieren alles von SPFli/SCARR/SFLIGHT in unsere Lokale Tabelle ZS01_...

*3 Mal derselbe Befehl für 3 Tabellen.
SELECT * INTO TABLE @DATA(SPFLI)
  FROM spfli.

*Insert ist nur einmal ausführen. beim 2. mal zeigtfehler, weil Daten schon drin sind.
*Modify eher für einzelne Einträge.

*Lädt daten von SPFLi zu unserer eigenen Tabelle.
INSERT ZS01_spfli  FROM TABLE spfli.

BREAK-POINT.

IF sy-subrc = 0.
  commit work.

ENDIF.


SELECT * INTO TABLE @DATA(SCARR)
  FROM SCARR.

INSERT zs01_scarr  FROM TABLE scarr.

BREAK-POINT.

IF sy-subrc = 0.
  commit work.

ENDIF.
BREAK-POINT.

SELECT * INTO TABLE @DATA(SFLIGHT)
  FROM SFLIGHT.

INSERT zs01_SFLIGHT  FROM TABLE SFLIGHT.



IF sy-subrc = 0.
  commit work.

ENDIF.
