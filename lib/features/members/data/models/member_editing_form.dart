class MemberEditingForm {
  final int id;
  final String name;
  final DateTime? joinAt;
  final String? description;

  MemberEditingForm({
    required this.id,
    required this.name,
    required this.joinAt,
    required this.description,
  });

  MemberEditingForm copyWith({
    int? id,
    String? name,
    DateTime? joinAt,
    String? description,
  }) {
    return MemberEditingForm(
      id: id ?? this.id,
      name: name ?? this.name,
      joinAt: joinAt ?? this.joinAt,
      description: description ?? this.description,
    );
  }
}
