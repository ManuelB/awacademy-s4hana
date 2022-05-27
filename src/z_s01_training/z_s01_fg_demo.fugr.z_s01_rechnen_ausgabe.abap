FUNCTION z_s01_rechnen_ausgabe.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"----------------------------------------------------------------------

ENDFUNCTION.

FORM ausgabe USING a op b res.

  WRITE :/ | { a } { op } { b } = { res }|.

  ULINE.

ENDFORM.
