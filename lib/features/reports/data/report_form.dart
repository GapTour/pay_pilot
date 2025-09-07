class ReportForm {
  final int? id;
  final int version;
  final String? description;
  final DateTime date;
  final double totalBalance;
  final List<MemberReport> membersReport;

  ReportForm({
    this.id,
    required this.version,
    required this.description,
    required this.date,
    required this.totalBalance,
    required this.membersReport,
  });
}

class MemberReport {
  final int id;
  final String name;
  final double percentage;
  final double amount;

  MemberReport({
    required this.id,
    required this.name,
    required this.percentage,
    required this.amount,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'percentage': percentage,
    'amount': amount,
  };

  factory MemberReport.fromJson(Map<String, dynamic> json) => MemberReport(
    id: json['id'],
    name: json['name'],
    percentage: json['percentage'],
    amount: json['amount'],
  );
}
