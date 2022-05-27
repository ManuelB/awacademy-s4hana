REPORT z_s04_dummy3.
CLASS pkw DEFINITION.
  PUBLIC SECTION.
    METHODS: change_owner
      IMPORTING im_owner TYPE string.
    DATA:
      kennz   TYPE String,
      owner   TYPE String,
      akt_ort TYPE string.
ENDCLASS.

CLASS pkw IMPLEMENTATION.
  METHOD change_owner.
    me->owner = im_owner.
  ENDMETHOD.
ENDCLASS.

DATA: mein_auto TYPE REF TO pkw.
PARAMETERS:
nr TYPE string DEFAULT 'A-RK 256',
own1 TYPE string DEFAULT 'Hugo',
own2 TYPE string DEFAULT 'Susi',
ort TYPE string DEFAULT 'Augsburg'.

START-OF-SELECTION.
CREATE OBJECT mein_auto.
mein_auto->kennz = nr.
mein_auto->owner = own1.
mein_auto->akt_ort = ort.
mein_auto->change_owner( own2 ).

WRITE: / 'Besitzer', mein_auto->owner.
