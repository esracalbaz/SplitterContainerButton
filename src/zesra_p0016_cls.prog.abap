*&---------------------------------------------------------------------*
*&  Include           ZESRA_P0016_CLS
*&---------------------------------------------------------------------*

CLASS cl_event_receiver DEFINITION.
  PUBLIC SECTION.

    METHODS handle_top_of_page                   "TOP_OF_PAGE------alv uzerine baslik alani actigim yapi
          FOR EVENT top_of_page OF cl_gui_alv_grid
      IMPORTING
          e_dyndoc_id
          table_index.

    METHODS handle_hotspot_click                  "HOTSPOT_CLICK---bir hucrenin tiklanabilir ozelligi
          FOR EVENT hotspot_click OF cl_gui_alv_grid
      IMPORTING
          e_row_id
          e_column_id.

    METHODS handle_double_click                   "DOUBLE_CLICK----bir satirin cift tiklanabilir ozelligi
          FOR EVENT double_click OF cl_gui_alv_grid
      IMPORTING
          e_row
          e_column
          es_row_no.

    METHODS handle_double_click2                   "DOUBLE_CLICK----bir satirin cift tiklanabilir ozelligi
          FOR EVENT double_click OF cl_gui_alv_grid
      IMPORTING
          e_row
          e_column
          es_row_no.

    METHODS handle_data_changed                   "DATA_CHANGED----yapilan degisiklikleri iceride loglayabildigim ve baska butona basildiginda bu degisiklikler uzerinden islem yapabildigim yer
          FOR EVENT data_changed OF cl_gui_alv_grid
      IMPORTING
          er_data_changed
          e_onf4
          e_onf4_before
          e_onf4_after
          e_ucomm.

    METHODS handle_onf4                            "ONF4-----------search help
          FOR EVENT onf4 OF cl_gui_alv_grid
      IMPORTING
          e_fieldname
          e_fieldvalue
          es_row_no
          er_event_data
          et_bad_cells
          e_display.

    METHODS handle_button_click                     "BUTTON_CLICK
          FOR EVENT button_click OF cl_gui_alv_grid
      IMPORTING
          es_col_id
          es_row_no.

    METHODS handle_toolbar                          "TOOLBAR
          FOR EVENT toolbar OF cl_gui_alv_grid
      IMPORTING
          e_object
          e_interactive.

    METHODS handle_user_command                     "USER_COMMAND
          FOR EVENT user_command OF cl_gui_alv_grid
      IMPORTING
          e_ucomm.
ENDCLASS.

CLASS cl_event_receiver IMPLEMENTATION.

  METHOD handle_top_of_page.
    BREAK-POINT.
  ENDMETHOD.                                  "handle_top_of_page

  METHOD handle_hotspot_click.
    DATA: lv_mess TYPE char200.

    READ TABLE gt_kna1 INTO gs_kna1 INDEX e_row_id-index.
    IF sy-subrc EQ 0.
      CASE e_column_id.
        WHEN 'WAERK'.
          CONCATENATE 'The clicked column'
                      e_column_id-fieldname
                      's value is'
                      gs_kna1-waerk
                      INTO lv_mess
                      SEPARATED BY space.
          MESSAGE lv_mess TYPE 'I'.
      ENDCASE.
    ENDIF.
  ENDMETHOD.                                  "handle_hotspot_click

  METHOD handle_double_click.
*    DATA: lt_vbrp TYPE TABLE OF vbrp,
*          ls_vbrp TYPE          vbrp.
    READ TABLE gt_kna1 INTO gs_kna1 INDEX e_row-index.
    IF sy-subrc EQ 0.
      SELECT * FROM vbrp INTO CORRESPONDING FIELDS OF TABLE gt_vbrp WHERE vbeln EQ gs_kna1-vbeln.
    ENDIF.
    CALL METHOD go_grid2->refresh_table_display.
  ENDMETHOD.                                  "handle_double_click

  METHOD handle_double_click2.
    READ TABLE gt_vbrp INTO gs_vbrp INDEX e_row-index.
    IF  sy-subrc EQ 0.
      SELECT * FROM mara INTO CORRESPONDING FIELDS OF TABLE gt_mara WHERE matnr EQ gs_vbrp-matnr.
    ENDIF.
    CALL METHOD go_grid3->refresh_table_display.
  ENDMETHOD.                                  "handle_double_click

  METHOD handle_data_changed.
    BREAK-POINT.
  ENDMETHOD.                                  "handle_data_changed

  METHOD handle_onf4.
    BREAK-POINT.
  ENDMETHOD.                                  "handle_onf4

  METHOD handle_button_click.
    BREAK-POINT.
  ENDMETHOD.                                  "handle_user_command

  METHOD handle_toolbar.
    DATA : is_btn TYPE stb_button.
    is_btn-function = 'MDT'.
    is_btn-icon = icon_detail.
    is_btn-text = 'Material Details'.
    is_btn-quickinfo = 'Material Details'.
    is_btn-disabled = ' '.
    APPEND is_btn TO e_object->mt_toolbar.
  ENDMETHOD.                                  "handle_toolbar

  METHOD handle_user_command.
    DATA: lt_rows1 TYPE lvc_t_row,
          ls_rows1 TYPE lvc_s_row.
    CASE e_ucomm.
      WHEN 'MDT'.
        go_grid2->get_selected_rows(
          IMPORTING
            et_index_rows = lt_rows1[]    " Indexes of Selected Rows
*            et_row_no     =              " Numeric IDs of Selected Rows
        ).
        LOOP AT lt_rows1 INTO ls_rows1.
          READ TABLE gt_vbrp INTO gs_vbrp INDEX  ls_rows1-index.
        ENDLOOP.
*        READ TABLE lt_rows1 INTO ls_rows1 INDEX 1.

        IF  sy-subrc EQ 0.
          SELECT * FROM mara INTO CORRESPONDING FIELDS OF TABLE gt_mara WHERE matnr EQ gs_vbrp-matnr.
        ENDIF.
        CALL METHOD go_grid3->refresh_table_display.
    ENDCASE.
  ENDMETHOD.                                  "handle_user_command

ENDCLASS.

*classi actiktan sonra classi sonradan kullanabilmek icin o class objesini referans alan bir data tanimlamasi yapilir topta.
