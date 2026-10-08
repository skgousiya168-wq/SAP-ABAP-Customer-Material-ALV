*&---------------------------------------------------------------------*
*& Include zrmm_cust_mat1747_f01
*&---------------------------------------------------------------------*
INITIALIZATION.

  s_erdat-sign   = 'I'.
  s_erdat-option = 'BT'.
  s_erdat-low    = sy-datum - 90.
  s_erdat-high   = sy-datum.

  APPEND s_erdat.


AT SELECTION-SCREEN.

  CREATE OBJECT go_report.

  go_report->validate_inputs(
    iv_vkorg = p_vkorg
    it_erdat = s_erdat[]
    it_kunnr = s_kunnr[]
    it_matnr = s_matnr[]
  ).


START-OF-SELECTION.

  go_report->fetch_data(
    iv_vkorg = p_vkorg
    it_erdat = s_erdat[]
    it_kunnr = s_kunnr[]
    it_matnr = s_matnr[]
  ).

  go_report->display_alv( ).
