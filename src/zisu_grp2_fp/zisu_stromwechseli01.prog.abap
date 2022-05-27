*&---------------------------------------------------------------------*
*& Include          ZISU_STROMWECHSELI01
*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_1010  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_1010 INPUT.

CLEAR flag.
  CASE sy-ucomm.
    WHEN 'SHOW'.
      SELECT * FROM zisu_fp_tarife INTO TABLE lt_tarife.

    flag = 'X'.
        WHEN 'REPORT'.
SUBMIT ZISU_GRP2_GRAFIK.
    WHEN 'BACK'.
      LEAVE PROGRAM.


   WHEN 'URL'.

      CALL FUNCTION 'CALL_BROWSER'
      EXPORTING
        URL = 'https://bootcamp.swm.de:44301/sap/bc/ui5_ui5/sap/zisu_tariff/?sap-ui-language=DE#/?sap-iapp-state=4&sap-iapp-state--history=1'.


  When 'COST'.
     CALL FUNCTION 'CALL_BROWSER'
      EXPORTING
        URL = 'https://10.0.0.65:44300/sap/bc/ui5_ui5/sap/zcostcalculator/index.html'.
          ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_1100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_1100 INPUT.
  CREATE OBJECT lo_wechsel.
  CASE sy-ucomm.
    WHEN 'CHANGE'.
      lo_wechsel->tarif_wechseln(
        EXPORTING
          im_kunnr       = zisu_fp_wechsel-kundennr             " Kundennummer
          im_altanbieter = zisu_fp_wechsel-alt_anbieter        " Stromanbieter
          im_tarife = ls_tarife
      ).
    WHEN 'CANCEL'.
      LEAVE PROGRAM.
      when 'GOTO'.
        Call Screen 1010.
endcase.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_1200  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_1200 INPUT.
  create object lo_wechsel.
case sy-ucomm.
  when 'SAVE'.
  Data  ls_kunde type zisu_fp_kunden.

*                CALL FUNCTION 'ADDR_POSTAL_CODE_CHECK'
*                  EXPORTING
*                    country                              = 'de'
*                   POSTAL_CODE_CITY                     = 'zisu_fp_kunden-plz '
**
**                 EXCEPTIONS
**                   COUNTRY_NOT_VALID                    = 1
**                   REGION_NOT_VALID                     = 2
**                   POSTAL_CODE_CITY_NOT_VALID           = 3
**                   POSTAL_CODE_PO_BOX_NOT_VALID         = 4
**                   POSTAL_CODE_COMPANY_NOT_VALID        = 5
**                   PO_BOX_MISSING                       = 6
**                   POSTAL_CODE_PO_BOX_MISSING           = 7
**                   POSTAL_CODE_MISSING                  = 8
**                   POSTAL_CODE_POBOX_COMP_MISSING       = 9
**                   PO_BOX_REGION_NOT_VALID              = 10
**                   PO_BOX_COUNTRY_NOT_VALID             = 11
**                   POBOX_AND_POBOXNUM_FILLED            = 12
**                   OTHERS                               = 13
*                          .
*                IF sy-subrc <> 0.
*Message e007.
*                ENDIF.

  ls_kunde-kunname = zisu_fp_kunden-kunname.
  ls_kunde-email = zisu_fp_kunden-email.
  ls_kunde-geburtsd = zisu_fp_kunden-geburtsd.
  ls_kunde-ort = zisu_fp_kunden-ort.
  ls_kunde-plz = zisu_fp_kunden-plz.
  ls_kunde-strasse = zisu_fp_kunden-strasse.
  ls_kunde-tel = zisu_fp_kunden-tel.
    lo_wechsel->neu_kunde_tarif_waehlen(
      EXPORTING
        im_kunde  =    ls_kunde              " Kundenstammtabelle für Abschlussprojekt Gruppe 2
        im_tarife =   ls_tarife               " Stromanbieter Tarife
    ).

    when 'BACK'.
      "Andere Tarif wählen
      SET SCREEN 1010.
      when 'CANCEL'.
        Leave Program.
        endcase.
ENDMODULE.


MODULE field_validation_name.
  IF zisu_fp_kunden-kunname CN 'A B C D E F G H I J K L M N O P Q R S T U V W X Y Z a b c d e f g h i j k l m n o p q r s t u v w x y z '.
      MESSAGE e006.
  ENDIF.
  endmodule.
  module field_validation_tel.
  if zisu_fp_kunden-tel CN '0 1 2 3 4 5 6 7 8 9 '.
    Message e003.
    endif.


ENDMODULE.
