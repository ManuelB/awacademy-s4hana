REPORT zaws04_rfc_sync.

DATA: fil_line  TYPE adrc,
      fil_table TYPE TABLE OF adrc,
      t_res     TYPE bapiret2_t.

SELECT ad~addrnumber, ad~name1, ad~post_code1, ad~city1, ad~street, ad~house_num1, ad~country
  FROM adrc AS ad
  INNER JOIN kna1 AS kn ON ad~addrnumber = kn~adrnr
  WHERE ad~country = 'US'
  INTO CORRESPONDING FIELDS OF TABLE @fil_table.

DATA: i_filnr   TYPE adrc-addrnumber,
      i_filname TYPE adrc-name1,
      i_pstcode TYPE adrc-post_code1,
      i_city    TYPE adrc-city1,
      i_street  TYPE adrc-street,
      i_hsnum   TYPE adrc-house_num1,

      new_task  TYPE char10.


LOOP AT fil_table INTO fil_line.

  CALL FUNCTION 'ZAWS04_FB_RFC_SYNC'
    EXPORTING
      i_filnr   = fil_line-addrnumber
      i_filname = fil_line-name1
      i_pstcode = fil_line-post_code1
      i_city    = fil_line-city1
      i_street  = fil_line-street
      i_hsnum   = fil_line-house_num1
    TABLES
      t_return  = t_res.

ENDLOOP.
