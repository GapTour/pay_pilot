part of 'language_cubit.dart';

class LanguageState extends Equatable {
  final LanguageChangingStatus languageChangingStatus;
  final MaterialLanguageStatus materialLanguageStatus;

  const LanguageState({
    required this.languageChangingStatus,
    required this.materialLanguageStatus,
  });

  @override
  List<Object> get props => [languageChangingStatus, materialLanguageStatus];

  LanguageState copyWith({
    LanguageChangingStatus? languageChangingStatus,
    MaterialLanguageStatus? materialLanguageStatus,
  }) {
    return LanguageState(
      languageChangingStatus:
          languageChangingStatus ?? this.languageChangingStatus,
      materialLanguageStatus:
          materialLanguageStatus ?? this.materialLanguageStatus,
    );
  }
}
