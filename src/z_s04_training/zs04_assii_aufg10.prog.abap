REPORT zs04_assii_aufg10.

INTERFACE lif_organisation.
ENDINTERFACE.

INTERFACE lif_natuerlicheperson.
  METHODS:
    name
      IMPORTING vorname  TYPE string
                nachname TYPE string,
    istAngestelltBei RETURNING VALUE(boolean) TYPE cp_boolean.
ENDINTERFACE.

CLASS lcl_praesident DEFINITION.
  PUBLIC SECTION.
    METHODS:
      name,
      istAngestelltBei.
    INTERFACES:
      lif_natuerlicheperson.
    DATA: vorname  TYPE string,
          nachname TYPE string.
    PROTECTED SECTION.
    METHODS test.
ENDCLASS.

CLASS lcl_praesident IMPLEMENTATION.
  METHOD name.
    me->lif_natuerlicheperson~name(
      EXPORTING
        vorname  = vorname
        nachname = nachname    ).
  ENDMETHOD.
  METHOD istangestelltbei.
    me->lif_natuerlicheperson~istangestelltbei( ).
  ENDMETHOD.
  METHOD lif_natuerlicheperson~name.
    WRITE: / vorname, nachname.
  ENDMETHOD.
  METHOD lif_natuerlicheperson~istangestelltbei.
  ENDMETHOD.

  METHOD test.
    ENDMETHOD.
ENDCLASS.

CLASS lcl_test DEFINITION INHERITING FROM lcl_praesident.
  PROTECTED SECTION.
  METHODS test REDEFINITION.

  ENDCLASS.

  CLASS lcl_test IMPLEMENTATION.
    METHOD test.
      super->test( ).
      ENDMETHOD.
      ENDCLASS.


START-OF-SELECTION.
  DATA: lo_praesi TYPE REF TO lcl_praesident.
  PARAMETERS: p_vname TYPE string,
              p_nname TYPE string,
              p_ja    TYPE cp_boolean.

  lo_praesi = NEW lcl_praesident( ).
  lo_praesi->lif_natuerlicheperson~name(
    EXPORTING
      vorname  = p_vname
      nachname = p_nname  ).

  lo_praesi->istangestelltbei( ).
  IF p_ja = 'X'.
    WRITE: / 'ist bei der Organisation angestellt.'.
  ELSE.
    WRITE: / 'ist nicht bei der Organisation angestellt.'.
  ENDIF.
