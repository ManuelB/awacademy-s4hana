*&---------------------------------------------------------------------*
*& Report Z_S01_STRING_TABELLEN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s01_string_tabellen.

*VERSTANDEN.

*Erstellung eineS StrukturenTYPS.
TYPES: BEGIN OF lty_s_user,
         vname(20) TYPE c,
         nname(20) TYPE c,
         alter     TYPE i,
         urlaub    TYPE i,
       END OF lty_s_user.


DATA ls_user TYPE lty_s_user. " deklariert Struktur, typisiert sie auf Strukturentyp lty_s_user.

DATA lt_user TYPE TABLE OF lty_s_user. " Deklariert interne Tabelle, typsiert sie auf lty_s_user.

ls_user-alter = 12.
ls_user-vname = |Peter|.
ls_user-nname = |Schmidt|.

* Reicht die struktuellen Werte zur Tabelle.
APPEND ls_user TO lt_user.


ULINE.

ls_user-vname = |Heinrich|.
ls_user-alter = 21.
ls_user-nname = |Krause|.
APPEND ls_user TO lt_user.


ls_user-vname = |Max|.
ls_user-alter = 33.
ls_user-nname = |Mutzke|.
APPEND ls_user TO lt_user.

ls_user-vname = |Petra|.
ls_user-alter = 49.
ls_user-nname = |Schäfer|.
APPEND ls_user TO lt_user.



**********************************************************************
* Auslesen der Tabelle
**********************************************************************

DATA lv_descr(13) TYPE c.

CLEAR: ls_user.

SORT lt_user BY nname DESCENDING alter DESCENDING. "Sortiert die Tabelle mit Attribut nname und Alter.

DELETE ADJACENT DUPLICATES FROM lt_user. "Vorsicht, Tabelle vorher sortieren. löscht duplikate die direkt überinander sind.


*Liest jede Zeile der Tabelle und überträgt sie zur Struktur.
* Tabellendaten müssen erst zu einer Struktur übergeben werden, damit man sie nutzen kann.
"Erst Tabelle angeben, dann struktur."
LOOP AT lt_user INTO ls_user.

  IF ls_user-alter > 35.  "If bedingung legt fest, wie viele Urlaubstage jeder bekommt.
    ls_user-urlaub = 32.
  ELSE.
    ls_user-urlaub = 30.
  ENDIF.

*Schleifenindex. Enthält in DO- und WHILE-Schleifen die Anzahl der bisherigen Schleifendurchläufe inklusive des aktuellen Durchlaufs.
  MODIFY lt_user FROM ls_user INDEX sy-tabix.


  CLEAR ls_user.

*DELETE lt_user INDEX sy-tabix.

  READ TABLE lt_user INDEX sy-tabix INTO ls_user.
  IF sy-subrc <> 0.
    MESSAGE: |Fehler bei Auslesen der Nutzerwerte. RC:{ sy-subrc }| TYPE 'E'.
  ENDIF.
ENDLOOP.

* Ausgabe der Benutzerdaten. *****************************************
lv_descr = |Vorname:|.
WRITE: / |{ lv_descr WIDTH = 13 ALIGN = RIGHT } { ls_user-vname  ALIGN = LEFT }|.
lv_descr = |Nachname:|.
WRITE: / |{ lv_descr WIDTH = 13 ALIGN = RIGHT } { ls_user-nname  ALIGN = LEFT }|.
lv_descr = |Alter:|.
WRITE: / |{ lv_descr WIDTH = 13 ALIGN = RIGHT } { ls_user-alter  ALIGN = LEFT }|.
lv_descr = |Urlaubstage:|.
WRITE: / |{ lv_descr WIDTH = 13 ALIGN = RIGHT } { ls_user-urlaub ALIGN = LEFT }|.




BREAK-POINT.



*append fügt neue Zeile.
*modifty modifiziert nicht.
*delete lt_user index s-tabix. löscht Zeile
* liest eine Zeile aus der internen Tabelle itab. Bei itab handelt es sich um eine funktionale Operandenposition.
*read TABLE lt_user INDEX sy-tabix into ls_user.


*Interne Tabelle dazu da , um Daten zwischenzuschpeichern, damit man sie verarbeiten kann.
*Benutzer kann nicht direkt auf die Datenbank zugreifen.
*Interne Tabellen bestehen nur zur Laufzeit.
*Dictionary Tabellen bleiben auf der Datenbank besthen.

*Kurze Info zur "Aufgabe". Wenn Ihr Daten in der internen Tabelle ändern wollt könnt ihr das über den Befehl MODIFY machen.
*Wir können uns das aber am Donnerstag zusammen ansehen.
*Die Syntax ist z.B.: MODIFY lt_user FROM ls_user INDEX "Zeilennummer"
*Zeilennummer" kann hier durch das Systemfeld sy-tabix gefüllt werden, aber auch als einfache Zahl übergeben werden.
