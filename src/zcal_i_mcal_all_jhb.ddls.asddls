@EndUserText.label: 'Singleton'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity ZCAL_I_MCAL_ALL_JHB
  as select from    I_Language
    left outer join zcal_holiday_JHB on 0 = 0
  composition [0..*] of zcal_i_mcal_JHB as _Holiday
{
  key 1                                          as HolidayAllID,
      @Semantics.systemDateTime.lastChangedAt: true
      max( zcal_holiday_JHB.last_changed_at )       as LastChangedAtMax,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      max( zcal_holiday_JHB.local_last_changed_at ) as LocalLastChangedAtMax,
      cast( '' as sxco_transport)                as Request,
      cast( 'X' as abap_boolean)                 as HideTransport,
      _Holiday
}
where
  I_Language.Language = $session.system_language
