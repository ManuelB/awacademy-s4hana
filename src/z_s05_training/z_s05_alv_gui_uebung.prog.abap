*&---------------------------------------------------------------------*
*& Report Z_S05_PICTURE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s05_alv_gui_uebung.

tables spfli.
SET SCREEN 100.

CONTROLS: TABS TYPE TABSTRIP.
DATA:
  cust           TYPE REF TO cl_gui_custom_container,
  cust2          TYPE REF TO cl_gui_custom_container,
  cust3          TYPE REF TO cl_gui_custom_container,
  cust4          TYPE REF TO cl_gui_custom_container,
  dock           TYPE REF TO cl_gui_docking_container,
  url            TYPE cndp_url,
  url2            TYPE cndp_url,
  url3            TYPE cndp_url,
  picture1        TYPE REF TO cl_gui_picture,
  picture2        TYPE REF TO cl_gui_picture,
  picture3        TYPE REF TO cl_gui_picture,
  edit           TYPE REF TO cl_gui_textedit,
  display_text type c LENGTH 350,
  it_text like table of display_text.

MODULE status_0100 OUTPUT.
* SET PF-STATUS 'xxxxxxxx'.
* SET TITLEBAR 'xxx'.
  IF cust IS INITIAL.
    CREATE OBJECT:

     cust
      EXPORTING
        container_name = 'CUCTRL1',

         cust2
      EXPORTING
        container_name = 'CUCTRL2',

         cust3
      EXPORTING
        container_name = 'CUCTRL3',

cust4
      EXPORTING
        container_name = 'CUCTRL4',

*    dock,

    picture1
      EXPORTING
        parent = cust,

    picture2
      EXPORTING
        parent = cust2,

         picture3
      EXPORTING
        parent = cust4,

     edit
      EXPORTING
        parent = cust3.

    CALL FUNCTION 'DP_PUBLISH_WWW_URL'
      EXPORTING
        objid    = 'SAPLOGO.GIF'
        lifetime = cndp_lifetime_transaction
      IMPORTING
        url      = url.
    picture1->load_picture_from_url( url ).

    CALL FUNCTION 'DP_PUBLISH_WWW_URL'
      EXPORTING
        objid    = 'TRVPICTURE01'
        lifetime = cndp_lifetime_transaction
      IMPORTING
        url      = url2.
    picture2->load_picture_from_url( url2 ).

     CALL FUNCTION 'DP_PUBLISH_WWW_URL'
      EXPORTING
        objid    = 'TRVPICTURE05'
        lifetime = cndp_lifetime_transaction
      IMPORTING
        url      = url3.
    picture3->load_picture_from_url( url3 ).

    display_text = 'Willkommen bei SAP-Fl??gen! Buchen Sie Ihren Flug in wenigen Minuten.'.
    append display_text to it_text.

    CALL METHOD edit->set_text_as_stream
      EXPORTING
        text            = it_text.

ENDIF.



ENDMODULE.

MODULE user_command_0100 INPUT.
  CASE sy-ucomm.
*    WHEN
    WHEN 'BEENDEN'.
      SET SCREEN 0.
      LEAVE SCREEN.
     WHEN 'SUCHEN'.
       SET SCREEN 200.
  ENDCASE.


ENDMODULE.


MODULE user_command_0200 INPUT.
  case sy-ucomm.
WHEN 'BACK'.
      SET SCREEN 100.
       when 'SUCHEN'.
             select SINGLE * FROM SPFLI
      WHERE CARRID = SPFLI-CARRID
      AND CONNID = SPFLI-CONNID.
      if sy-subrc <> 0.
        MESSAGE: 'NICHT DA' TYPE 'E'.
        "spfli-cityfrom = 'nicht da'.
        CLEAR SPFLI.
        endif.
          select SINGLE * FROM SPFLI
      WHERE cityfrom = SPFLI-cityfrom
     AND cityto = SPFLI-cityto
            and carrid = spfli-carrid.


      if sy-subrc <> 0.
        MESSAGE: 'NICHT DA' TYPE 'E'.
        "spfli-cityfrom = 'nicht da'.
        CLEAR SPFLI.
          endif.

          WHEN 'BEENDEN'.
      SET SCREEN 0.

  ENDCASE.

ENDMODULE.
                                        "fcode_tc_mark_lines
