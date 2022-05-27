*&---------------------------------------------------------------------*
*& Module Pool      SAPMZ_SWEETS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE MZ_SWEETSTOP                            .    " Global Data
** * Definition der Daten und lokalen Klassen/Methoden
*
** INCLUDE MZ_SWEETSO01                            .  " PBO-Modules
** INCLUDE MZ_SWEETSI01                            .  " PAI-Modules
* INCLUDE MZ_SWEETSF01                            .  " FORM-Routines
** * Implementierung der lokalen Klassen/Methoden
** Code für die geforderte Funktionaltät
*
*tables : ZGRP03_SWEETS.
*
*SELECTION-SCREEN BEGIN OF SCREEN 1001.
*
*  PARAMETERS:
*p_artnr type ZGRP03_SWEETS-ARTIKELNUMMER,
*p_artgrp type ZGRP03_SWEETS-Artikelgruppe,
*p_vk_b type ZGRP03_SWEETS-vk_brutto.
*
*SELECTION-SCREEN END OF SCREEN 1001.
*
*AT SELECTION-SCREEN OUTPUT.
*
*LOOP AT SCREEN.
*
*  CASE sy-tcode.
*
*    WHEN 'Z_SWEETS'.
**      IF screen-name = p_artgrp.
**        screen-active = 0.
*        if screen-name = p_vk_b.
*          screen-active = 0.
*        endif.
*        MODIFY SCREEN.
*
*      WHEN OTHERS.
**-- nothing to do.
*    ENDCASE.
*
*  ENDLOOP.

*----------------------------------------------------------------------------------------------------------------------
* Hier findet die eigentliche Verarbeitung statt.
* Voraussetzung ist, dass die Klassen/Methoden in *TOP definiert und deren Funktionalität in *F01 implementiert ist.
* Hier erfolgt die Instantiierung der Klasse/Methoden
* Auch hier erfolgt der Aufruf der Methoden abhängig vom auszuführenden Transaktionscode
*<
* wie schon erwähnt in *TOP wirddas & in der Nachricht ersetzt durch den Wert nach dem WITH
* beim Aufruf der Nachricht.
* e - Fehler. w - Warnung, I = Information ( startet Popup )
*  MESSAGE e002 WITH ??? .

* Für die Ausgabe von Daten / Listen kann der Einfachheit halber die Methode für die Demoanwendungen
* verwendet werden.Y
*  cl_demo_output=>display( ....... ).
