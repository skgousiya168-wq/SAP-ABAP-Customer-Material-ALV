SELECT-OPTIONS:

  s_vkorg FOR vbak-vkorg OBLIGATORY,

  s_erdat FOR vbak-erdat OBLIGATORY,

  s_kunnr FOR vbak-kunnr,

  s_matnr FOR vbap-matnr.


INITIALIZATION.

  s_erdat-sign   = 'I'.
  s_erdat-option = 'BT'.
  s_erdat-low    = sy-datum - 90.
  s_erdat-high   = sy-datum.

  APPEND s_erdat.


AT SELECTION-SCREEN.

  "Date validation
  IF s_erdat-low IS NOT INITIAL
     AND s_erdat-high IS NOT INITIAL.

    IF s_erdat-low > s_erdat-high.

      MESSAGE 'From date cannot be greater than To date'
        TYPE 'E'.

    ENDIF.

  ENDIF.


  "Sales Organization validation
  SELECT SINGLE vkorg
    FROM vbak
    WHERE vkorg IN @s_vkorg
    INTO @DATA(lv_vkorg).

  IF sy-subrc <> 0.

    MESSAGE 'Invalid Sales Organization'
      TYPE 'E'.

  ENDIF.


  "Customer validation
  IF s_kunnr[] IS NOT INITIAL.

    SELECT SINGLE kunnr
      FROM kna1
      WHERE kunnr IN @s_kunnr
      INTO @DATA(lv_kunnr).

    IF sy-subrc <> 0.

      MESSAGE 'Invalid Customer Number'
        TYPE 'E'.

    ENDIF.

  ENDIF.


  "Material validation
  IF s_matnr[] IS NOT INITIAL.

    SELECT SINGLE matnr
      FROM mara
      WHERE matnr IN @s_matnr
      INTO @DATA(lv_matnr).

    IF sy-subrc <> 0.

      MESSAGE 'Invalid Material Number'
        TYPE 'E'.

    ENDIF.

  ENDIF.
