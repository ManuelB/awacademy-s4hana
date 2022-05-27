*&---------------------------------------------------------------------*
*& Report ZS01_TEST
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZS01_TEST.


PARAMETERS:
  p_orgpr1 TYPE p DECIMALS 2 DEFAULT 100,
  p_rinpr1 TYPE p DECIMALS 2 DEFAULT 5,
  p_orgpr2 TYPE p DECIMALS 2 DEFAULT 100,
  p_rinpr2 TYPE p DECIMALS 2 DEFAULT 10.

DATA: neuerpreis1 TYPE p DECIMALS 2,
      neuerpreis2 TYPE p DECIMALS 2,
      pwrabat1    TYPE p DECIMALS 2,
      pwrabat2    TYPE p DECIMALS 2.




PERFORM calc USING p_orgpr1 p_rinpr1 CHANGING neuerpreis1 pwrabat1.
PERFORM calc USING p_orgpr2 p_rinpr2 CHANGING neuerpreis2 pwrabat2.




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


  ELSE.
    WRITE: 'Ungültige Eingabe.'.

  ENDIF.




ENDFORM.
