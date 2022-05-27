REPORT zgrp1_enh_smeal_basis.
DATA: ls_smeal TYPE smeal.
PARAMETERS: p_type TYPE smeal-mealtype DEFAULT 'VE'.
*
SELECT * FROM smeal INTO ls_smeal
  WHERE carrid = 'LH'.
  "AND mealtype = p_type.
  WRITE: / ls_smeal-mealnumber.
  CASE ls_smeal-mealtype.
    WHEN 'VE'. WRITE: ls_smeal-mealtype COLOR 4.
    WHEN 'FI'. WRITE: ls_smeal-mealtype COLOR 5.
    WHEN 'FL'. WRITE: ls_smeal-mealtype COLOR 3.
  ENDCASE.
enhancement-POINT ZGRP1 spots zgrp1
ENDSELECT.
