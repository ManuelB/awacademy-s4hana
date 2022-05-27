*&---------------------------------------------------------------------*
*& Report Z_GRP3_FIORI_LIST
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_GRP3_FIORI_LIST.
data: l_obj type SMENSAPNEW-REPORT,
      l_rep type SMENSAPNEW-REPORTTYPE,
      l_url type SMEN_BUFFI-URL.

l_obj = 'URL'.
l_rep = 'OT'.
l_url = 'https://bootcamp.swm.de:44301/sap/bc/ui2/flp?sap-client=100&sap-language=DE'.

CALL FUNCTION 'MENU_START_OBJECT_VIA_INDX'
 EXPORTING
   OBJECT_NAME         = l_obj
   REPORTTYPE          = l_rep
   URL                 = l_url.
