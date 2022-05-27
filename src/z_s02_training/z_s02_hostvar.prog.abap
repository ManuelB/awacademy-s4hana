*&---------------------------------------------------------------------*
*& Report Z_S02_HOSTVAR
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s02_hostvar.

* Ziel: parameter eingeben, select, struktur wird definiert
* Beispiel unten ändern. Nicht nur, ... , andere Tabelle



*SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME. "ein Eingabefeld für Dynpro zur Verfügung stellen mit einem Rahmen
*
*
*  PARAMETERS p_carr TYPE s_carr_id.
*
*SELECTION-SCREEN END OF BLOCK a1.
*
*
*START-OF-SELECTION.
*
*  SELECT SINGLE carrid, connid INTO @DATA(flights)
*    FROM sflight
*    WHERE carrid = @p_carr.



*BREAK-POINT.

******
** Beispiel von oben ändern: andere Parameter, andere Tabelle
******



  SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME.


    PARAMETERS: p_fltime TYPE s_fltime,
                p_dist  TYPE s_distance.

  SELECTION-SCREEN END OF BLOCK a1.


START-OF-SELECTION.

  SELECT SINGLE fltime, distance INTO @DATA(flights)
    FROM spfli
    WHERE fltime = @p_fltime
    AND distance >= @p_dist.

  BREAK-POINT.

















*  DATA carrid TYPE spfli-carrid.
*  cl_demo_input=>request( CHANGING field =
*
*    data: begin OF result,
*      carrid TYPE sflight-carrid,
*      connic TYPE sflight-connid,
*      end OF result.
*
*  SELECT carrid, connid
*    FROM sflight
*    INTO CORRESPONDING FIELDS OF @result "-@DATA(result_new)-
*    WHERE carrid = @carrid.
*
*    ...
*  ENDSELECT.
*
*  FIELD-SYMBOLS <result> LIKE result.
*  SELECT carrid, connid
*    FROM sflight
*    INTO sflight
*    INTO CORRESPONDING FIELDS OF @<result>
*    WHERE carrid = @carrid.
*
*    ...
*  ENDSELECT.
