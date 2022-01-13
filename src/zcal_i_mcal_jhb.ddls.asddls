@EndUserText.label: 'Public Holiday'
@AccessControl.authorizationCheck: #CHECK
@ObjectModel.semanticKey: ['Holiday']
define view entity zcal_i_mcal_JHB
  as select from zcal_holiday_jhb
  composition [0..*] of zcal_i_mcal_txt_JHB as _HolidayTxt
  association to parent ZCAL_I_MCAL_ALL_JHB as _HolidayAll on $projection.HolidayAllID = _HolidayAll.HolidayAllID
{
  key holiday_id       as Holiday,
      1                as HolidayAllID,
      month_of_holiday as HolidayMonth,
      day_of_holiday   as HolidayDay,
      _HolidayTxt,
      _HolidayAll
}
