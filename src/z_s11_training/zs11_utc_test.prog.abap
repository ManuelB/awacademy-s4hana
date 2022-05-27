REPORT ZS11_UTC_TEST.
*
DATA:
  ls_goodsmove type zgrp3_bewegungen.

ls_goodsmove-mandant = sy-mandt.
    ls_goodsmove-artikelnummer = '10001'.
    ls_goodsmove-filialnummer = '0005'.
    ls_goodsmove-bewegungsart = '105'.
    ls_goodsmove-soll_haben = '+'.
    ls_goodsmove-menge = 100.
    ls_goodsmove-mengeneinheit = 'ST'.
    ls_goodsmove-verbuchende = sy-uname.
    ls_goodsmove-verbuchungsdatum = sy-datum.
    ls_goodsmove-verbuchungszeit = sy-uzeit.
    ls_goodsmove-beleg_zeit = utclong_current( ).
*   INSERT INTO zgrp3_bewegungen VALUES @ls_goodsmove.
     "INSERT ls_goodsmove INTO TABLE lt_goodsmove.
    WRITE: / utclong_current( ), / ls_goodsmove-beleg_zeit.
     INSERT zgrp3_bewegungen FROM ls_goodsmove.
     WRITE: / sy-subrc.
