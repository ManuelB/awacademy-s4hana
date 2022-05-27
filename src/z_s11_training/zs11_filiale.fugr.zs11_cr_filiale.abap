FUNCTION ZS11_CR_FILIALE.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(IM_FILIALNR) TYPE  ADRC-ADDRNUMBER
*"     VALUE(IM_NAME1) TYPE  ADRC-NAME1
*"     VALUE(IM_POST_CODE1) TYPE  ADRC-POST_CODE1
*"     VALUE(IM_CITY1) TYPE  ADRC-CITY1
*"     VALUE(IM_STREET) TYPE  ADRC_STREET
*"     VALUE(IM_HOUSENR) TYPE  ADRC-HOUSE_NUM1
*"  TABLES
*"      T_RETURN STRUCTURE  BAPIRET2
*"----------------------------------------------------------------------



  DATA: fil_line TYPE zs11_filstammdat,
        return   TYPE bapiret2,
        count1    TYPE i.

tables: zs11_filstammdat.
  CLEAR fil_line.

  fil_line-mandant    = sy-mandt.
  fil_line-filialnummer     = im_filialnr.
  fil_line-filialbezeichnung       = im_name1.
  fil_line-ort        = im_city1.
  fil_line-strasse    = im_street && ' ' && im_housenr .
  fil_line-plz        = im_post_code1.
  fil_line-benutzer   = sy-uname.
  fil_line-datum   = sy-datum.

  SELECT COUNT( filialnummer )
    FROM zs11_filstammdat
    WHERE filialnummer = @im_filialnr
    INTO @count1.

  IF count1 = 0.
    INSERT zs11_filstammdat FROM fil_line.

    IF sy-subrc = 0.
      return-type = 'S'.
      return-id = 'ZMSG_GRP9'.
      return-number = '003'.
      return-message_v1 = im_filialnr.
    ELSE.
      return-type = 'E'.
      return-id = 'ZMSG_GRP9'.
      return-number = '003'.
      return-message = 'Update failed'.
      return-message_v1 = im_filialnr.

    ENDIF.
  ELSE.

  ENDIF.

  APPEND return TO t_return.

ENDFUNCTION.
