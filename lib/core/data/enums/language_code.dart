enum LanguageCode {
  persian('fa'),
  english('en');

  final String code;
  const LanguageCode(this.code);

  bool get isPersian => this == LanguageCode.persian;
  bool get isEnglish => this == LanguageCode.english;

  factory LanguageCode.fromString(String response) {
    late LanguageCode languageCode;
    if (response == LanguageCode.persian.code) {
      languageCode = LanguageCode.persian;
      return languageCode;
    }

    return LanguageCode.english;
  }
}
