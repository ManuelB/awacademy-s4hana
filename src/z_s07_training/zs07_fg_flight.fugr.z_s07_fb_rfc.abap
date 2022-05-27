FUNCTION Z_S07_FB_RFC.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(I_FILIALNR) TYPE  ADRC-ADDRNUMBER
*"     VALUE(I_NAME1) TYPE  ADRC-NAME1
*"     VALUE(I_POST_CODE1) TYPE  ADRC-POST_CODE1
*"     VALUE(I_CITY) TYPE  ADRC-CITY1
*"     VALUE(I_STREET) TYPE  ADRC-STREET
*"     VALUE(I_HOUSENR) TYPE  ADRC-HOUSE_NUM1
*"  TABLES
*"      T_RETURN STRUCTURE  BAPIRET2
*"----------------------------------------------------------------------
DATA: fil_line TYPE ZSD_GRP1_FS_KP,
        return   TYPE bapiret2,
        count    TYPE i.

  CLEAR fil_line.

  fil_line-mandt    = sy-mandt.
  fil_line-filnr     = i_filialnr.
  fil_line-filname       = i_name1.
  fil_line-ort        = i_city.
  fil_line-strasse    = i_street && ' ' && i_housenr .
  fil_line-plz        = i_post_code1.
  fil_line-userid   = sy-uname.
  fil_line-datum   = sy-datum.

  SELECT COUNT( filnr )
    FROM zsd_grp1_fs_kp
    WHERE filnr = @i_filialnr
    INTO @count.

  IF count = 0.
    INSERT zsd_grp1_fs_kp FROM fil_line.

    IF sy-subrc = 0.
      return-type = 'S'.
      return-id = 'ZMSG_GRP9'.
      return-number = '003'.
      return-message_v1 = i_filialnr.
    ELSE.
      return-type = 'E'.
      return-id = 'ZMSG_GRP9'.
      return-number = '003'.
      return-message = 'Update failed'.
      return-message_v1 = i_filialnr.

    ENDIF.
  ELSE.

  ENDIF.

  APPEND return TO t_return.




ENDFUNCTION.
