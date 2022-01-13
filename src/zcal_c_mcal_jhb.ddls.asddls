@EndUserText.label: 'Projection Holiday'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
define view entity ZCAL_C_MCAL_JHB
  as projection on zcal_i_mcal_JHB
{
  key Holiday,
      @Consumption.hidden: true
      HolidayAllID,
      HolidayMonth,
      HolidayDay,
      _HolidayTxt.HolidayDescription as HolidayDescription : localized,
      _HolidayTxt : redirected to composition child ZCAL_C_MCAL_TXT_JHB,
      _HolidayAll : redirected to parent ZCAL_C_MCAL_ALL_JHB
}
