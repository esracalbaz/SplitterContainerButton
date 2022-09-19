*&---------------------------------------------------------------------*
*&  Include           ZESRA_P0016_TOP
*&---------------------------------------------------------------------*

TABLES: vbrk, kna1, vbrp, mara.

DATA: go_grid1 TYPE REF TO cl_gui_alv_grid,
      go_grid2 TYPE REF TO cl_gui_alv_grid,
      go_grid3 TYPE REF TO cl_gui_alv_grid,
      go_cont  TYPE REF TO cl_gui_custom_container.

TYPES: BEGIN OF gty_kna1,
*         mark,
         vbeln TYPE vbrk-vbeln,
         fkart TYPE vbrk-fkart,
         waerk TYPE vbrk-waerk,
         vkorg TYPE vbrk-vkorg,
         fkdat TYPE vbrk-fkdat,
         bukrs TYPE vbrk-bukrs,
*         netwr TYPE vbrk-netwr,
*         mwsbk TYPE vbrk-mwsbk,
         kunag TYPE vbrk-kunag,
         kunnr TYPE kna1-kunnr,
         adrnr TYPE kna1-adrnr,
*         linecolor TYPE char4,
       END OF gty_kna1.

DATA: gt_kna1 TYPE TABLE OF gty_kna1,
      gs_kna1 TYPE          gty_kna1.

DATA: gt_vbrp TYPE TABLE OF vbrp,
      gs_vbrp TYPE          vbrp.

DATA: gt_mara TYPE TABLE OF mara,
      gs_mara TYPE          mara.

DATA: gt_fcat   TYPE lvc_t_fcat,
      gs_fcat   TYPE lvc_s_fcat,
      gs_layout TYPE lvc_s_layo. "internal structure

DATA: gt_fc TYPE lvc_t_fcat,
      gs_fc TYPE lvc_s_fcat.

DATA: gt_fieldcat TYPE lvc_t_fcat,
      gs_fieldcat TYPE lvc_s_fcat.

DATA: go_docking     TYPE REF TO cl_gui_docking_container,
      go_splitter    TYPE REF TO cl_gui_splitter_container,
      go_splitter2   TYPE REF TO cl_gui_splitter_container,
      go_cell_top    TYPE REF TO cl_gui_container,
      go_cell_bottom TYPE REF TO cl_gui_container,
      go_cell_left   TYPE REF TO cl_gui_container,
      go_cell_right  TYPE REF TO cl_gui_container.

CLASS cl_event_receiver DEFINITION DEFERRED. "boyle bir class tanimimda var 49.satira kizma demek

DATA: go_event_receiver TYPE REF TO cl_event_receiver. "olusturdugum classin objesini referans alan data tanimlamasi

SELECTION-SCREEN BEGIN OF BLOCK block WITH FRAME TITLE title.
SELECT-OPTIONS: s_vbeln FOR vbrk-vbeln MODIF ID gr1.
SELECTION-SCREEN END OF BLOCK block.
