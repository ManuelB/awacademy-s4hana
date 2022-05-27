FUNCTION ZS505_FUBA_RFC.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     REFERENCE(I_FILIALBEZEICHNUNG) TYPE
*"        ZSD_GRP2_FILBEST-FILIALBEZEICHNUNG
*"     REFERENCE(I_ORT) TYPE  ZSD_GRP2_FILBEST-ORT
*"     REFERENCE(I_STRASSE) TYPE  ZSD_GRP2_FILBEST-STRASSE
*"     REFERENCE(I_PLZ) TYPE  ZSD_GRP2_FILBEST-PLZ
*"     REFERENCE(I_TELEFON) TYPE  ZSD_GRP2_FILBEST-TELEFON OPTIONAL
*"  EXPORTING
*"     REFERENCE(EX_FILNUM) TYPE  ZSD_GRP2_FILBEST-FILIALNUMMER
*"  TABLES
*"      T_RETURN STRUCTURE  BAPIRET2
*"----------------------------------------------------------------------
DATA: fil_line TYPE ZS05_FILSTAM,
        return   TYPE bapiret2,
        count    TYPE i.

  CLEAR fil_line.

  fil_line-mandant    = sy-mandt.
*  fil_line-filialnummer     = ex_filnum.
  fil_line-filialbezeichnung      = i_filialbezeichnung.
  fil_line-ort        = i_ort.
  fil_line-strasse    = i_strasse.
  fil_line-plz        = i_plz.
  fil_line-benutzer   = sy-uname.
  fil_line-datum   = sy-datum.

*  SELECT COUNT( nummer )
*    FROM ZSD_GRP2_FILBEST
*    WHERE nummer = @i_filialnr
*    INTO @count.

 SELECT MAX( filialnummer ) FROM zsd_grp2_filbest INTO fil_line-filialnummer.
    fil_line-filialnummer = fil_line-filialnummer + 5.
    ex_filnum = fil_line-filialnummer.

  IF sy-subrc = 0.
    INSERT ZS05_FILSTAM FROM fil_line.

    IF sy-subrc = 0.
      return-type = 'S'.
      return-id = 'ZMSG_GRP9'.
      return-number = '003'.
      return-message_v1 = 'Neue filiale ist angelegt'.
    ELSE.
      return-type = 'E'.
      return-id = 'ZMSG_GRP9'.
      return-number = '003'.
      return-message = 'Update failed'.
      return-message_v1 = ex_filnum.

    ENDIF.
  ELSE.

  ENDIF.

  APPEND return TO t_return.

ENDFUNCTION.
