*&---------------------------------------------------------------------*
*& Report  ZESRA_P0016
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT zesra_p0016.

INCLUDE zesra_p0016_top.
INCLUDE zesra_p0016_cls.
INCLUDE zesra_p0016_pbo.
INCLUDE zesra_p0016_pai.
INCLUDE zesra_p0016_frm.

START-OF-SELECTION.

  PERFORM get_data.
  PERFORM set_fcat.
  PERFORM set_layout.

  CALL SCREEN 0100.
