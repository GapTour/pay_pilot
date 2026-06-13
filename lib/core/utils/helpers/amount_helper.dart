import 'package:intl/intl.dart';
import 'package:pay_pilot/core/database/tables/event_transactions.dart';
import 'package:pay_pilot/core/utils/extensions/persian_numbers_converter.dart';

class AmountHelper {
  static double formattedPriceToInteger(String inputPrice) {
    final cleaned = inputPrice.replaceAll(',', '').replaceAll('٬', '').trim();

    return cleaned.parseToDouble;
  }

  static String integerToFormattedPrice(
    double inputPrice, [
    TransactionType? type,
  ]) {
    final String simplePrice = inputPrice.toStringAsFixed(0);

    final int parsedValue =
        int.tryParse(simplePrice.replaceAll(RegExp(r'[^\d]'), '')) ?? 0;

    final String formattedText = NumberFormat('#,###').format(parsedValue);

    if (type?.isExpense ?? false) return '$formattedText -';
    return formattedText;
  }
}
