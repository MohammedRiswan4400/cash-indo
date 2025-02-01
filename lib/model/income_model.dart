class IncomeModel {
  final String category;
  final String amount;
  String? comment;
  final String currency;
  final DateTime createdAt;

  IncomeModel({
    required this.currency,
    required this.amount,
    required this.category,
    this.comment,
    required this.createdAt,
  });

  factory IncomeModel.fromMap(Map<String, dynamic> data) {
    return IncomeModel(
      currency: data['currency'] ?? '',
      amount: data['amount'] ?? '',
      category: data['category'] ?? '',
      comment: data['comment'] ?? '',
      createdAt: data['createdAt']?.toDate() ?? DateTime.now(),
    );
  }
}
