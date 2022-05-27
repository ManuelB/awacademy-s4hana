FUNCTION ZBAPI_GRP3.
*"--------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(MATERIAL) TYPE  ZGRP3_BAPI_INPUT
*"  EXPORTING
*"     VALUE(MAT_DETAILS) TYPE  ZGRP3_BAPI_OUTPUT
*"     VALUE(RETURN) TYPE  BAPIRET2
*"--------------------------------------------------------------------

  SELECT SINGLE matnr
    mtart
    meins
    matkl
    mbrsh
    FROM mara INTO mat_details WHERE matnr = material.

  IF sy-subrc NE 0.
    return-type = 'E'.
    return-message = 'Material nicht gefunden'.
    ENDIF.




  ENDFUNCTION.
