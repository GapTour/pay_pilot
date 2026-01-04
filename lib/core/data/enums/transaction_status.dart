enum TransactionStatus {
  income,
  expense;

  bool get isIncome => this == TransactionStatus.income;
  bool get isExpense => this == TransactionStatus.expense;
}
