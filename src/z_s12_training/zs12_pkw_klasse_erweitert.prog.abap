*&---------------------------------------------------------------------*
*& Report ZS12_PKW_KLASSE_ERWEITERT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zs12_pkw_klasse_erweitert.


CLASS pkw DEFINITION. "definitionsteil der Klasse
  PUBLIC SECTION. "Öffentlich einsehbar
    METHODS:
      set_kennz
        IMPORTING im_kz TYPE string,
          get_kennz
          RETURNING VALUE(re_kz) type string,
      fahren
        IMPORTING
          im_ziel TYPE string
          im_dist TYPE i
        EXCEPTIONS "Ausnahme deklarieren
          zu_weit,
      set_farbe
        IMPORTING
          im_farbe TYPE string,
      get_km_stand
        IMPORTING
          im_km TYPE i,
      get_anzsitze
        IMPORTING
          im_sitze TYPE i,
      verbrauch
        IMPORTING
          im_tank TYPE i
          im_dist TYPE i,
      show_attributes.
  PRIVATE SECTION. "Privat und nicht zugreifbar was in der PRIVATE SECTION steht
    DATA:
      akt_ort   TYPE string,
      farbe     TYPE string,
      km_stand  TYPE i,
      anz_sitze TYPE i,
      kennz     TYPE string,
      tstand    TYPE i,
      verbr     TYPE i.
ENDCLASS.
*PRIVATE SECTION bei pkw wie Fahrzeugbrief - ich kann also nichts darin verändern (legal)
*CALL METHOD mein_auto->set_kennz
*    EXPORTING
*      im_kz = 'A - RK 1024'.
*Funktioniert wie ein Gang zur KFZ-Zulassungtsbehörde um im Fahrzeugbrief Werte ändern zu lassen
*-->Welche Werte muss ich beim erzeugen eines Objektes also dann als PRIVATE SECTION kennzeichnen damit diese Werte so bleiben

CLASS pkw IMPLEMENTATION.
  METHOD show_attributes. "Methoden implementieren
    WRITE: / 'Farbe:', farbe, 'Kennzeichen:', kennz, 'Anzahl der Sitzplätze:', anz_sitze,
    'akt.Ort', akt_ort, 'Km:', km_stand, 'Aktueller Tankstand:', tstand, 'Verbraucht:', verbr.
  ENDMETHOD.
  METHOD set_kennz.
    kennz = im_kz.
  ENDMETHOD.
  method get_kennz.
    re_kz = kennz.
    endmethod.
  METHOD fahren.
    IF im_dist >= 400.
      RAISE zu_weit.
    ELSE.
      akt_ort = im_ziel.
      km_stand = km_stand + im_dist.
    ENDIF.

  ENDMETHOD.
  METHOD set_farbe.
    farbe = im_farbe.
  ENDMETHOD.
  METHOD get_km_stand.
    km_stand = im_km.
  ENDMETHOD.
  METHOD get_anzsitze.
    anz_sitze = im_sitze.
  ENDMETHOD.
  METHOD verbrauch.
    tstand = im_tank.
    verbr  = 2 * im_dist.
  ENDMETHOD.
ENDCLASS.

*Hauptprogramm
PARAMETERS:
p_dist TYPE i DEFAULT 333.

DATA:
      "akt_kz type string,
      mein_auto TYPE REF TO pkw. "auf die Klasse referenzieren
*mein_auto --> Instanz oder Objekt

START-OF-SELECTION. "Macht Zuweisen erreichbar
  CREATE OBJECT mein_auto. "erzeugt das Objekt, damit darauf zugegriffen werden kann
*  mein_auto->farbe = 'rot'.
  "mein_auto->kennz = 'A - RK 1024'.
  CALL METHOD mein_auto->set_kennz "Methode ermöglich sicher auf private Objekte zuzugreifen
    EXPORTING
      im_kz = 'A - RK 1024'.
  CALL METHOD mein_auto->show_attributes.
  "Methode mit Returning-Parameter
  call method mein_auto->get_kennz
  RECEIVING re_kz = akt_kz.
  akt_kz = mein_auto->get_kennz( ). "Funktionale Schreibweise ersetzt die zwei Zeilen darüber
    Write: / 'Kennzeichen:', akt_kz.
*************************************************************
  "ODER
 " Write: / 'Kennzeichen:', mein_auto->get_kennz( ). "Nach CALL METHOD reicht auch --> noch weniger Code und spart DATA definition


  CALL METHOD mein_auto->fahren
    EXPORTING
      im_ziel = 'Ausgburg'
      im_dist = p_dist
  exceptions
  zu_weit = 3
  others = 99.
  CASE sy-subrc.
    WHEN 0.  CALL METHOD mein_auto->show_attributes.
    WHEN 3. WRITE: / 'Reichweite überschritten' COLOR COL_NEGATIVE.
    WHEN OTHERS. WRITE: / 'Ein Fehler ist aufgetreten'.
  ENDCASE.

  CALL METHOD mein_auto->fahren
    EXPORTING
      im_ziel = 'München'
      im_dist = 85.
  CALL METHOD mein_auto->show_attributes.
  CALL METHOD mein_auto->set_farbe
    EXPORTING
      im_farbe = 'Perlglanz Pink'.
  CALL METHOD mein_auto->show_attributes.
  CALL METHOD mein_auto->get_km_stand
    EXPORTING
      im_km = 99999.
  CALL METHOD mein_auto->show_attributes.
  CALL METHOD mein_auto->get_anzsitze
    EXPORTING
      im_sitze = 4.
  CALL METHOD mein_auto->show_attributes.
