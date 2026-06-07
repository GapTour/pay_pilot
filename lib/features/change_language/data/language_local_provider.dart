import 'package:pay_pilot/core/data/enums/language_code.dart';
import 'package:pay_pilot/core/utils/services/shared_preferences_service.dart';

class LanguageLocalProvider {
  final SharedPreferencesService _preferencesService;

  LanguageLocalProvider(this._preferencesService);

  Future<bool> changeLanguage(String languageCode) async {
    return await _preferencesService.write<String>('locale', languageCode);
  }

  Future<String> fetchLanguageInfo() async {
    return (await _preferencesService.read<String>(
      'locale',
      defaultValue: LanguageCode.persian.code,
    ))!;
  }
}
