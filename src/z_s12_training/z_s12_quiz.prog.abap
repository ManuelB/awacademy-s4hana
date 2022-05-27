*&---------------------------------------------------------------------*
*& Report Z_S12_QUIZ
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S12_QUIZ.
*Typisierung für Loop-Aufgabe
TYPES:
  BEGIN OF lty_s_user,
    user_id(8) TYPE n,
    vname(16)  TYPE c,
    nname(16)  TYPE c,
  END OF lty_s_user,

  BEGIN OF lty_s_id,
    user_id(8) TYPE n,
    param(1)   TYPE c,
  END OF lty_s_id.

*Deklaration der Tabellen für die 2. Schleifen-Aufgabe
DATA lt_id TYPE TABLE OF lty_s_id.
DATA lt_user TYPE TABLE OF lty_s_user.

*Datenbefüllung für Loop-Aufgabe. Hier zu sehen: Befüllung einer Tabelle mit TABLE EXPRESSIONS
lt_id = VALUE #( ( user_id = 1  param = 'X' )
                 ( user_id = 3  param = 'X' )
                 ( user_id = 5  param = 'X' )
                 ( user_id = 7  param = 'X' ) ).

lt_user = VALUE #( ( user_id = 1 vname = 'Hannelore' nname = 'Schmidt'    )
                    ( user_id = 2 vname = 'Max'      nname = 'Treu'       )
                    ( user_id = 3 vname = 'Agnes'    nname = 'Musterfrau' )
                    ( user_id = 4 vname = 'Thilo'    nname = 'Mustermann' )
                    ( user_id = 5 vname = 'Hartmut'  nname = 'Köhler'     ) ).


SKIP. "Überspringt eine Zeile. - nicht relevant für die Aufgaben


**********************************************************************
*             1. Schleifen-Aufgabe                                   *
**********************************************************************

DO 3 TIMES.
  WRITE / sy-index.
  DO 2 TIMES.
    IF sy-index = 1.
      WRITE sy-index.
      EXIT.
    ENDIF.
  ENDDO.
  IF sy-index MOD 2 = 0.
    CONTINUE.
  ENDIF.
  WRITE sy-index.
ENDDO.

**********************************************************************
*             ENDE 1. Schleifen-Aufgabe                              *
**********************************************************************


SKIP.  "Abgrenzung zur 2. Aufgabe
ULINE. "ULINEs etc. waren nicht Teil der Quiz-Aufgaben
SKIP.


**********************************************************************
*             2. Schleifen-Aufgabe                                   *
**********************************************************************

LOOP AT lt_id ASSIGNING FIELD-SYMBOL(<id>).
  LOOP AT lt_user ASSIGNING FIELD-SYMBOL(<user>) WHERE user_id EQ <id>-user_id.
    WRITE: / |Name:{ <user>-nname }|.
  ENDLOOP.
ENDLOOP.

**********************************************************************
*             ENDE 2. Schleifen-Aufgabe
**********************************************************************

SKIP.
ULINE.




*data lv_distance TYPE spfli-distance.
*
*SELECT DISTANCE UP TO 1 rows FROM spfli INTO lv_distance ORDER BY DISTANCE.
*  endselect.
*
*  BREAK-POINT.
