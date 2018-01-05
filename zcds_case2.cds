@AbapCatalog.sqlViewName: 'Ztest_cds_view'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'ZTEST_SUMIT'
define view Ztest_CDS_2
  with parameters
    i_partner :bu_partner
  as select from but020 as b20
  association        to adr6 as a6       on  b20.addrnumber = a6.addrnumber
                                         and a6.flgdefault  = 'X'
  association [1..1] to adrc as _address on  $projection.addrnumber = _address.addrnumber
{
      // Business partner
  key b20.partner                                 as partner,
      // Address #
  key b20.addrnumber                              as addrnumber,
      a6[1: left outer].smtp_addr                 as email, // Email ID
      // Exposed association is used to future reusability
      // Association is on demand join,
      // so if no field of ADRC is selected, join will never execute!
      _address

}
where
        b20.partner         =  :i_partner
  and(
        // Address should be valid on current date
        b20.addr_valid_from <= tstmp_current_utctimestamp()
    and b20.addr_valid_to   >= tstmp_current_utctimestamp()
  )
