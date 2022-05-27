*&---------------------------------------------------------------------*
*& Report ZS01_AUFGABE1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zs01_frage1.


*Szenario: ein Geschäft bietet reduzierte Artikel an.
*Dabei sind die Artikel mit dem Originalpreis sowie einem "x% Rabatt"-Schild gekennzeichnet (x: ist dabei pro Ware ein anderer Wert).
*Sie möchten jetzt über ein ABAP-Programm ausrechnen lassen, wie hoch der absolute Preis nach der Reduktion ist.
*Alle Preise sind in derselben Währung auf 2 Nachkomma-Stellen angegeben.
*
*Aufgabe:
*
*Schreiben Sie ein ABAP-Programm, das für die im Szenario beschriebene Anforderung eine FORM-Routine enthält, die mit den Werten "Original-Preis" und "Rabatt-Prozentsatz" den "reduzierten Preis" ausrechnet.
*Auf dem Eingabebildschirm soll es möglich sein, für 2 verschiedene Artikel jeweils den Originalpreis und den Rabatt-Prozentsatz einzugeben.
*Auf der Ausgabeliste sollen sowohl die Eingabe- als auch die berechneten Werte mit erläuternden Texten angezeigt werden.
*(Schreiben Sie hier in den Canvas-Editor Ihre Lösung rein!)



*E
*Geichzeitig:
*2 verschiedene Nettobeträge
*1 Prozentsatz.
*
*V
*
*A
*Mehrwertsteuerbetrag.


PARAMETERS:
  p_orgpr1 TYPE p DECIMALS 2 DEFAULT 100,
  p_rinpr1 TYPE p DECIMALS 2 DEFAULT 5,
  p_orgpr2 TYPE p DECIMALS 2 DEFAULT 100,
  p_rinpr2 TYPE p DECIMALS 2 DEFAULT 10.

DATA: neuerpreis1 TYPE p DECIMALS 2,
      neuerpreis2 TYPE p DECIMALS 2,
      pwrabat1    TYPE p DECIMALS 2,
      pwrabat2    TYPE p DECIMALS 2.

*V

PERFORM calc USING p_orgpr1 p_rinpr1 CHANGING neuerpreis1 pwrabat1.
PERFORM calc USING p_orgpr2 p_rinpr2 CHANGING neuerpreis2 pwrabat2.



*A

WRITE: / 'Rechnung 1'.
WRITE: / | OriginalPreis: { p_orgpr1 }|.
WRITE: / | Rabat in Prozent: { p_rinpr1 } |.
WRITE: / | Preis mit Rabat: { neuerpreis1 } |.
ULINE.
WRITE: / 'Rechnung 2'.
WRITE: / | OriginalPreis: { p_orgpr2 }|.
WRITE: / | Rabat in Prozent: { p_rinpr2 } |.
WRITE: / | Preis mit Rabat: { neuerpreis2 } |.
ULINE.


FORM calc USING p_orgpr1 p_rinpr1 CHANGING  neuerpreis1 pwrabat1.


  IF p_rinpr1 > 0.

    neuerpreis1 = ( p_orgpr1 - ( ( p_orgpr1 / 100 ) * p_rinpr1 ) ).


* 50€ x 20 : 100 = 10 €
  ELSE.
    WRITE: 'Ungültige Eingabe.'.

  ENDIF.



ENDFORM.





*E
*Geichzeitig:
*2 verschiedene Nettobeträge
*2 Warentypen

*V

*A
*Mehrwertsteuerbetrag.


*Variante 1
*
*PARAMETERS:
*  netto1 TYPE p DECIMALS 2 DEFAULT 100,
*  Wtyp1  TYPE string DEFAULT 'L',
*
*  netto2 TYPE p DECIMALS 2 DEFAULT 100,
*  Wtyp2  TYPE string DEFAULT 'H'.
*
*DATA: Brutto1 TYPE p DECIMALS 2,
*      Brutto2 TYPE p DECIMALS 2,
*      pw1     TYPE p DECIMALS 2,
*      pw2     TYPE p DECIMALS 2.
*
**V
*
*PERFORM calc USING netto1 wtyp1 CHANGING brutto1 pw1.
*PERFORM calc USING netto2 wtyp2 CHANGING brutto2 pw2.
*
*
*
**A
*
*WRITE: / 'Brutto 1:'.
*WRITE: / | Brutto: { brutto1 }|.
*WRITE: / | Netto: { netto1 } |.
*WRITE:/ | Mehrwertsteuerbetrag: { pw1 } |.
*ULINE.
*WRITE: / 'Brutto 2:'.
*WRITE: / | Brutto: { brutto2 }|.
*WRITE: / | Netto: { netto2 } |.
*WRITE:/ | Mehrwertsteuerbetrag: { pw2 } |.
*
*
*
*FORM calc USING Netto1 wtyp1 CHANGING Brutto1 pw1.
*
*  CASE wtyp1.
*    WHEN 'L'.
*      brutto1 = netto1 * '1.07'.
*      pw1 = brutto1 - netto1.
*
*    WHEN 'H'.
*      brutto1 = Netto1 * '1.19' .
*      pw1 = brutto1 - netto1.
*
*    WHEN OTHERS.
*      WRITE: 'Ungültige Eingabe.'.
*  ENDCASE.
*
*ENDFORM.








*Ursprüngliche Aufgabe.

*Schreiben Sie ein ABAP-Programm, das folgende Anforderungen erfüllt:
*Mit einem Unterprogramm (also nicht mit einem Funktionsbaustein)
*soll aus einem Bruttopreis der Mehrwertsteuer-Anteil herausgerechnet werden.

*Dazu soll es möglich sein, den Bruttobetrag sowie den Warentyp
*(7%-Ware für Lebensmittel bzw. 19%-Ware für Handelsware) einzugeben.
*Es soll dann sowohl der Nettobetrag als auch der Mehrwertsteuerbetrag über Parameter zurückgegeben werden.
*Das ABAP-Programm soll ermöglichen, 2 verschiedene Beträge mit dem jeweiligen Warentyp auf dem Selektionsbild einzugeben.
*Es sollen alle relevanten Werte übersichtlich ausgegeben werden.

*E
*Geichzeitig:
*2 verschiedene Bruttobeträge
*2 Warentypen

*V

*A
*Nettobetrag, Mehrwertsteuerbetrag



*E
*4 Parameter für 4 selektionen

*PARAMETERS:
* Brutto1 TYPE P DECIMALS 2 DEFAULT 100,
*Wtyp1 TYPE string DEFAULT 'L',
*
*Brutto2 TYPE P DECIMALS 2 DEFAULT 100,
*Wtyp2 TYPE string DEFAULT 'H'.
*
*DATA: netto1 TYPE P DECIMALS 2,
*      netto2 TYPE P DECIMALS 2,
*      pw1 TYPE P DECIMALS 2,
*      pw2 TYPE P DECIMALS 2.
*
**V
*
*PERFORM calc USING brutto1 wtyp1 CHANGING netto1 pw1.
*PERFORM calc USING brutto2 wtyp2 CHANGING netto2 pw2.
*
*
*
**A
*
*WRITE: / 'Brutto 1:'.
*WRITE: / | Brutto: { brutto1 }|.
*WRITE: / | Netto: { netto1 } |.
*WRITE:/ | Mehrwertsteuerbetrag: { pw1 } |.
*ULINE.
*WRITE: / 'Brutto 2:'.
*WRITE: / | Brutto: { brutto2 }|.
*WRITE: / | Netto: { netto2 } |.
*WRITE:/ | Mehrwertsteuerbetrag: { pw2 } |.
*
*
*
*FORM calc using Brutto1 wtyp1 CHANGING netto1 pw1.
*
*  CASE wtyp1.
*    WHEN 'L'.
*     netto1 = brutto1 / '1.07' .
*     pw1 = brutto1 - netto1.
*          WHEN 'H'.
*     netto1 = brutto1 / '1.19' .
*     pw1 = brutto1 - netto1.
*
*    WHEN OTHERS.
*      WRITE: 'Ungültige Eingabe.'.
*  ENDCASE.
*
*  ENDFORM.
