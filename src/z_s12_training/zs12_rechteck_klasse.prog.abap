*&---------------------------------------------------------------------*
*& Report ZS12_RECHTECK_KLASSE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zs12_rechteck_klasse.
TYPES messung TYPE p LENGTH 6 DECIMALS 2.

CLASS Rechteck DEFINITION.

  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING
          im_l TYPE messung
          im_b TYPE messung,

      get_umf
        IMPORTING
          im_l TYPE messung
          im_b TYPE messung
        EXCEPTIONS
          null,
      get_flae
        IMPORTING
          im_l TYPE messung
          im_b TYPE messung
        EXCEPTIONS
          null,
      show_umf,
      show_flae.

  PRIVATE SECTION.
    DATA:
      laenge TYPE messung,
      breite TYPE messung,
      umf    TYPE messung,
      flae   TYPE messung.
ENDCLASS.

CLASS Rechteck IMPLEMENTATION.
  METHOD constructor.
    Laenge = im_l.
    Breite = im_b.
  ENDMETHOD.
  METHOD show_umf.
    WRITE: / 'Länge:', laenge, 'Breite', breite, 'Umfang:', umf.
  ENDMETHOD.
  METHOD show_flae.
    WRITE: / 'Länge:', laenge, 'Breite', breite,'Flächeninhalt:', flae.
  ENDMETHOD.
  METHOD get_umf.
    IF im_l = 0 OR im_b = 0.
      RAISE null.
    ELSE.
      umf = 2 * im_l + 2 * im_b.
    ENDIF.

  ENDMETHOD.
  METHOD get_flae.
    IF im_l = 0 OR im_b = 0.
      RAISE null.
    ELSE.
      flae = im_l * im_b.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
* Hauptprogramm

PARAMETERS:
  p_Laenge TYPE messung,
  p_Breite TYPE messung,
  Umfang   RADIOBUTTON GROUP rb_1,
  Flaeche  RADIOBUTTON GROUP rb_1.

DATA:
      das_rechteck TYPE REF TO rechteck. "auf die Klasse referenzieren


START-OF-SELECTION. "Macht Zuweisen erreichbar
  CREATE OBJECT das_rechteck"erzeugt das Objekt, damit darauf zugegriffen werden kann
  exporting "EXPORTING Zusatz hier wegen Constructor nötig
    im_l = p_laenge
    im_b = p_breite.
  CASE 'X'.
    WHEN Umfang.
      CALL METHOD das_rechteck->get_umf "Methode ermöglich sicher auf private Objekte zuzugreifen
        EXPORTING
          im_l   = p_Laenge
          im_b   = p_Breite
        EXCEPTIONS
          null   = 2
          OTHERS = 3.
      CASE sy-subrc.
        WHEN 0.  CALL METHOD das_rechteck->show_umf.
        WHEN 2. WRITE: / 'Ein Rechteckt mit einer Länge oder Breite von Null gibt es nicht!' COLOR COL_NEGATIVE.
        WHEN OTHERS. WRITE: / 'Ein Fehler ist aufgetreten'.
      ENDCASE.

    WHEN Flaeche.
      CALL METHOD das_rechteck->get_flae "Methode ermöglich sicher auf private Objekte zuzugreifen
        EXPORTING
          im_l   = p_Laenge
          im_b   = p_Breite
        EXCEPTIONS
          null   = 2
          OTHERS = 3.
      CASE sy-subrc.
        WHEN 0.  CALL METHOD das_rechteck->show_flae.
        WHEN 2. WRITE: / 'Ein Rechteckt mit einer Länge oder Breite von Null gibt es nicht!' COLOR COL_NEGATIVE.
        WHEN OTHERS. WRITE: / 'Ein Fehler ist aufgetreten'.
      ENDCASE.
    WHEN OTHERS.
      WRITE: / 'Entschuldigung, ein Fehler ist aufgetreten!'.
  ENDCASE.


DATA:
  laenge  TYPE p LENGTH 6 DECIMALS 2,
  breite  TYPE p LENGTH 6 DECIMALS 2,
  Umfang  TYPE p LENGTH 6 DECIMALS 2,
  Flaeche TYPE p LENGTH 6 DECIMALS 2.

PARAMETERS:
  laenge1  TYPE p LENGTH 6 DECIMALS 2,
  breite1  TYPE p LENGTH 6 DECIMALS 2,
  umfang1  RADIOBUTTON GROUP rb_1,
  flaeche1 RADIOBUTTON GROUP rb_1.

CASE 'x'.
  WHEN flaeche1.
    laenge = laenge1.
    breite = breite1.
    flaeche = laenge * breite.
    WRITE: / 'Der Flächeninhalt beträgt', flaeche, 'Bei einer Länge von:', laenge, 'und einer Breite von:', breite.
  WHEN umfang1.
    laenge = laenge1.
    breite = breite1.
    umfang = 2 * ( laenge + breite ).
    WRITE: / 'Der Umfang beträgt', umfang, 'Bei einer Länge von:', laenge, 'und einer Breite von:', breite.
  WHEN OTHERS.
    WRITE: / 'Vivi stinkt.'.
ENDCASE.
