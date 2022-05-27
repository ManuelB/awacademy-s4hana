*&---------------------------------------------------------------------*
*& Report ZRK_T12_CAST
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrk_t12_cast.

CLASS lcl_parent DEFINITION.
  PUBLIC SECTION.
    METHODS parent_method.

ENDCLASS.
*lcl_parent definition

CLASS lcl_child DEFINITION INHERITING FROM lcl_parent.
  PUBLIC SECTION.
    METHODS parent_method REDEFINITION.
    METHODS child_method.

ENDCLASS.
*lcl_child definition

CLASS lcl_parent IMPLEMENTATION.

  METHOD parent_method.
    WRITE / 'called -> parent METHOD in Parent class!'.
  ENDMETHOD.
*parent_method
ENDCLASS.

*lcl_parent implementation

CLASS lcl_child IMPLEMENTATION.

  METHOD parent_method.
    WRITE / 'called -> parent redifinition METHOD in Child class!'.
  ENDMETHOD.
*parent_method
  METHOD child_method.
    WRITE / 'called -> child METHOD in Child class!'.
  ENDMETHOD.
*child_method

ENDCLASS.
*lcl_child implementation

START-OF-SELECTION.

  DATA: lr_parent TYPE REF TO lcl_parent,
        lr_child  TYPE REF TO lcl_child.

  CREATE OBJECT: lr_parent,lr_child.


BREAK-POINT.


  lr_parent->parent_method( ).
  lr_child->parent_method( ).
  lr_child->child_method( ).
