import 'package:flutter/material.dart';
import 'package:persian_calendar_widget/persian_calendar_widget.dart';

class PickDate {
  PickDate._();

  static void yearAndMonth(
    BuildContext context, {
    required Function(DateTime pickedDate, String formattedDate) onSubmit,
    DateTime? initDate,
    int? startFrom,
    int? endTo,
  }) {
    CustomDecorationPersianCalendar.pickYearAndMonth(
      context: context,
      enablePersianDigits: false,
      initialDate: initDate,
      i18n: I18n(
        buttons: I18nButtons(cancel: 'cancel', submit: 'Submit'),
        persianMonths: I18nPersianMonths(
          aban: 'Aban',
          azar: 'Azar',
          bahman: 'Bahman',
          dey: 'Dey',
          esfand: 'Esfand',
          farvardin: 'Farvardin',
          khordad: 'Khordad',
          mehr: 'Mehr',
          mordad: 'Mordad',
          ordibehesht: 'Ordibehesht',
          shahrivar: 'Sharivar',
          tir: 'Tir',
        ),
      ),
      titleBoxStyle: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(20),
      ),
      titleSelectedTextStyle: TextStyle(
        color: Theme.of(context).colorScheme.onPrimary,
      ),
      titleTextStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
      submitButtonStyle: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        shadowColor: Theme.of(context).colorScheme.onSecondary,
      ),

      onSubmit: (pickedDate, formattedDate) {
        final splitFormattedDate = formattedDate.jalali.split(' ');
        onSubmit.call(
          pickedDate.gregorian.toDateTime(),
          '${splitFormattedDate[1]} ${splitFormattedDate[2]}',
        );
      },
      calendarType: CalendarType.persian,
      minYear: startFrom,
      maxYear: endTo,
    );
  }

  static void yearMonthAndDay(
    BuildContext context, {
    required Function(DateTime pickedDate, String formattedDate) onSubmit,
    DateTime? initDate,
    int? startFrom,
    int? endTo,
  }) {
    CustomDecorationPersianCalendar.pickFullDate(
      context: context,
      enablePersianDigits: false,
      initialDate: initDate,
      i18n: I18n(
        buttons: I18nButtons(cancel: 'cancel', submit: 'Submit'),
        persianMonths: I18nPersianMonths(
          aban: 'Aban',
          azar: 'Azar',
          bahman: 'Bahman',
          dey: 'Dey',
          esfand: 'Esfand',
          farvardin: 'Farvardin',
          khordad: 'Khordad',
          mehr: 'Mehr',
          mordad: 'Mordad',
          ordibehesht: 'Ordibehesht',
          shahrivar: 'Sharivar',
          tir: 'Tir',
        ),
        weekCodes: I18nWeekCodes(
          friday: 'Fr',
          monday: 'Mo',
          saturday: 'Sa',
          sunday: 'Su',
          thursday: 'Th',
          tuesday: 'Tu',
          wednesday: 'We',
        ),
      ),
      titleBoxStyle: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(20),
      ),
      titleSelectedTextStyle: TextStyle(
        color: Theme.of(context).colorScheme.onPrimary,
      ),
      weekDaysTextStyle: TextStyle(
        color: Theme.of(context).colorScheme.secondary,
        fontSize: 14,
        fontWeight: FontWeight.w300,
      ),
      titleTextStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
      submitButtonStyle: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        shadowColor: Theme.of(context).colorScheme.onSecondary,
      ),
      onSubmit: (pickedDate, formattedDate) {
        final splitFormattedDate = formattedDate.jalali.split(' ');
        onSubmit.call(
          pickedDate.gregorian.toDateTime(),
          '${splitFormattedDate[0]}  ${splitFormattedDate[1]} ${splitFormattedDate[2]}',
        );
      },
      calendarType: CalendarType.persian,
      minYear: startFrom,
      maxYear: endTo,
    );
  }
}
