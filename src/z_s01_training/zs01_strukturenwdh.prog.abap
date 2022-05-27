*&---------------------------------------------------------------------*
*& Report Z_S01_WDH_W1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s01_wdh_w1.

*verstanden

* Data Dictionary Mischung aus Bibltiothek und werkzeug um  Dictionary objects zu manipulieren/erstellen
*Dictionary objects sind alle Inhalte der DDic.

*Ein Datenelement (elemante Datentyp) = Datentypen & deren Referenzen.
*Strukturen
*Tabellen, Transparente = 1 zu 1 in DDic & Datenbank.
*Alles kann in Programmen referenziert werden.
*Domäne = wiederverwendbar, beschreibt technischen Eigenschaften eines Feldes (Variablen). Eine Domäne kann nicht direkt als Tabellenfeld verwendet werden.
* Datenelemente (Domäne + semantische Beschreibung)= werden benutzt, um im DDIC komplexere Datentypen (Strukturen, Tabellentypen, Tabellen) anzulegen, oder um Variablen zu deklarieren.

*im Dictionary bauen die Objekte mit steigender Komplexität aufeinander auf.
*Die unterste Hierarchieebene bilden die eingebauten Datentypen.
*eine Stufe höher stehen die Domänen. Domänen kann man schon weitere Merkmale mitgeben, wie z.B. Anzahl der Stellen oder einen bestimmten Wertebereich.
*Darüber stehen Datenelemente. Datenelemente können weitere Merkmale enthalten wie z.B. Feldbezeichner, also wie das Feld später beim Anwender beschriftet ist (bei Tabellen).
*Man bewegt sich quasi aus technischer Sicht (Datentyp->domäne->Datenelement->Struktur/Tabelle) immer einen Schritt näher zum Endanwender.

*Views = wird genutzt, um Daten aus einer Tabelle während der laufzeit zu extrahieren.
*Search helps = used to display all the possible entries in search help window.
*Local Objects = * used to control the parallel access for the same data by the multiple.

*wa = workarea (structure). lty = localtype. LS=local Structure. LT = local table.
*Strukturen
* TYPE i typisiert nicht die Strutktur, sondern den von der Struktur unabhängigen lokalen Typen lty_num
TYPES: lty_wdh TYPE i,
       BEGIN OF lty_s_auto,
         Model(20) TYPE c,
         Marke(20) TYPE c,
         Baujahr   TYPE String,
         Tueren    TYPE i,

       END OF lty_S_Auto
       .
*Struktur Auto wird deklariert, Struktur auto wird typisiert auf den StrukturenTyp lty_S_auto.

DATA ls_auto TYPE lty_s_auto.



ls_auto-baujahr = |1991|.
ls_auto-marke = |VW|.
ls_auto-model = |Golf|.
ls_auto-tueren = 4.

* Jetzt Struktur mit Daten füllen.
WRITE: / |Marke: { ls_auto-marke } |.
WRITE: / |Model: { ls_auto-model } |.
WRITE: / |Baujahr: { ls_auto-baujahr } |.
WRITE: / |Türen: { ls_auto-tueren } |.

ULINE.


*Tada. Du hast eine Struktur erstellt.

* Benutzung von Systemfelder (fragen Systemzustände ab.) in F1
*Nützlich : sy-subrc =  0 = true

FIND |z| IN ls_auto-model.

IF sy-subrc = 0.

  WRITE: |Buchstabe gefunden|.

ELSE.
  WRITE: |Buchstabe nicht vorhanden|.

ENDIF.

ULINE.

*Systemfelder haben ihre eigenen Domänen.
*D.h. Wenn du eine Variable mit ihnen füllst, muss sie die Domäne auch als Typ haben.

DATA lv_zeit TYPE sy-timlo. "Variable hat jetzt nur das Format vom SF.

lv_zeit = sy-timlo.

WRITE: | Es ist { lv_Zeit TIME = USER }|. "Iso,User,Raw "

ULINE.

DATA lv_Sek TYPE String.
DATA lv_Min TYPE String.
DATA lv_STu TYPE String.

lv_zeit = sy-uzeit.

lv_Stu = lv_zeit(2).
lv_min = lv_zeit+2(2). "offset = +2 Länge (2)."
lv_sek = lv_zeit+4(2).

WRITE: / lv_stu.

ULINE.
