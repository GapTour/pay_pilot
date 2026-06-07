import 'package:pay_pilot/core/data/enums/language_code.dart';
import 'package:pay_pilot/core/data/response/error_response.dart';
import 'package:pay_pilot/core/utils/resource/data_state.dart';
import 'package:pay_pilot/features/change_language/data/language_local_provider.dart';

class LanguageRepository {
  final LanguageLocalProvider _localProvider;

  LanguageRepository(this._localProvider);

  Future<DataState<LanguageCode>> fetchLanguageInfo() async {
    try {
      final response = await _localProvider.fetchLanguageInfo();
      final languageCodes = LanguageCode.fromString(response);

      return DataSuccess(languageCodes);
    } catch (e) {
      return DataFailed(ErrorResponse.defaultError(e.toString()));
    }
  }

  Future<DataState<void>> changeLanguage(LanguageCode languageCodes) async {
    try {
      final response = await _localProvider.changeLanguage(languageCodes.code);

      if (response) {
        return DataSuccess(null);
      }

      return DataFailed(ErrorResponse.defaultError('Something went wrong!'));
    } catch (e) {
      return DataFailed(ErrorResponse.defaultError(e.toString()));
    }
  }
}
