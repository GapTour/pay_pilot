enum PaymentSource {
  member,
  guest;

  bool get isMemberSelected => this == PaymentSource.member;
  bool get isGuestSelected => this == PaymentSource.guest;
}
