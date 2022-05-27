*&---------------------------------------------------------------------*
*& Report Z_S11_OOP_A38PKW
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S11_OOP_A38PKW.

*class pkw definition.
* •  Kennzeichen
*•  km-Stand (absolut)
*•  km-Stand (Tag)
*•  Spritmenge im Tank
*•  Verbrauch
*•  Standort
**Als Methoden soll sie enthalten:
**•  tanken( )
**•  fahren_nach( )
**•  diverse get( )-Methoden.
*  endclass.
*Aufgabe A38: Fahrende Autos
*Schreiben  Sie  ein  Programm  mit  einer  lokalen  Klasse  für  Autos.  Folgende  Attribute
*sollen enthalten sein:
*•  Kennzeichen
*•  km-Stand (absolut)
*•  km-Stand (Tag)
*•  Spritmenge im Tank
*•  Verbrauch
*•  Standort
*Als Methoden soll sie enthalten:
*•  tanken( )
*•  fahren_nach( )
*•  diverse get( )-Methoden.
*Die  Methoden  sollen  die  naheliegende  Funktionalität  haben  und  die  Attribute  sinnvoll
*ändern. Mit private bzw. public ist wie üblich zu verfahren.
*
*Im Hauptprogramm soll folgendes getan werden:
*•  Legen  Sie  3  Instanzen  der  Klasse  an.  Vereinbaren  Sie  für  die  Initialisierung  der
*Objekte passende Eingabefelder.
*
*•  Die  3  Autos  sollen  verschieden  weit  fahren,  wobei  der  jeweilige  Zielort  und  die
*entsprechende Distanz über das Selektionsbild eingegeben werden können sollen.
*•  Beim  Erzeugen  sollen  einmalig  25  Liter  mitgegeben  werden.  Es  soll  dann  einmalig
*getankt  werden,  wenn  nach  der  angestrebten  Fahrt  weniger  als  5  Liter  im  Tank
*verbleiben würden. Die Tankmenge soll fix 20 Liter betragen, negative Tankmengen
*nach  der  Fahrt  werden  hier  noch  in  Kauf  genommen.  Die  Ausgabeliste  soll  ein
*aussagekräftiges Tankprotokoll enthalten.
*Hinweis: Die Tankgröße wird vorerst als beliebig groß angenommen.
