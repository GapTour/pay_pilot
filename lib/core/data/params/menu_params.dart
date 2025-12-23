class MenuParams {
  final int? id;
  final String title;
  final bool? isActive;

  MenuParams({required this.id, required this.title, required this.isActive});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'title': title, 'is_active': isActive};
  }
}
