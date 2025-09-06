import 'package:intl/intl.dart';

class AmountHelper {
  static double formattedPriceToInteger(String inputPrice) {
    final String simplePrice = inputPrice.replaceAll(',', '');

    return double.parse(
      simplePrice
        ..replaceAll('۱', '1')
        ..replaceAll('۲', '2')
        ..replaceAll('۳', '3')
        ..replaceAll('۴', '4')
        ..replaceAll('۵', '5')
        ..replaceAll('۶', '6')
        ..replaceAll('۷', '7')
        ..replaceAll('۸', '8')
        ..replaceAll('۹', '9')
        ..replaceAll('۰', '0'),
    );
  }

  static String integerToFormattedPrice(double inputPrice) {
    final String simplePrice = inputPrice.toStringAsFixed(0);

    final int parsedValue =
        int.tryParse(simplePrice.replaceAll(RegExp(r'[^\d]'), '')) ?? 0;

    final String formattedText = NumberFormat('#,###').format(parsedValue);

    return formattedText;
  }
}
