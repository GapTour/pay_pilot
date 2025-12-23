class ResponseMenu {
  final int id;
  final String title;
  final bool isActive;

  ResponseMenu({required this.id, required this.title, required this.isActive});

  factory ResponseMenu.fromMap(Map<String, dynamic> map) {
    return ResponseMenu(
      id: int.parse(map['id'] as String),
      title: map['title'] as String,
      isActive: map['is_active'] as String == '1',
    );
  }
}
