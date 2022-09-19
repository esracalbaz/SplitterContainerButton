*&---------------------------------------------------------------------*
*&  Include           ZESRA_P0016_FRM
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  DISPLAY_ALV
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM display_alv .
  CREATE OBJECT go_cont
    EXPORTING
*     parent                      =     " Parent container
      container_name              = 'CC_ALV'    " Name of the Screen CustCtrl Name to Link Container To
    EXCEPTIONS
      cntl_error                  = 1
      cntl_system_error           = 2
      create_error                = 3
      lifetime_error              = 4
      lifetime_dynpro_dynpro_link = 5
      OTHERS                      = 6.
  IF sy-subrc <> 0.
*   MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
*              WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.

  CREATE OBJECT go_docking
    EXPORTING
      parent                      = cl_gui_container=>screen0
      ratio                       = 90
    EXCEPTIONS
      cntl_error                  = 1
      cntl_system_error           = 2
      create_error                = 3
      lifetime_error              = 4
      lifetime_dynpro_dynpro_link = 5
      OTHERS                      = 6.
  IF sy-subrc <> 0.
*   MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
*              WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.

  CREATE OBJECT go_splitter
    EXPORTING
      parent            = go_docking    " Parent Container
      rows              = 1    " Number of Rows to be displayed
      columns           = 2    " Number of Columns to be Displayed
    EXCEPTIONS
      cntl_error        = 1
      cntl_system_error = 2
      OTHERS            = 3.
  IF sy-subrc <> 0.
*   MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
*              WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.

  CALL METHOD go_splitter->get_container
    EXPORTING
      row       = 1    " Row
      column    = 1    " Column
    RECEIVING
      container = go_cell_right.    " Container

  CALL METHOD go_splitter->get_container
    EXPORTING
      row       = 1    " Row
      column    = 2    " Column
    RECEIVING
      container = go_cell_left.    " Container

  CREATE OBJECT go_splitter2
    EXPORTING
      parent            = go_cell_left    " Parent Container
      rows              = 2    " Number of Rows to be displayed
      columns           = 1    " Number of Columns to be Displayed
    EXCEPTIONS
      cntl_error        = 1
      cntl_system_error = 2
      OTHERS            = 3.
  IF sy-subrc <> 0.
*   MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
*              WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.

  CALL METHOD go_splitter2->get_container
    EXPORTING
      row       = 1    " Row
      column    = 1    " Column
    RECEIVING
      container = go_cell_top.    " Container

  CALL METHOD go_splitter2->get_container
    EXPORTING
      row       = 2    " Row
      column    = 1    " Column
    RECEIVING
      container = go_cell_left.    " Container

  CREATE OBJECT go_grid1
    EXPORTING
      i_parent          = go_cell_right    " Parent Container
    EXCEPTIONS
      error_cntl_create = 1
      error_cntl_init   = 2
      error_cntl_link   = 3
      error_dp_create   = 4
      OTHERS            = 5.
  IF sy-subrc <> 0.
*   MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
*              WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.

  CREATE OBJECT go_grid2
    EXPORTING
      i_parent          = go_cell_top    " Parent Container
    EXCEPTIONS
      error_cntl_create = 1
      error_cntl_init   = 2
      error_cntl_link   = 3
      error_dp_create   = 4
      OTHERS            = 5.
  IF sy-subrc <> 0.
*   MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
*              WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.

  CREATE OBJECT go_grid3
    EXPORTING
      i_parent          = go_cell_left    " Parent Container
    EXCEPTIONS
      error_cntl_create = 1
      error_cntl_init   = 2
      error_cntl_link   = 3
      error_dp_create   = 4
      OTHERS            = 5.
  IF sy-subrc <> 0.
*   MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
*              WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.

  CREATE OBJECT go_event_receiver.
*  SET HANDLER go_event_receiver->handle_top_of_page FOR go_grid1.
  SET HANDLER go_event_receiver->handle_hotspot_click FOR go_grid1.
  SET HANDLER go_event_receiver->handle_double_click FOR go_grid1.
  SET HANDLER go_event_receiver->handle_double_click2 FOR go_grid2.
  SET HANDLER go_event_receiver->handle_toolbar FOR go_grid2."esra
  SET HANDLER go_event_receiver->handle_user_command FOR go_grid2."esra

  CALL METHOD go_grid1->set_table_for_first_display
    EXPORTING
      is_layout                     = gs_layout    " Layout
    CHANGING
      it_outtab                     = gt_kna1[]    " Output Table
      it_fieldcatalog               = gt_fcat     " Field Catalog
    EXCEPTIONS
      invalid_parameter_combination = 1
      program_error                 = 2
      too_many_lines                = 3
      OTHERS                        = 4.
  IF sy-subrc <> 0.
*   MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
*              WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.

  CALL METHOD go_grid2->set_table_for_first_display
*    EXPORTING
*      is_layout                     = gs_layout    " Layout
    CHANGING
      it_outtab                     = gt_vbrp    " Output Table
      it_fieldcatalog               = gt_fc    " Field Catalog
    EXCEPTIONS
      invalid_parameter_combination = 1
      program_error                 = 2
      too_many_lines                = 3
      OTHERS                        = 4.
  IF sy-subrc <> 0.
*   MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
*              WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.

  CALL METHOD go_grid3->set_table_for_first_display
*    EXPORTING
*      is_layout                     =     " Layout
    CHANGING
      it_outtab                     = gt_mara    " Output Table
      it_fieldcatalog               = gt_fieldcat    " Field Catalog
    EXCEPTIONS
      invalid_parameter_combination = 1
      program_error                 = 2
      too_many_lines                = 3
      OTHERS                        = 4.
  IF sy-subrc <> 0.
*   MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
*              WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.

ENDFORM.                    " DISPLAY_ALV
*&---------------------------------------------------------------------*
*&      Form  GET_DATA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM get_data .
  "vbrk~vbeln vbrk~fkart vbrk~waerk vbrk~vkorg vbrk~fkdat vbrk~bukrs vbrk~kunag kna1~kunnr kna1~adrnr
  SELECT a~vbeln a~fkart a~waerk a~vkorg a~fkdat a~bukrs a~kunag b~kunnr b~adrnr
    FROM vbrk AS a
    INNER JOIN kna1 AS b
    ON a~kunag EQ b~kunnr
    INTO CORRESPONDING FIELDS OF TABLE gt_kna1
    WHERE a~vbeln IN s_vbeln.
*  select * from vbrk into CORRESPONDING FIELDS OF TABLE gt_kna1 where vbrk~vbeln in s_vbeln.

ENDFORM.                    " GET_DATA
*&---------------------------------------------------------------------*
*&      Form  SET_FCAT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM set_fcat .
  CLEAR: gs_fcat.                  "fieldcatalog merge kullandigim icin burayi kapattim
  gs_fcat-fieldname = 'VBELN'.
  gs_fcat-scrtext_s = 'Billing D'.
  gs_fcat-scrtext_m = 'Billing Doc'.
  gs_fcat-scrtext_l = 'Billing Document'.
  gs_fcat-col_opt = abap_true.
  gs_fcat-key = abap_true.
  APPEND gs_fcat TO gt_fcat.
  CLEAR: gs_fcat.
  gs_fcat-fieldname = 'FKART'.
  gs_fcat-scrtext_s = 'Billing T'.
  gs_fcat-scrtext_m = 'Billing Ty'.
  gs_fcat-scrtext_l = 'Billing Type'.
  gs_fcat-col_opt = abap_true.
  APPEND gs_fcat TO gt_fcat.
  CLEAR: gs_fcat.
  gs_fcat-fieldname = 'WAERK'.
  gs_fcat-scrtext_s = 'SD Document C'.
  gs_fcat-scrtext_m = 'SD Document Curr'.
  gs_fcat-scrtext_l = 'SD Document Currency'.
  gs_fcat-col_opt = abap_true.
  gs_fcat-hotspot = abap_true.
  APPEND gs_fcat TO gt_fcat.
  CLEAR: gs_fcat.
  gs_fcat-fieldname = 'VKORG'.
  gs_fcat-scrtext_s = 'Sales O'.
  gs_fcat-scrtext_m = 'Sales Org'.
  gs_fcat-scrtext_l = 'Sales Organization'.
  gs_fcat-col_opt = abap_true.
  APPEND gs_fcat TO gt_fcat.
  CLEAR: gs_fcat.
  gs_fcat-fieldname = 'FKDAT'.
  gs_fcat-scrtext_s = 'Billing D'.
  gs_fcat-scrtext_m = 'Billing Date'.
  gs_fcat-scrtext_l = 'Billing Date for Billing Index and and Printout'.
  gs_fcat-col_opt = abap_true.
  APPEND gs_fcat TO gt_fcat.
  CLEAR: gs_fcat.
  gs_fcat-fieldname = 'BUKRS'.
  gs_fcat-scrtext_s = 'Company C'.
  gs_fcat-scrtext_m = 'Company Co'.
  gs_fcat-scrtext_l = 'Company Code'.
  gs_fcat-col_opt = abap_true.
  APPEND gs_fcat TO gt_fcat.
  CLEAR: gs_fcat.
  gs_fcat-fieldname = 'KUNNR'.
  gs_fcat-scrtext_s = 'Customer N'.
  gs_fcat-scrtext_m = 'Customer Num'.
  gs_fcat-scrtext_l = 'Customer Number'.
  gs_fcat-col_opt = abap_true.
  APPEND gs_fcat TO gt_fcat.
  CLEAR: gs_fcat.
  gs_fcat-fieldname = 'ADRNR'.
  gs_fcat-scrtext_s = 'Address'.
  gs_fcat-scrtext_m = 'Address'.
  gs_fcat-scrtext_l = 'Address'.
  gs_fcat-col_opt = abap_true.
  APPEND gs_fcat TO gt_fcat.

*  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE' "bu fonksiyon fieldcatalogu otomatik olusturur
*   EXPORTING
**     I_BUFFER_ACTIVE              =
**     I_STRUCTURE_NAME             = 'ZESRA_S_KNA1'
**     I_CLIENT_NEVER_DISPLAY       = 'X'
**     I_BYPASSING_BUFFER           =
*     I_INTERNAL_TABNAME           = 'GT_KNA1'
*    CHANGING
*      ct_fieldcat                  = gt_fcat
*   EXCEPTIONS
*     INCONSISTENT_INTERFACE       = 1
*     PROGRAM_ERROR                = 2
*     OTHERS                       = 3
*            .
*  IF sy-subrc <> 0.
** Implement suitable error handling here
*  ENDIF.
  CLEAR: gs_fc.
  gs_fc-fieldname = 'VBELN'.
  gs_fc-scrtext_s = 'Billing D'.
  gs_fc-scrtext_m = 'Billing Doc'.
  gs_fc-scrtext_l = 'Billing Document'.
  gs_fc-col_opt = abap_true.
  APPEND gs_fc TO gt_fc.
  CLEAR: gs_fc.
  gs_fc-fieldname = 'POSNR'.
  gs_fc-scrtext_s = 'Item'.
  gs_fc-scrtext_m = 'Item'.
  gs_fc-scrtext_l = 'Item'.
  gs_fc-col_opt = abap_true.
  APPEND gs_fc TO gt_fc.
  CLEAR: gs_fc.
  gs_fc-fieldname = 'UEPOS'.
  gs_fc-scrtext_s = 'Higher-lev.Item'.
  gs_fc-scrtext_m = 'Higher-lev.Item'.
  gs_fc-scrtext_l = 'Higher-lev.Item'.
  gs_fc-col_opt = abap_true.
  APPEND gs_fc TO gt_fc.
  CLEAR: gs_fc.
  gs_fc-fieldname = 'FKIMG'.
  gs_fc-scrtext_s = 'Actual Invoiced Q'.
  gs_fc-scrtext_m = 'Actual Invoiced Quant'.
  gs_fc-scrtext_l = 'Actual Invoiced Quantity'.
  gs_fc-col_opt = abap_true.
  APPEND gs_fc TO gt_fc.
  CLEAR: gs_fc.
  gs_fc-fieldname = 'VRKME'.
  gs_fc-scrtext_s = 'Sales Unit'.
  gs_fc-scrtext_m = 'Sales Unit'.
  gs_fc-scrtext_l = 'Sales Unit'.
  gs_fc-col_opt = abap_true.
  APPEND gs_fc TO gt_fc.
  CLEAR: gs_fc.
  gs_fc-fieldname = 'UMVKZ'.
  gs_fc-scrtext_s = 'Numerator'.
  gs_fc-scrtext_m = 'Numerator'.
  gs_fc-scrtext_l = 'Numerator'.
  gs_fc-col_opt = abap_true.
  APPEND gs_fc TO gt_fc.
  CLEAR: gs_fc.
  gs_fc-fieldname = 'UMVKN'.
  gs_fc-scrtext_s = 'Denominator'.
  gs_fc-scrtext_m = 'Denominator'.
  gs_fc-scrtext_l = 'Denominator'.
  gs_fc-col_opt = abap_true.
  APPEND gs_fc TO gt_fc.
  CLEAR: gs_fc.
  gs_fc-fieldname = 'MATNR'.
  gs_fc-scrtext_s = 'Material'.
  gs_fc-scrtext_m = 'Material'.
  gs_fc-scrtext_l = 'Material'.
  gs_fc-col_opt = abap_true.
  APPEND gs_fc TO gt_fc.
  CLEAR: gs_fc.
  gs_fc-fieldname = 'ARKTX'.
  gs_fc-scrtext_s = 'Description'.
  gs_fc-scrtext_m = 'Description'.
  gs_fc-scrtext_l = 'Description'.
  gs_fc-col_opt = abap_true.
  APPEND gs_fc TO gt_fc.
  CLEAR: gs_fc.
  gs_fc-fieldname = 'MATKL'.
  gs_fc-scrtext_s = 'Material Group'.
  gs_fc-scrtext_m = 'Material Group'.
  gs_fc-scrtext_l = 'Material Group'.
  gs_fc-col_opt = abap_true.
  APPEND gs_fc TO gt_fc.

  CLEAR: gs_fieldcat.
  gs_fieldcat-fieldname = 'MATNR'.
  gs_fieldcat-scrtext_s = 'Material'.
  gs_fieldcat-scrtext_m = 'Material'.
  gs_fieldcat-scrtext_l = 'Material'.
  gs_fieldcat-col_opt = abap_true.
  APPEND gs_fieldcat TO gt_fieldcat.
  CLEAR: gs_fieldcat.
  gs_fieldcat-fieldname = 'ERSDA'.
  gs_fieldcat-scrtext_s = 'Created On'.
  gs_fieldcat-scrtext_m = 'Created On'.
  gs_fieldcat-scrtext_l = 'Created On'.
  gs_fieldcat-col_opt = abap_true.
  APPEND gs_fieldcat TO gt_fieldcat.
  CLEAR: gs_fieldcat.
  gs_fieldcat-fieldname = 'ERNAM'.
  gs_fieldcat-scrtext_s = 'Created by'.
  gs_fieldcat-scrtext_m = 'Created by'.
  gs_fieldcat-scrtext_l = 'Created by'.
  gs_fieldcat-col_opt = abap_true.
  APPEND gs_fieldcat TO gt_fieldcat.
  CLEAR: gs_fieldcat.
  gs_fieldcat-fieldname = 'MTART'.
  gs_fieldcat-scrtext_s = 'Material Ty'.
  gs_fieldcat-scrtext_m = 'Material Typ'.
  gs_fieldcat-scrtext_l = 'Material Type'.
  gs_fieldcat-col_opt = abap_true.
  APPEND gs_fieldcat TO gt_fieldcat.
  CLEAR: gs_fieldcat.
  gs_fieldcat-fieldname = 'MEINS'.
  gs_fieldcat-scrtext_s = 'Base Unit'.
  gs_fieldcat-scrtext_m = 'Base Unit'.
  gs_fieldcat-scrtext_l = 'Base Unit'.
  gs_fieldcat-col_opt = abap_true.
  APPEND gs_fieldcat TO gt_fieldcat.
  CLEAR: gs_fieldcat.
  gs_fieldcat-fieldname = 'BSTME'.
  gs_fieldcat-scrtext_s = 'Order Unit'.
  gs_fieldcat-scrtext_m = 'Order Unit'.
  gs_fieldcat-scrtext_l = 'Order Unit'.
  gs_fieldcat-col_opt = abap_true.
  APPEND gs_fieldcat TO gt_fieldcat.
  CLEAR: gs_fieldcat.
  gs_fieldcat-fieldname = 'ZEINR'.
  gs_fieldcat-scrtext_s = 'Document'.
  gs_fieldcat-scrtext_m = 'Document'.
  gs_fieldcat-scrtext_l = 'Document'.
  gs_fieldcat-col_opt = abap_true.
  APPEND gs_fieldcat TO gt_fieldcat.
  CLEAR: gs_fieldcat.
  gs_fieldcat-fieldname = 'ZEIAR'.
  gs_fieldcat-scrtext_s = 'Document type'.
  gs_fieldcat-scrtext_m = 'Document type'.
  gs_fieldcat-scrtext_l = 'Document type'.
  gs_fieldcat-col_opt = abap_true.
  APPEND gs_fieldcat TO gt_fieldcat.
  CLEAR: gs_fieldcat.
  gs_fieldcat-fieldname = 'BLATT'.
  gs_fieldcat-scrtext_s = 'Page number'.
  gs_fieldcat-scrtext_m = 'Page number'.
  gs_fieldcat-scrtext_l = 'Page number'.
  gs_fieldcat-col_opt = abap_true.
  APPEND gs_fieldcat TO gt_fieldcat.

ENDFORM.                    " SET_FCAT
*&---------------------------------------------------------------------*
*&      Form  SET_LAYOUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM set_layout .
  CLEAR: gs_layout.
  gs_layout-col_opt = abap_true. "layout butun alvyi butun columnlari etkiler
  gs_layout-zebra = abap_true.
  gs_layout-no_toolbar = abap_true.
*  gs_layout-info_fname = 'LINE_COLOR'.
ENDFORM.                    " SET_LAYOUT
