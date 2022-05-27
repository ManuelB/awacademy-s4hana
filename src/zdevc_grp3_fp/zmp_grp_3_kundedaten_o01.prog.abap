*&---------------------------------------------------------------------*
*& Include          ZMP_GRP_3_KUNDEDATEN_O01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
DATA:
  cust     TYPE REF TO cl_gui_custom_container,
  cust2    TYPE REF TO cl_gui_custom_container,
  cust3    TYPE REF TO cl_gui_custom_container,
  url      TYPE cndp_url,
  url2     TYPE cndp_url,
  url3     TYPE cndp_url,
  picture1 TYPE REF TO cl_gui_picture,
  picture2 TYPE REF TO cl_gui_picture,
  picture3 TYPE REF TO cl_gui_picture.

MODULE status_0105 OUTPUT.
CREATE OBJECT:
 cust
    EXPORTING
      container_name = 'LG1',

       cust2
    EXPORTING
      container_name = 'CT1',

       cust3
    EXPORTING
      container_name = 'CT2',

      picture1
      EXPORTING
        parent = cust,

    picture2
      EXPORTING
        parent = cust2,

         picture3
      EXPORTING
        parent = cust3.

         CALL FUNCTION 'DP_PUBLISH_WWW_URL'
      EXPORTING
        objid    = 'ZDEMOGR3'
        lifetime = cndp_lifetime_transaction
      IMPORTING
        url      = url.
    picture1->load_picture_from_url( url ).

    CALL FUNCTION 'DP_PUBLISH_WWW_URL'
      EXPORTING
        objid    = 'ZDEMOGR3D'
        lifetime = cndp_lifetime_transaction
      IMPORTING
        url      = url2.
    picture2->load_picture_from_url( url2 ).

     CALL FUNCTION 'DP_PUBLISH_WWW_URL'
      EXPORTING
        objid    = 'ZDEMOGR3C'
        lifetime = cndp_lifetime_transaction
      IMPORTING
        url      = url3.
    picture3->load_picture_from_url( url3 ).

* SET PF-STATUS 'xxxxxxxx'.
* SET TITLEBAR 'xxx'.
endmodule.
