part of '../language_cubit.dart';

sealed class MaterialLanguageStatus extends Equatable {}

class MaterialChangingInit extends MaterialLanguageStatus {
  @override
  List<Object?> get props => [];
}

class MaterialChangingLoading extends MaterialLanguageStatus {
  @override
  List<Object?> get props => [];
}

class MaterialChangingSuccess extends MaterialLanguageStatus {
  final LanguageCode code;
  MaterialChangingSuccess(this.code);
  @override
  List<Object?> get props => [code];
}

class MaterialChangingFailure extends MaterialLanguageStatus {
  @override
  List<Object?> get props => [];
}
