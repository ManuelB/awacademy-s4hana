*&---------------------------------------------------------------------*
*& Report ZBC_INTERFACE_1_RFC_SYNC
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zs11_interface_2_rfc_async.

DATA: fil_line  TYPE adrc,
      fil_table TYPE TABLE OF adrc,
      t_result  TYPE bapiret2_t.

*--------------------------------------------------------------
START-OF-SELECTION.

  SELECT addrnumber, name1, post_code1, city1, street, house_num1 UP TO 10 ROWS
  FROM adrc
  INTO CORRESPONDING FIELDS OF TABLE @fil_table.

  DATA i_filialnr   TYPE adrc-addrnumber.
  DATA i_name1      TYPE adrc-name1.
  DATA i_post_code1 TYPE adrc-post_code1.
  DATA i_city1      TYPE adrc-city1.
  DATA i_street     TYPE adrc-street.
  DATA i_housenr    TYPE adrc-house_num1.

  DATA: new_task TYPE char10.

  LOOP AT fil_table INTO fil_line.

    new_task = 'ACTTASK' && sy-tabix.
    ASSIGN new_task TO FIELD-SYMBOL(<new_task>).

    IF <new_task> IS ASSIGNED.

      CALL FUNCTION 'Z_BC_CREATE_FILIALE_ASYNC'
        STARTING NEW TASK <new_task>
        DESTINATION 'NONE' "IN GROUP '390'
        CALLING zbc_cl_rfc_receive=>receive ON END OF TASK
        EXPORTING
          i_filialnr   = fil_line-addrnumber
          i_name1      = fil_line-name1
          i_post_code1 = fil_line-post_code1
          i_city1      = fil_line-city1
          i_street     = fil_line-street
          i_housenr    = fil_line-house_num1.
*
*        TABLES
*          t_return     = t_result.

      WAIT FOR ASYNCHRONOUS TASKS UNTIL 2 LT 1.

    ENDIF.

  ENDLOOP.

*--- t_result will not provide any data in asynchronous mode

*--- check target table whether inserted entries are stored
*    w/o explicit COMMIT WORK
*--  same behaviour like befor in synchronous mode
  BREAK-POINT.