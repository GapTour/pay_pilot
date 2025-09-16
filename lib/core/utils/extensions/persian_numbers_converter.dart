extension PersianNumbersConverter on String {
  String get parseToString {
    const persianDigits = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];
    const westernDigits = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];

    String westernized = this;
    for (int i = 0; i < persianDigits.length; i++) {
      westernized = westernized.replaceAll(persianDigits[i], westernDigits[i]);
    }

    return westernized;
  }

  double get parseToDouble {
    const persianDigits = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];
    const westernDigits = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];

    String westernized = this;
    for (int i = 0; i < persianDigits.length; i++) {
      westernized = westernized.replaceAll(persianDigits[i], westernDigits[i]);
    }

    return double.tryParse(westernized) ?? 0.0;
  }
}
