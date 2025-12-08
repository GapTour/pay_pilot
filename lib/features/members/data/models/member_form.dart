class MemberForm {
  final String name;
  final DateTime? joinAt;
  final String? description;

  MemberForm({required this.name, required this.joinAt, this.description});

  MemberForm copyWith({String? name, DateTime? joinAt, String? description}) {
    return MemberForm(
      name: name ?? this.name,
      joinAt: joinAt ?? this.joinAt,
      description: description ?? this.description,
    );
  }
}
