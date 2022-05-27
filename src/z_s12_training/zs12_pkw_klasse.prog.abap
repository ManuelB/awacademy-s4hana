REPORT zs12_pkw_klasse.

CLASS pkw DEFINITION. "definitionsteil der Klasse
  PUBLIC SECTION. "Öffentlich einsehbar
    METHODS:
      set_kennz
        IMPORTING im_kz TYPE string,
      fahren
        IMPORTING im_kz TYPE i
         im_ziel type string
         im_dist type i,
      show_attributes.
    "PRIVATE SECTION. "Privat und nicht zugreifbar was in der PRIVATE SECTION steht
    DATA:
      akt_ort TYPE string,
      farbe   TYPE string,
      kennz   TYPE string.
ENDCLASS.
*PRIVATE SECTION bei pkw wie Fahrzeugbrief - ich kann also nichts darin verändern (legal)
*CALL METHOD mein_auto->set_kennz
*    EXPORTING
*      im_kz = 'A - RK 1024'.
*Funktioniert wie ein Gang zur KFZ-Zulassungtsbehörde um im Fahrzeugbrief Werte ändern zu lassen
*-->Welche Werte muss ich beim erzeugen eines Objektes also dann als PRIVATE SECTION kennzeichnen damit diese Werte so bleiben

CLASS pkw IMPLEMENTATION.
  METHOD show_attributes. "Methoden implementieren
    WRITE: / 'Farbe:', farbe, 'Kennzeichen:', kennz,
    'akt.Ort', akt_ort,.
  ENDMETHOD.
  METHOD set_kennz.
    kennz = im_kz.
  ENDMETHOD.
  METHOD fahren.
    akt_ort = im_ziel.
    km_stand = km_stand + im_dist.
  ENDMETHOD.
ENDCLASS.

*Hauptprogramm
DATA:
      mein_auto TYPE REF TO pkw. "auf die Klasse referenzieren
*mein_auto --> Instanz oder Objekt

START-OF-SELECTION. "Macht Zuweisen erreichbar
  CREATE OBJECT mein_auto. "erzeugt das Objekt, damit darauf zugegriffen werden kann
  mein_auto->farbe = 'rot'.
  "mein_auto->kennz = 'A - RK 1024'.
  CALL METHOD mein_auto->set_kennz "Methode ermöglich sicher auf private Objekte zuzugreifen
    EXPORTING
      im_kz = 'A - RK 1024'.
  CALL METHOD mein_auto=>fahren
    EXPORTING
      im_ziel = 'Ausgburg'
      im_dist = 30.
  CALL METHOD mein_auto->show_attributes.
