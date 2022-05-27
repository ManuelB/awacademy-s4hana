REPORT zs01_a115.

*Flugliste
*Übung T11-5: Flugliste ausgeben
*Schreiben Sie ein Programm, mit dem Sie eine Flugliste wie folgt ausgeben können:
*Auf der Ausgabeliste
*sollen nur Spalten der Tabelle SFLIGHT erscheinen, davon aber maximal 5, die
*Sie frei auswählen können. Begründen Sie dabei, warum genau diese 5 Spalten interessant sind.

*Auf dem Selektionsbild soll es möglich sein, wie folgt die Treffermenge einzugrenzen:
*Fluggesellschaft, Flugdatum und Anzahl belegter Plätze als Mengeneingrenzung,
*Flugzeugtyp als Einzelwert-Auswahl.
*Falls die Treffermenge leer ist, soll eine passende Meldung ausgegeben werden.

*Deklaration/typisierung von table und Struktur
DATA:
  ls_sflight TYPE sflight,
  lt_sflight TYPE TABLE OF sflight.

SELECT-OPTIONS:
s_carrid FOR ls_sflight-carrid DEFAULT 'AA',
s_fldate FOR ls_sflight-fldate,
s_socc FOR ls_sflight-seatsocc,
s_connid for ls_sflight-connid.

PARAMETERS: P_pltype TYPE sflight-planetype DEFAULT '747-400'.

SELECT * FROM sflight INTO TABLE lt_sflight
  WHERE planetype  =  p_pltype
  AND carrid IN s_carrid
  AND connid in s_connid
  AND fldate IN s_fldate
  AND seatsocc IN s_socc.

 IF sy-subrc <> 0.
WRITE: / 'Die Treffermenge ist leer'.
 ENDIF.



LOOP AT lt_sflight INTO ls_sflight.
  WRITE:/ ls_sflight-carrid,
  ls_sflight-connid,
  ls_sflight-fldate,
   ls_sflight-seatsocc,
   ls_sflight-planetype.
ENDLOOP.

*Begründung der Auswahl:
*Auswahl basiert auf Wichtigkeit für den Kunden bei der Abfrage.
*1.Carrid,  connid, fldate sind gute Hauptmerkmale, um nach bestimmten Flügen zu filtern.
