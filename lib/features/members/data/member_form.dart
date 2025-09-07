class MemberForm {
  final int? id;
  final String name;
  final double percentage;
  final String? description;

  MemberForm({
    this.id,
    required this.name,
    required this.percentage,
    this.description,
  });

  MemberForm copyWith({
    int? id,
    String? name,
    double? percentage,
    String? description,
  }) {
    return MemberForm(
      id: id ?? this.id,
      name: name ?? this.name,
      percentage: percentage ?? this.percentage,
      description: description ?? this.description,
    );
  }
}
