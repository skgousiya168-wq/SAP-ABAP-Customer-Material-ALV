TABLES:
  vbak,
  vbap,
  kna1,
  mara,
  makt.

TYPE-POOLS:
  slis.

TYPES: BEGIN OF ty_output,

         kunnr  TYPE vbak-kunnr,
         name1  TYPE kna1-name1,
         matnr  TYPE vbap-matnr,
         maktx  TYPE makt-maktx,
         mtart  TYPE mara-mtart,
         kwmeng TYPE vbap-kwmeng,
         meins  TYPE vbap-meins,
         werks  TYPE vbap-werks,

       END OF ty_output.

DATA:
  gt_output TYPE TABLE OF ty_output,
  gs_output TYPE ty_output.

DATA:
  gt_fieldcat TYPE slis_t_fieldcat_alv,
  gs_fieldcat TYPE slis_fieldcat_alv.
