*&---------------------------------------------------------------------*
*& Report Z_BRUTTO_NETTO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S07_Rabat.

* Selektionsbild:
TYPES: ty_betrag TYPE p LENGTH 7 DECIMALS 2.
parameters:
ware1 tYPE ty_betrag DEFAULT '20.00',
rabat1 TYPE C LENGTH 2 DEFAULT '10',
ware2 TYPE ty_betrag DEFAULT '12.50',
rabat2 TYPE C LENGTH 2 DEFAULT '20'.
*
DATA:
erg1 TYPE ty_betrag,
erg2 TYPE ty_betrag,
rab_erg1 TYPE ty_betrag,
rab_erg2 TYPE ty_betrag.
* ABAP-Code: Berechnungen für beide Artikel
PERFORM rechnen USING ware1 rabat1 CHANGING erg1 rab_erg1.
PERFORM rechnen USING ware2 rabat2 CHANGING erg2 rab_erg2.



WRITE: / 'Original Preis Ware 1:', ware1, '€'.
write: / 'Prozente:', rabat1, 'Rabat in €', rab_erg1.
WRITE: / 'Preisreduzierung:', erg1,'€'.

ULINE.

WRITE: / 'Original Preis Ware 2:', ware2, '€'.
write: / 'Prozente:', rabat2, 'Rabat in €', rab_erg2.
WRITE: / 'Preisreduzierung:', erg2,'€'.

FORM rechnen USING ware rabat CHANGING erg rab_erg.
  rab_erg = ware / 100 * rabat.
  erg = ware - rab_erg.
ENDFORM.
