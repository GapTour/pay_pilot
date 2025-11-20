import 'package:persian_calendar_widget/persian_calendar_widget.dart';

extension FormatDateToPersianCalendar on DateTime {
  String get formattedToJalali_yearMonth =>
      '${toJalali().formatter.mNFn} ${toJalali().formatter.yyyy}';
  String get formattedToJalali_yearMonthDay =>
      '${toJalali().formatter.dd} ${toJalali().formatter.mNFn} ${toJalali().formatter.yyyy}';
  String get formattedToJalali_yearMonthDayWeekDay =>
      '${toJalali().formatter.wNFn} - ${toJalali().formatter.dd} ${toJalali().formatter.mNFn} ${toJalali().formatter.yyyy}';
}
