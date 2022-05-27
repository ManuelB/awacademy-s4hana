*&---------------------------------------------------------------------*
*& Report Z_GRP03_SWEETS_CLASS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_grp03_sweets_class.


CLASS lcl_sweets DEFINITION.
  PUBLIC SECTION.

    METHODS:
      articlelist
        EXPORTING
          ex_list TYPE string
        EXCEPTIONS
          no_group,

      delistarticle
        EXPORTING
          ex_delarticle TYPE string
        EXCEPTIONS
          no_artikel,

      newarticleprice
        EXPORTING
          ex_newprice TYPE price
        EXCEPTIONS
          no_artikel
          no_group
          stocktoohigh
          pricetoohigh.

  PRIVATE SECTION.
    TYPES price TYPE p LENGTH 6 DECIMALS 2.

    DATA  Sweets TYPE zgrp03_sweets.

ENDCLASS.

CLASS lcl_sweets IMPLEMENTATION.

  METHOD articlelist.
    CALL TRANSACTION 'Z_GRP03_TR_GETLIST'.
    RAISE no_group.
*    MESSAGE 'xyz' WITH p_artgrp.
  ENDMETHOD.
  METHOD delistarticle.
    CALL TRANSACTION 'Z_GRP03_TR_DELIST'.
    RAISE no_artikel.
  ENDMETHOD.
  METHOD newarticleprice.
    CALL TRANSACTION 'Z_GRP03_TR_newprice'.
    RAISE: no_artikel,
    no_group,
    stocktoohigh,
    pricetoohigh.

  ENDMETHOD.

ENDCLASS.


START-OF-SELECTION.

  DATA:
    lo_articlelist     TYPE REF TO lcl_sweets,
    lo_delistarticel   TYPE REF TO lcl_sweets,
    lo_newarticleprice TYPE REF TO lcl_sweets.

  lo_articlelist     = NEW lcl_sweets( ).
  lo_delistarticel   = NEW lcl_sweets( ).
  lo_newarticleprice = NEW lcl_sweets( ).

  lo_articlelist->articlelist( ).
  lo_delistarticel->delistarticle( ).
  lo_newarticleprice->newarticleprice( ).
