@EndUserText.label: 'Holiday text'
@AccessControl.authorizationCheck: #CHECK
@ObjectModel.dataCategory: #TEXT
define view entity zcal_i_mcal_txt_JHB
  as select from zcal_holitxt_jhb
  association        to parent zcal_i_mcal_JHB as _Public_Holiday on $projection.Holiday = _Public_Holiday.Holiday
  association [0..*] to I_LanguageText         as _LanguageText   on $projection.Language = _LanguageText.LanguageCode
  association [1]    to ZCAL_I_MCAL_ALL_JHB    as _HolidayAll     on $projection.HolidayAllID = _HolidayAll.HolidayAllID
{
      @Semantics.language: true
  key spras            as Language,
  key holiday_id       as Holiday,
      1                as HolidayAllID,
      @Semantics.text: true
      fcal_description as HolidayDescription,
      _Public_Holiday,
      _LanguageText,
      _HolidayAll
}
