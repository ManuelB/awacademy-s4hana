*&---------------------------------------------------------------------*
*& Report Z_S07_RFC_AUFGABE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s07_rfc_aufgabe.

DATA: fil_line  TYPE adrc,
      fil_table TYPE TABLE OF adrc,
      t_result  TYPE bapiret2_t.

PARAMETERS p_county TYPE land1_gp.

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

LOOP AT fil_table INTO fil_line.

  CALL FUNCTION 'Z_S07_FB_RFC'
    EXPORTING
      i_filialnr         = fil_line-addrnumber
      i_name1            = fil_line-name1
      i_post_code1       = fil_line-post_code1
      i_city             = fil_line-city1
      i_street           = fil_line-street
      i_housenr          = fil_line-house_num1
    TABLES
      t_return           = t_result
            .



ENDLOOP.
