// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a fa locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'fa';

  static String m0(totalOrders, totalGuests, totalMembers) =>
      "ظرفیت کل: ${totalOrders} / مهمانان: ${totalGuests}, اعضا: ${totalMembers}";

  static String m1(ratio) => "• نسبت نمی‌تواند بیشتر از ${ratio} باشد";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "alertDialog_areYouSure": MessageLookupByLibrary.simpleMessage(
      "درباره انجام این عملیات اطمینان دارید؟",
    ),
    "alertDialog_discardChanges": MessageLookupByLibrary.simpleMessage(
      "در صورت تایید تغییرات اعمال شده ذخیره نخواهد شد!",
    ),
    "alertDialog_noticeThisAboutAction": MessageLookupByLibrary.simpleMessage(
      "توجه کنید که در صورت حذف این آیتم، تمامی اطلاعات مربوط به این آیتم هم به صورت اتوماتیک حذف خواهد شد.",
    ),
    "button_title_backToLogin": MessageLookupByLibrary.simpleMessage(
      "بازگشت به ورود",
    ),
    "button_title_backup": MessageLookupByLibrary.simpleMessage(
      "تولید پشتیبان",
    ),
    "button_title_cancel": MessageLookupByLibrary.simpleMessage("انصراف"),
    "button_title_changeLanguage": MessageLookupByLibrary.simpleMessage(
      "تغییر زبان",
    ),
    "button_title_delete": MessageLookupByLibrary.simpleMessage("حذف"),
    "button_title_edit": MessageLookupByLibrary.simpleMessage("ویرایش"),
    "button_title_events": MessageLookupByLibrary.simpleMessage("رویدادها"),
    "button_title_generate": MessageLookupByLibrary.simpleMessage("تولید"),
    "button_title_guests": MessageLookupByLibrary.simpleMessage("مهمانان"),
    "button_title_login": MessageLookupByLibrary.simpleMessage("ورود"),
    "button_title_members": MessageLookupByLibrary.simpleMessage("اعضا"),
    "button_title_menuItems": MessageLookupByLibrary.simpleMessage("موارد منو"),
    "button_title_next": MessageLookupByLibrary.simpleMessage("بعدی"),
    "button_title_offlineMode": MessageLookupByLibrary.simpleMessage(
      "حالت آفلاین",
    ),
    "button_title_onlineMode": MessageLookupByLibrary.simpleMessage(
      "حالت آنلاین",
    ),
    "button_title_preview": MessageLookupByLibrary.simpleMessage("پیش‌نمایش"),
    "button_title_previous": MessageLookupByLibrary.simpleMessage("قبلی"),
    "button_title_register": MessageLookupByLibrary.simpleMessage("ثبت‌نام"),
    "button_title_reports": MessageLookupByLibrary.simpleMessage("گزارش‌ها"),
    "button_title_restore": MessageLookupByLibrary.simpleMessage(
      "بازیابی داده",
    ),
    "button_title_salaryReport": MessageLookupByLibrary.simpleMessage(
      "گزارش حقوق",
    ),
    "button_title_settings": MessageLookupByLibrary.simpleMessage("تنظیمات"),
    "button_title_submit": MessageLookupByLibrary.simpleMessage("تایید"),
    "button_title_switchToOfflineMode": MessageLookupByLibrary.simpleMessage(
      "تغییر به حالت آفلاین",
    ),
    "button_title_teamMember": MessageLookupByLibrary.simpleMessage(
      "اعضای تیم",
    ),
    "button_title_teams": MessageLookupByLibrary.simpleMessage("تیم ها"),
    "contentTitle_active": MessageLookupByLibrary.simpleMessage("فعال: "),
    "contentTitle_balance": MessageLookupByLibrary.simpleMessage("مانده: "),
    "contentTitle_birthday": MessageLookupByLibrary.simpleMessage(
      "تاریخ تولد: ",
    ),
    "contentTitle_byWho": MessageLookupByLibrary.simpleMessage("توسط "),
    "contentTitle_date": MessageLookupByLibrary.simpleMessage("تاریخ: "),
    "contentTitle_description": MessageLookupByLibrary.simpleMessage(
      "توضیحات: ",
    ),
    "contentTitle_engagedTeam": MessageLookupByLibrary.simpleMessage(
      "تیم درگیر: ",
    ),
    "contentTitle_expense": MessageLookupByLibrary.simpleMessage("هزینه "),
    "contentTitle_income": MessageLookupByLibrary.simpleMessage("درآمد "),
    "contentTitle_instagram": MessageLookupByLibrary.simpleMessage(
      "آی‌دی اینستاگرام: ",
    ),
    "contentTitle_joinAt": MessageLookupByLibrary.simpleMessage(
      "تاریخ عضویت: ",
    ),
    "contentTitle_onDate": MessageLookupByLibrary.simpleMessage("در "),
    "contentTitle_paidExpenses": MessageLookupByLibrary.simpleMessage(
      "هزینه‌های پرداخت‌شده ",
    ),
    "contentTitle_phone": MessageLookupByLibrary.simpleMessage("تلفن: "),
    "contentTitle_salary": MessageLookupByLibrary.simpleMessage("حقوق "),
    "contentTitle_telegram": MessageLookupByLibrary.simpleMessage(
      "آی‌دی تلگرام: ",
    ),
    "contentTitle_totalExpense": MessageLookupByLibrary.simpleMessage(
      "کل هزینه: ",
    ),
    "contentTitle_totalIncome": MessageLookupByLibrary.simpleMessage(
      "کل درآمد: ",
    ),
    "contentTitle_unknown": MessageLookupByLibrary.simpleMessage("نامشخص"),
    "contentTitle_unpaid": MessageLookupByLibrary.simpleMessage("پرداخت‌نشده"),
    "dropDownButton_hint_selectGuest": MessageLookupByLibrary.simpleMessage(
      "یک مهمان انتخاب کنید",
    ),
    "dropDownButton_hint_selectItem": MessageLookupByLibrary.simpleMessage(
      "یک آیتم انتخاب کنید",
    ),
    "dropDownButton_hint_selectMember": MessageLookupByLibrary.simpleMessage(
      "یک عضو انتخاب کنید",
    ),
    "dropDownButton_hint_selectTeam": MessageLookupByLibrary.simpleMessage(
      "یک تیم انتخاب کنید",
    ),
    "dropDownButton_hint_selectType": MessageLookupByLibrary.simpleMessage(
      "یک نوع انتخاب کنید",
    ),
    "dropDownButton_label_guests": MessageLookupByLibrary.simpleMessage(
      "مهمانان",
    ),
    "dropDownButton_label_members": MessageLookupByLibrary.simpleMessage(
      "اعضا",
    ),
    "dropDownButton_label_teams": MessageLookupByLibrary.simpleMessage(
      "تیم‌ها",
    ),
    "dropDownButton_label_transactionType":
        MessageLookupByLibrary.simpleMessage("نوع تراکنش"),
    "eventDetails_addEventOrder": MessageLookupByLibrary.simpleMessage(
      "افزودن سفارش جدید",
    ),
    "eventDetails_addEventRatio": MessageLookupByLibrary.simpleMessage(
      "افزودن نسبت عضو جدید",
    ),
    "eventDetails_addEventTransaction": MessageLookupByLibrary.simpleMessage(
      "افزودن تراکنش جدید",
    ),
    "eventDetails_appBarTitle": MessageLookupByLibrary.simpleMessage(
      "جزئیات رویداد",
    ),
    "eventDetails_editEventOrder": MessageLookupByLibrary.simpleMessage(
      "ویرایش سفارش",
    ),
    "eventDetails_editEventRatio": MessageLookupByLibrary.simpleMessage(
      "ویرایش نسبت",
    ),
    "eventDetails_editEventTransaction": MessageLookupByLibrary.simpleMessage(
      "ویرایش تراکنش",
    ),
    "eventDetails_eventOrdersBanner_all": MessageLookupByLibrary.simpleMessage(
      "همه",
    ),
    "eventDetails_eventOrdersBanner_notAttended":
        MessageLookupByLibrary.simpleMessage("بدون سفارش"),
    "eventDetails_eventOrdersBanner_totalCapacity": m0,
    "eventDetails_orderBy": MessageLookupByLibrary.simpleMessage("سفارش‌دهنده"),
    "eventDetails_selectOrder": MessageLookupByLibrary.simpleMessage(
      "لطفاً انتخاب کنید...",
    ),
    "eventDetails_tabBar_guest": MessageLookupByLibrary.simpleMessage("مهمان"),
    "eventDetails_tabBar_member": MessageLookupByLibrary.simpleMessage("عضو"),
    "eventDetails_tabBar_members": MessageLookupByLibrary.simpleMessage("اعضا"),
    "eventDetails_tabBar_orders": MessageLookupByLibrary.simpleMessage(
      "سفارش‌ها",
    ),
    "eventDetails_tabBar_report": MessageLookupByLibrary.simpleMessage("گزارش"),
    "eventDetails_tabBar_transactions": MessageLookupByLibrary.simpleMessage(
      "تراکنش‌ها",
    ),
    "eventStory_appBarTitle": MessageLookupByLibrary.simpleMessage(
      "دفتر یادداشت",
    ),
    "eventStory_writeHere": MessageLookupByLibrary.simpleMessage(
      "از اینجا شروع به نوشتن کنید...",
    ),
    "event_addEvent": MessageLookupByLibrary.simpleMessage(
      "افزودن رویداد جدید",
    ),
    "event_appBarTitle": MessageLookupByLibrary.simpleMessage("رویدادها"),
    "event_editEvent": MessageLookupByLibrary.simpleMessage("ویرایش رویداد"),
    "event_emptyStateContent": MessageLookupByLibrary.simpleMessage(
      "هنوز رویدادی اضافه نشده است!",
    ),
    "guestDetails_appBarTitle": MessageLookupByLibrary.simpleMessage(
      "جزئیات مهمان",
    ),
    "guest_addGuest": MessageLookupByLibrary.simpleMessage("افزودن مهمان جدید"),
    "guest_appBarTitle": MessageLookupByLibrary.simpleMessage("مهمانان"),
    "guest_editGuest": MessageLookupByLibrary.simpleMessage("ویرایش مهمان"),
    "guest_emptyStateContent": MessageLookupByLibrary.simpleMessage(
      "هنوز مهمانی اضافه نشده است!",
    ),
    "login_appBarTitle": MessageLookupByLibrary.simpleMessage(
      "ورود به حساب کاربری...",
    ),
    "memberDetails_appBarTitle": MessageLookupByLibrary.simpleMessage(
      "جزئیات عضو",
    ),
    "member_addMember": MessageLookupByLibrary.simpleMessage("افزودن عضو جدید"),
    "member_appBarTitle": MessageLookupByLibrary.simpleMessage("اعضا"),
    "member_editMember": MessageLookupByLibrary.simpleMessage("ویرایش عضو"),
    "member_emptyStateContent": MessageLookupByLibrary.simpleMessage(
      "هنوز عضوی اضافه نشده است!",
    ),
    "menu_addItem": MessageLookupByLibrary.simpleMessage("افزودن مورد منو"),
    "menu_appBarTitle": MessageLookupByLibrary.simpleMessage("موارد منو"),
    "menu_editItem": MessageLookupByLibrary.simpleMessage("ویرایش مورد"),
    "menu_emptyStateContent": MessageLookupByLibrary.simpleMessage(
      "هنوز موردی اضافه نشده است!",
    ),
    "modalBottom_title_changeLanguage": MessageLookupByLibrary.simpleMessage(
      "تغییر زبان",
    ),
    "monthTitle_aban": MessageLookupByLibrary.simpleMessage("آبان"),
    "monthTitle_azar": MessageLookupByLibrary.simpleMessage("آذر"),
    "monthTitle_bahman": MessageLookupByLibrary.simpleMessage("بهمن"),
    "monthTitle_dey": MessageLookupByLibrary.simpleMessage("دی"),
    "monthTitle_esfand": MessageLookupByLibrary.simpleMessage("اسفند"),
    "monthTitle_farvardin": MessageLookupByLibrary.simpleMessage("فروردین"),
    "monthTitle_khordad": MessageLookupByLibrary.simpleMessage("خرداد"),
    "monthTitle_mehr": MessageLookupByLibrary.simpleMessage("مهر"),
    "monthTitle_mordad": MessageLookupByLibrary.simpleMessage("مرداد"),
    "monthTitle_ordibehesht": MessageLookupByLibrary.simpleMessage("اردیبهشت"),
    "monthTitle_shahrivar": MessageLookupByLibrary.simpleMessage("شهریور"),
    "monthTitle_tir": MessageLookupByLibrary.simpleMessage("تیر"),
    "order_emptyStateContent": MessageLookupByLibrary.simpleMessage(
      "هنوز سفارشی اضافه نشده است!",
    ),
    "ratio_emptyStateContent": MessageLookupByLibrary.simpleMessage(
      "هنوز نسبتی اضافه نشده است!",
    ),
    "register_appBarTitle": MessageLookupByLibrary.simpleMessage(
      "ثبت یک حساب جدید...",
    ),
    "reportDetails_appBarTitle": MessageLookupByLibrary.simpleMessage(
      "جزئیات گزارش",
    ),
    "reportDetails_reportGeneratedFor": MessageLookupByLibrary.simpleMessage(
      "این گزارش برای تولید شده است",
    ),
    "reportDetails_selectedEvents": MessageLookupByLibrary.simpleMessage(
      "رویدادهای انتخاب‌شده",
    ),
    "report_addReport": MessageLookupByLibrary.simpleMessage(
      "ایجاد گزارش جدید",
    ),
    "report_appBarTitle": MessageLookupByLibrary.simpleMessage("گزارش‌ها"),
    "report_emptyStateContent": MessageLookupByLibrary.simpleMessage(
      "هنوز گزارشی اضافه نشده است!",
    ),
    "report_selectingEvents_noEvent": MessageLookupByLibrary.simpleMessage(
      "هیچ رویدادی یافت نشد",
    ),
    "settings_appBarTitle": MessageLookupByLibrary.simpleMessage("تنظیمات"),
    "teamDetails_addMembers": MessageLookupByLibrary.simpleMessage(
      "افزودن عضو جدید",
    ),
    "teamDetails_editMembers": MessageLookupByLibrary.simpleMessage(
      "ویرایش عضو",
    ),
    "teamDetails_emptyStateContent": MessageLookupByLibrary.simpleMessage(
      "هنوز عضوی اضافه نشده است!",
    ),
    "teamDetials_appBarTitle": MessageLookupByLibrary.simpleMessage(
      "اعضای تیم",
    ),
    "team_addTeam": MessageLookupByLibrary.simpleMessage("افزودن تیم جدید"),
    "team_appBarTitle": MessageLookupByLibrary.simpleMessage("تیم‌ها"),
    "team_editTeam": MessageLookupByLibrary.simpleMessage("ویرایش تیم"),
    "team_emptyStateContent": MessageLookupByLibrary.simpleMessage(
      "هنوز تیمی اضافه نشده است!",
    ),
    "textField_hint_castAwayMovie": MessageLookupByLibrary.simpleMessage(
      "فیلم Cast Away",
    ),
    "textField_hint_chocolateCake": MessageLookupByLibrary.simpleMessage(
      "کیک شکلاتی",
    ),
    "textField_hint_id": MessageLookupByLibrary.simpleMessage("@mahdiyar"),
    "textField_hint_mahdiyar": MessageLookupByLibrary.simpleMessage("مهدیار"),
    "textField_hint_movieAnalyze": MessageLookupByLibrary.simpleMessage(
      "تحلیل فیلم",
    ),
    "textField_hint_phone": MessageLookupByLibrary.simpleMessage("09391543702"),
    "textField_hint_thisMonthSalary": MessageLookupByLibrary.simpleMessage(
      "حقوق این ماه",
    ),
    "textField_label_amount": MessageLookupByLibrary.simpleMessage("مبلغ"),
    "textField_label_birthday": MessageLookupByLibrary.simpleMessage(
      "تاریخ تولد",
    ),
    "textField_label_date": MessageLookupByLibrary.simpleMessage("تاریخ"),
    "textField_label_description": MessageLookupByLibrary.simpleMessage(
      "توضیحات",
    ),
    "textField_label_email": MessageLookupByLibrary.simpleMessage("ایمیل"),
    "textField_label_generateFor": MessageLookupByLibrary.simpleMessage(
      "تولید برای",
    ),
    "textField_label_instagramId": MessageLookupByLibrary.simpleMessage(
      "آی‌دی اینستاگرام",
    ),
    "textField_label_joinAt": MessageLookupByLibrary.simpleMessage(
      "تاریخ عضویت",
    ),
    "textField_label_name": MessageLookupByLibrary.simpleMessage("نام"),
    "textField_label_optional": MessageLookupByLibrary.simpleMessage(
      "(اختیاری)",
    ),
    "textField_label_password": MessageLookupByLibrary.simpleMessage(
      "رمز عبور",
    ),
    "textField_label_phone": MessageLookupByLibrary.simpleMessage("تلفن"),
    "textField_label_ratio": MessageLookupByLibrary.simpleMessage("نسبت"),
    "textField_label_repeatPassword": MessageLookupByLibrary.simpleMessage(
      "تکرار رمز عبور",
    ),
    "textField_label_team": MessageLookupByLibrary.simpleMessage("تیم"),
    "textField_label_telegramId": MessageLookupByLibrary.simpleMessage(
      "آی‌دی تلگرام",
    ),
    "textField_label_title": MessageLookupByLibrary.simpleMessage("عنوان"),
    "transaction_emptyStateContent": MessageLookupByLibrary.simpleMessage(
      "هنوز تراکنشی اضافه نشده است!",
    ),
    "validator_noMemberToAddTeam": MessageLookupByLibrary.simpleMessage(
      "• هیچ عضوی برای اضافه کردن وجود ندارد",
    ),
    "validator_passwordNotMatch": MessageLookupByLibrary.simpleMessage(
      "• رمز عبور مطابقت ندارد",
    ),
    "validator_ratioCanNotMoreThan": m1,
    "validator_required": MessageLookupByLibrary.simpleMessage("• الزامی"),
    "validator_thereIsNoRatio": MessageLookupByLibrary.simpleMessage(
      "• هیچ نسبتی برای اضافه کردن وجود ندارد",
    ),
    "warning_calculatingSalaryGoesWrong": MessageLookupByLibrary.simpleMessage(
      "خطا در محاسبه حقوق اعضا!",
    ),
    "warning_operationFailure": MessageLookupByLibrary.simpleMessage(
      "عملیات ناموفق بود:",
    ),
    "warning_operationSuccessful": MessageLookupByLibrary.simpleMessage(
      "عملیات با موفقیت انجام شد!",
    ),
    "warning_selectEvent": MessageLookupByLibrary.simpleMessage(
      "لطفاً یک رویداد انتخاب کنید!",
    ),
    "warning_somethingWentWrong": MessageLookupByLibrary.simpleMessage(
      "مشکلی پیش آمد، بعداً دوباره تلاش کنید...",
    ),
  };
}
