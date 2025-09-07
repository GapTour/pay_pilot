import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class PriceInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    int parsedValue =
        int.tryParse(newValue.text.replaceAll(RegExp(r'[^\d]'), '')) ?? 0;

    String formattedText = NumberFormat('#,###').format(parsedValue);
    String resultText = formattedText;

    return TextEditingValue(
      text: resultText,
      selection: TextSelection.collapsed(offset: resultText.length),
    );
  }
}
