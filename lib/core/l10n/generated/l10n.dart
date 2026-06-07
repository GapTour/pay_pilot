// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `مشکلی پیش آمد، بعداً دوباره تلاش کنید...`
  String get warning_somethingWentWrong {
    return Intl.message(
      'مشکلی پیش آمد، بعداً دوباره تلاش کنید...',
      name: 'warning_somethingWentWrong',
      desc: '',
      args: [],
    );
  }

  /// `عملیات با موفقیت انجام شد!`
  String get warning_operationSuccessful {
    return Intl.message(
      'عملیات با موفقیت انجام شد!',
      name: 'warning_operationSuccessful',
      desc: '',
      args: [],
    );
  }

  /// `عملیات ناموفق بود:`
  String get warning_operationFailure {
    return Intl.message(
      'عملیات ناموفق بود:',
      name: 'warning_operationFailure',
      desc: '',
      args: [],
    );
  }

  /// `لطفاً یک رویداد انتخاب کنید!`
  String get warning_selectEvent {
    return Intl.message(
      'لطفاً یک رویداد انتخاب کنید!',
      name: 'warning_selectEvent',
      desc: '',
      args: [],
    );
  }

  /// `خطا در محاسبه حقوق اعضا!`
  String get warning_calculatingSalaryGoesWrong {
    return Intl.message(
      'خطا در محاسبه حقوق اعضا!',
      name: 'warning_calculatingSalaryGoesWrong',
      desc: '',
      args: [],
    );
  }

  /// `توضیحات: `
  String get contentTitle_description {
    return Intl.message(
      'توضیحات: ',
      name: 'contentTitle_description',
      desc: '',
      args: [],
    );
  }

  /// `درآمد `
  String get contentTitle_income {
    return Intl.message(
      'درآمد ',
      name: 'contentTitle_income',
      desc: '',
      args: [],
    );
  }

  /// `هزینه `
  String get contentTitle_expense {
    return Intl.message(
      'هزینه ',
      name: 'contentTitle_expense',
      desc: '',
      args: [],
    );
  }

  /// `کل درآمد: `
  String get contentTitle_totalIncome {
    return Intl.message(
      'کل درآمد: ',
      name: 'contentTitle_totalIncome',
      desc: '',
      args: [],
    );
  }

  /// `کل هزینه: `
  String get contentTitle_totalExpense {
    return Intl.message(
      'کل هزینه: ',
      name: 'contentTitle_totalExpense',
      desc: '',
      args: [],
    );
  }

  /// `مانده: `
  String get contentTitle_balance {
    return Intl.message(
      'مانده: ',
      name: 'contentTitle_balance',
      desc: '',
      args: [],
    );
  }

  /// `فعال: `
  String get contentTitle_active {
    return Intl.message(
      'فعال: ',
      name: 'contentTitle_active',
      desc: '',
      args: [],
    );
  }

  /// `تاریخ عضویت: `
  String get contentTitle_joinAt {
    return Intl.message(
      'تاریخ عضویت: ',
      name: 'contentTitle_joinAt',
      desc: '',
      args: [],
    );
  }

  /// `تاریخ: `
  String get contentTitle_date {
    return Intl.message(
      'تاریخ: ',
      name: 'contentTitle_date',
      desc: '',
      args: [],
    );
  }

  /// `تاریخ تولد: `
  String get contentTitle_birthday {
    return Intl.message(
      'تاریخ تولد: ',
      name: 'contentTitle_birthday',
      desc: '',
      args: [],
    );
  }

  /// `تلفن: `
  String get contentTitle_phone {
    return Intl.message(
      'تلفن: ',
      name: 'contentTitle_phone',
      desc: '',
      args: [],
    );
  }

  /// `آی‌دی تلگرام: `
  String get contentTitle_telegram {
    return Intl.message(
      'آی‌دی تلگرام: ',
      name: 'contentTitle_telegram',
      desc: '',
      args: [],
    );
  }

  /// `آی‌دی اینستاگرام: `
  String get contentTitle_instagram {
    return Intl.message(
      'آی‌دی اینستاگرام: ',
      name: 'contentTitle_instagram',
      desc: '',
      args: [],
    );
  }

  /// `در `
  String get contentTitle_onDate {
    return Intl.message('در ', name: 'contentTitle_onDate', desc: '', args: []);
  }

  /// `تیم درگیر: `
  String get contentTitle_engagedTeam {
    return Intl.message(
      'تیم درگیر: ',
      name: 'contentTitle_engagedTeam',
      desc: '',
      args: [],
    );
  }

  /// `حقوق `
  String get contentTitle_salary {
    return Intl.message(
      'حقوق ',
      name: 'contentTitle_salary',
      desc: '',
      args: [],
    );
  }

  /// `نامشخص`
  String get contentTitle_unknown {
    return Intl.message(
      'نامشخص',
      name: 'contentTitle_unknown',
      desc: '',
      args: [],
    );
  }

  /// `پرداخت‌نشده`
  String get contentTitle_unpaid {
    return Intl.message(
      'پرداخت‌نشده',
      name: 'contentTitle_unpaid',
      desc: '',
      args: [],
    );
  }

  /// `توسط `
  String get contentTitle_byWho {
    return Intl.message(
      'توسط ',
      name: 'contentTitle_byWho',
      desc: '',
      args: [],
    );
  }

  /// `هزینه‌های پرداخت‌شده `
  String get contentTitle_paidExpenses {
    return Intl.message(
      'هزینه‌های پرداخت‌شده ',
      name: 'contentTitle_paidExpenses',
      desc: '',
      args: [],
    );
  }

  /// `فروردین`
  String get monthTitle_farvardin {
    return Intl.message(
      'فروردین',
      name: 'monthTitle_farvardin',
      desc: '',
      args: [],
    );
  }

  /// `اردیبهشت`
  String get monthTitle_ordibehesht {
    return Intl.message(
      'اردیبهشت',
      name: 'monthTitle_ordibehesht',
      desc: '',
      args: [],
    );
  }

  /// `خرداد`
  String get monthTitle_khordad {
    return Intl.message(
      'خرداد',
      name: 'monthTitle_khordad',
      desc: '',
      args: [],
    );
  }

  /// `تیر`
  String get monthTitle_tir {
    return Intl.message('تیر', name: 'monthTitle_tir', desc: '', args: []);
  }

  /// `مرداد`
  String get monthTitle_mordad {
    return Intl.message('مرداد', name: 'monthTitle_mordad', desc: '', args: []);
  }

  /// `شهریور`
  String get monthTitle_shahrivar {
    return Intl.message(
      'شهریور',
      name: 'monthTitle_shahrivar',
      desc: '',
      args: [],
    );
  }

  /// `مهر`
  String get monthTitle_mehr {
    return Intl.message('مهر', name: 'monthTitle_mehr', desc: '', args: []);
  }

  /// `آبان`
  String get monthTitle_aban {
    return Intl.message('آبان', name: 'monthTitle_aban', desc: '', args: []);
  }

  /// `آذر`
  String get monthTitle_azar {
    return Intl.message('آذر', name: 'monthTitle_azar', desc: '', args: []);
  }

  /// `دی`
  String get monthTitle_dey {
    return Intl.message('دی', name: 'monthTitle_dey', desc: '', args: []);
  }

  /// `بهمن`
  String get monthTitle_bahman {
    return Intl.message('بهمن', name: 'monthTitle_bahman', desc: '', args: []);
  }

  /// `اسفند`
  String get monthTitle_esfand {
    return Intl.message('اسفند', name: 'monthTitle_esfand', desc: '', args: []);
  }

  /// `عنوان`
  String get textField_label_title {
    return Intl.message(
      'عنوان',
      name: 'textField_label_title',
      desc: '',
      args: [],
    );
  }

  /// `نام`
  String get textField_label_name {
    return Intl.message(
      'نام',
      name: 'textField_label_name',
      desc: '',
      args: [],
    );
  }

  /// `تاریخ عضویت`
  String get textField_label_joinAt {
    return Intl.message(
      'تاریخ عضویت',
      name: 'textField_label_joinAt',
      desc: '',
      args: [],
    );
  }

  /// `ایمیل`
  String get textField_label_email {
    return Intl.message(
      'ایمیل',
      name: 'textField_label_email',
      desc: '',
      args: [],
    );
  }

  /// `تاریخ تولد`
  String get textField_label_birthday {
    return Intl.message(
      'تاریخ تولد',
      name: 'textField_label_birthday',
      desc: '',
      args: [],
    );
  }

  /// `توضیحات`
  String get textField_label_description {
    return Intl.message(
      'توضیحات',
      name: 'textField_label_description',
      desc: '',
      args: [],
    );
  }

  /// `(اختیاری)`
  String get textField_label_optional {
    return Intl.message(
      '(اختیاری)',
      name: 'textField_label_optional',
      desc: '',
      args: [],
    );
  }

  /// `تیم`
  String get textField_label_team {
    return Intl.message(
      'تیم',
      name: 'textField_label_team',
      desc: '',
      args: [],
    );
  }

  /// `مبلغ`
  String get textField_label_amount {
    return Intl.message(
      'مبلغ',
      name: 'textField_label_amount',
      desc: '',
      args: [],
    );
  }

  /// `رمز عبور`
  String get textField_label_password {
    return Intl.message(
      'رمز عبور',
      name: 'textField_label_password',
      desc: '',
      args: [],
    );
  }

  /// `تکرار رمز عبور`
  String get textField_label_repeatPassword {
    return Intl.message(
      'تکرار رمز عبور',
      name: 'textField_label_repeatPassword',
      desc: '',
      args: [],
    );
  }

  /// `نسبت`
  String get textField_label_ratio {
    return Intl.message(
      'نسبت',
      name: 'textField_label_ratio',
      desc: '',
      args: [],
    );
  }

  /// `تلفن`
  String get textField_label_phone {
    return Intl.message(
      'تلفن',
      name: 'textField_label_phone',
      desc: '',
      args: [],
    );
  }

  /// `آی‌دی تلگرام`
  String get textField_label_telegramId {
    return Intl.message(
      'آی‌دی تلگرام',
      name: 'textField_label_telegramId',
      desc: '',
      args: [],
    );
  }

  /// `آی‌دی اینستاگرام`
  String get textField_label_instagramId {
    return Intl.message(
      'آی‌دی اینستاگرام',
      name: 'textField_label_instagramId',
      desc: '',
      args: [],
    );
  }

  /// `تاریخ`
  String get textField_label_date {
    return Intl.message(
      'تاریخ',
      name: 'textField_label_date',
      desc: '',
      args: [],
    );
  }

  /// `تولید برای`
  String get textField_label_generateFor {
    return Intl.message(
      'تولید برای',
      name: 'textField_label_generateFor',
      desc: '',
      args: [],
    );
  }

  /// `تحلیل فیلم`
  String get textField_hint_movieAnalyze {
    return Intl.message(
      'تحلیل فیلم',
      name: 'textField_hint_movieAnalyze',
      desc: '',
      args: [],
    );
  }

  /// `کیک شکلاتی`
  String get textField_hint_chocolateCake {
    return Intl.message(
      'کیک شکلاتی',
      name: 'textField_hint_chocolateCake',
      desc: '',
      args: [],
    );
  }

  /// `مهدیار`
  String get textField_hint_mahdiyar {
    return Intl.message(
      'مهدیار',
      name: 'textField_hint_mahdiyar',
      desc: '',
      args: [],
    );
  }

  /// `فیلم Cast Away`
  String get textField_hint_castAwayMovie {
    return Intl.message(
      'فیلم Cast Away',
      name: 'textField_hint_castAwayMovie',
      desc: '',
      args: [],
    );
  }

  /// `@mahdiyar`
  String get textField_hint_id {
    return Intl.message(
      '@mahdiyar',
      name: 'textField_hint_id',
      desc: '',
      args: [],
    );
  }

  /// `09391543702`
  String get textField_hint_phone {
    return Intl.message(
      '09391543702',
      name: 'textField_hint_phone',
      desc: '',
      args: [],
    );
  }

  /// `حقوق این ماه`
  String get textField_hint_thisMonthSalary {
    return Intl.message(
      'حقوق این ماه',
      name: 'textField_hint_thisMonthSalary',
      desc: '',
      args: [],
    );
  }

  /// `• الزامی`
  String get validator_required {
    return Intl.message(
      '• الزامی',
      name: 'validator_required',
      desc: '',
      args: [],
    );
  }

  /// `• رمز عبور مطابقت ندارد`
  String get validator_passwordNotMatch {
    return Intl.message(
      '• رمز عبور مطابقت ندارد',
      name: 'validator_passwordNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `• هیچ عضوی برای اضافه کردن وجود ندارد`
  String get validator_noMemberToAddTeam {
    return Intl.message(
      '• هیچ عضوی برای اضافه کردن وجود ندارد',
      name: 'validator_noMemberToAddTeam',
      desc: '',
      args: [],
    );
  }

  /// `• هیچ نسبتی برای اضافه کردن وجود ندارد`
  String get validator_thereIsNoRatio {
    return Intl.message(
      '• هیچ نسبتی برای اضافه کردن وجود ندارد',
      name: 'validator_thereIsNoRatio',
      desc: '',
      args: [],
    );
  }

  /// `• نسبت نمی‌تواند بیشتر از {ratio} باشد`
  String validator_ratioCanNotMoreThan(int ratio) {
    return Intl.message(
      '• نسبت نمی‌تواند بیشتر از $ratio باشد',
      name: 'validator_ratioCanNotMoreThan',
      desc: 'add reminded ratio',
      args: [ratio],
    );
  }

  /// `اعضا`
  String get dropDownButton_label_members {
    return Intl.message(
      'اعضا',
      name: 'dropDownButton_label_members',
      desc: '',
      args: [],
    );
  }

  /// `مهمانان`
  String get dropDownButton_label_guests {
    return Intl.message(
      'مهمانان',
      name: 'dropDownButton_label_guests',
      desc: '',
      args: [],
    );
  }

  /// `تیم‌ها`
  String get dropDownButton_label_teams {
    return Intl.message(
      'تیم‌ها',
      name: 'dropDownButton_label_teams',
      desc: '',
      args: [],
    );
  }

  /// `نوع تراکنش`
  String get dropDownButton_label_transactionType {
    return Intl.message(
      'نوع تراکنش',
      name: 'dropDownButton_label_transactionType',
      desc: '',
      args: [],
    );
  }

  /// `یک نوع انتخاب کنید`
  String get dropDownButton_hint_selectType {
    return Intl.message(
      'یک نوع انتخاب کنید',
      name: 'dropDownButton_hint_selectType',
      desc: '',
      args: [],
    );
  }

  /// `یک مهمان انتخاب کنید`
  String get dropDownButton_hint_selectGuest {
    return Intl.message(
      'یک مهمان انتخاب کنید',
      name: 'dropDownButton_hint_selectGuest',
      desc: '',
      args: [],
    );
  }

  /// `یک عضو انتخاب کنید`
  String get dropDownButton_hint_selectMember {
    return Intl.message(
      'یک عضو انتخاب کنید',
      name: 'dropDownButton_hint_selectMember',
      desc: '',
      args: [],
    );
  }

  /// `یک آیتم انتخاب کنید`
  String get dropDownButton_hint_selectItem {
    return Intl.message(
      'یک آیتم انتخاب کنید',
      name: 'dropDownButton_hint_selectItem',
      desc: '',
      args: [],
    );
  }

  /// `یک تیم انتخاب کنید`
  String get dropDownButton_hint_selectTeam {
    return Intl.message(
      'یک تیم انتخاب کنید',
      name: 'dropDownButton_hint_selectTeam',
      desc: '',
      args: [],
    );
  }

  /// `اعضای تیم`
  String get button_title_teamMember {
    return Intl.message(
      'اعضای تیم',
      name: 'button_title_teamMember',
      desc: '',
      args: [],
    );
  }

  /// `تولید پشتیبان`
  String get button_title_backup {
    return Intl.message(
      'تولید پشتیبان',
      name: 'button_title_backup',
      desc: '',
      args: [],
    );
  }

  /// `بازیابی داده`
  String get button_title_restore {
    return Intl.message(
      'بازیابی داده',
      name: 'button_title_restore',
      desc: '',
      args: [],
    );
  }

  /// `تغییر زبان`
  String get button_title_changeLanguage {
    return Intl.message(
      'تغییر زبان',
      name: 'button_title_changeLanguage',
      desc: '',
      args: [],
    );
  }

  /// `انصراف`
  String get button_title_cancel {
    return Intl.message(
      'انصراف',
      name: 'button_title_cancel',
      desc: '',
      args: [],
    );
  }

  /// `ورود`
  String get button_title_login {
    return Intl.message('ورود', name: 'button_title_login', desc: '', args: []);
  }

  /// `تغییر به حالت آفلاین`
  String get button_title_switchToOfflineMode {
    return Intl.message(
      'تغییر به حالت آفلاین',
      name: 'button_title_switchToOfflineMode',
      desc: '',
      args: [],
    );
  }

  /// `ثبت‌نام`
  String get button_title_register {
    return Intl.message(
      'ثبت‌نام',
      name: 'button_title_register',
      desc: '',
      args: [],
    );
  }

  /// `بازگشت به ورود`
  String get button_title_backToLogin {
    return Intl.message(
      'بازگشت به ورود',
      name: 'button_title_backToLogin',
      desc: '',
      args: [],
    );
  }

  /// `قبلی`
  String get button_title_previous {
    return Intl.message(
      'قبلی',
      name: 'button_title_previous',
      desc: '',
      args: [],
    );
  }

  /// `تولید`
  String get button_title_generate {
    return Intl.message(
      'تولید',
      name: 'button_title_generate',
      desc: '',
      args: [],
    );
  }

  /// `بعدی`
  String get button_title_next {
    return Intl.message('بعدی', name: 'button_title_next', desc: '', args: []);
  }

  /// `حذف`
  String get button_title_delete {
    return Intl.message('حذف', name: 'button_title_delete', desc: '', args: []);
  }

  /// `اعضا`
  String get button_title_members {
    return Intl.message(
      'اعضا',
      name: 'button_title_members',
      desc: '',
      args: [],
    );
  }

  /// `پیش‌نمایش`
  String get button_title_preview {
    return Intl.message(
      'پیش‌نمایش',
      name: 'button_title_preview',
      desc: '',
      args: [],
    );
  }

  /// `تیم ها`
  String get button_title_teams {
    return Intl.message(
      'تیم ها',
      name: 'button_title_teams',
      desc: '',
      args: [],
    );
  }

  /// `مهمانان`
  String get button_title_guests {
    return Intl.message(
      'مهمانان',
      name: 'button_title_guests',
      desc: '',
      args: [],
    );
  }

  /// `موارد منو`
  String get button_title_menuItems {
    return Intl.message(
      'موارد منو',
      name: 'button_title_menuItems',
      desc: '',
      args: [],
    );
  }

  /// `رویدادها`
  String get button_title_events {
    return Intl.message(
      'رویدادها',
      name: 'button_title_events',
      desc: '',
      args: [],
    );
  }

  /// `گزارش‌ها`
  String get button_title_reports {
    return Intl.message(
      'گزارش‌ها',
      name: 'button_title_reports',
      desc: '',
      args: [],
    );
  }

  /// `تنظیمات`
  String get button_title_settings {
    return Intl.message(
      'تنظیمات',
      name: 'button_title_settings',
      desc: '',
      args: [],
    );
  }

  /// `تایید`
  String get button_title_submit {
    return Intl.message(
      'تایید',
      name: 'button_title_submit',
      desc: '',
      args: [],
    );
  }

  /// `ویرایش`
  String get button_title_edit {
    return Intl.message(
      'ویرایش',
      name: 'button_title_edit',
      desc: '',
      args: [],
    );
  }

  /// `گزارش حقوق`
  String get button_title_salaryReport {
    return Intl.message(
      'گزارش حقوق',
      name: 'button_title_salaryReport',
      desc: '',
      args: [],
    );
  }

  /// `حالت آنلاین`
  String get button_title_onlineMode {
    return Intl.message(
      'حالت آنلاین',
      name: 'button_title_onlineMode',
      desc: '',
      args: [],
    );
  }

  /// `حالت آفلاین`
  String get button_title_offlineMode {
    return Intl.message(
      'حالت آفلاین',
      name: 'button_title_offlineMode',
      desc: '',
      args: [],
    );
  }

  /// `تغییر زبان`
  String get modalBottom_title_changeLanguage {
    return Intl.message(
      'تغییر زبان',
      name: 'modalBottom_title_changeLanguage',
      desc: '',
      args: [],
    );
  }

  /// `درباره انجام این عملیات اطمینان دارید؟`
  String get alertDialog_areYouSure {
    return Intl.message(
      'درباره انجام این عملیات اطمینان دارید؟',
      name: 'alertDialog_areYouSure',
      desc: '',
      args: [],
    );
  }

  /// `توجه کنید که در صورت حذف این آیتم، تمامی اطلاعات مربوط به این آیتم هم به صورت اتوماتیک حذف خواهد شد.`
  String get alertDialog_noticeThisAboutAction {
    return Intl.message(
      'توجه کنید که در صورت حذف این آیتم، تمامی اطلاعات مربوط به این آیتم هم به صورت اتوماتیک حذف خواهد شد.',
      name: 'alertDialog_noticeThisAboutAction',
      desc: '',
      args: [],
    );
  }

  /// `ثبت یک حساب جدید...`
  String get register_appBarTitle {
    return Intl.message(
      'ثبت یک حساب جدید...',
      name: 'register_appBarTitle',
      desc: '',
      args: [],
    );
  }

  /// `ورود به حساب کاربری...`
  String get login_appBarTitle {
    return Intl.message(
      'ورود به حساب کاربری...',
      name: 'login_appBarTitle',
      desc: '',
      args: [],
    );
  }

  /// `تنظیمات`
  String get settings_appBarTitle {
    return Intl.message(
      'تنظیمات',
      name: 'settings_appBarTitle',
      desc: '',
      args: [],
    );
  }

  /// `اعضای تیم`
  String get teamDetials_appBarTitle {
    return Intl.message(
      'اعضای تیم',
      name: 'teamDetials_appBarTitle',
      desc: '',
      args: [],
    );
  }

  /// `افزودن عضو جدید`
  String get teamDetails_addMembers {
    return Intl.message(
      'افزودن عضو جدید',
      name: 'teamDetails_addMembers',
      desc: '',
      args: [],
    );
  }

  /// `ویرایش عضو`
  String get teamDetails_editMembers {
    return Intl.message(
      'ویرایش عضو',
      name: 'teamDetails_editMembers',
      desc: '',
      args: [],
    );
  }

  /// `هنوز عضوی اضافه نشده است!`
  String get teamDetails_emptyStateContent {
    return Intl.message(
      'هنوز عضوی اضافه نشده است!',
      name: 'teamDetails_emptyStateContent',
      desc: '',
      args: [],
    );
  }

  /// `تیم‌ها`
  String get team_appBarTitle {
    return Intl.message('تیم‌ها', name: 'team_appBarTitle', desc: '', args: []);
  }

  /// `هنوز تیمی اضافه نشده است!`
  String get team_emptyStateContent {
    return Intl.message(
      'هنوز تیمی اضافه نشده است!',
      name: 'team_emptyStateContent',
      desc: '',
      args: [],
    );
  }

  /// `افزودن تیم جدید`
  String get team_addTeam {
    return Intl.message(
      'افزودن تیم جدید',
      name: 'team_addTeam',
      desc: '',
      args: [],
    );
  }

  /// `ویرایش تیم`
  String get team_editTeam {
    return Intl.message(
      'ویرایش تیم',
      name: 'team_editTeam',
      desc: '',
      args: [],
    );
  }

  /// `جزئیات عضو`
  String get memberDetails_appBarTitle {
    return Intl.message(
      'جزئیات عضو',
      name: 'memberDetails_appBarTitle',
      desc: '',
      args: [],
    );
  }

  /// `اعضا`
  String get member_appBarTitle {
    return Intl.message('اعضا', name: 'member_appBarTitle', desc: '', args: []);
  }

  /// `هنوز عضوی اضافه نشده است!`
  String get member_emptyStateContent {
    return Intl.message(
      'هنوز عضوی اضافه نشده است!',
      name: 'member_emptyStateContent',
      desc: '',
      args: [],
    );
  }

  /// `افزودن عضو جدید`
  String get member_addMember {
    return Intl.message(
      'افزودن عضو جدید',
      name: 'member_addMember',
      desc: '',
      args: [],
    );
  }

  /// `ویرایش عضو`
  String get member_editMember {
    return Intl.message(
      'ویرایش عضو',
      name: 'member_editMember',
      desc: '',
      args: [],
    );
  }

  /// `جزئیات رویداد`
  String get eventDetails_appBarTitle {
    return Intl.message(
      'جزئیات رویداد',
      name: 'eventDetails_appBarTitle',
      desc: '',
      args: [],
    );
  }

  /// `ویرایش تراکنش`
  String get eventDetails_editEventTransaction {
    return Intl.message(
      'ویرایش تراکنش',
      name: 'eventDetails_editEventTransaction',
      desc: '',
      args: [],
    );
  }

  /// `افزودن تراکنش جدید`
  String get eventDetails_addEventTransaction {
    return Intl.message(
      'افزودن تراکنش جدید',
      name: 'eventDetails_addEventTransaction',
      desc: '',
      args: [],
    );
  }

  /// `ویرایش سفارش`
  String get eventDetails_editEventOrder {
    return Intl.message(
      'ویرایش سفارش',
      name: 'eventDetails_editEventOrder',
      desc: '',
      args: [],
    );
  }

  /// `افزودن سفارش جدید`
  String get eventDetails_addEventOrder {
    return Intl.message(
      'افزودن سفارش جدید',
      name: 'eventDetails_addEventOrder',
      desc: '',
      args: [],
    );
  }

  /// `لطفاً انتخاب کنید...`
  String get eventDetails_selectOrder {
    return Intl.message(
      'لطفاً انتخاب کنید...',
      name: 'eventDetails_selectOrder',
      desc: '',
      args: [],
    );
  }

  /// `سفارش‌دهنده`
  String get eventDetails_orderBy {
    return Intl.message(
      'سفارش‌دهنده',
      name: 'eventDetails_orderBy',
      desc: '',
      args: [],
    );
  }

  /// `ویرایش نسبت`
  String get eventDetails_editEventRatio {
    return Intl.message(
      'ویرایش نسبت',
      name: 'eventDetails_editEventRatio',
      desc: '',
      args: [],
    );
  }

  /// `افزودن نسبت عضو جدید`
  String get eventDetails_addEventRatio {
    return Intl.message(
      'افزودن نسبت عضو جدید',
      name: 'eventDetails_addEventRatio',
      desc: '',
      args: [],
    );
  }

  /// `تراکنش‌ها`
  String get eventDetails_tabBar_transactions {
    return Intl.message(
      'تراکنش‌ها',
      name: 'eventDetails_tabBar_transactions',
      desc: '',
      args: [],
    );
  }

  /// `سفارش‌ها`
  String get eventDetails_tabBar_orders {
    return Intl.message(
      'سفارش‌ها',
      name: 'eventDetails_tabBar_orders',
      desc: '',
      args: [],
    );
  }

  /// `اعضا`
  String get eventDetails_tabBar_members {
    return Intl.message(
      'اعضا',
      name: 'eventDetails_tabBar_members',
      desc: '',
      args: [],
    );
  }

  /// `عضو`
  String get eventDetails_tabBar_member {
    return Intl.message(
      'عضو',
      name: 'eventDetails_tabBar_member',
      desc: '',
      args: [],
    );
  }

  /// `مهمان`
  String get eventDetails_tabBar_guest {
    return Intl.message(
      'مهمان',
      name: 'eventDetails_tabBar_guest',
      desc: '',
      args: [],
    );
  }

  /// `گزارش`
  String get eventDetails_tabBar_report {
    return Intl.message(
      'گزارش',
      name: 'eventDetails_tabBar_report',
      desc: '',
      args: [],
    );
  }

  /// `همه`
  String get eventDetails_eventOrdersBanner_all {
    return Intl.message(
      'همه',
      name: 'eventDetails_eventOrdersBanner_all',
      desc: '',
      args: [],
    );
  }

  /// `ظرفیت کل: {totalOrders} / مهمانان: {totalGuests}, اعضا: {totalMembers}`
  String eventDetails_eventOrdersBanner_totalCapacity(
    int totalOrders,
    int totalGuests,
    int totalMembers,
  ) {
    return Intl.message(
      'ظرفیت کل: $totalOrders / مهمانان: $totalGuests, اعضا: $totalMembers',
      name: 'eventDetails_eventOrdersBanner_totalCapacity',
      desc: 'Report about capacity',
      args: [totalOrders, totalGuests, totalMembers],
    );
  }

  /// `حاضر نشده`
  String get eventDetails_eventOrdersBanner_notAttended {
    return Intl.message(
      'حاضر نشده',
      name: 'eventDetails_eventOrdersBanner_notAttended',
      desc: '',
      args: [],
    );
  }

  /// `هنوز تراکنشی اضافه نشده است!`
  String get transaction_emptyStateContent {
    return Intl.message(
      'هنوز تراکنشی اضافه نشده است!',
      name: 'transaction_emptyStateContent',
      desc: '',
      args: [],
    );
  }

  /// `هنوز نسبتی اضافه نشده است!`
  String get ratio_emptyStateContent {
    return Intl.message(
      'هنوز نسبتی اضافه نشده است!',
      name: 'ratio_emptyStateContent',
      desc: '',
      args: [],
    );
  }

  /// `هنوز سفارشی اضافه نشده است!`
  String get order_emptyStateContent {
    return Intl.message(
      'هنوز سفارشی اضافه نشده است!',
      name: 'order_emptyStateContent',
      desc: '',
      args: [],
    );
  }

  /// `جزئیات مهمان`
  String get guestDetails_appBarTitle {
    return Intl.message(
      'جزئیات مهمان',
      name: 'guestDetails_appBarTitle',
      desc: '',
      args: [],
    );
  }

  /// `مهمانان`
  String get guest_appBarTitle {
    return Intl.message(
      'مهمانان',
      name: 'guest_appBarTitle',
      desc: '',
      args: [],
    );
  }

  /// `هنوز مهمانی اضافه نشده است!`
  String get guest_emptyStateContent {
    return Intl.message(
      'هنوز مهمانی اضافه نشده است!',
      name: 'guest_emptyStateContent',
      desc: '',
      args: [],
    );
  }

  /// `ویرایش مهمان`
  String get guest_editGuest {
    return Intl.message(
      'ویرایش مهمان',
      name: 'guest_editGuest',
      desc: '',
      args: [],
    );
  }

  /// `افزودن مهمان جدید`
  String get guest_addGuest {
    return Intl.message(
      'افزودن مهمان جدید',
      name: 'guest_addGuest',
      desc: '',
      args: [],
    );
  }

  /// `موارد منو`
  String get menu_appBarTitle {
    return Intl.message(
      'موارد منو',
      name: 'menu_appBarTitle',
      desc: '',
      args: [],
    );
  }

  /// `هنوز موردی اضافه نشده است!`
  String get menu_emptyStateContent {
    return Intl.message(
      'هنوز موردی اضافه نشده است!',
      name: 'menu_emptyStateContent',
      desc: '',
      args: [],
    );
  }

  /// `افزودن مورد منو`
  String get menu_addItem {
    return Intl.message(
      'افزودن مورد منو',
      name: 'menu_addItem',
      desc: '',
      args: [],
    );
  }

  /// `ویرایش مورد`
  String get menu_editItem {
    return Intl.message(
      'ویرایش مورد',
      name: 'menu_editItem',
      desc: '',
      args: [],
    );
  }

  /// `رویدادها`
  String get event_appBarTitle {
    return Intl.message(
      'رویدادها',
      name: 'event_appBarTitle',
      desc: '',
      args: [],
    );
  }

  /// `هنوز رویدادی اضافه نشده است!`
  String get event_emptyStateContent {
    return Intl.message(
      'هنوز رویدادی اضافه نشده است!',
      name: 'event_emptyStateContent',
      desc: '',
      args: [],
    );
  }

  /// `افزودن رویداد جدید`
  String get event_addEvent {
    return Intl.message(
      'افزودن رویداد جدید',
      name: 'event_addEvent',
      desc: '',
      args: [],
    );
  }

  /// `ویرایش رویداد`
  String get event_editEvent {
    return Intl.message(
      'ویرایش رویداد',
      name: 'event_editEvent',
      desc: '',
      args: [],
    );
  }

  /// `جزئیات گزارش`
  String get reportDetails_appBarTitle {
    return Intl.message(
      'جزئیات گزارش',
      name: 'reportDetails_appBarTitle',
      desc: '',
      args: [],
    );
  }

  /// `رویدادهای انتخاب‌شده`
  String get reportDetails_selectedEvents {
    return Intl.message(
      'رویدادهای انتخاب‌شده',
      name: 'reportDetails_selectedEvents',
      desc: '',
      args: [],
    );
  }

  /// `این گزارش برای تولید شده است`
  String get reportDetails_reportGeneratedFor {
    return Intl.message(
      'این گزارش برای تولید شده است',
      name: 'reportDetails_reportGeneratedFor',
      desc: '',
      args: [],
    );
  }

  /// `گزارش‌ها`
  String get report_appBarTitle {
    return Intl.message(
      'گزارش‌ها',
      name: 'report_appBarTitle',
      desc: '',
      args: [],
    );
  }

  /// `هنوز گزارشی اضافه نشده است!`
  String get report_emptyStateContent {
    return Intl.message(
      'هنوز گزارشی اضافه نشده است!',
      name: 'report_emptyStateContent',
      desc: '',
      args: [],
    );
  }

  /// `ایجاد گزارش جدید`
  String get report_addReport {
    return Intl.message(
      'ایجاد گزارش جدید',
      name: 'report_addReport',
      desc: '',
      args: [],
    );
  }

  /// `هیچ رویدادی یافت نشد`
  String get report_selectingEvents_noEvent {
    return Intl.message(
      'هیچ رویدادی یافت نشد',
      name: 'report_selectingEvents_noEvent',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'fa'),
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
