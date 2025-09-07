class IncomeForm {
  final int? id;
  final String title;
  final double amount;
  final DateTime date;
  final String? description;

  IncomeForm({
    required this.title,
    required this.amount,
    required this.date,
    required this.description,
    this.id,
  });

  IncomeForm copyWith({
    int? id,
    String? title,
    double? amount,
    DateTime? date,
    String? description,
  }) {
    return IncomeForm(
      id: id ?? this.id,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      description: description ?? this.description,
    );
  }
}
