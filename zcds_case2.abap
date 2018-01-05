*&---------------------------------------------------------------------*
*& Report ZCDS_case2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcds_case2.

DATA : i_bp TYPE bu_partner VALUE '1234567890'.

SELECT FROM ztest_cds_2( i_partner = @i_bp )
    FIELDS
    " Path expression used to get Telephone #
    \_address-tel_number   AS telephone,   " Telephone
    email                  AS email        " Email
    INTO TABLE @DATA(lt_address).

IF sy-subrc IS INITIAL.
  cl_demo_output=>display( lt_address ).
ENDIF.
