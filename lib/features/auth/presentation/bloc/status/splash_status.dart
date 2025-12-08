part of '../auth_bloc.dart';

sealed class SplashStatus extends Equatable {}

class SplashInit extends SplashStatus {
  @override
  List<Object?> get props => [];
}

class SplashLoading extends SplashStatus {
  @override
  List<Object?> get props => [];
}

class SplashAuthenticated extends SplashStatus {
  @override
  List<Object?> get props => [];
}

class SplashNotAuthenticated extends SplashStatus {
  @override
  List<Object?> get props => [];
}

class SplashNeedUpdate extends SplashStatus {
  @override
  List<Object?> get props => [];
}
