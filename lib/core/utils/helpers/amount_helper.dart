import 'package:intl/intl.dart';
import 'package:pay_pilot/core/utils/extensions/persian_numbers_converter.dart';

class AmountHelper {
  static double formattedPriceToInteger(String inputPrice) {
    final double simplePrice = inputPrice.replaceAll(',', '').parseToDouble;

    return simplePrice;
  }

  static String integerToFormattedPrice(double inputPrice) {
    final String simplePrice = inputPrice.toStringAsFixed(0);

    final int parsedValue =
        int.tryParse(simplePrice.replaceAll(RegExp(r'[^\d]'), '')) ?? 0;

    final String formattedText = NumberFormat('#,###').format(parsedValue);

    return formattedText;
  }
}
