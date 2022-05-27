*&---------------------------------------------------------------------*
*& Report Z_S05_RFC_AUFGABE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s05_rfc_aufgabe.

DATA: fil_line  TYPE ZS05_FILSTAM,
      fil_table TYPE TABLE OF adrc,
      t_result  TYPE bapiret2_t.

PARAMETERS p_county TYPE land1_gp.

*SELECT a~adrnr, b~addrnumber , b~name1, b~post_code1, b~city1, b~street, b~house_num1 FROM kna1 AS a
*      INNER JOIN adrc AS b ON a~adrnr = b~addrnumber
*      WHERE land1 = @p_county
*    INTO CORRESPONDING FIELDS OF TABLE @fil_table.


SELECT adrnr INTO TABLE @DATA(addrnr)
  FROM kna1
  WHERE land1 = @p_county.

IF NOT addrnr[] IS INITIAL.
  SELECT addrnumber, name1, post_code1, city1, street, house_num1
  FROM adrc
  INTO CORRESPONDING FIELDS OF TABLE @fil_table
    FOR ALL ENTRIES IN @addrnr
    WHERE addrnumber = @addrnr-adrnr.

ENDIF.

DATA i_filialnr   TYPE adrc-addrnumber.
DATA i_name1      TYPE adrc-name1.
DATA i_post_code1 TYPE adrc-post_code1.
DATA i_city1      TYPE adrc-city1.
DATA i_street     TYPE adrc-street.
DATA i_housenr    TYPE adrc-house_num1.

DATA: new_task TYPE char10.


*  DATA:
*    i_FILIALNUMMER      TYPE zsd_grp2_filbest-filialnummer,
*    i_FILIALBEZEICHNUNG TYPE zsd_grp2_filbest-filialbezeichnung,
*    i_ORT               TYPE zsd_grp2_filbest-ort,
*    i_STRASSE           TYPE zsd_grp2_filbest-strasse,
*    i_PLZ               TYPE zsd_grp2_filbest-plz,
*    i_TELEFON           TYPE zsd_grp2_filbest-telefon,
*    i_benutzer          TYPE sy-uname,
*    i_datum             TYPE sy-datlo.


*  DATA: new_task TYPE char10.

  LOOP AT fil_table INTO fil_line.

    CALL FUNCTION 'ZS505_FUBA_RFC'
      EXPORTING
        i_filialbezeichnung       = fil_line-FILIALNUMMER
        i_ort                     = fil_line-ort
        i_strasse                 = fil_line-strasse
        i_plz                     = fil_line-plz
       I_TELEFON                 = fil_line-telefon
*     IMPORTING
*       EX_FILNUM                 =
      TABLES
        t_return                  = t_result.
              .

  ENDLOOP.

*LOOP AT fil_table INTO fil_line.
*
**  new_task = 'ACTTASK' && sy-tabix.
**  ASSIGN new_task TO FIELD-SYMBOL(<new_task>).
**
**  IF <new_task> IS ASSIGNED.
*
*  CALL FUNCTION 'Z_BC_CREATE_FILIALE'
**    STARTING NEW TASK <new_task>
**      DESTINATION 'NONE'
*    EXPORTING
*      i_filialnr   = fil_line-filialnummer
*      i_name1      = fil_line-filialbezeichnung
*      i_post_code1 = fil_line-plz
*      i_city1      = fil_line-ort
*      i_street     = fil_line-strasse
**      i_housenr    = fil_line-house_num1
*    TABLES
*      t_return     = t_result.
*
**  ENDIF.
*
*ENDLOOP.

*--- check target table whether inserted entries are stored
*    w/o explicit COMMIT WORK
BREAK-POINT.

**DATA: fil_line  TYPE zsd_grp2_filbest,
**      fil_table TYPE TABLE OF zsd_grp2_filbest,
**      t_result  TYPE bapiret2_t.
*
*DATA: fil_line  TYPE adrc,
*      fil_table TYPE TABLE OF adrc,
*      t_result  TYPE bapiret2_t.
*
*parameters p_coun type land1.
*
*  select adrnr into table @DATA(addrnr)
*    from kna1
*    where land1 = @p_coun.
*
*  if not addrnr() is initial.
*
*SELECT addrnumber, name1, post_code1, city1, street, house_num1
*FROM adrc
*INTO CORRESPONDING FIELDS OF TABLE @fil_table
*  for all entries in @adrc
*    where addrnumber = @adrc-aadrc.
*    endif.
*
*  DATA i_filialnr   TYPE adrc-addrnumber.
*DATA i_name1      TYPE adrc-name1.
*DATA i_post_code1 TYPE adrc-post_code1.
*DATA i_city1      TYPE adrc-city1.
*DATA i_street     TYPE adrc-street.
*DATA i_housenr    TYPE adrc-house_num1.
*
*DATA: new_task TYPE char10.
*
*LOOP AT fil_table INTO fil_line.
*
**  new_task = 'ACTTASK' && sy-tabix.
**  ASSIGN new_task TO FIELD-SYMBOL(<new_task>).
**
**  IF <new_task> IS ASSIGNED.
*
*  CALL FUNCTION 'Z_BC_CREATE_FILIALE'
**    STARTING NEW TASK <new_task>
**      DESTINATION 'NONE'
*    EXPORTING
*      i_filialnr   = fil_line-addrnumber
*      i_name1      = fil_line-name1
*      i_post_code1 = fil_line-post_code1
*      i_city1      = fil_line-city1
*      i_street     = fil_line-street
*      i_housenr    = fil_line-house_num1
*    TABLES
*      t_return     = t_result.
*endloop.
**
**SELECT filialbezeichnung, ort, strasse, TELEFON  FROM zsd_grp2_filbest INTO CORRESPONDING FIELDS OF @fil_line. endselect.
**
**  DATA:
**    i_FILIALNUMMER      TYPE zsd_grp2_filbest-filialnummer,
**    i_FILIALBEZEICHNUNG TYPE zsd_grp2_filbest-filialbezeichnung,
**    i_ORT               TYPE zsd_grp2_filbest-ort,
**    i_STRASSE           TYPE zsd_grp2_filbest-strasse,
**    i_PLZ               TYPE zsd_grp2_filbest-plz,
**    i_TELEFON           TYPE zsd_grp2_filbest-telefon,
**    i_benutzer          TYPE sy-uname,
**    i_datum             TYPE sy-datlo.
**
**
**  DATA: new_task TYPE char10.
**
**  LOOP AT fil_table INTO fil_line.
**
**    CALL FUNCTION 'ZS505_FUBA_RFC'
**      EXPORTING
**        i_filialbezeichnung       = fil_line-FILIALNUMMER
**        i_ort                     = fil_line-ort
**        i_strasse                 = fil_line-strasse
**        i_plz                     = fil_line-plz
**       I_TELEFON                 = fil_line-telefon
***     IMPORTING
***       EX_FILNUM                 =
**      TABLES
**        t_return                  = t_result.
**              .
**
**  ENDLOOP.
