enum SplashType {
  authenticated,
  notAuthenticated,
  needToUpdate;

  bool get isAuthenticated => this == SplashType.authenticated;
  bool get isNotAuthenticated => this == SplashType.notAuthenticated;
  bool get isNeedToUpdate => this == SplashType.needToUpdate;

  static SplashType fromName(String? name) {
    return SplashType.values.firstWhere(
      (e) => e.name == name,
      orElse: () => SplashType.notAuthenticated,
    );
  }
}
