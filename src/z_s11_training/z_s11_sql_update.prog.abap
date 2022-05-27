*&---------------------------------------------------------------------*
*& Report Z_S11_SQL_UPDATE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s11_sql_update.


SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME.
  PARAMETERS : p_carr   TYPE s_carr_id DEFAULT 'AA',
               p_connid TYPE s_conn_id DEFAULT '0017'.
SELECTION-SCREEN END OF BLOCK a1.



SELECT carrid, connid, fldate, price, currency INTO TABLE @DATA(flights) UP TO 2 rows
  FROM ZS11_sflight
  WHERE carrid = @p_carr
  AND connid = @p_connid.


  cl_demo_output=>display( flights ).


UPDATE ZS11_sflight SET price = '500' WHERE carrid = 'AA' AND connid = '0017'.

*Update statement(alone) updates the whole table  acc to given where condition

*COMMIT WORK. "what for?
*
*SELECTION-SCREEN BEGIN OF BLOCK a2 WITH FRAME.
*  PARAMETERS : p_carr2  TYPE s_carr_id DEFAULT 'AZ',
*               p_arpfrm TYPE s_fromairp DEFAULT 'FCO'.
*SELECTION-SCREEN END OF BLOCK a2.
*
*
*
*SELECT SINGLE for update carrid, connid, airpfrom, cityfrom, cityto INTO @DATA(ls_flights)
*  FROM ZS11_spfli
*  WHERE carrid = @p_carr2
*  AND airpfrom = @p_arpfrm.
*
*IF sy-subrc = 0.
*  cl_demo_output=>display( ls_flights ).
*ELSE.
*  WRITE 'No record found'.
*ENDIF.
*
*
*
*UPDATE ZS11_spfli SET cityto = 'FRANKFURT' WHERE carrid = 'AZ' AND airpfrom = 'FCO'.
*
*BREAK-POINT.


*
*COMMIT WORK. "implicit commit


******below code from F1.************************************

**Delete from ZS11_spfli.
*
*INSERT ZS11_flight FROM @( VALUE #( carrid = 'AA') ).
*COMMIT CONNECTION default.
