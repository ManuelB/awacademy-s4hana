*&---------------------------------------------------------------------*
*& Report Z_S06_ABAPSQL_COALESCE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S06_ABAPSQL_COALESCE.

CONSTANTS:co_no_email TYPE ad_smtpadr VALUE 'NO-EMAIL'" try and do the same for persnumber and addrnumber (dataelement persnumber = AD_PERSNUM)(addrnumber = AD_ADDRNUM)
*co_no_persnumber TYPE ad_pernum VALUE 'NO-PERSNUM',
*co_no_addrnum TYPE ad_addrnum VALUE 'NO-PERSNUM'
.

SELECT u~bname,
  u~persnumber,
  u~addrnumber,
  COALESCE( a~smtp_addr,@co_no_email ) AS email


  INTO TABLE @DATA(it_usr)
  FROM usr21 AS u
  LEFT OUTER JOIN adr6 AS a ON a~persnumber = u~persnumber AND a~addrnumber = u~persnumber.

  cl_demo_output=>display( it_usr ).
