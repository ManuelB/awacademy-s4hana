*&---------------------------------------------------------------------*
*& Report ZS01_UEBT115
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zs01_a116.

*Übung T11-6: Flugliste mit Funktionsbaustein ausgeben
*Schreiben Sie einen Funktionsbaustein, mit dem Sie eine Flugliste wie folgt ausgeben können:
*Die Fluggesellschaft soll eingegrenzt werden können (PARAMETERS-Logik, d.h. keine SELECTOPTIONS-Logik).
*Falls nichts übergeben wird, soll alles selektiert werden.
*Falls nichts gefunden wird, soll eine passende Ausnahme geworfen werden.
*Die Flugliste soll doppelt ausgegeben werden:
* „alte Logik“ über TABLES-Parameter
* „neue Logik“ über EXPORTING-Parameter
*Nutzen Sie bei der neuen Logik einen geeigneten Tabellentyp aus dem Dictionary. Falls Sie keinen
*finden, definieren Sie selbst einen.
*Schreiben Sie einen Report, der Ihren Funktionsbaustein aufruft und verwenden Sie dazu passende
*PARAMETER und eine geeignete Ausgabe, die anfangs direkt im ABAP-Report, später mit einem
*eigenen Funktionsbaustein realisiert werden soll.

DATA:
  lt_flugliste TYPE sflight_tab2,
  ls_fluege    TYPE sflight,
  lt_fluege    TYPE TABLE OF sflight.

PARAMETERS:
p_carrid TYPE sflight-carrid.


CALL FUNCTION 'ZS01_FLUGLISTE'
  EXPORTING
    i_carrid      = p_carrid
  IMPORTING
    ex_flugliste  = lt_flugliste
*   EX_FLUGVIEW   =
  TABLES
    flugliste     = lt_fluege
  EXCEPTIONS
    nothing_found = 1
    OTHERS        = 2.

CASE sy-subrc.
  WHEN 0.
    WRITE: / lines( lt_fluege ), 'Flüge gefunden'.
    ULINE.
    LOOP AT lt_fluege INTO ls_fluege.
      WRITE: /
     ls_fluege-carrid,
    ls_fluege-connid,
    ls_fluege-fldate,
     ls_fluege-seatsocc,
     ls_fluege-planetype.

    ENDLOOP.

  WHEN 1. WRITE: / 'Nichts gefunden'.
  WHEN 2. WRITE: / 'Irgendein anderer Fehler'.

ENDCASE.
