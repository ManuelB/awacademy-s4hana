*&---------------------------------------------------------------------*
*& Report ZBC_INTERFACE_1_RFC_SYNC
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zs11_interface_1_rfc_sync.


TYPES :
  BEGIN OF fil_line,
    i_filialnr   TYPE adrc-addrnumber,
    i_name1      TYPE adrc-name1,
    i_post_code1 TYPE adrc-post_code1,
    i_city1      TYPE adrc-city1,
    i_street     TYPE adrc-street,
    i_housenr    TYPE adrc-house_num1,
  END OF fil_line.

DATA: ls_fil_line TYPE fil_line.

DATA: t_result  TYPE table of bapiret2.

PARAMETERS p_cntry TYPE land1_gp.



SELECT a~addrnumber, a~name1, a~post_code1, a~city1, a~street, a~house_num1
FROM adrc AS a INNER JOIN kna1 AS k
  ON a~addrnumber = k~adrnr
  WHERE k~land1 = @p_cntry
INTO TABLE @DATA(fil_table).


DATA: new_task TYPE char10.

LOOP AT fil_table INTO ls_fil_line.

*  new_task = 'ACTTASK' && sy-tabix.
*  ASSIGN new_task TO FIELD-SYMBOL(<new_task>).
*
*  IF <new_task> IS ASSIGNED.




  CALL FUNCTION 'ZS11_CR_FILIALE'
    EXPORTING
      im_filialnr   = ls_fil_line-i_filialnr
      im_name1      = ls_fil_line-i_name1
      im_post_code1 = ls_fil_line-i_post_code1
      im_city1      = ls_fil_line-i_city1
      im_street     = ls_fil_line-i_street
      im_housenr    = ls_fil_line-i_housenr
    TABLES
      t_return      = t_result.

*endif.
ENDLOOP.
.

*  CALL FUNCTION 'Zs11_CREATE_FILIALE'
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
*
**  ENDIF.
*
*ENDLOOP.

*--- check target table whether inserted entries are stored
*    w/o explicit COMMIT WORK
BREAK-POINT.
