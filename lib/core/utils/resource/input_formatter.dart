import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pay_pilot/core/utils/extensions/persian_numbers_converter.dart';

class PriceInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String cleanedText = newValue.text.replaceAll(RegExp(r'[^\d۰-۹]'), '');
    String westernizedText = cleanedText.parseToString;
    double parsedValue = double.tryParse(westernizedText) ?? 0.0;

    String formattedText = NumberFormat('#,###').format(parsedValue);
    String resultText = formattedText;

    return TextEditingValue(
      text: resultText,
      selection: TextSelection.collapsed(offset: resultText.length),
    );
  }
}
