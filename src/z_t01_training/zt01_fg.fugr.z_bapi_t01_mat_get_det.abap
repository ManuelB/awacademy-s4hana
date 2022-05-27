FUNCTION Z_BAPI_T01_MAT_GET_DET.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(MATNR) TYPE  ZT01_MATNR
*"  EXPORTING
*"     VALUE(MARA) TYPE  ZT01_MARA
*"     VALUE(RETURN) TYPE  BAPIRET2
*"----------------------------------------------------------------------

SELECT SINGLE * FROM MARA INTO CORRESPONDING FIELDS OF mara WHERE matnr = matnr.



ENDFUNCTION.
