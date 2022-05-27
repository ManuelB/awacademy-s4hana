*&---------------------------------------------------------------------*
*& Report Z_S01_WDH_Z2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s01_wdh_z2.

*verstanden.

BREAK-POINT.


* Tabellen. *Wie man Tabellen liest.
* TYPE i typisiert nicht die Strutktur, sondern den von der Struktur unabhängigen lokalen Typen lty_num
*ERstelleung des StrukturenTyps.
TYPES: lty_wdh2 TYPE i,
       BEGIN OF lty_s_auto2,
         Model(20) TYPE c,
         Marke(20) TYPE c,
         Baujahr   TYPE String,
         Tueren    TYPE i,
         gaenge    TYPE i,

       END OF lty_S_Auto2
       .

DATA ls_auto2 TYPE lty_s_auto2.
DATA lt_auto2 TYPE TABLE OF lty_s_auto2. " Deklariert interne Tabelle, typsiert sie auf Strukturentyp lty_s_user.


ls_auto2-baujahr = |1991|.
ls_auto2-marke = |VW|.
ls_auto2-model = |Golf|.
ls_auto2-tueren = 4.

APPEND ls_auto2 TO lt_auto2.

ls_auto2-baujahr = |1991|.
ls_auto2-marke = |VW|.
ls_auto2-model = |Golf|.
ls_auto2-tueren = 4.

APPEND ls_auto2 TO lt_auto2.

ls_auto2-baujahr = |2015|.
ls_auto2-marke = |BMW|.
ls_auto2-model = |X2|.
ls_auto2-tueren = 5.
.
APPEND ls_auto2 TO lt_auto2.

ls_auto2-baujahr = |2010|.
ls_auto2-marke = |Toyota|.
ls_auto2-model = |Corola|.
ls_auto2-tueren = 2.

APPEND ls_auto2 TO lt_auto2. "überträgt angegebenen daten in die Tabelle.

CLEAR: ls_auto2.
* Die Struktur wird geleert, weil wir sie nochmal mit neuen Werten befüllen wollen.

SORT lt_auto2 BY baujahr DESCENDING.
*Sortiert Tabelleninhalt nach Baujahr.

DELETE ADJACENT DUPLICATES FROM lt_auto2.
*löscht duplizierte EInträge untereinander.

*Wie man Tabellen liest.

*Ich wollte aber die daten aus der internen Tabelle haben.
*Was wir im Loop im Detail gemacht haben ist folgendes:
*-Lesen des Datensatzes in die Struktur. X
*-Ergänzen des Datensatzes mit dem Wert für die Urlaubstage X
*-Ergänzen der Daten in der internen Tabelle (durch MODIFY) X
*-Auslesen und Ausgabe der Daten der internen Tabelle (als Kontrolle) X

LOOP AT lt_auto2 INTO ls_auto2.

  IF ls_auto2-baujahr < 2015.
    ls_auto2-gaenge = 4.

  ELSE.
    ls_auto2-gaenge = 7.

  ENDIF.

*Modify manipuliert Tabellenzeile
* INDEX = verweist in (MODIFY, DELETE, READ TABLE) auf die Tabellenzeile , die angesprochen werden soll.
*Sy-Tabix  = gibt immer die aktuelle Tabellenzeile des Schleifendurchlaufs zurück.

  MODIFY lt_auto2 FROM ls_auto2 INDEX sy-tabix.

* Struktur wird gecleared, aus vorsicht, damit da keine Alten Daten sind, wenn wir sie wieder füllen.
  CLEAR ls_auto2.

*delete lt_auto2 index sy-tabix. "lösht in der Schleife die aktuelle Zeile, wenn in schleife.

*liest die aktuelle Zeile in der Tabelle/Schleife und überträgt sie zu ls_auto2 wieder. Info Bleibt in lt
  READ TABLE lt_auto2 INDEX sy-tabix INTO ls_auto2.
*Muss direkt über Testbefehl
  IF sy-subrc <> 0.

    MESSAGE: | Fehler beim Auslesen der Nutzerwerte in der Tabelle | TYPE 'E' DISPLAY LIKE 's'.

  ENDIF.

ENDLOOP.

DATA lv_Beschreibung(13) TYPE c.
*WIDTH = Eingeräumter Platz für Variable soll 13 Stellen lang sein. ALIGN = Rechtsbündig

lv_beschreibung = | Marke: |.
WRITE:/  |{ lv_beschreibung WIDTH = 13 ALIGN = RIGHT }{ ls_auto2-marke  ALIGN = LEFT }|.

lv_beschreibung = | Modell: |.
WRITE:/  |{ lv_beschreibung WIDTH = 13 ALIGN = RIGHT }{ ls_auto2-model  ALIGN = LEFT }|.

lv_beschreibung = | Baujahr |.
WRITE:/  |{ lv_beschreibung WIDTH = 13 ALIGN = RIGHT }{ ls_auto2-baujahr  ALIGN = LEFT }|.

lv_beschreibung = | Türen |.
WRITE:/  |{ lv_beschreibung WIDTH = 13 ALIGN = RIGHT }{ ls_auto2-tueren  ALIGN = LEFT }|.

lv_beschreibung = | Gänge: |.
WRITE:/  |{ lv_beschreibung WIDTH = 13 ALIGN = RIGHT }{ ls_auto2-gaenge  ALIGN = LEFT }|.



**Wie man Tabellen liest.
**Variante 1: mit Index.
*READ TABLE lt_auto2 INTO ls_auto2 INDEX 2. "Zeile
*IF sy-subrc = 0. "Systemfeld für
*  WRITE: / | Marke:  { ls_auto2-marke } |.
*  WRITE: / | Model:  { ls_auto2-model } |.
*  WRITE: / | Baujahr: { ls_auto2-baujahr } |.
*  WRITE: / | Türen { ls_auto2-tueren } |.
*ELSE.
*  WRITE | Kein Eintrag gefunden |.
*ENDIF.
*ULINE.
*
**Variante 2: mit Schlüssel.
*READ TABLE lt_auto2 INTO ls_auto2 WITH KEY Marke = |BMW|.
*
*IF sy-subrc = 0. "Systemfeld für
*  WRITE: / | Marke:  { ls_auto2-marke } |.
*  WRITE: / | Model:  { ls_auto2-model } |.
*  WRITE: / | Baujahr: { ls_auto2-baujahr } |.
*  WRITE: / | Türen { ls_auto2-tueren } |.
*ELSE.
*  WRITE | Kein Eintrag gefunden |.
*ENDIF.
*Wichtig: Nur für eine Zeile angegeben durch Index. If-Bedingung als safety net
*Generelle Struktur: READ TABLE lt INTO ls INDEX oder WITH KEY Attribut = | |.

ULINE.
