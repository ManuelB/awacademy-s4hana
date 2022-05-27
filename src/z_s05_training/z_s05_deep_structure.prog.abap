*&---------------------------------------------------------------------*
*& Report Z_S05_DEEP_STRUCTURE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s05_deep_structure.

**********************************************************************
* Typisierung einer tiefen Struktur
TYPES:
  BEGIN OF lty_s_roles, "StrukturTYP für Rollentabelle
    rolle(20)    TYPE c,
    rol_desc(20) TYPE c,
  END OF lty_s_roles,

  lty_t_roles TYPE STANDARD TABLE OF lty_s_roles WITH DEFAULT KEY, "TabellenTYP für Rollentabelle

  BEGIN OF lty_s_user, " StrukturTYP der tiefen Struktur
    user_id(8) TYPE n,
    vname(16)  TYPE c,
    nname(16)  TYPE c,
    lt_roles   TYPE lty_t_roles, "Enthaltener Tabellentyp
  END OF lty_s_user
  .

**********************************************************************
*Deklarieren der Tiefen Struktur LS_USER
DATA ls_user TYPE lty_s_user.

*Deklarieren der Hilfs-Struktur LS_ROLES zum ansprechen der enthaltenen internen Tabelle
DATA ls_roles TYPE lty_s_roles.


**********************************************************************
*Hinzufügen von Daten in eine Tiefe Struktur
ls_user-user_id = '1'.
ls_user-vname   = 'Albert'.
ls_user-nname   = 'Albrecht'.

ls_roles-rolle    = 'ZSPOOL'.
ls_roles-rol_desc = 'Druckberechtigungen'.
APPEND ls_roles TO ls_user-lt_roles.

ls_roles-rolle    = 'ZBASIS'.
ls_roles-rol_desc = 'Basisadministrator'.
APPEND ls_roles TO ls_user-lt_roles.

ls_roles-rolle    = 'ZGUI'.
ls_roles-rol_desc = 'GUI Sonderrolle'.
APPEND ls_roles TO ls_user-lt_roles.

**********************************************************************
*Auslesen von Daten aus einer Tiefen Struktur
*Abfrage auf Zuordnung der Rolle ZGUI in der
READ TABLE ls_user-lt_roles INTO ls_roles WITH KEY rolle = 'ZGUI'.
IF sy-subrc <> 0.
  WRITE: / |Dem User { ls_user-vname } { ls_user-nname } ist die Rolle 'ZGUI' nicht zugeordnet!|.
ELSE.
  WRITE: / |Dem User { ls_user-vname } { ls_user-nname } ist die Rolle 'ZGUI' zugeordnet!|.
ENDIF.

*Rollenanzahl des Benutzers ausgeben
DESCRIBE TABLE ls_user-lt_roles LINES DATA(lv_rollenanzahl).
WRITE: / |Dem User { ls_user-vname } { ls_user-nname } sind { lv_rollenanzahl } Rollen zugeordnet.|.


**********************************************************************
*INLINEDEKLARATION
DATA lv_testtext TYPE string VALUE 'TESTTEXT'.

DATA ls_results TYPE match_result.

FIND ALL OCCURRENCES OF 'T' IN lv_testtext RESULTS ls_results. " DATA(results). temprär verwenden um zu sehen in welchem Datentyp vom Schlüsselbefehl FIND die Ergebnisse geliefert werden.
IF sy-subrc <> 0.
*Abfangen des Ergebnisses auch ohne Auswertung der Ergebnisstruktur möglich. (Ohne Zusatz "RESULTS")
ENDIF.

BREAK-POINT.
