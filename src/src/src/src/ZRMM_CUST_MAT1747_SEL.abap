SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.

  PARAMETERS:
    p_vkorg TYPE vbak-vkorg OBLIGATORY.

  SELECT-OPTIONS:
    s_erdat FOR vbak-erdat OBLIGATORY,
    s_kunnr FOR vbak-kunnr,
    s_matnr FOR vbap-matnr.

SELECTION-SCREEN END OF BLOCK b1.
