FUNCTION zaws04_fb_rfc_sync.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(I_FILNR) TYPE  AD_ADDRNUM
*"     VALUE(I_FILNAME) TYPE  AD_NAME1
*"     VALUE(I_PSTCODE) TYPE  AD_PSTCD1
*"     VALUE(I_CITY) TYPE  AD_CITY1
*"     VALUE(I_STREET) TYPE  AD_STREET
*"     VALUE(I_HSNUM) TYPE  AD_HSNM1
*"  TABLES
*"      T_RETURN STRUCTURE  BAPIRET2
*"----------------------------------------------------------------------

  DATA: fil_line TYPE zaws04_grp1_fs,
        return TYPE bapiret2,
        count    TYPE i.

  CLEAR fil_line.

  fil_line-mandt = sy-mandt.
  fil_line-filnr = i_filnr.
  fil_line-filname = i_filname.
  fil_line-ort = i_city.
  fil_line-strasse = i_street.
  fil_line-hausnummer = i_hsnum.
  fil_line-plz = i_pstcode.

*  SELECT COUNT( filnr )
*    FROM zaws04_grp1_fs WHERE filnr = @i_filnr INTO @count.

  IF count = 0.
    INSERT zaws04_grp1_fs FROM fil_line.

    IF sy-subrc = 0.
      t_return-type = 'S'.
      t_return-message = 'Update erfolgreich'.
      t_return-message_v1 = i_filnr.
    ELSE.
      t_return-type = 'E'.
      t_return-message = 'Update fehlgeschlagen'.
      t_return-message_v1 = i_filnr.
    ENDIF.
  ENDIF.

  APPEND return TO t_return.

ENDFUNCTION.
