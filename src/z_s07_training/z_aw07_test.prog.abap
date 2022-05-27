*&---------------------------------------------------------------------*
*& Report Z_AW07_TEST
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

REPORT Z_S07_Rabat.

INTERFACE z_s07_fahrzeug.

ENDINTERFACE.

INTERFACE z_s07_auto.

    METHODS: besitzer IMPORTING besitzer TYPE String.
    METHODS: max_geschwindigkeit RETURNING VALUE(max_g) TYPE i.

ENDINTERFACE.

CLASS z_s07_teslamodel3 DEFINITION.


  PUBLIC SECTION.

    INTERFACES z_s07_auto .
    METHODS: vollgas.
    DATA:
      batterie        TYPE i,
      nummernschild   TYPE string,
      geschwindigkeit TYPE i,
      besitzer        TYPE string.

ENDCLASS.



CLASS z_s07_teslamodel3 IMPLEMENTATION.


  METHOD z_s07_auto~besitzer.
    me->besitzer = besitzer.
  ENDMETHOD.


  METHOD z_s07_auto~max_geschwindigkeit.
    max_g = 180.
  ENDMETHOD.

  METHOD vollgas.
    me->geschwindigkeit = me->z_s07_auto~max_geschwindigkeit(  ).
  ENDMETHOD.

ENDCLASS.



* Selektionsbild:
*TYPES: ty_betrag TYPE p LENGTH 7 DECIMALS 2.
*parameters:
*ori_pre tYPE ty_betrag DEFAULT '20,00',
*pro_red TYPE C LENGTH 3 DEFAULT '10',
**bwert2 TYPE ty_betrag DEFAULT '12.50',
**wtyp2 TYPE C LENGTH 1 DEFAULT 'H'.
**
*DATA:
*nwert1 TYPE ty_betrag,
*twert1 TYPE ty_betrag,
*nwert2 TYPE ty_betrag,
*twert2 TYPE ty_betrag.
** ABAP-Code: Berechnungen für beide Artikel
*PERFORM rechnen USING bwert1 wtyp1 CHANGING nwert1 twert1.
*PERFORM rechnen USING bwert2 wtyp2 CHANGING nwert2 twert2.
** Ausgabeliste:
*WRITE: / 'bw1:', bwert1,
*/ 'Netto-Anteil:', nwert1, 'MWSt-Anteil:', twert1.
*skip.
*WRITE: / 'bw2:', bwert2,
*/ 'Netto-Anteil:', nwert2, 'MWSt-Anteil:', twert2.
*
*FORM rechnen USING bw wt CHANGING nw tw.
*CASE wt.
*WHEN 'L'. "aktuell: 7%
*nw = bw / '1.07'.
*tw = bw - nw.
*WHEN 'H'. "aktuell: 19%
*nw = bw / '1.19'.
*tw = bw - nw.
*WHEN OTHERS.
*write: / 'Falscher Typ'. exit.
*ENDCASE.
*ENDFORM.




*DO 3 TIMES.
*  WRITE / sy-index.
*  DO 2 TIMES.
*    IF sy-index = 1.
*      WRITE sy-index.
*      EXIT.
*    ENDIF.
*  ENDDO.
*  IF sy-index MOD 2 = 0.
*    CONTINUE.
*  ENDIF.
*  WRITE sy-index.
*ENDDO.

*
*DATA:
*  carrid TYPE spfli-carrid VALUE 'LH',
*  cityto TYPE spfli-cityto   VALUE 'HAMBURG'.
*
*cl_demo_input=>new(
*  )->add_field( CHANGING field = carrid
*  )->add_field( CHANGING field = cityto )->request( ).
*
*SELECT  p~connid, f~fldate, price, seatsocc
*       FROM ( ( scarr AS c
*         INNER JOIN spfli AS p ON p~carrid   = @carrid
*                              AND p~cityto = @cityto )
*         INNER JOIN sflight AS f ON f~connid = p~connid )
*       ORDER BY c~carrname, p~connid, f~fldate
*       INTO TABLE @DATA(itab2).
*
*  cl_demo_output=>display( ITAB2 ).
*
*  Liste Terminazfträge mit Lieferstatus = nicht/unvollständig bearbeitet, nach Kunde Land, gruppiert
**SELECT k~land1, v~vkorg, v~vtweg, k~kunnr, v~lfstk, COUNT( lfstk ) AS anzahl
**  FROM vbak AS v
**  INNER JOIN kna1 AS k
**  ON v~kunnr = k~kunnr
**  WHERE v~auart = 'TA'
**    AND ( v~lfstk = 'A' OR v~lfstk = 'B')
*** AND k~land1 = 'DE'
**  GROUP BY k~land1, v~vkorg, v~vtweg, k~kunnr, v~lfstk  " KUNNR kommt aus Eingabe
***  HAVING k~land1 = 'DE'   " kommt aus Eingabe
**  INTO TABLE @DATA(tresult1).
**
**cl_demo_output=>display( tresult1 ).
*
**- Liste Terminazfträge mit Lieferstatus = nicht/unvollständig bearbeitet, nach Kunde Land, gruppiert
**  Auftragsnettowert / Währung für noch nicht ausgelieferte Aufträge -> Kohle fehlt uns
*SELECT k~land1, v~vkorg, v~vtweg, k~kunnr, v~lfstk, SUM( NETWR ) AS Auftragswert, v~waerk as Currency
* FROM vbak AS v
*  INNER JOIN kna1 AS k
*  ON v~kunnr = k~kunnr
*  WHERE v~auart = 'TA'
*    AND ( v~lfstk = 'A' OR v~lfstk = 'B')
** AND k~land1 = 'DE'
*  GROUP BY k~land1, v~vkorg, v~vtweg, k~kunnr, v~lfstk,  v~waerk  " KUNNR kommt aus Eingabe
**  HAVING k~land1 = 'DE'   " kommt aus Eingabe
*  INTO TABLE @DATA(tresult2).
*
*cl_demo_output=>display( tresult2 ).
*
*PARAMETERS: b TYPE i DEFAULT 4.
*DATA: res type i VALUE 5.
*WRITE: b, res.
*PERFORM rechne USING res CHANGING b.
*WRITE: b, res.
*FORM rechne USING b CHANGING c.
*  data: res TYPE i VALUE 6.
*  c = res.
*  WRITE: b, res.
*  ENDFORM.

*CLASS pkw DEFINITION.
*PUBLIC SECTION.
*METHODS:
*fahren,
*tanken,
*get_inhalt,
*get_farbe. "RETURNING VALUE (re_farbe) TYPE string.
*PROTECTED SECTION.
*DATA:
*
*km TYPE i,
*inhalt TYPE i,
*farbe TYPE string.
*ENDCLASS.
*
*CLASS pkw IMPLEMENTATION.
*METHOD fahren.
*me->km = me->km + 100.
*ENDMETHOD.
*
*METHOD Tanken.
*me->inhalt = me->inhalt + 20.
*ENDMETHOD.
*ENDCLASS.
*
*CLASS taxi DEFINITION INHERITING FROM pkw.
*PUBLIC SECTION.
*METHODS:
**fahren,
*bezahlen,
*qet_inhalt, "RETURNING VALUE (re_inhalt) TYPE i,
*tanken REDEFINITION,
*get_km. "RETURNING VALUE (re_km) TYpe i.
*ENDCLASS.
*
*CLASS taxi IMPLEMENTATION.
**METHOD fahren.
**
**ENDMETHOD.
*
*METHOD tanken.
*super->tanken( ).
**me->inhalt = super->inhalt.
*ENDMETHOD.
*
*ENDCLASS.
*
*START-OF-SELECTIoN.
*DATA:
*my_pkw TYPE REF TO pkw,
*my_taxi TYPE REF TO taxi.
*
*CREATE OBJECT: my_pkw, my_taxi.
*WRITE:/ my_taxi->km, my_pkw->farbe.
*my_taxi->fahren( ).
*my_taxi-get_farbe( ).
*my_pkw->bezahlen( ).

*PARAMETERS:
*p_alter TYPE i.
*
*DATA:
*alter TYPE i.
*
*CLASS kauefer_zu_jung_exception DEFINITION
*INHERITING FROM cx_static_check.
*ENDCLASS.
*
*CLASS laden DEFINITION.
*PUBLIC SECTION.
*CLASS-METHODS:
*alkoholkaufen
*IMPORTING alter TYPE i
*RAISING kauefer_zu_jung_exception.
*
*ENDCLASS.
*
*CLASS laden IMPLEMENTATION.
*
* METHOD alkoholkaufen.
*
* IF alter > 18.
*message |Zum Wohl!| type 'S'.
*ELSE.
*RAISE EXCEPTION TYPE kauefer_zu_jung_exception.
*
* ENDIF.
*ENDMETHOD.
*ENDCLASS.
*
*START-OF-SELECTION.
*
* TRY.
*
* laden=>alkoholkaufen(
*exporting alter = p_alter ).
*
* CATCH kauefer_zu_jung_exception INTO DATA(e_text).
*MESSAGE e_text->get_text( ) TYPE 'S' DISPLAY LIKE 'E'.
*ENDTRY.
