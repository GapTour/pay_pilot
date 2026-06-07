part of '../language_cubit.dart';

sealed class LanguageChangingStatus extends Equatable {}

class LanguageChangingInit extends LanguageChangingStatus {
  @override
  List<Object?> get props => [];
}

class LanguageChangingLoading extends LanguageChangingStatus {
  @override
  List<Object?> get props => [];
}

class LanguageChangingSuccess extends LanguageChangingStatus {
  @override
  List<Object?> get props => [];
}

class LanguageChangingFailure extends LanguageChangingStatus {
  final String errorMessage;
  LanguageChangingFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
