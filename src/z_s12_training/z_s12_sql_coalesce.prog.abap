*&---------------------------------------------------------------------*
*& Report Z_S12_SQL_COALESCE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S12_SQL_COALESCE.

CONSTANTS: co_no_email type ad_smtpadr value '<leer>'. "ad_smtpadr ist eine Domäne des Feldes smtp_addr
select u~bname,
  u~persnumber,
  u~addrnumber,
  COALESCE( a~smtp_addr, @co_no_email ) as email "COALESCE reagiert auf Nullwerte, danach Feld auf das es zutrifft und danach das Feld
  into table @DATA(it_usr)
  from usr21 as u
  left OUTER join adr6 as a on a~persnumber = u~persnumber and a~addrnumber = u~addrnumber.
