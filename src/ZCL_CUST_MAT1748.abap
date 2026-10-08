CLASS zcl_cust_mat1748 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.

    TYPES:
      BEGIN OF ty_final,
        kunnr  TYPE vbak-kunnr,
        name1  TYPE kna1-name1,
        matnr  TYPE vbap-matnr,
        maktx  TYPE makt-maktx,
        mtart  TYPE mara-mtart,
        kwmeng TYPE vbap-kwmeng,
        meins  TYPE vbap-meins,
        werks  TYPE vbap-werks,
      END OF ty_final.

    TYPES:
      tt_final TYPE STANDARD TABLE OF ty_final
                WITH EMPTY KEY.

    TYPES:
      tt_erdat TYPE RANGE OF vbak-erdat,
      tt_kunnr TYPE RANGE OF vbak-kunnr,
      tt_matnr TYPE RANGE OF vbap-matnr.

    METHODS validate_inputs
      IMPORTING
        iv_vkorg TYPE vbak-vkorg
        it_erdat TYPE tt_erdat
        it_kunnr TYPE tt_kunnr
        it_matnr TYPE tt_matnr.

    METHODS fetch_data
      IMPORTING
        iv_vkorg TYPE vbak-vkorg
        it_erdat TYPE tt_erdat
        it_kunnr TYPE tt_kunnr
        it_matnr TYPE tt_matnr.

    METHODS display_alv
      RAISING
        cx_salv_msg.

  PROTECTED SECTION.

  PRIVATE SECTION.

    DATA mt_final TYPE tt_final.

ENDCLASS.


CLASS zcl_cust_mat1748 IMPLEMENTATION.

  METHOD validate_inputs.

    IF iv_vkorg IS INITIAL.
      MESSAGE e001(zmc_cust_mat)
        WITH 'Sales Organization is mandatory'.
    ENDIF.

    SELECT SINGLE vkorg
      FROM vbak
      WHERE vkorg = @iv_vkorg
      INTO @DATA(lv_vkorg).

    IF sy-subrc <> 0.
      MESSAGE e002(zmc_cust_mat)
        WITH 'Invalid Sales Organization'.
    ENDIF.

    IF it_erdat IS INITIAL.
      MESSAGE e003(zmc_cust_mat)
        WITH 'Creation Date is mandatory'.
    ENDIF.

    IF it_kunnr IS NOT INITIAL.

      SELECT SINGLE kunnr
        FROM kna1
        WHERE kunnr IN @it_kunnr
        INTO @DATA(lv_kunnr).

      IF sy-subrc <> 0.
        MESSAGE e004(zmc_cust_mat)
          WITH 'Invalid Customer Number'.
      ENDIF.

    ENDIF.

    IF it_matnr IS NOT INITIAL.

      SELECT SINGLE matnr
        FROM mara
        WHERE matnr IN @it_matnr
        INTO @DATA(lv_matnr).

      IF sy-subrc <> 0.
        MESSAGE e005(zmc_cust_mat)
          WITH 'Invalid Material Number'.
      ENDIF.

    ENDIF.

  ENDMETHOD.


  METHOD fetch_data.

    CLEAR mt_final.

    SELECT
      a~kunnr,
      b~name1,
      c~matnr,
      e~maktx,
      d~mtart,
      c~kwmeng,
      c~meins,
      c~werks

      FROM vbak AS a

      INNER JOIN kna1 AS b
        ON a~kunnr = b~kunnr

      INNER JOIN vbap AS c
        ON a~vbeln = c~vbeln

      INNER JOIN mara AS d
        ON c~matnr = d~matnr

      LEFT OUTER JOIN makt AS e
        ON c~matnr = e~matnr
       AND e~spras = @sy-langu

      WHERE a~vkorg = @iv_vkorg
        AND a~erdat IN @it_erdat
        AND a~kunnr IN @it_kunnr
        AND c~matnr IN @it_matnr

      INTO TABLE @mt_final.

    IF mt_final IS INITIAL.

      MESSAGE s006(zmc_cust_mat)
        WITH 'No Data Found for the Given Selection Criteria'
        DISPLAY LIKE 'E'.

    ENDIF.

  ENDMETHOD.


  METHOD display_alv.

    DATA lo_alv TYPE REF TO cl_salv_table.

    IF mt_final IS INITIAL.
      RETURN.
    ENDIF.

    cl_salv_table=>factory(
      IMPORTING
        r_salv_table = lo_alv
      CHANGING
        t_table      = mt_final ).

    lo_alv->get_functions( )->set_all(
      abap_true ).

    lo_alv->get_columns( )->set_optimize(
      abap_true ).

    lo_alv->display( ).

  ENDMETHOD.

ENDCLASS.
